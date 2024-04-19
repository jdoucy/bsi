#
# 🧑‍💻 Development
#
FROM node:20-alpine as dev
# add the missing shared libraries from alpine base image
RUN apk add --no-cache libc6-compat
# Create app folder
WORKDIR /app

# Set to dev environment
ENV NODE_ENV dev


# Copy source code into app folder
COPY . .

# Install dependencies
RUN npm ci


#
# 🏡 Production Build
#
FROM node:20-alpine as build

WORKDIR /app
RUN apk add --no-cache libc6-compat

# Set to production environment
ENV NODE_ENV production

# Nest CLI is a dev dependency.
COPY --from=dev /app/node_modules ./node_modules
# Copy source code
COPY . .

# Generate the production build. The build script runs "nest build" to compile the application.
RUN npm run build


#
# 🚀 Production Server
#
FROM node:20-alpine as prod

WORKDIR /app
RUN apk add --no-cache libc6-compat

# Set to production environment
ENV NODE_ENV production

# Copy only the necessary files
COPY --from=build /app/dist dist
COPY --from=build /app/node_modules node_modules

CMD ["node", "dist/main.js"]