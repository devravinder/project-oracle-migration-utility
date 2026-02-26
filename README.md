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