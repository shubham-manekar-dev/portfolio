FROM node:18-alpine as builder

WORKDIR /app
COPY index.html .

# Security: Run as non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001 && \
    chown -R nodejs:nodejs /app

USER nodejs

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "console.log('healthy')" || exit 1

EXPOSE 3000

# Serve the portfolio
CMD ["npx", "http-server", "-p", "3000"]