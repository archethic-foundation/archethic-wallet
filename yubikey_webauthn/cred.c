
#include <errno.h>
#include<err.h>
#include <fido.h>
#include <fido/es256.h>
#include <fido/rs256.h>
#include <fido/eddsa.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <limits.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <getopt.h>
#include <openssl/ec.h>
#include <openssl/evp.h>
#include <openssl/pem.h>

int
base10(const char *str, long long *ll);

static const unsigned char cd[32] = {
	0xf9, 0x64, 0x57, 0xe7, 0x2d, 0x97, 0xf6, 0xbb,
	0xdd, 0xd7, 0xfb, 0x06, 0x37, 0x62, 0xea, 0x26,
	0x20, 0x44, 0x8e, 0x69, 0x7c, 0x03, 0xf2, 0x31,
	0x2f, 0x99, 0xdc, 0xaf, 0x3e, 0x8a, 0x91, 0x6b,
};

static const unsigned char user_id[32] = {
	0x78, 0x1c, 0x78, 0x60, 0xad, 0x88, 0xd2, 0x63,
	0x32, 0x62, 0x2a, 0xf1, 0x74, 0x5d, 0xed, 0xb2,
	0xe7, 0xa4, 0x2b, 0x44, 0x89, 0x29, 0x39, 0xc5,
	0x56, 0x64, 0x01, 0x27, 0x0d, 0xbb, 0xc4, 0x49,
};

static void
usage(void)
{
	fprintf(stderr, "usage: cred [-t ecdsa|rsa|eddsa] [-k pubkey] "
	    "[-ei cred_id] [-P pin] [-T seconds] [-b blobkey] [-hruv] "
	    "<device>\n");
	exit(EXIT_FAILURE);
}

int
base10(const char *str, long long *ll)
{
	char *ep;

	*ll = strtoll(str, &ep, 10);
	if (str == ep || *ep != '\0')
		return (-1);
	else if (*ll == LLONG_MIN && errno == ERANGE)
		return (-1);
	else if (*ll == LLONG_MAX && errno == ERANGE)
		return (-1);

	return (0);
}

int
read_blob(const char *path, unsigned char **ptr, size_t *len)
{
	int fd, ok = -1;
	struct stat st;
	ssize_t n;

	*ptr = NULL;
	*len = 0;

	if ((fd = open(path, O_RDONLY)) < 0) {
		warn("open %s", path);
		goto fail;
	}
	if (fstat(fd, &st) < 0) {
		warn("stat %s", path);
		goto fail;
	}
	if (st.st_size < 0) {
		warnx("stat %s: invalid size", path);
		goto fail;
	}
	*len = (size_t)st.st_size;
	if ((*ptr = malloc(*len)) == NULL) {
		warn("malloc");
		goto fail;
	}
	if ((n = read(fd, *ptr, *len)) < 0) {
		warn("read");
		goto fail;
	}
	if ((size_t)n != *len) {
		warnx("read");
		goto fail;
	}

	ok = 0;
fail:
	if (fd != -1) {
		close(fd);
	}
	if (ok < 0) {
		free(*ptr);
		*ptr = NULL;
		*len = 0;
	}

	return (ok);
}

int
write_blob(const char *path, const unsigned char *ptr, size_t len)
{
	int fd, ok = -1;
	ssize_t n;

	if ((fd = open(path, O_WRONLY | O_CREAT, 0600)) < 0) {
		warn("open %s", path);
		goto fail;
	}

	if ((n = write(fd, ptr, len)) < 0) {
		warn("write");
		goto fail;
	}
	if ((size_t)n != len) {
		warnx("write");
		goto fail;
	}

	ok = 0;
fail:
	if (fd != -1) {
		close(fd);
	}

	return (ok);
}






















