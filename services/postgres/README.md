# PostgreSQL Configuration

This directory contains configuration and data for PostgreSQL, the database used by n8n and other services.

## Directory Structure

- `data/`: Contains PostgreSQL data files

## Connection Details

- **Host**: `postgres` (from Docker network) or `localhost` (from host)
- **Port**: 5432
- **Username**: postgres
- **Password**: postgres
- **Database**: n8n

## Usage

### Connecting from n8n

n8n is pre-configured to connect to this PostgreSQL instance. No additional setup is required.

### Connecting from Host Machine

You can connect to the database using any PostgreSQL client:

```bash
psql -h localhost -p 5432 -U postgres -d n8n
```

### Executing SQL Commands

```bash
docker-compose exec postgres psql -U postgres -d n8n -c "SELECT * FROM information_schema.tables;"
```

## Database Management

### Backup

Create a database backup:

```bash
docker-compose exec postgres pg_dump -U postgres n8n > backup.sql
```

### Restore

Restore from a backup:

```bash
cat backup.sql | docker-compose exec -T postgres psql -U postgres -d n8n
```

### Creating Additional Databases

```bash
docker-compose exec postgres createdb -U postgres my_new_database
```

## Security Notes

- The default credentials are for development only
- For production, change the password and restrict access
- Consider enabling SSL for secure connections

## Additional Resources

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [PostgreSQL Docker Image](https://hub.docker.com/_/postgres)
- [PostgreSQL Tutorial](https://www.postgresqltutorial.com/)
