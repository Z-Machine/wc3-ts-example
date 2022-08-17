# wc3-ts-template

## Work in Progress

_This is very basic at the moment._

An easy to use template to get you started coding in TypeScript for Warcraft III maps.

## Usage

```bash
npx degit github:Z-Machine/wc3-ts-template my-new-project
cd ./my-new-project
npm i
code .
```

Open up `config.json` in the root folder and setup for your local environment.

## Commands

-   `npm run dev`
    -   Runs a file watcher on all the maps contained within `/maps/` and
        generates d.ts files for variables inside war3map.lua that get outputted to `/src/{map name}.d.ts`
-   `npm run build`
    -   Builds and exports the map as a folder and a binary file into `/out/`
-   `npm run clean`
    -   Empties the `/out/` folder
-   `npm run test`
    -   Will deploy the binary map file to the configured path and then will launch wc3 with -loadfile
