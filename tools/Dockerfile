FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y osmium-tool gdal-bin jq wget gnupg && \
    wget -qO- https://www.mongodb.org/static/pgp/server-7.0.asc | apt-key add - && \
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/7.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list && \
    apt-get update && \
    apt-get install -y mongodb-database-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy scripts and configuration files
COPY /scripts /usr/local/bin
COPY /config /config

# Ensure scripts are executable
RUN chmod +x /usr/local/bin/*.sh

# Set the entrypoint to run the main script
ENTRYPOINT ["/usr/local/bin/main.sh"]
# ENTRYPOINT ["tail", "-f", "/dev/null"]
