FROM rust:1.75 as builder

WORKDIR /app
COPY . .

RUN apt-get update && apt-get install -y libssl-dev pkg-config
RUN cargo build --release

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y libssl3 ca-certificates
COPY --from=builder /app/target/release/hbbs /app/hbbs

WORKDIR /app
EXPOSE 21115 21116 21117 21118 21119

CMD ["./hbbs", "-p", "21115"]
