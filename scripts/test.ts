import { execSync } from "child_process";
import * as fs from "fs-extra";
import * as path from "path";
import TSConfig from "../tsconfig.json";
import CONFIG from "./utils/config";
import { wsl2win } from "./utils/wslPath";

if (!CONFIG.mapDeployDir) {
    throw `Missing "mapDeployDir" key in config.json`;
}

const outPath = path.join(process.cwd(), TSConfig.compilerOptions.outDir ?? "./out");
const archivePath = path.join(outPath, "./bin", CONFIG.mapFolder);
const deployPath = path.join(CONFIG.mapDeployDir, CONFIG.mapFolder);

console.log(`Copying map to "${deployPath}"`);
fs.copyFileSync(archivePath, deployPath);

// Having an invalid path passed to -loadfile causes the map to pause/desync of load.
const launchOptions = `${CONFIG.launchOptions.join(" ")} -loadfile "${
    CONFIG.wsl2Fix === true ? wsl2win(deployPath) : deployPath
}"`;

console.log(`Launching game...`);
execSync(`"${CONFIG.gameBin}" ${launchOptions}`);
