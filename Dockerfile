FROM node:current-alpine AS base
WORKDIR /base
COPY ./ ./
RUN yarn install

FROM base AS build
ENV NODE_ENV=production
WORKDIR /build
COPY --from=base /base ./
RUN yarn build


FROM node:current-alpine AS production
ENV NODE_ENV=production
WORKDIR /app
COPY --from=build /build/package.json ./
COPY --from=build /build/dist ./dist
RUN yarn install

EXPOSE 3000

