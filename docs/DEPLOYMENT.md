# Deployment and Environment

## Local

```powershell
C:\Ruby34-x64\bin\ruby.exe bin\rails db:migrate db:seed
C:\Ruby34-x64\bin\ruby.exe bin\rails server -b 127.0.0.1 -p 3000
```

Open:

- Customer app: `http://127.0.0.1:3000`
- Admin app: `http://127.0.0.1:3000/admin-portal`

## Environment Variables

Recommended production variables:

```env
RAILS_ENV=production
RAILS_MASTER_KEY=replace-with-config-master-key
DATABASE_URL=postgres://user:password@host:5432/j2c_rentals
APP_HOST=your-domain.com
ADMIN_HOST=admin.your-domain.com
PAYMENT_PROVIDER=demo
PAYMENT_WEBHOOK_SECRET=replace-me
UPLOAD_MAX_MB=10
```

## Vercel Note

This workspace is currently a Rails application because the project was originally requested and scaffolded as Rails. Vercel is excellent for a Next.js/TypeScript implementation, but it is not the best production runtime for a stateful Rails server with Active Record and SQLite/Postgres.

For a strict Vercel deployment, port the same domain model to:

- Next.js App Router
- TypeScript strict mode
- Prisma or Drizzle
- Postgres
- Zod validation
- NextAuth/Auth.js or Clerk
- Route groups: `(customer)` and `(admin)`
- Middleware protecting `/admin-portal`

For this Rails implementation, deploy to a Rails-friendly host such as Fly.io, Render, Railway, or a Docker/Kamal server. Keep `/admin-portal` protected by the same server-side role guard in production.

## Production Hardening Checklist

- Move from SQLite to Postgres.
- Set secure cookies and HTTPS-only sessions.
- Store uploaded documents in S3-compatible storage.
- Add payment provider webhooks with signature verification.
- Add Rack::Attack or gateway-level rate limits for login and payment endpoints.
- Add background jobs for notifications and invoices.
- Add admin permission granularity for super admin workflows.
- Add automated request/system tests for admin authorization.
