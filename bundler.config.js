import { readFileSync } from "node:fs";

/** @type {import("scribunto-bundler").Config} */
export default {
  prefix: readFileSync("prefix.lua", "utf-8"),

  main: "src/main.lua",
  out: "dist/bundled.lua",
};
