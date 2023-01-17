FROM rust:1.61.0 as builder

WORKDIR /usr/src/
COPY . .

RUN git clone https://github.com/moparisthebest/wireguard-proxy
WORKDIR /usr/src/wireguard-proxy
RUN cargo build --release
RUN cargo install --path .
RUN udp-test



FROM debian:buster-slim as runtime
COPY --from=builder /usr/local/cargo/bin/wireguard-proxy  /usr/local/bin/
CMD ["/usr/local/bin/wireguard-proxy"]
