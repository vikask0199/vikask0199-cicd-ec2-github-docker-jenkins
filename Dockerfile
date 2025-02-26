# Base image
FROM node:20.12.2

# Set working directory
WORKDIR /usr/src/app

# Install pnpm globally
RUN npm install -g pnpm

# Install dependencies using pnpm
COPY package*.json ./
RUN pnpm install

# Copy the rest of the source code
COPY . .

# Build the TypeScript code
RUN pnpm run build

# Expose the application port
EXPOSE 3000

# Start the app using pnpm
CMD ["pnpm", "start"]
