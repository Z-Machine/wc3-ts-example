import * as fs from "fs-extra";
import * as path from "path";
import TSConfig from "../tsconfig.json";

const outDir = TSConfig.compilerOptions.outDir ?? "./out";
const outDirPath = path.join(process.cwd(), outDir);
fs.emptyDirSync(outDirPath);
