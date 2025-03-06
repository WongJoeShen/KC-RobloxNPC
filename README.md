# KC-RobloxNPC
## Description
This project integrates an AI-powered Trainer NPC in Roblox using Google Gemini 2.0 Flash Experimental. The NPC can answer user queries, provide programming guidance, and interact dynamically using an external API. The API is hosted separately via a Node.js server, ensuring real-time responses.

## Project Setup
Things you need to download:
  1. [Roblox Studio](https://create.roblox.com)
  2. [VS Code](https://code.visualstudio.com/download)
  3. [Rojo](https://marketplace.visualstudio.com/items?itemName=evaera.vscode-rojo) - VSCode Plugin
  4. [Luau](https://marketplace.visualstudio.com/items?itemName=JohnnyMorganz.luau-lsp) - VSCode Plugin
     > Why use Luau instead of Lua?
     > 
     > Luau is a performance-optimized version of Lua designed specifically for Roblox.

## API Key & Server Setup
>[!WARNING]
> **DO NOT UPLOAD YOUR API KEY TO THE GITHUB REPO**

1. Get an API key from any LLM of your preference.

2. Host your API key with a Node.js server.
   > Don't forget about the dependencies for the server too `/apiserver/package.json`
   >   
   > I used [Glitch](https://glitch.com) to host the API server`/apiserver/server.js`, but you can use these free alternatives as well:
   > - [Replit](https://replit.com)
   > - [Railway](https://railway.com)
   > - [Vercel](https://vercel.com)

## Video Guides
1. Setting up  Rojo + VS Code
   - [Video 1 - 3 years ago](https://youtu.be/ulBM7UdHk_4?si=j_rIfE0qHA3ty1nc)
   - [Video 2 - 5 months ago](https://youtu.be/18-cGOjfrKw?si=wVtNliil9bKXbDEx)
2. [Setting up The API Server + Trainer NPC](https://youtu.be/DpPugbWPViw?si=SspoBODLu9MuVXZj)

## Contribution
1. Fork the Repository
2. Create a branch.
3. Make sure to test the codes before submiting the pull request.

## License
This project is under the Apache-2.0 license. See [LICENSE](https://github.com/WongJoeShen/KC-RobloxNPC/tree/main?tab=Apache-2.0-1-ov-file#) for details
