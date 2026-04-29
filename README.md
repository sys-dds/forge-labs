# Forge Labs

Forge Labs is a never-ending backend learning workshop. It is not a portfolio app, a huge backend system, or a random lab dump. The repository teaches senior Java and backend fundamentals through progressive, implementation-first workshops.

The current learning path is **01-sql**. SQL comes first because backend systems use it to model relationships, protect correctness, filter visibility, count social signals, paginate feeds, and prepare candidate sets for ranking or matching.

## How To Run The SQL Workshop

```bash
docker compose -f infra/docker-compose/docker-compose.postgres.yml up -d
./scripts/run-all-sql-chapters.sh
docker compose -f infra/docker-compose/docker-compose.postgres.yml down -v
```

Run one chapter:

```bash
./scripts/run-sql-chapter.sh 01-sql/04-followers-and-social-graph
```

## How To Study A Chapter

Read the chapter README, then read `00-concept.explainer.md`. After that, read the numbered `.solution.sql` files in order, run the proof test, inspect common mistakes, deliberately break one small thing, fix it, and try one extension task.

The implemented solution comes first on purpose. You should learn by seeing a working backend-shaped pattern, not by staring at a blank page.

## SQL Unlock Chain

Tables and relationships unlock graph queries. Graph queries unlock feed candidates. Feed candidates unlock ranking inputs. Pagination unlocks stable production feeds. Recursive CTEs unlock comments and categories. Swipes unlock matching candidates.

## Intentionally Not Included Yet

This first path does not add Java, Spring Boot, JPA, frontend work, Redis, Kafka, RabbitMQ, or PostgreSQL optimisation deep dives. Those are later vertical paths after the SQL foundation is useful.
