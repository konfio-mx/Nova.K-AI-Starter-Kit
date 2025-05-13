# Customer Support AI Agent

This example demonstrates how to build an AI agent that can answer customer support questions using a knowledge base of product information and FAQs.

## Features

- Responds to customer queries using a knowledge base
- Handles common support scenarios
- Provides accurate and helpful responses
- Escalates complex issues to human support

## How It Works

1. **Knowledge Ingestion**: The agent loads product documentation, FAQs, and support articles into a vector database
2. **Query Processing**: When a customer asks a question, the agent searches for relevant information
3. **Response Generation**: The agent uses an LLM to generate a helpful response based on the retrieved information
4. **Escalation Logic**: If the agent cannot confidently answer, it suggests escalation to human support

## Setup Instructions

1. Import the workflow into n8n:
   - Go to Workflows > Import from file
   - Select `customer-support-agent.json` from this directory

2. Set up the knowledge base:
   - Create a collection in Qdrant using the included setup workflow
   - Run the document ingestion workflow to populate the knowledge base

3. Configure the webhook:
   - Activate the workflow
   - Note the webhook URL for integration with your support channels

## Usage

Send a POST request to the webhook URL with the following JSON structure:

```json
{
  "query": "How do I reset my password?",
  "customer_id": "12345",
  "context": {
    "previous_interactions": []
  }
}
```

The agent will respond with:

```json
{
  "response": "To reset your password, please follow these steps:\n1. Go to the login page\n2. Click on 'Forgot Password'\n3. Enter your email address\n4. Follow the instructions sent to your email",
  "sources": [
    {
      "title": "Password Reset Guide",
      "url": "https://example.com/help/password-reset"
    }
  ],
  "confidence": 0.92,
  "requires_human": false
}
```

## Customization

You can customize this agent by:

1. **Expanding the knowledge base**: Add more documents to improve coverage
2. **Tuning the LLM prompts**: Adjust the system prompts for different response styles
3. **Adding authentication**: Secure the webhook with API keys or other authentication
4. **Implementing feedback loops**: Collect user feedback to improve responses over time

## Integration Ideas

- Connect to your customer support ticketing system
- Integrate with chat platforms like Slack or Microsoft Teams
- Add to your website as a chatbot
- Use in your mobile app for in-app support
