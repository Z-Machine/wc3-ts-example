/**
 * Watch the maps directory for changes to war3map.lua files and generate definitions.
 */

import { fdir } from "fdir";
import * as fs from "fs-extra";
import * as path from "path";
import { CreateDefinitionFromFile, isWar3mapLua } from "./utils/definitions";

const timestamp = () => `[${new Date().toLocaleTimeString()}]`;

const cwd = path.join(process.cwd());
const maps = path.join(cwd, "./maps");
const src = path.join(cwd, "./src");

console.log(`Starting file watcher.`);
const files = new fdir()
    .withBasePath()
    .filter((filePath) => isWar3mapLua(filePath))
    .crawl(maps)
    .sync() as string[];

files.forEach((filePath) => {
    console.log(`${timestamp()} Generating initial d.ts for ${filePath}`);
    CreateDefinitionFromFile(filePath, src);
    fs.watch(filePath).on("change", (e) => {
        if (e !== "change") return;
        console.log(`${timestamp()} Change detected in "${filePath}"`);
        CreateDefinitionFromFile(filePath, src);
    });
    // fs.watchFile(filePath, () => {
    //     console.log(`[${new Date().toTimeString()}] Change detected in "${filePath}"`);
    //     CreateDefinitionFromFile(filePath, src);
    // });
});
