# KC-RobloxNPC
## Description
This project integrates an AI-powered Trainer NPC in Roblox using Google Gemini 2.0 Flash Experimental. The NPC can answer user queries, provide programming guidance, and interact dynamically using an external API. The API is hosted separately via a Node.js server, ensuring real-time responses.

## Installation & Setup

### **Prerequisites**
Ensure you have the following installed:

- [Roblox Studio](https://create.roblox.com) - For developing the NPC.
- [VS Code](https://code.visualstudio.com/download) - Preferred code editor.
- [Rojo](https://marketplace.visualstudio.com/items?itemName=evaera.vscode-rojo) - VSCode Plugin for syncing scripts with Roblox Studio.
- [Luau](https://marketplace.visualstudio.com/items?itemName=JohnnyMorganz.luau-lsp) - VSCode Plugin for Luau syntax highlighting.

### **Setting Up Rojo**
```sh
1. Install Rojo via VS Code Marketplace.
2. Run `rojo init` in the project directory.
3. Link the project by running `rojo serve` in the terminal.
```
## Setting Up the API Server
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


## Project Structure
```sh
📦 KC-RobloxNPC
 ├── 📂 apiserver/            # Node.js API server for handling LLM requests
 │   ├── 📜 env.txt           # Environment variables (DO NOT COMMIT)
 │   ├── 📜 package.json      # Dependencies for Node.js server
 │   ├── 📜 server.js         # Main API server file
 │
 ├── 📂 cleanernpc/           # Scripts for the Cleaner NPC behavior
 │   ├── 📜 chat.luau         # Handles NPC chat responses
 │   ├── 📜 pathfinding.luau  # NPC pathfinding logic
 │
 ├── 📂 sensor/               # Scripts for sensor-based interactions
 │   ├── 📜 sensorscript.luau # Logic for detecting players
 │   ├── 📜 footprint.luau  # Spawning script
 │
 ├── 📂 src/                  # Rojo linking component for VS Code
 │   ├── 📂 client/           # Client-side scripts
 │   │   ├── 📜 init.client.luau  # Initialization script
 │   │   ├── 📜 test.client.luau  # Test script
 │   │
 │   ├── 📂 server/           # Server-side scripts
 │   │   ├── 📜 promise.luau      # Promise-based utilities
 │   │   ├── 📜 server.server.luau # Main server script
 │   │
 │   ├── 📂 shared/           # Shared modules across client/server
 │       ├── 📜 Hello.luau        # Example shared script
 │
 ├── 📂 teleporter/           # Scripts for teleporting system
 │   ├── 📜 teleporter.luau   # Handles player teleportation
 │
 ├── 📜 LICENSE               # License information
 ├── 📜 README.md             # Project documentation
 ├── 📜 aftman.toml           # Aftman package manager configuration
 ├── 📜 default.project.json  # Rojo project configuration file
```
## How It Works

### Trainer NPC Logic
1. The NPC detects player input through a GUI chat system.
2. The message is sent to the API via a **RemoteEvent**.
3. The Node.js API processes the request using **Google Gemini 2.0 Flash** and returns a response.
4. The response is displayed in the NPC's dialogue UI.
5. If the API is down or the response fails, the NPC displays a fallback message.

### Handling Errors & Edge Cases
- If no internet connection is detected, the NPC notifies the user.
- API errors result in a **default response** instead of breaking the chat system.

### API Key & Server Setup
1. Obtain an API key from your preferred LLM provider.
2. Store your API key securely and never push it to GitHub.
3. Modify `server.js` to include your API key:
   const apiKey = "YOUR_SECRET_API_KEY";
4. Restart the Node.js server after making changes.

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
