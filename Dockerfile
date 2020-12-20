FROM crystallang/crystal:0.35.1-alpine as build
WORKDIR /workspace/
COPY shard.yml shard.lock /workspace/
RUN shards install
COPY . /workspace/
RUN shards build --static --release

FROM scratch
LABEL maintainer="sieg@nyrst.tools"
COPY --from=build /workspace/bin/beulogue /
ENTRYPOINT ["/beulogue"]
CMD ["help"]