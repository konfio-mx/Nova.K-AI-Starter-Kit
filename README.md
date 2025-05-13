# 🚀 Nova.K AI Agent Starter Kit

Welcome to the Nova.K AI Agent and Automation Starter Kit! This project provides everything you need to start building powerful AI agents and workflow automations for various ideas and scenarios, regardless of your technical background.

![Nova.K Banner](docs/images/nova-k-banner.png)

## :key: Key Features

- **Low-code Development**: Create agents without writing code using n8n's visual workflow editor - if not using CodeGPT Agents
- **Local LLM Processing**: Run AI models locally for privacy and cost savings - Ollama, Deepseek, etc.
- **Vector Search**: Implement semantic search and RAG patterns with Qdrant
- **Extensible Architecture**: Add new capabilities through n8n nodes and integrations, like Google Drive, Sheets, Docs, Notion, Slack, and other APIs
- **Comprehensive Examples**: Learn from working examples covering common use cases

## 📋 Overview

This starter kit provides a complete environment for developing integrations with AI agents and workflows using:

- **n8n**: Low-code workflow automation platform with 400+ integrations and AI components
- **Ollama/deepseek**: Run powerful LLMs locally on your machine
- **Open WebUI**: ChatGPT-like interface for interacting with your local models
- **Qdrant**: Vector database for semantic search and retrieval
- **PostgreSQL**: Reliable database for storing structured data

All components are pre-configured and ready to use through Docker, making setup easy regardless of your technical expertise.

## 🔧 Prerequisites

- **Docker** (or a compatible container runtime):
  - **Docker Desktop**: Recommended for most users on Windows, macOS, and Linux.
    - Installation: [Download Docker Desktop](https://www.docker.com/products/docker-desktop/)
    - Docker Compose is typically included with Docker Desktop.
  - **Alternatives**:
    - **Podman**: A daemonless container engine.
      - Installation: [Podman Installation Guide](https://podman.io/docs/installation)
      - You will also need `podman-compose`.
    - **OrbStack**: A fast, light, and easy way to run Docker containers and Linux machines on macOS.
      - Installation: [OrbStack Website](https://orbstack.dev/)
- **Git**: To clone this repository.
  - Installation: [Git Downloads](https://git-scm.com/downloads)
- **RAM**: 8GB+ RAM is recommended, especially for running Large Language Models (LLMs) locally. More RAM (16GB+) will provide a better experience. Or use CodeGPT for it.

## 🚀 Quick Start

### 1. Clone this repository

Open your terminal, copy and paste the following commands.

```bash
git clone https://github.com/konfio/nova-k-starter-kit.git
cd nova-k-starter-kit
```

### 2. Start the services

Using Task (recommended):

```bash
task start
```

### 3. Access the services

Once all services are running, you can access them at:

- **n8n**: [http://localhost:5678](http://localhost:5678)
- **Open WebUI**: [http://localhost:3000](http://localhost:3000)
- **Qdrant Dashboard**: [http://localhost:6333/dashboard](http://localhost:6333/dashboard)

### 4. Set up your first agent

Follow our [First Agent Tutorial](docs/first-agent.md) to create your first AI agent in minutes!

## 📚 What's Included

- **Pre-configured Docker environment** with all necessary services
- **Example workflows** for common AI agent scenarios
- **Step-by-step tutorials** for building different types of agents
- **Integration templates** for connecting to various data sources
- **Best practices** for AI agent development

## 🗂️ Project Structure

```bash
nova-k-starter-kit/
├── docker-compose.yml       # Docker configuration for all services
├── Taskfile.yml             # Task automation for common operations
├── .env.example             # Example environment variables
├── services/                # Service-specific configurations
│   ├── n8n/                 # n8n configuration and workflows
│   ├── ollama/              # Ollama models and configuration
│   ├── openwebui/           # Open WebUI configuration
│   └── qdrant/              # Qdrant vector database configuration
├── examples/                # Example workflows and agents
│   ├── customer-support/    # Customer support agent example
│   ├── data-analysis/       # Data analysis agent example
│   └── document-qa/         # Document Q&A agent example
└── docs/                    # Documentation
    ├── images/              # Images for documentation
    ├── first-agent.md       # Getting started tutorial
    ├── concepts.md          # Key concepts explanation
    └── advanced-usage.md    # Advanced usage guides
```

## 🧩 Example Agents

This starter kit includes several example agents to help you get started:

1. **Customer Support Agent**: Answers customer queries using your knowledge base
2. **Data Analysis Agent**: Analyzes data from various sources and generates insights
3. **Document Q&A Agent**: Answers questions based on document content

Check the [examples directory](examples/) for more details on each example.

## 📖 Documentation

- [First Agent Tutorial](docs/first-agent.md): Step-by-step guide to creating your first agent
- [Key Concepts](docs/concepts.md): Understanding the core concepts of AI agents
- [Advanced Usage](docs/advanced-usage.md): Taking your agents to the next level

## 🛠️ Troubleshooting

Having issues? Check our [Troubleshooting Guide](docs/troubleshooting.md) or open an issue on this repository.

For support and queries, use the #nova_k25_hachathon Slack channel.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
