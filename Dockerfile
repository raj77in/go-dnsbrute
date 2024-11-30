# Use an official Golang image to build the application
FROM golang:1.20 as builder

# Set environment variables for Alpine compatibility
ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64

# Set the working directory
WORKDIR /app

# Copy the Go modules and source code
COPY go.mod ./
RUN go mod download
COPY . .

# Build the Go application
RUN GOOS=linux GOARCH=amd64 go build -o go-dnsbrute main.go

# Use a minimal base image for the final container
FROM alpine:latest

# LABELS

LABEL org.opencontainers.image.title="go-dnsbrute" \
      org.opencontainers.image.description="A DNS brute-forcing tool built in Go for security testing purposes." \
      org.opencontainers.image.version="0.1" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.url="docker.io/raj77in/go-dnsbrute" \
      org.opencontainers.image.source="https://github.com/raj77in/go-dnsbrute" \
      org.opencontainers.image.revision="0.1" \
      org.opencontainers.image.created="2024-11-30" \
      org.opencontainers.image.authors="Amit Agarwal" \
      org.opencontainers.image.documentation="https://github.com/raj77in/go-dnsbrute"


# Create a non-root user named 'go'
RUN adduser -D -u 1001 go

# Set the working directory in the container
WORKDIR /app

# Change ownership of the working directory and binary to the 'go' user
RUN chown -R go:go /app

# Switch to the 'go' user
USER go

# Copy the compiled binary from the builder stage
COPY --from=builder /app/go-dnsbrute .

# Command to run your application
ENTRYPOINT ["/app/go-dnsbrute"]

