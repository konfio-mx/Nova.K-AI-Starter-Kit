# Open WebUI Configuration

This directory contains configuration and data for Open WebUI, a ChatGPT-like interface for interacting with local LLM models.

## Directory Structure

- `data/`: Contains Open WebUI data and configuration

## Features

Open WebUI provides a user-friendly interface for:

- Chatting with local LLM models
- Managing conversation history
- Creating and using custom personas
- Uploading and analyzing documents
- Comparing responses from different models

## Usage

1. Access the UI at [http://localhost:3000](http://localhost:3000)
2. Select a model from the dropdown (models are pulled from Ollama)
3. Start chatting with your local AI

## Configuration

The Open WebUI container is configured to connect to Ollama automatically. Key environment variables:

- `OLLAMA_API_BASE_URL`: Set to `http://ollama:11434/api` for container communication
- `WEBUI_AUTH`: Set to `false` for development (enable for production)

## Customization

You can customize the UI by:

- Creating custom personas with specific system prompts
- Configuring model parameters (temperature, top_p, etc.)
- Setting up RAG (Retrieval-Augmented Generation) with document uploads

## Troubleshooting

If you encounter issues:

1. Ensure Ollama is running and has models installed
2. Check the container logs:
   ```bash
   docker-compose logs openwebui
   ```
3. Restart the service:
   ```bash
   docker-compose restart openwebui
   ```

## Additional Resources

- [Open WebUI GitHub Repository](https://github.com/open-webui/open-webui)
- [Open WebUI Documentation](https://docs.openwebui.com/)
