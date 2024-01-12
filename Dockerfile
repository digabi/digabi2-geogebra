FROM node:18.17.0 AS deps

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm clean-install
COPY Makefile sha512sum.txt ./
RUN make public/GeoGebra/deployggb.js

FROM node:18.17.0 AS build

WORKDIR /app
COPY --from=deps /app/node_modules node_modules
COPY server server
COPY tsconfig.json .
RUN npx tsc --project server

FROM node:18.17.0

WORKDIR /app
COPY --from=deps /app/node_modules node_modules
COPY --from=build /app/dist dist
COPY --from=deps /app/public public
COPY public/index.html public/index.html
COPY bin bin
ENTRYPOINT ["/app/bin/geogebra"]
