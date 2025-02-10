const app = require("express")();          // Create an Express application
const bodyParser = require("body-parser"); // Middleware to parse JSON request bodies
const fetch = require("node-fetch");       // Enables fetch API in Node.js
const fs = require("fs");                  // File system module (not used but included)

const PORT = 8080; // Define the port for the server to listen on

// Ensure fetch API is available globally for compatibility
globalThis.fetch = fetch;
globalThis.Headers = fetch.Headers;
globalThis.Request = fetch.Request;
globalThis.Response = fetch.Response;

app.use(bodyParser.json());  // Enable JSON request parsing for incoming requests

// Import the Google Generative AI SDK
const {
  GoogleGenerativeAI,
  HarmCategory,
  HarmBlockThreshold
} = require("@google/generative-ai");

// Retrieve the API key from environment variables (must be set in .env)
const apikey = process.env.API_KEY;
const genai = new GoogleGenerativeAI(apikey);

// Configuration for AI response generation
const generationconfig = {
  temperature: 0,    // Lower value = more deterministic responses
  topP: 0.95,        // Controls randomness
  topK: 64,          // Limits possible responses to the top 64 choices
  responseMimeType: "text/plain" // Ensures response is returned as plain text
};

// Function to process chat requests using Gemini AI
async function run(prompt, history) {
  try {
    // Initialize the AI model with specific instructions and constraints
    const model = genai.getGenerativeModel({
      model: "gemini-2.0-flash-exp", // Fast version of Gemini 2.0 for quick responses
      systemInstruction: "Concise response, maximum 200 characters in length. You are a Trainer from Kidocode. Family-friendly, do not say inappropriate things."
    });

    // Start a chat session with the AI model, providing chat history
    const chatSession = model.startChat({
      generationconfig, // Apply the predefined AI settings
      history: history, // Include past conversation history
    });

    // Send the user's prompt (message) to the AI and await a response
    const result = await chatSession.sendMessage(prompt);

    // Return the AI's response in a structured format
    return { Response: true, Text: result.response.text() };
  } catch (error) {
    console.error("Error processing chat request:", error); // Log the error
    return { Response: false }; // Return failure response
  }
}

// API endpoint to handle incoming chat requests from Roblox
app.post("/", async (req, res) => {
  console.log("Received request:", req.body); // Log incoming request for debugging

  // Extract the 'prompt' (user's message) and 'history' (previous chat) from the request
  const { prompt, history } = req.body;
  
  // If no prompt is provided, return a 400 Bad Request error
  if (!prompt) {
    return res.status(400).send("Missing prompt");
  }

  // Call the 'run' function to process the chat request
  const response = await run(prompt, history);
  
  console.log("Response:", response); // Log AI's response for debugging

  // Send the AI-generated response back to the client
  // If successful, return HTTP 200; otherwise, return HTTP 500 (server error)
  res.status(response.Response ? 200 : 500).send(response.Text || "Server Error");
});

// Start the server and log status messages for debugging
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
  console.log("API Key:", process.env.API_KEY ? "Loaded" : "Missing (Check .env)");
});
