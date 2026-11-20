FROM node:20-slim

WORKDIR /app

ENV NODE_ENV=production

RUN npm install -g pnpm@10.26.1 --no-fund --no-audit

COPY package.json pnpm-lock.yaml patch-baileys.mjs ./

RUN pnpm install --prod --frozen-lockfile

COPY artifacts ./artifacts

CMD ["node", "--enable-source-maps", "artifacts/api-server/dist/index.mjs"]
