import * as fs from "fs-extra";
import * as path from "path";
import CONFIG from "./utils/config";
import { CompileMap, CreateMapFromDirectory } from "./utils/mapHelpers";

console.log("Building...");

const mapCompiled = CompileMap(CONFIG);
if (!mapCompiled) {
    throw new Error(`Failed to compile map.`);
}

console.log(`Creating w3x archive...`);
const binPath = path.join(process.cwd(), "./out/bin");
const mapDirPath = path.join(process.cwd(), "./out/", CONFIG.mapFolder);
const filePath = path.join(binPath, CONFIG.mapFolder);
fs.ensureDirSync(binPath);
if (fs.existsSync(filePath)) {
    fs.unlinkSync(filePath);
}

CreateMapFromDirectory(filePath, mapDirPath);

console.log(`Finished!`);