EC_KEY *
read_ec_pubkey(const char *path)
{
	FILE *fp = NULL;
	EVP_PKEY *pkey = NULL;
	EC_KEY *ec = NULL;

	if ((fp = fopen(path, "r")) == NULL) {
		warn("fopen");
		goto fail;
	}

	if ((pkey = PEM_read_PUBKEY(fp, NULL, NULL, NULL)) == NULL) {
		warnx("PEM_read_PUBKEY");
		goto fail;
	}
	if ((ec = EVP_PKEY_get1_EC_KEY(pkey)) == NULL) {
		warnx("EVP_PKEY_get1_EC_KEY");
		goto fail;
	}

fail:
	if (fp != NULL) {
		fclose(fp);
	}
	if (pkey != NULL) {
		EVP_PKEY_free(pkey);
	}

	return (ec);
}


int
write_ec_pubkey(const char *path, const void *ptr, size_t len)
{
	FILE *fp = NULL;
	EVP_PKEY *pkey = NULL;
	es256_pk_t *pk = NULL;
	int fd = -1;
	int ok = -1;

	if ((pk = es256_pk_new()) == NULL) {
		warnx("es256_pk_new");
		goto fail;
	}

	if (es256_pk_from_ptr(pk, ptr, len) != FIDO_OK) {
		warnx("es256_pk_from_ptr");
		goto fail;
	}

	if ((fd = open(path, O_WRONLY | O_CREAT, 0644)) < 0) {
		warn("open %s", path);
		goto fail;
	}

	if ((fp = fdopen(fd, "w")) == NULL) {
		warn("fdopen");
		goto fail;
	}
	fd = -1; /* owned by fp now */

	if ((pkey = es256_pk_to_EVP_PKEY(pk)) == NULL) {
		warnx("es256_pk_to_EVP_PKEY");
		goto fail;
	}

	if (PEM_write_PUBKEY(fp, pkey) == 0) {
		warnx("PEM_write_PUBKEY");
		goto fail;
	}

	ok = 0;
fail:
	es256_pk_free(&pk);

	if (fp != NULL) {
		fclose(fp);
	}
	if (fd != -1) {
		close(fd);
	}
	if (pkey != NULL) {
		EVP_PKEY_free(pkey);
	}

	return (ok);
}

RSA *
read_rsa_pubkey(const char *path)
{
	FILE *fp = NULL;
	EVP_PKEY *pkey = NULL;
	RSA *rsa = NULL;

	if ((fp = fopen(path, "r")) == NULL) {
		warn("fopen");
		goto fail;
	}

	if ((pkey = PEM_read_PUBKEY(fp, NULL, NULL, NULL)) == NULL) {
		warnx("PEM_read_PUBKEY");
		goto fail;
	}
	if ((rsa = EVP_PKEY_get1_RSA(pkey)) == NULL) {
		warnx("EVP_PKEY_get1_RSA");
		goto fail;
	}

fail:
	if (fp != NULL) {
		fclose(fp);
	}
	if (pkey != NULL) {
		EVP_PKEY_free(pkey);
	}

	return (rsa);
}

int
write_rsa_pubkey(const char *path, const void *ptr, size_t len)
{
	FILE *fp = NULL;
	EVP_PKEY *pkey = NULL;
	rs256_pk_t *pk = NULL;
	int fd = -1;
	int ok = -1;

	if ((pk = rs256_pk_new()) == NULL) {
		warnx("rs256_pk_new");
		goto fail;
	}

	if (rs256_pk_from_ptr(pk, ptr, len) != FIDO_OK) {
		warnx("rs256_pk_from_ptr");
		goto fail;
	}

	if ((fd = open(path, O_WRONLY | O_CREAT, 0644)) < 0) {
		warn("open %s", path);
		goto fail;
	}

	if ((fp = fdopen(fd, "w")) == NULL) {
		warn("fdopen");
		goto fail;
	}
	fd = -1; /* owned by fp now */

	if ((pkey = rs256_pk_to_EVP_PKEY(pk)) == NULL) {
		warnx("rs256_pk_to_EVP_PKEY");
		goto fail;
	}

	if (PEM_write_PUBKEY(fp, pkey) == 0) {
		warnx("PEM_write_PUBKEY");
		goto fail;
	}

	ok = 0;
fail:
	rs256_pk_free(&pk);

	if (fp != NULL) {
		fclose(fp);
	}
	if (fd != -1) {
		close(fd);
	}
	if (pkey != NULL) {
		EVP_PKEY_free(pkey);
	}

	return (ok);
}

