FROM node:20-slim

WORKDIR /app

ENV NODE_ENV=production

RUN npm install -g pnpm@10.26.1 --no-fund --no-audit

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml patch-baileys.mjs ./

COPY artifacts/api-server/package.json ./artifacts/api-server/
COPY artifacts/nutter-xmd/package.json ./artifacts/nutter-xmd/

COPY lib/ ./lib/

RUN pnpm install --prod --frozen-lockfile --filter "@workspace/api-server..."

RUN node ./patch-baileys.mjs

COPY artifacts/api-server/dist ./artifacts/api-server/dist

CMD ["node", "--enable-source-maps", "artifacts/api-server/dist/index.mjs"]

COPY artifacts/nutter-xmd/dist ./artifacts/nutter-xmd/dist
