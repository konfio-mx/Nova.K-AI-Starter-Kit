# Ollama Configuration

This directory contains configuration and data for Ollama, the local LLM server.

## Directory Structure

- `data/`: Contains Ollama models and configuration

## Recommended Models

For the best experience with this starter kit, we recommend pulling these models:

1. **llama3** - Meta's Llama 3 model, good all-around performance
2. **mistral** - Mistral 7B, efficient and high-quality
3. **phi** - Microsoft's Phi-2, small but powerful

You can pull these models using:

```bash
task pull-models
```

Or manually:

```bash
docker-compose exec ollama ollama pull llama3
docker-compose exec ollama ollama pull mistral
docker-compose exec ollama ollama pull phi
```

## Model Management

- List installed models:
  ```bash
  docker-compose exec ollama ollama list
  ```

- Remove a model:
  ```bash
  docker-compose exec ollama ollama rm model-name
  ```

- Get model information:
  ```bash
  docker-compose exec ollama ollama show model-name
  ```

## Custom Models

You can create custom models with specific parameters or system prompts:

```bash
docker-compose exec ollama ollama create mycustom -f Modelfile
```

Example Modelfile:
```
FROM llama3
PARAMETER temperature 0.7
SYSTEM You are a helpful AI assistant for Konfío Bank.
```

## API Usage

Ollama provides a REST API that can be accessed at `http://ollama:11434/api` from other containers or `http://localhost:11434/api` from your host machine.

Example API call:
```bash
curl -X POST http://ollama:11434/api/generate -d '{
  "model": "llama3",
  "prompt": "What is an AI agent?",
  "stream": false
}'
```

## Additional Resources

- [Ollama Documentation](https://ollama.ai/docs)
- [Ollama GitHub Repository](https://github.com/ollama/ollama)
- [Ollama Model Library](https://ollama.ai/library)
