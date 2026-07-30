export async function POST(request) {
  const body = await request.json();
  const severity = body.description?.length > 120 ? 'Critical' : 'High';
  const score = Math.min(100, 40 + (body.description?.length || 0) / 10);

  return Response.json({
    severity,
    score: Math.round(score),
    priority: severity,
    resourceRequirement: 'Ambulance + Dispatcher',
    suggestedResponders: ['Ambulance', 'Police'],
    hospitalRecommendation: 'Nearest public hospital',
    duplicatePossible: false,
  });
}
