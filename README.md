# ResQNet

ResQNet is a Vercel-ready emergency response coordination platform for Kenya. The initial implementation includes a modern Next.js frontend, API routes, basic AI triage logic, architecture and database documentation, deployment config, and CI/CD workflow.

## Features included
- Responsive landing page, about, services, report, login, register, analytics, and maps pages
- Health check and AI triage API routes
- Architecture, SRS, API docs, and SQL schema
- Vercel deployment configuration and GitHub Actions workflow

## Getting started
1. Install dependencies: npm install
2. Run locally: npm run dev
3. Build: npm run build
4. Test: npm test

## Project structure
- app/ - Next.js app router pages and API routes
- docs/ - SRS, architecture, database schema, and API documentation
- tests/ - smoke tests

## Deployment notes
- Configure environment variables from .env.example in Vercel
- Uploads should use Cloudinary/S3 instead of the Vercel filesystem
- Extend the API and database layers for full production rollout
