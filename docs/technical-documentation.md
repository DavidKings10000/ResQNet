# ResQNet Technical Documentation

## Architecture principles
- Clean separation between presentation, API, business logic, and infrastructure concerns
- Modular route handlers and UI pages to support future extension
- Environment-based configuration for local development and Vercel deployment

## Extending the platform
- Add database persistence by connecting a PostgreSQL/MySQL service
- Replace the placeholder triage API with a FastAPI service for advanced AI models
- Integrate GIS and messaging providers such as Mapbox, Leaflet, or Pusher
