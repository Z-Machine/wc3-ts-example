import CONFIG from "../../config.json";

export interface IConfig {
    mapFolder: string;
    minifyScript: boolean;
    gameBin: string;
    launchOptions: string[];
    mapDeployDir?: string;
    wsl2Fix?: boolean;
}

export default CONFIG as IConfig;
