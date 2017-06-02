FROM golang:1.8
ENV ver 1.1.1

# install unzip utility
RUN apt-get -y update && apt-get -y install zip

# download and unzip Dapperdox sources
RUN cd /go/src/ && \
    curl -L -o dapperdox.zip https://github.com/DapperDox/dapperdox/archive/v${ver}.zip && \
    unzip dapperdox.zip && \
    rm dapperdox.zip

# compile
WORKDIR /go/src/dapperdox-${ver}
RUN go-wrapper download   # "go get -d -v ./..."
RUN go-wrapper install    # "go install -v ./..."

# Dappedox default port
EXPOSE 3123

# Default configuration
ENV SPEC_DIR /dapperdox/specs
ENV ASSETS_DIR /dapperdox/assets

# run
CMD ["go-wrapper", "run"] # ["app"]
