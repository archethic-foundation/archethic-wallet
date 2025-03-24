import copyfiles from 'copyfiles';
import esbuild from 'esbuild';
import path from 'path';
import { fileURLToPath } from 'url';

// Resolve __dirname in ES Module mode
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Copy files from the "public" folder to "dist"
copyfiles(['public/**/*', 'dist'], { up: 1 }, () => {
    console.log('📂 Fichiers copiés dans dist/');
});

// List of entry files and their global names
const entries = [
    { file: "archethic.ts", globalName: "archethic" },
    { file: "background.ts", globalName: "background" },
    { file: "content.js", globalName: "content" }
];

// Function to build each file individually
async function buildAll() {
    for (const entry of entries) {
        await esbuild.build({
            entryPoints: [path.resolve(__dirname, "src", entry.file)],
            bundle: true,
            sourcemap: "inline",
            outdir: path.resolve(__dirname, "dist"),
            format: "iife",  // IIFE format to expose a global variable
            target: "esnext",
            platform: "browser",
            globalName: entry.globalName,  // Set a unique globalName
            loader: {
                ".ts": "ts",
                ".tsx": "tsx"
            },
            tsconfig: path.resolve(__dirname, "tsconfig.json"),
        });

        console.log(`✅ Build terminé pour ${entry.file} -> ${entry.globalName}`);
    }
}

// Execute the build
buildAll().catch(() => process.exit(1));