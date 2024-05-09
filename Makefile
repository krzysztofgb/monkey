GOCMD=go

GOARCH?=$(shell go env GOARCH)
GOOS?=$(shell go env GOOS)

GOTEST=$(GOCMD) test

COVERPROFILE=coverage.out
TESTMODULES=./...

.PHONY: test
test:
	$(GOTEST) -race -timeout=10s -coverpkg=$(TESTMODULES) -coverprofile=$(COVERPROFILE) -outputdir=. $(TESTMODULES)

cov:
	go tool cover -html=$(COVERPROFILE)

test-cov: test cov

format:
	gofumpt -w .

# Requires golangci-lint: https://golangci-lint.run/usage/install/
linter: format
	golangci-lint run --fix

lint-check:
	golangci-lint run