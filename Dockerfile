FROM node:16-slim as build

ARG COMMIT_SHA=<not-specified>

WORKDIR /build-dir

COPY package.json .
COPY package-lock.json .

RUN npm ci

COPY . .

RUN npm run build

RUN echo "mia_template_service_name_placeholder: $COMMIT_SHA" >> ./commit.sha

########################################################################################################################

FROM node:16-slim

LABEL maintainer="%CUSTOM_PLUGIN_CREATOR_USERNAME%" \
      name="mia_template_service_name_placeholder" \
      description="%CUSTOM_PLUGIN_SERVICE_DESCRIPTION%" \
      eu.mia-platform.url="https://www.mia-platform.eu" \
      eu.mia-platform.version="0.1.0"

ENV NODE_ENV=production
ENV LOG_LEVEL=info
ENV SERVICE_PREFIX=/
ENV HTTP_PORT=3000

WORKDIR /home/node/app

COPY --from=build /build-dir ./

RUN ls /home/node/app/dist
RUN ls /home/node/app

USER node

CMD ["npm", "run", "start:prod"]
