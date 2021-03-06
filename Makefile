postgres:
	docker run --name postgres12-2 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=mysecret -d postgres:12-alpine
createdb:
	docker exec -it postgres12-2 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres12-2 dropdb simple_bank

migrateup:
	migrate -path db/migrations -database "postgresql://root:mysecret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migrations -database "postgresql://root:mysecret@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test