# Qdrant Configuration

This directory contains configuration and data for Qdrant, a vector database for semantic search and retrieval.

## Directory Structure

- `data/`: Contains Qdrant data and collections

## Features

Qdrant is used in this starter kit for:

- Storing document embeddings for retrieval
- Semantic search capabilities
- Knowledge base for AI agents
- Vector-based recommendation systems

## Usage

### Dashboard

Access the Qdrant dashboard at [http://localhost:6333/dashboard](http://localhost:6333/dashboard) to:

- View and manage collections
- Explore vector data
- Monitor performance

### API

Qdrant provides a REST API that can be accessed at `http://qdrant:6333` from other containers or `http://localhost:6333` from your host machine.

Example API calls:

1. Create a collection:
```bash
curl -X PUT http://localhost:6333/collections/my_collection \
  -H 'Content-Type: application/json' \
  -d '{
    "vectors": {
      "size": 1536,
      "distance": "Cosine"
    }
  }'
```

2. Add points:
```bash
curl -X PUT http://localhost:6333/collections/my_collection/points \
  -H 'Content-Type: application/json' \
  -d '{
    "points": [
      {
        "id": 1,
        "vector": [0.1, 0.2, ...],
        "payload": {
          "text": "Sample document text",
          "metadata": {
            "source": "document1.pdf",
            "page": 5
          }
        }
      }
    ]
  }'
```

3. Search:
```bash
curl -X POST http://localhost:6333/collections/my_collection/points/search \
  -H 'Content-Type: application/json' \
  -d '{
    "vector": [0.1, 0.2, ...],
    "limit": 5
  }'
```

## Integration with n8n

To use Qdrant in n8n workflows:

1. Use the HTTP Request node to interact with the Qdrant API
2. Set the URL to `http://qdrant:6333` (internal Docker network)
3. Configure the appropriate HTTP method and payload

## Additional Resources

- [Qdrant Documentation](https://qdrant.tech/documentation/)
- [Qdrant GitHub Repository](https://github.com/qdrant/qdrant)
- [Qdrant Python Client](https://github.com/qdrant/qdrant-client)
