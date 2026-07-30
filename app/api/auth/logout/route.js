import { cookies } from 'next/headers';

export async function POST() {
  const cookieStore = cookies();
  cookieStore.set('resqnet-session', '', { maxAge: 0, httpOnly: true, path: '/' });
  return Response.json({ message: 'Signed out.' }, { status: 200 });
}
