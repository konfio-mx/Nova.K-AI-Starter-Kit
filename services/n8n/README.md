# n8n Configuration

This directory contains configuration and data for the n8n workflow automation platform.

## Directory Structure

- `data/`: Contains n8n data, workflows, and credentials

## Important Notes

- Workflows are stored in `data/.n8n/workflows`
- Credentials are stored in `data/.n8n/credentials`
- Do not commit sensitive credentials to version control

## Custom Nodes

If you need to add custom n8n nodes, you can place them in a `custom` directory and mount it in the docker-compose.yml file.

## Useful Commands

- View n8n logs:
  ```bash
  docker-compose logs -f n8n
  ```

- Access n8n shell:
  ```bash
  docker-compose exec n8n /bin/sh
  ```

- Backup workflows:
  ```bash
  docker-compose exec n8n n8n export:workflow --all --output=/home/node/.n8n/backups/workflows.json
  ```

## Additional Resources

- [n8n Documentation](https://docs.n8n.io/)
- [n8n Community Forum](https://community.n8n.io/)
- [n8n Academy](https://academy.n8n.io/)
