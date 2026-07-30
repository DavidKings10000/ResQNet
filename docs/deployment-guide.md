# ResQNet Deployment Guide

## Vercel deployment
1. Push the repository to GitHub
2. Connect the repository to Vercel
3. Configure environment variables from .env.example
4. Deploy the production branch

## Production environment
- Use a managed PostgreSQL/MySQL service for persistence
- Use Cloudinary/S3 for uploaded media
- Add domain and HTTPS configuration in Vercel

## Optional containers
- Run AI services or additional API backends in Docker for future expansion
