# ResQNet API Documentation

## Endpoints
- GET /api/health - health check
- POST /api/triage - AI triage scoring for an incident report

## Request Example
```json
{
  "description": "Gas leak near a residential building"
}
```

## Response Example
```json
{
  "severity": "Critical",
  "score": 60,
  "priority": "Critical",
  "resourceRequirement": "Ambulance + Dispatcher",
  "suggestedResponders": ["Ambulance", "Police"],
  "hospitalRecommendation": "Nearest public hospital",
  "duplicatePossible": false
}
```
