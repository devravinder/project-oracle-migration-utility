# Migrations From Existing DB

## Setup

```bash
docker compose up -d
```

```bash

## Optional

# Watch dev DB seed (takes ~2-3 min first time)
docker logs -f oracle-19c-dev    # wait for "DATABASE IS READY TO USE!"


#============

docker logs -f oracle-19c-local  # wait for "DATABASE IS READY TO USE!"

```

## Migration
```bash

./gradlew generateChangelogFromDev
./gradlew fixChangelogSchemaRefs
./gradlew reorderChangelog
./gradlew extractProcsFromDev
./gradlew createMasterChangelog
./gradlew applyChangelogToLocal

```
or
```bash
./gradlew fullMigration
```

## Clean up
```bash
docker compose down
```

```bash
docker compose down -v
```

## Note:-
1.  Community Liquibase limitation: generateChangeLog captures tables, views, sequences, indexes, constraints 
    - but NOT stored procedures/functions/packages/triggers. 
    - Those need to be exported manually as SQL files (see Step 2 workaround below).

## Prompt
This project is migration utility for oracle db to set up oracle db on local environment from dev environment.
The dev db is already created with schema, tables, functions & stored procedures.

This project uses liquibase to achieve the goal.

Currently, this project uses both dev, local db from docker, for dev db...we created seed data using entry points to mimic real world.


we run the following commands to do migrations

./gradlew fullMigration