EVP_PKEY *
read_eddsa_pubkey(const char *path)
{
	FILE *fp = NULL;
	EVP_PKEY *pkey = NULL;

	if ((fp = fopen(path, "r")) == NULL) {
		warn("fopen");
		goto fail;
	}

	if ((pkey = PEM_read_PUBKEY(fp, NULL, NULL, NULL)) == NULL) {
		warnx("PEM_read_PUBKEY");
		goto fail;
	}

fail:
	if (fp) {
		fclose(fp);
	}

	return (pkey);
}
int
write_eddsa_pubkey(const char *path, const void *ptr, size_t len)
{
	FILE *fp = NULL;
	EVP_PKEY *pkey = NULL;
	eddsa_pk_t *pk = NULL;
	int fd = -1;
	int ok = -1;

	if ((pk = eddsa_pk_new()) == NULL) {
		warnx("eddsa_pk_new");
		goto fail;
	}

	if (eddsa_pk_from_ptr(pk, ptr, len) != FIDO_OK) {
		warnx("eddsa_pk_from_ptr");
		goto fail;
	}

	if ((fd = open(path, O_WRONLY | O_CREAT, 0644)) < 0) {
		warn("open %s", path);
		goto fail;
	}

	if ((fp = fdopen(fd, "w")) == NULL) {
		warn("fdopen");
		goto fail;
	}
	fd = -1; /* owned by fp now */

	if ((pkey = eddsa_pk_to_EVP_PKEY(pk)) == NULL) {
		warnx("eddsa_pk_to_EVP_PKEY");
		goto fail;
	}

	if (PEM_write_PUBKEY(fp, pkey) == 0) {
		warnx("PEM_write_PUBKEY");
		goto fail;
	}

	ok = 0;
fail:
	eddsa_pk_free(&pk);

	if (fp != NULL) {
		fclose(fp);
	}
	if (fd != -1) {
		close(fd);
	}
	if (pkey != NULL) {
		EVP_PKEY_free(pkey);
	}

	return (ok);
}


















