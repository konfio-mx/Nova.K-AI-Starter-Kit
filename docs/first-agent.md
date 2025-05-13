# Creating Your First AI Agent

This tutorial will guide you through creating your first AI agent using the Nova.K starter kit. We'll build a simple question-answering agent that can respond to queries using a knowledge base.

## Prerequisites

- Nova.K starter kit running (all services started)
- Basic understanding of workflows (no coding required!)

## Step 1: Access n8n

Open your browser and navigate to [http://localhost:5678](http://localhost:5678). You should see the n8n dashboard.

## Step 2: Create a New Workflow

1. Click on "Workflows" in the left sidebar
2. Click the "+ Create Workflow" button
3. Name your workflow "Simple QA Agent"

## Step 3: Set Up the Trigger

1. Click the "+ Add Trigger" button
2. Search for "Webhook" and select it
3. Configure the webhook:
   - Click on "Add Webhook"
   - Select "REST API"
   - Method: POST
   - Path: qa-agent
   - Authentication: None
   - Response Mode: Last Node
4. Click "Save" to create the webhook

## Step 4: Add LLM Processing

1. Click the "+ Add Node" button
2. Search for "Ollama" and select it
3. Configure the Ollama node:
   - Model: llama3 (or any model you've pulled)
   - Operation: Chat
   - System Prompt: "You are a helpful assistant that answers questions accurately and concisely."
   - Message: Use an expression to get the input from the webhook:

     ```plain
     {{$json.question}}
     ```

   - Temperature: 0.7

## Step 5: Format the Response

1. Add another node by clicking "+ Add Node"
2. Search for "Set" and select it
3. Configure the Set node:
   - Keep Only Set: Checked
   - Add Value:
     - Name: response
     - Type: String
     - Value: `{{$node["Ollama"].json.message.content}}`

## Step 6: Test Your Agent

1. Click "Save" in the top right to save your workflow
2. Click "Activate" to make your webhook active
3. Copy the webhook URL (it should look like `http://localhost:5678/webhook/qa-agent`)
4. Use a tool like curl, Postman, or a simple HTTP request to test your agent:

```bash
curl -X POST http://localhost:5678/webhook/qa-agent \
  -H "Content-Type: application/json" \
  -d '{"question": "What is an AI agent?"}'
```

You should receive a response from your AI agent!

## Step 7: Enhance Your Agent (Optional)

Now that you have a basic agent working, you can enhance it by:

1. Adding error handling
2. Implementing rate limiting
3. Adding a knowledge base using Qdrant
4. Creating a more sophisticated conversation flow

## Next Steps

Congratulations! You've created your first AI agent. To learn more about building advanced agents, check out:

- [Key Concepts](concepts.md) to understand the fundamentals
- [Advanced Usage](advanced-usage.md) for more complex agent patterns
- [Example Agents](../examples/) for inspiration and templates

Happy building!
