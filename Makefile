postgres:
	docker run --name postgres13 -p 5432:5432 -e POSTGRES_PASSWORD=123456 -d postgres:13.1-alpine

createdb:
	docker exec -it postgres13 createdb -U postgres simple_bank

dropdb:
	docker exec -it postgres13 dropdb -U postgres simple_bank

migrateup:
	migrate -path db/migration -database "postgres://postgres:123456@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgres://postgres:123456@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...
	
.PHONY: createdb