static void
verify_cred(int type, const char *fmt, const unsigned char *authdata_ptr,
    size_t authdata_len, const unsigned char *attstmt_ptr, size_t attstmt_len,
    bool rk, bool uv, int ext, const char *key_out, const char *id_out)
{
        fido_cred_t	*cred;
	    int		 r;


        if ((cred = fido_cred_new()) == NULL)
		    errx(1, "fido_cred_new");

        /* type */
	    r = fido_cred_set_type(cred, type);
        if (r != FIDO_OK)
		    errx(1, "fido_cred_set_type: %s (0x%x)", fido_strerr(r), r);

        /* client data */
	    r = fido_cred_set_clientdata(cred, cd, sizeof(cd));
	    if (r != FIDO_OK)
		    errx(1, "fido_cred_set_clientdata: %s (0x%x)", fido_strerr(r), r);

        /* relying party */
	r = fido_cred_set_rp(cred, "localhost", "sweet home localhost");
	if (r != FIDO_OK)
		errx(1, "fido_cred_set_rp: %s (0x%x)", fido_strerr(r), r);    

        /* authdata */
	r = fido_cred_set_authdata(cred, authdata_ptr, authdata_len);
	if (r != FIDO_OK)
		errx(1, "fido_cred_set_authdata: %s (0x%x)", fido_strerr(r), r);

    /* extensions */
	r = fido_cred_set_extensions(cred, ext);
	if (r != FIDO_OK)
		errx(1, "fido_cred_set_extensions: %s (0x%x)", fido_strerr(r), r);

    	/* resident key */
	if (rk && (r = fido_cred_set_rk(cred, FIDO_OPT_TRUE)) != FIDO_OK)
		errx(1, "fido_cred_set_rk: %s (0x%x)", fido_strerr(r), r);

        /* user verification */
	if (uv && (r = fido_cred_set_uv(cred, FIDO_OPT_TRUE)) != FIDO_OK)
		errx(1, "fido_cred_set_uv: %s (0x%x)", fido_strerr(r), r);

    /* fmt */
	r = fido_cred_set_fmt(cred, fmt);
	if (r != FIDO_OK)
		errx(1, "fido_cred_set_fmt: %s (0x%x)", fido_strerr(r), r);

    if (!strcmp(fido_cred_fmt(cred), "none")) {
		warnx("no attestation data, skipping credential verification");
		goto out;
	}

    /* attestation statement */
	r = fido_cred_set_attstmt(cred, attstmt_ptr, attstmt_len);
	if (r != FIDO_OK)
		errx(1, "fido_cred_set_attstmt: %s (0x%x)", fido_strerr(r), r);

    r = fido_cred_verify(cred);
	if (r != FIDO_OK)
		errx(1, "fido_cred_verify: %s (0x%x)", fido_strerr(r), r);  


    out:
	if (key_out != NULL) {
		/* extract the credential pubkey */
		if (type == COSE_ES256) {
            if (write_ec_pubkey(key_out, fido_cred_pubkey_ptr(cred),
			    fido_cred_pubkey_len(cred)) < 0)
				errx(1, "write_ec_pubkey");
        } else if (type == COSE_RS256) {
			if (write_rsa_pubkey(key_out, fido_cred_pubkey_ptr(cred),
			    fido_cred_pubkey_len(cred)) < 0)
				errx(1, "write_rsa_pubkey");
        } else if (type == COSE_EDDSA) {
			if (write_eddsa_pubkey(key_out, fido_cred_pubkey_ptr(cred),
			    fido_cred_pubkey_len(cred)) < 0)
				errx(1, "write_eddsa_pubkey");
		}
    }

    if (id_out != NULL) {
		/* extract the credential id */
		if (write_blob(id_out, fido_cred_id_ptr(cred),
		    fido_cred_id_len(cred)) < 0)
			errx(1, "write_blob");
	}


    fido_cred_free(&cred);



}












