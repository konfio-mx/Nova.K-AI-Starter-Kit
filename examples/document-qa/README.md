# Document Q&A AI Agent

This example demonstrates how to build an AI agent that can answer questions based on document content, making it easy to extract information from PDFs, Word documents, and other text-based files.

## Features

- Processes various document formats (PDF, DOCX, TXT, etc.)
- Extracts and indexes document content
- Answers questions based on document content
- Provides source references for answers
- Handles multiple documents simultaneously

## How It Works

1. **Document Processing**: The agent extracts text from documents and splits it into manageable chunks
2. **Embedding Generation**: Each chunk is converted into a vector embedding
3. **Vector Storage**: Embeddings are stored in Qdrant with metadata
4. **Query Processing**: When a question is asked, it's converted to an embedding and similar chunks are retrieved
5. **Answer Generation**: The LLM generates an answer based on the retrieved chunks

## Setup Instructions

1. Import the workflow into n8n:
   - Go to Workflows > Import from file
   - Select `document-qa-agent.json` from this directory

2. Configure document storage:
   - Create a folder for document uploads
   - Update the path in the workflow configuration

3. Set up the vector database:
   - Run the setup workflow to create the necessary collection in Qdrant

4. Activate the workflow:
   - Enable the webhook trigger
   - Note the webhook URL for document uploads and queries

## Usage

### Step 1: Upload Documents

Send a POST request to the document upload webhook:

```bash
curl -X POST http://localhost:5678/webhook/document-upload \
  -F "file=@sample_document.pdf" \
  -F "document_id=doc123" \
  -F "title=Sample Document"
```

### Step 2: Ask Questions

Send a POST request to the question webhook:

```bash
curl -X POST http://localhost:5678/webhook/document-qa \
  -H "Content-Type: application/json" \
  -d '{
    "question": "What are the key points in the document?",
    "document_ids": ["doc123"],
    "max_results": 5
  }'
```

The agent will respond with:

```json
{
  "answer": "The key points in the document are: 1) Project timeline extends from January to June 2023, 2) Budget allocation is $500,000, 3) Main objectives include increasing customer satisfaction by 25% and reducing operational costs by 15%, 4) Team consists of 8 members across 3 departments.",
  "sources": [
    {
      "document_id": "doc123",
      "document_title": "Sample Document",
      "page": 2,
      "text": "Project timeline: January - June 2023. Budget: $500,000."
    },
    {
      "document_id": "doc123",
      "document_title": "Sample Document",
      "page": 3,
      "text": "Objectives: Increase customer satisfaction by 25%, reduce operational costs by 15%."
    }
  ],
  "confidence": 0.87
}
```

## Advanced Features

### Multi-Document Queries

Ask questions across multiple documents:

```json
{
  "question": "Compare the financial projections across all quarterly reports",
  "document_ids": ["q1_report", "q2_report", "q3_report", "q4_report"],
  "max_results": 10
}
```

### Document Filtering

Filter documents by metadata:

```json
{
  "question": "What were the sales figures?",
  "filters": {
    "department": "sales",
    "year": "2023"
  }
}
```

### Conversation Mode

Maintain context across multiple questions:

```json
{
  "question": "What does the document say about risk factors?",
  "conversation_id": "conv123",
  "document_ids": ["annual_report"]
}
```

Then follow up with:

```json
{
  "question": "How do they compare to last year?",
  "conversation_id": "conv123"
}
```

## Customization

You can customize this agent by:

1. **Adding document preprocessing**: Implement OCR for scanned documents
2. **Enhancing chunking strategies**: Optimize how documents are split
3. **Implementing document refresh**: Update document content when files change
4. **Adding summarization**: Generate document summaries automatically

## Integration Ideas

- Connect to document management systems
- Integrate with email for document processing
- Add to internal knowledge bases
- Use for contract analysis or research assistance
