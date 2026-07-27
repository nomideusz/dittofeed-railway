# Deploy and Host Dittofeed on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/dittofeed-2?utm_medium=integration&utm_source=button&utm_campaign=dittofeed)

[Dittofeed](https://dittofeed.com/) is an open-source customer engagement platform — a self-hosted alternative to Customer.io, Braze, and OneSignal. Build segment-driven automated journeys with a visual editor, send templated messages over email, SMS, and webhooks, and keep every user event in your own infrastructure.

## About Hosting Dittofeed

This template runs Dittofeed's **lite** bundle — API, dashboard, and worker in a single service — next to the three stores it needs: Postgres (app data), ClickHouse (user events and segmentation), and Temporal (journey orchestration, using the same Postgres). Database migrations and the initial workspace bootstrap run automatically on first boot. Authentication is single-tenant: one shared login guarded by the generated `PASSWORD` template variable, with sessions signed by `SECRET_KEY`.

## Common Use Cases

- Lifecycle email journeys (onboarding drips, win-backs, upgrade nudges) without per-contact SaaS pricing
- Product-event-driven messaging — segments computed from the events your app already emits
- Keeping customer PII and behavioral data in your own infrastructure for GDPR or policy reasons

## Dependencies for Dittofeed Hosting

- PostgreSQL, ClickHouse, and Temporal — all included as services in this template
- An email provider for actual sending (SendGrid, Amazon SES, Resend, Postmark, or raw SMTP), connected in Settings after deploy

### Deployment Dependencies

- [Dittofeed documentation](https://docs.dittofeed.com/)
- [Template source on GitHub](https://github.com/nomideusz/dittofeed-railway)

### Implementation Details

**Your Dittofeed dashboard lives at the lite service's Railway domain** (it redirects to `/dashboard`). Sign in with the `PASSWORD` template variable.

| Service | Role |
|---|---|
| dittofeed | API + dashboard + worker (`dittofeed-lite`) |
| postgres | App data + Temporal's persistence |
| clickhouse | User events, segment computation; volume at `/var/lib/clickhouse` |
| temporal | Journey/workflow engine (`auto-setup`, dynamicconfig baked in) |

After deploy:

1. Sign in and open **Settings → Message Channels** to connect your email provider (API key or SMTP).
2. Send events via the [Dittofeed API or SDKs](https://docs.dittofeed.com/integrations) using a write key from **Settings**.
3. Build a segment, a template, and a journey — then activate it.

Notes:

- `BOOTSTRAP=true` re-checks the workspace on every boot; it's idempotent. You can set it to `false` after the first successful deploy for slightly faster restarts (the login page reminds you).
- `SESSION_COOKIE_SECURE=true` is set by default — correct behind Railway's HTTPS edge. Set it to `false` only if you ever serve Dittofeed over plain HTTP.
- ClickHouse is the memory-hungry piece — give it ~2 GB for comfortable segment computation.
- The dashboard's API base is derived from the Railway domain automatically; set `DASHBOARD_API_BASE` yourself if you attach a custom domain.

## Why Deploy Dittofeed on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying Dittofeed on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