int main(int argc, char *argv)
{
    bool      rk=false;
    bool      uv=false;
    bool      u2f=false;
    fido_dev_t *dev;
    fido_cred_t *cred=NULL;
    const char *pin=NULL;
    const char *blobkey_out= NULL;
    const char *key_out= NULL;
    const char *id_out=NULL;
    unsigned char *body=NULL;
    long long ms=0;
    size_t len;
    int type=COSE_ES256;
    int ext=0;
    int ch;
    int r;

    if((cred=fido_cred_new())==NULL)
        printf("ERROR: fido_cred_new()");
    
    while((ch=getopt(argc,argv, "P:T:b:e:hi:k:rt:uv" ))!=-1)
    {
        switch(ch)
        {
            case 'P':
                pin= optarg;
                break;
            case 'T':
                if(base10(optarg, &ms)<0)
                printf("base10: %s", optarg);

                if(ms<=0 || ms>30)
                    printf("-T: %s must be in (0, 30]", optarg);
                ms *= 1000;
                break;
            case 'b':
                ext |= FIDO_EXT_LARGEBLOB_KEY;
                blobkey_out=optarg;
                break;
            case 'e':
                if(read_blob(optarg, &body, &len) < 0)
                    printf("read_blob: %s", optarg);
                r = fido_cred_exclude(cred, body, len);
                if (r != FIDO_OK)
                    printf("fido_cred_exclude: %s (0x%x)", fido_strerr(r), r);
                free(body);
                body = NULL;
                break;
            case 'h':
			ext |= FIDO_EXT_HMAC_SECRET;
			break;

            case 'i':
			id_out = optarg;
			break;

            case 'k':
			key_out = optarg;
			break;

            case 'r':
			rk = true;
			break;

            case 't':
			if (strcmp(optarg, "ecdsa") == 0)
				type = COSE_ES256;
            else if (strcmp(optarg, "rsa") == 0)
				type = COSE_RS256;

            else if (strcmp(optarg, "eddsa") == 0)
				type = COSE_EDDSA;

            else
				errx(1, "unknown type %s", optarg);
			break;

            case 'u':
			u2f = true;
			break;
            case 'v':
			uv = true;
			break;

            default:
			    usage();
		}

    }

        argc -= optind;
	    argv += optind;

        if (argc != 1)
		usage();

        fido_init(0);

        if ((dev = fido_dev_new()) == NULL)
		errx(1, "fido_dev_new");

        r = fido_dev_open(dev, argv[0]);
	    if (r != FIDO_OK)
		    errx(1, "fido_dev_open: %s (0x%x)", fido_strerr(r), r);
        if (u2f)
		    fido_dev_force_u2f(dev);

    /* type */
	r = fido_cred_set_type(cred, type);
	if (r != FIDO_OK)
		errx(1, "fido_cred_set_type: %s (0x%x)", fido_strerr(r), r);

    
	/* client data */
	r = fido_cred_set_clientdata(cred, cd, sizeof(cd));
	if (r != FIDO_OK)
		errx(1, "fido_cred_set_clientdata: %s (0x%x)", fido_strerr(r), r);

        
    /* relying party */
	r = fido_cred_set_rp(cred, "localhost", "sweet home localhost");
	if (r != FIDO_OK)
		errx(1, "fido_cred_set_rp: %s (0x%x)", fido_strerr(r), r);

    /* user */
	r = fido_cred_set_user(cred, user_id, sizeof(user_id), "john smith",
	    "jsmith", NULL);
	if (r != FIDO_OK)
		errx(1, "fido_cred_set_user: %s (0x%x)", fido_strerr(r), r);

    /* extensions */
	r = fido_cred_set_extensions(cred, ext);
	if (r != FIDO_OK)
		errx(1, "fido_cred_set_extensions: %s (0x%x)", fido_strerr(r), r);

    /* resident key */
	if (rk && (r = fido_cred_set_rk(cred, FIDO_OPT_TRUE)) != FIDO_OK)
		errx(1, "fido_cred_set_rk: %s (0x%x)", fido_strerr(r), r);

    /* user verification */
	if (uv && (r = fido_cred_set_uv(cred, FIDO_OPT_TRUE)) != FIDO_OK)
		errx(1, "fido_cred_set_uv: %s (0x%x)", fido_strerr(r), r);

    /* timeout */
	if (ms != 0 && (r = fido_dev_set_timeout(dev, (int)ms)) != FIDO_OK)
		errx(1, "fido_dev_set_timeout: %s (0x%x)", fido_strerr(r), r);

    if ((r = fido_dev_make_cred(dev, cred, pin)) != FIDO_OK) {
		fido_dev_cancel(dev);
		errx(1, "fido_makecred: %s (0x%x)", fido_strerr(r), r);
    }
    
    r = fido_dev_close(dev);
	if (r != FIDO_OK)
		errx(1, "fido_dev_close: %s (0x%x)", fido_strerr(r), r);

	fido_dev_free(&dev);

    /* when verifying, pin implies uv */
	if (pin)
		uv = true;

    verify_cred(type, fido_cred_fmt(cred), fido_cred_authdata_ptr(cred),
	    fido_cred_authdata_len(cred), fido_cred_attstmt_ptr(cred),
	    fido_cred_attstmt_len(cred), rk, uv, ext, key_out, id_out);

    if (blobkey_out != NULL) {
		/* extract the "largeBlob" key */
		if (write_blob(blobkey_out, fido_cred_largeblob_key_ptr(cred),
		    fido_cred_largeblob_key_len(cred)) < 0)
			errx(1, "write_blob");
    fido_cred_free(&cred);        

    exit(0); 
    

}
}
























