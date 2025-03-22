import copyfiles from 'copyfiles';
import esbuild from 'esbuild';
import path from 'path';
import { fileURLToPath } from 'url';

// Résoudre __dirname en mode ES Module
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Copier les fichiers du dossier "public" vers "dist"
copyfiles(['public/**/*', 'dist'], { up: 1 }, () => {
    console.log('📂 Fichiers copiés dans dist/');
});

// Liste des fichiers d'entrée et leurs noms globaux
const entries = [
    { file: "archethic.ts", globalName: "archethic" },
    { file: "background.ts", globalName: "background" },
    { file: "content.js", globalName: "content" }
];

// Fonction pour builder chaque fichier individuellement
async function buildAll() {
    for (const entry of entries) {
        await esbuild.build({
            entryPoints: [path.resolve(__dirname, "src", entry.file)],
            bundle: true,
            sourcemap: "inline",
            outdir: path.resolve(__dirname, "dist"),
            format: "iife",  // Format IIFE pour exposer une variable globale
            target: "esnext",
            platform: "browser",
            globalName: entry.globalName,  // Définir un globalName unique
            loader: {
                ".ts": "ts",
                ".tsx": "tsx"
            },
            tsconfig: path.resolve(__dirname, "tsconfig.json"),
        });

        console.log(`✅ Build terminé pour ${entry.file} -> ${entry.globalName}`);
    }
}

// Exécuter le build
buildAll().catch(() => process.exit(1));