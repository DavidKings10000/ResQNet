# ResQNet Architecture

## High-Level Architecture
- Frontend: Next.js app with responsive pages for citizens, dispatchers, hospitals, and administrators
- API layer: Next.js API routes for health, triage, incident submission, analytics, and notification hooks
- Data layer: cloud-hosted SQL or NoSQL database with schema for users, incidents, responders, hospitals, and notifications
- AI services: Python/FastAPI service for triage, NLP, image analysis, hotspot detection, and forecasting
- GIS layer: Leaflet/OpenStreetMap or Google Maps integration for live tracking and routing
- Blockchain layer: Ethereum-compatible smart contracts for incident verification and immutable audit logs

## Deployment Architecture
- Frontend hosted on Vercel
- Environment variables managed through Vercel settings
- Object storage for uploads via Cloudinary/S3
- CI/CD via GitHub Actions
