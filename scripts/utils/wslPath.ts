import * as path from "path";

export function win2wsl(absolutePath: string): string {
    if (!path.win32.isAbsolute(absolutePath)) throw new Error(`The path must be absolute.`);
    absolutePath = path.win32.normalize(absolutePath);
    const seperated = absolutePath.split(path.win32.sep);
    const joined = Array<string>().concat([seperated[0]!.toLowerCase(), ...seperated.splice(1)]);
    return path.posix.join("/mnt/", path.posix.join(...joined)).replace(":", "");
}

export function wsl2win(absolutePath: string): string {
    if (!path.posix.isAbsolute(absolutePath)) throw new Error(`The path must be absolute.`);
    absolutePath = path.posix.normalize(absolutePath);
    const seperated = absolutePath.split(path.posix.sep);
    seperated.splice(0, 2);
    return path.win32.join(...seperated).replace(seperated[0]!, seperated[0]!.toUpperCase() + ":");
}
