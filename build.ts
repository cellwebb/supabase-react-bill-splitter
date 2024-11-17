import { build } from "@std/esbuild/mod.ts";

await build({
  entryPoints: ["./src/main.tsx"],
  outfile: "./dist/main.js",
  bundle: true,
  minify: true,
  platform: "browser",
  format: "esm",
  jsx: "automatic",
  jsxImportSource: "react",
  define: {
    "process.env.NODE_ENV": '"production"',
  },
  plugins: [
    {
      name: "env",
      setup(build) {
        // Handle environment variables
        build.onResolve({ filter: /^env$/ }, () => {
          return { path: "env", namespace: "env-ns" };
        });
        build.onLoad({ filter: /.*/, namespace: "env-ns" }, () => {
          return {
            contents: JSON.stringify({
              VITE_SUPABASE_URL: Deno.env.get("VITE_SUPABASE_URL"),
              VITE_SUPABASE_ANON_KEY: Deno.env.get("VITE_SUPABASE_ANON_KEY"),
            }),
            loader: "json",
          };
        });
      },
    },
  ],
});
