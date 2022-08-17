import { execSync } from "child_process";
import { fdir } from "fdir";
import * as fs from "fs-extra";
import War3Map from "mdx-m3-viewer/dist/cjs/parsers/w3x/map";
import * as path from "path";
import tsconfig from "../../tsconfig.json";
import type { IConfig } from "./config";
import CONFIG from "./config";

// This isn't needed anymore
export function fixRequire(lua: string): string {
    const regex = /return require\("index", ...\)/gi;
    return lua.replace(regex, `require("index", ...)`);
}

export function CompileMap(config: IConfig) {
    if (!config.mapFolder) {
        console.error(`Could not find key "mapFolder" in config.`);
        return false;
    }

    const luaBundlePath = path.join(tsconfig.compilerOptions.outDir ?? "out", tsconfig.tstl.luaBundle);
    if (fs.existsSync(luaBundlePath)) {
        fs.unlinkSync(luaBundlePath);
    }

    const srcPath = path.join(process.cwd(), "./maps/", CONFIG.mapFolder);
    const distPath = path.join(process.cwd(), "./out/", CONFIG.mapFolder);

    fs.ensureDirSync(srcPath);
    fs.emptyDirSync(distPath);

    console.log(`Building "${CONFIG.mapFolder}"...`);
    fs.copySync(srcPath, distPath);

    console.log(`Transpiling TypeScript to Lua...`);
    execSync(`tstl -p tsconfig.json`, { stdio: "inherit" });

    if (!fs.existsSync(luaBundlePath)) {
        console.error(`Could not find luaBundle. "${luaBundlePath}"`);
        return false;
    }

    // Merge TSTL bundle with war3map.lua.
    const mapLuaPath = path.join(distPath, "./war3map.lua");
    if (!fs.existsSync(mapLuaPath)) {
        console.error(`Could not find map script. "${mapLuaPath}"`);
        return false;
    }

    try {
        let lua = fs.readFileSync(mapLuaPath).toString("utf-8");
        lua += fs.readFileSync(luaBundlePath).toString("utf-8");
        //lua = fixRequire(lua);

        // TODO: minifier.
        fs.writeFileSync(mapLuaPath, lua, {
            encoding: "utf-8",
        });
    } catch (err) {
        console.error(err);
        return false;
    }

    return true;
}

export function CreateMapFromDirectory(fileName: string, dirPath: string): void {
    const map = new War3Map();
    const files = new fdir()
        .crawlWithOptions(dirPath, {
            includeBasePath: true,
            resolvePaths: true,
        })
        .sync() as string[];

    map.archive.resizeHashtable(files.length);

    for (const filePath of files) {
        const contents = fs.readFileSync(filePath);
        const archivePath = path.relative(dirPath, filePath);
        const imported = map.import(archivePath, contents);

        if (!imported) {
            console.error(`Failed to import "${archivePath}"`);
            continue;
        }
    }

    const result = map.save();
    if (!result) {
        console.error(`Failed to save archive.`);
        return;
    }

    fs.writeFileSync(fileName, result);
}
