# Troubleshooting Guide

This guide helps you resolve common issues you might encounter when using the Nova.K AI Agent Starter Kit.

## Docker Issues

### Services Won't Start

**Symptoms:**

- Docker containers fail to start
- Error messages about ports already in use

**Solutions:**

1. Check if the required ports are already in use:

   ```bash
   lsof -i :5678  # Check if n8n port is in use
   lsof -i :3000  # Check if Open WebUI port is in use
   lsof -i :6333  # Check if Qdrant port is in use
   ```

2. Stop conflicting services or change ports in `docker-compose.yml`

3. Ensure Docker has enough resources:
   - Increase memory allocation in Docker Desktop settings
   - Restart Docker Desktop

### Container Exits Immediately

**Symptoms:**

- Container starts and then stops immediately
- Error messages in logs

**Solutions:**

1. Check container logs:

   ```bash
   docker-compose logs [service-name]
   ```

2. Verify file permissions:

   ```bash
   chmod -R 777 ./services/[service-name]/data
   ```

3. Check for disk space issues:

   ```bash
   df -h
   ```

## n8n Issues

### Workflow Not Triggering

**Symptoms:**

- Webhook doesn't respond
- Scheduled workflows don't run

**Solutions:**

1. Check if workflow is activated:
   - In n8n UI, ensure the toggle is set to "Active"

2. Verify webhook URL:
   - Make sure you're using the correct URL format
   - Check if the webhook node is configured correctly

3. Check n8n logs:

   ```bash
   docker-compose logs n8n
   ```

### Node Execution Errors

**Symptoms:**

- Workflow shows red error indicators
- Execution fails at specific nodes

**Solutions:**

1. Check node configuration:
   - Verify all required fields are filled
   - Check expression syntax for errors

2. Test API connections:
   - Use the "Test API Call" button where available
   - Check credentials and API keys

3. Increase timeout settings for long-running operations

## Ollama Issues

### Models Not Loading

**Symptoms:**

- "Model not found" errors
- Slow or failed model loading

**Solutions:**

1. Pull the model manually:

   ```bash
   docker-compose exec ollama ollama pull llama3
   ```

2. Check disk space:

   ```bash
   df -h
   ```

3. Verify model compatibility with your hardware

### Slow Response Times

**Symptoms:**

- LLM responses take a long time
- Timeouts in n8n workflows

**Solutions:**

1. Use a smaller model:
   - Try models like `phi` or `mistral` instead of larger ones

2. Adjust batch size and context settings:
   - Lower values use less memory but may be slower

3. Check system resources:
   - Monitor CPU and memory usage during model execution

## Qdrant Issues

### Connection Errors

**Symptoms:**

- Cannot connect to Qdrant
- API calls fail with connection errors

**Solutions:**

1. Check if Qdrant is running:

   ```bash
   docker-compose ps qdrant
   ```

2. Verify network connectivity:

   ```bash
   docker-compose exec n8n ping qdrant
   ```

3. Check Qdrant logs:

   ```bash
   docker-compose logs qdrant
   ```

### Collection Creation Failures

**Symptoms:**

- Cannot create collections
- Error messages about vector dimensions

**Solutions:**

1. Verify collection configuration:
   - Ensure vector dimensions match your embedding model
   - Check for duplicate collection names

2. Use the Qdrant dashboard to inspect collections:
   - Access at <http://localhost:6333/dashboard>

## Open WebUI Issues

### UI Not Loading

**Symptoms:**

- Blank page or loading errors
- Cannot access the interface

**Solutions:**

1. Check if the service is running:

   ```bash
   docker-compose ps openwebui
   ```

2. Clear browser cache and cookies

3. Try a different browser

### Cannot Connect to Ollama

**Symptoms:**

- Error messages about Ollama connection
- Models don't appear in the UI

**Solutions:**

1. Verify Ollama is running:

   ```bash
   docker-compose ps ollama
   ```

2. Check the environment variables in docker-compose.yml:
   - Ensure `OLLAMA_API_BASE_URL` is set correctly

3. Restart both services:

   ```bash
   docker-compose restart ollama openwebui
   ```

## General Workflow Issues

### Data Format Problems

**Symptoms:**

- Errors about invalid JSON
- Unexpected data formats

**Solutions:**

1. Use "Debug" nodes to inspect data:
   - Add a Debug node after problematic nodes
   - Check the output format

2. Transform data explicitly:
   - Use "Set" nodes to format data correctly
   - Use JSON.parse() and JSON.stringify() when needed

### Memory Issues

**Symptoms:**

- Services crash under load
- Out of memory errors

**Solutions:**

1. Limit context sizes in LLM calls

2. Process data in smaller batches

3. Increase Docker memory allocation

## Still Having Issues?

If you're still experiencing problems:

1. Check the GitHub repository for known issues
2. Search the n8n and Ollama documentation
3. Open an issue on the Nova.K repository with:
   - Detailed description of the problem
   - Steps to reproduce
   - Logs and error messages
   - System information (OS, Docker version, etc.)
