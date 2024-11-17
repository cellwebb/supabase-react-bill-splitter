import { serve } from "@std/http/server.ts";
import { serveDir } from "@std/http/file_server.ts";

const port = 8000;

async function handler(req: Request): Promise<Response> {
  const pathname = new URL(req.url).pathname;

  // Serve static files from the dist directory
  if (pathname.startsWith("/assets/")) {
    return await serveDir(req, {
      fsRoot: "dist",
      urlRoot: "assets",
    });
  }

  // Serve index.html for all other routes (SPA behavior)
  return new Response(await Deno.readFile("./dist/index.html"), {
    headers: { "content-type": "text/html; charset=utf-8" },
  });
}

console.log(`HTTP server running on http://localhost:${port}`);
await serve(handler, { port });
