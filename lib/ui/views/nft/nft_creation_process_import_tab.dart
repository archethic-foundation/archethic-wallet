/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'nft_creation_process.dart';

class _NFTCreationProcessImportTab extends StatefulWidget {
  const _NFTCreationProcessImportTab({
    required this.tabActiveIndex,
    required this.currentNftCategoryIndex,
  });

  final int tabActiveIndex;
  final int currentNftCategoryIndex;

  @override
  State<_NFTCreationProcessImportTab> createState() => _NFTCreationProcessImportTabState();
}

class _NFTCreationProcessImportTabState extends State<_NFTCreationProcessImportTab> {
  @override
  Widget build(BuildContext context) {
    // TODO(reddwarf03): refacto code with Riverpod
    return const SizedBox();
  }
}
  /*
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.theme);
    File? file;
    var importSelection = 0;

    if (widget.tabActiveIndex != 0) {
      return const SizedBox();
    }

    return SingleChildScrollView(
      physics: file == null
          ? const NeverScrollableScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height + 200,
        child: Container(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  NftCategory.getDescriptionHearder(
                    context,
                    widget.currentNftCategoryIndex!,
                  ),
                  style: theme.textStyleSize12W100Primary,
                  textAlign: TextAlign.justify,
                ),
              ),
              sddssdds
              if (kIsWeb == false && (Platform.isAndroid || Platform.isIOS))
                SizedBox(
                  height: 40,
                  child: InkWell(
                    onTap: () async {
                      final pickedFile = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                        maxWidth: 1800,
                        maxHeight: 1800,
                      );
                      if (pickedFile != null) {
                        importSelection = 2;
                        file = File(pickedFile.path);
                        await setFileProperties(file!);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                              child: FaIcon(
                                FontAwesomeIcons.photoFilm,
                                size: 18,
                                color: theme.text,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              localizations.nftAddImportPhoto,
                              style: theme.textStyleSize12W400Primary,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            if (importSelection == 2)
                              const Icon(
                                Icons.check_circle,
                                size: 16,
                                color: Colors.green,
                              )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            sl.get<HapticUtil>().feedback(
                                  FeedbackType.light,
                                  StateContainer.of(context).activeVibrations,
                                );
                            AppDialogs.showInfoDialog(
                              context,
                              localizations.informations,
                              localizations.nftAddPhotoFormatInfo,
                            );
                          },
                          child: SizedBox(
                            width: 30,
                            child: FaIcon(
                              FontAwesomeIcons.circleInfo,
                              size: 18,
                              color: theme.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (kIsWeb == false && (Platform.isAndroid || Platform.isIOS))
                Divider(
                  height: 2,
                  color: theme.text15,
                ),
              if (kIsWeb == false && (Platform.isAndroid || Platform.isIOS))
                SizedBox(
                  height: 40,
                  child: InkWell(
                    onTap: () async {
                      final pickedFile = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                        maxWidth: 1800,
                        maxHeight: 1800,
                      );
                      if (pickedFile != null) {
                        importSelection = 3;
                        file = File(pickedFile.path);
                        await setFileProperties(file!);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                              child: FaIcon(
                                FontAwesomeIcons.cameraRetro,
                                size: 18,
                                color: theme.text,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Take a photo',
                              style: theme.textStyleSize12W400Primary,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            if (importSelection == 3)
                              const Icon(
                                Icons.check_circle,
                                size: 16,
                                color: Colors.green,
                              )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              Divider(
                height: 2,
                color: theme.text15,
              ),
              if (file != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: GestureDetector(
                    onTap: () async {},
                    onLongPress: () {},
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: tokenPropertyAsset!.publicKeysList != null &&
                                tokenPropertyAsset!.publicKeysList!.isNotEmpty
                            ? const BorderSide(
                                color: Colors.redAccent,
                                width: 2,
                              )
                            : BorderSide(
                                color: theme
                                    .backgroundAccountsListCardSelected!,
                              ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      color: theme
                          .backgroundAccountsListCardSelected,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          right: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: AutoSizeText(
                                            tokenPropertyAsset!
                                                .tokenProperty!.keys.first,
                                            style: AppStyles
                                                .textStyleSize12W600Primary(
                                              context,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 200,
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: AutoSizeText(
                                            tokenPropertyAsset!
                                                .tokenProperty!.values.first,
                                            style: AppStyles
                                                .textStyleSize12W400Primary(
                                              context,
                                            ),
                                          ),
                                        ),
                                        if (tokenPropertyAsset!
                                                    .publicKeysList !=
                                                null &&
                                            tokenPropertyAsset!
                                                .publicKeysList!.isNotEmpty)
                                          tokenPropertyAsset!
                                                      .publicKeysList!.length ==
                                                  1
                                              ? Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      180,
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 20,
                                                  ),
                                                  child: AutoSizeText(
                                                    'This asset is protected and accessible by ${tokenPropertyAsset!.publicKeysList!.length} public key',
                                                    style: AppStyles
                                                        .textStyleSize12W400Primary(
                                                      context,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      180,
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 20,
                                                  ),
                                                  child: AutoSizeText(
                                                    'This asset is protected and accessible by ${tokenPropertyAsset!.publicKeysList!.length} public keys',
                                                    style: AppStyles
                                                        .textStyleSize12W400Primary(
                                                      context,
                                                    ),
                                                  ),
                                                )
                                        else
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                180,
                                            padding: const EdgeInsets.only(
                                              left: 20,
                                            ),
                                            child: AutoSizeText(
                                              'This asset is accessible by everyone',
                                              style: AppStyles
                                                  .textStyleSize12W400Primary(
                                                context,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: theme
                                          .backgroundDark!
                                          .withOpacity(0.3),
                                      border: Border.all(
                                        color: theme
                                            .backgroundDarkest!
                                            .withOpacity(0.2),
                                        width: 2,
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.key,
                                        color: theme
                                            .backgroundDarkest,
                                        size: 21,
                                      ),
                                      onPressed: () {
                                        sl.get<HapticUtil>().feedback(
                                              FeedbackType.light,
                                              StateContainer.of(context)
                                                  .activeVibrations,
                                            );
                                        Sheets.showAppHeightNineSheet(
                                          context: context,
                                          widget: AddPublicKey(
                                            tokenPropertyWithAccessInfos:
                                                tokenPropertyAsset!,
                                            returnPublicKeys: (
                                              List<String> publicKeysList,
                                            ) {
                                              tokenPropertyAsset!
                                                      .publicKeysList =
                                                  publicKeysList;

                                              setState(() {});
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: theme
                                          .backgroundDark!
                                          .withOpacity(0.3),
                                      border: Border.all(
                                        color: theme
                                            .backgroundDarkest!
                                            .withOpacity(0.2),
                                        width: 2,
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: theme
                                            .backgroundDarkest,
                                        size: 21,
                                      ),
                                      onPressed: () {
                                        sl.get<HapticUtil>().feedback(
                                              FeedbackType.light,
                                              StateContainer.of(context)
                                                  .activeVibrations,
                                            );
                                        AppDialogs.showConfirmDialog(
                                            context,
                                            'Delete file',
                                            'Are you sure ?',
                                            localizations.deleteOption, () {
                                          sl.get<HapticUtil>().feedback(
                                                FeedbackType.light,
                                                StateContainer.of(context)
                                                    .activeVibrations,
                                              );
                                          importSelection = 0;
                                          file = null;
                                          file64 = '';
                                          tokenPropertyWithAccessInfosList
                                              .removeWhere(
                                            (element) =>
                                                element.tokenProperty!.keys
                                                    .first ==
                                                tokenPropertyAsset!
                                                    .tokenProperty!.keys.first,
                                          );
                                          tokenPropertyAsset!.publicKeysList!
                                              .clear();
                                          setState(() {});
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (file != null &&
                  (MimeUtil.isImage(typeMime) == true ||
                      MimeUtil.isPdf(typeMime) == true))
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.text,
                    border: Border.all(),
                  ),
                  child: Image.memory(
                    fileDecodedForPreview!,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              if (file != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Align(
                    child: Text(
                      'Format: $typeMime',
                      style: theme.textStyleSize12W400Primary,
                    ),
                  ),
                ),
              if (file != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Align(
                    child: Text(
                      '${localizations.nftAddFileSize} ${filesize(sizeFile)}',
                      style: theme.textStyleSize12W400Primary,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> setFileProperties(File file, {bool copyNFTName = false}) async {
    fileDecoded = File(file.path).readAsBytesSync();
    file64 = base64Encode(fileDecoded!);
    sizeFile = fileDecoded!.length;

    tokenPropertyWithAccessInfosList
        .removeWhere((element) => element.tokenProperty!.keys.first == 'file');
    tokenPropertyWithAccessInfosList.add(
      TokenPropertyWithAccessInfos(
        tokenProperty: <String, String>{'file': file64},
      ),
    );

    try {
      typeMime = Mime.getTypesFromExtension(
        path.extension(file.path).replaceAll('.', ''),
      )![0];

      tokenPropertyWithAccessInfosList.removeWhere(
        (element) => element.tokenProperty!.keys.first == 'type/mime',
      );
      tokenPropertyWithAccessInfosList.add(
        TokenPropertyWithAccessInfos(
          tokenProperty: <String, String>{'type/mime': typeMime},
        ),
      );
    } catch (e) {}

    if (MimeUtil.isImage(typeMime) == true) {
      fileDecodedForPreview = fileDecoded;

      /*final data = await readExifFromBytes(fileDecoded!);

      for (final entry in data.entries) {
        tokenPropertyWithAccessInfosList.add(TokenPropertyWithAccessInfos(
            tokenProperty:
                TokenProperty(name: entry.key, value: entry.value.printable)));
        tokenPropertyWithAccessInfosList.sort(
            (TokenPropertyWithAccessInfos a, TokenPropertyWithAccessInfos b) =>
                a.tokenProperty!.name!
                    .toLowerCase()
                    .compareTo(b.tokenProperty!.name!.toLowerCase()));
      }*/
    } else {
      if (MimeUtil.isPdf(typeMime) == true) {
        final pdfDocument = await PdfDocument.openData(
          File(file.path).readAsBytesSync(),
        );
        final pdfPage = await pdfDocument.getPage(1);

        final pdfPageImage =
            await pdfPage.render(width: pdfPage.width, height: pdfPage.height);
        fileDecodedForPreview = pdfPageImage!.bytes;
      }
    }
    setState(() {});
  }
}

class _NFTCreationProcessImportTab extends StatelessWidget {
  const _NFTCreationProcessImportTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
        final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.theme);

return 
Column(children: [

SizedBox(
                height: 30,
                child: InkWell(
                  onTap: () async {
                    importSelection = 1;
                    final result = await FilePicker.platform.pickFiles();

                    if (result != null) {
                      file = File(result.files.single.path!);
                      await setFileProperties(file!);
                    } else {
                      // User canceled the picker
                    }
                  },
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 30,
                        child: FaIcon(
                          FontAwesomeIcons.file,
                          size: 18,
                          color: theme.text,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        localizations.nftAddImportFile,
                        style: theme.textStyleSize12W400Primary,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      if (importSelection == 1)
                        const Icon(
                          Icons.check_circle,
                          size: 16,
                          color: Colors.green,
                        )
                    ],
                  ),
                ),
              ),
             
                Divider(
                  height: 2,
                  color: theme.text15,
                ),
  
],);

  }
}
*/
