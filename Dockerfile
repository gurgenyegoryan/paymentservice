FROM node:12-alpine

# Some packagesrequire additional
# deps for post-install scripts
RUN apk add --update --no-cache \
    python3 \
    make \
    g++ 

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --only=production


RUN GRPC_HEALTH_PROBE_VERSION=v0.4.6 && \
    wget -qO/bin/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 && \
    chmod +x /bin/grpc_health_probe


COPY . .

EXPOSE 50051

ENTRYPOINT [ "node", "index.js" ]