# ---- Base Node ----
FROM node:18-alpine AS base
WORKDIR /app
COPY package*.json ./

# ---- Dependencies ----
FROM base AS dependencies
RUN npm ci --only=production

# ---- Build ----
FROM dependencies AS build
COPY . .
RUN npm run build

# ---- Release ----
FROM node:18-alpine AS release
WORKDIR /app
COPY --from=dependencies /app/node_modules ./node_modules
COPY --from=build /app/build ./build
CMD ["npm", "start"]