# ResQNet Software Requirements Specification

## 1. Introduction
ResQNet is a production-ready emergency response coordination platform for Kenya, designed to connect citizens, dispatch centers, ambulances, police, fire departments, hospitals, and county administrators. The platform supports incident reporting, AI triage, GIS mapping, alerts, blockchain-backed audit trails, and analytics.

## 2. Functional Requirements
- Citizen incident reporting with metadata, GPS, media, and contact details
- AI-based incident classification and priority scoring
- Dispatcher dashboard with live routing, responder monitoring, and incident override tools
- Role-based access control for citizens, dispatchers, responders, hospitals, and administrators
- Notification system for SMS, email, push, and in-app alerts
- Blockchain-compatible audit logging with hashes for evidence integrity

## 3. Non-Functional Requirements
- Availability: 99.9% target for critical services
- Security: JWT, role-based access, encryption, rate limiting, audit logging
- Performance: responsive UI, optimized API routes, low-latency incident updates
- Scalability: modular architecture suitable for national deployment

## 4. Assumptions and Dependencies
- Vercel-compatible frontend deployment
- Cloud-hosted database and object storage
- External SMS and mapping integrations

## 5. Scope and Future Expansion
The initial release focuses on core reporting, dispatch coordination, dashboards, and deployment guidance. Future phases may add full mobile apps, advanced AI models, and nationwide integration.
