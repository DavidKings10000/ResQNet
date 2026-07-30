import { signInWithCredentials } from '../../../../auth';

export async function POST(request) {
  const body = await request.json();
  const result = await signInWithCredentials(body.email, body.password);

  if (!result) {
    return Response.json({ message: 'Invalid credentials.' }, { status: 401 });
  }

  return Response.json(result, { status: 200 });
}
