FROM rust:1.61.0 as builder

WORKDIR /usr/src/
COPY . .

RUN git clone https://github.com/moparisthebest/wireguard-proxy
WORKDIR /usr/src/wireguard-proxy
RUN cargo build --release
RUN cargo install --path .
RUN udp-test



FROM rust:1.61.0 as runtime
COPY --from=builder /usr/local/cargo/bin/wireguard-proxy  /usr/local/cargo/bin/

CMD ["/usr/local/cargo/bin/wireguard-proxy"]
