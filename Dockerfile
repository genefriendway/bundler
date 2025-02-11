FROM node:20

WORKDIR /app

# Install build essentials and git
RUN apt-get update && \
    apt-get install -y build-essential git && \
    rm -rf /var/lib/apt/lists/*

# Copy the entire repository
COPY . .

# Configure git for submodules
RUN git config --global user.email "docker@example.com" && \
    git config --global user.name "Docker Build"

# Initialize git repository and submodules
RUN git init && \
    git add . && \
    git commit -m "Initial commit" && \
    yarn && yarn preprocess

# Set the default command
CMD ["yarn", "run", "bundler"]
