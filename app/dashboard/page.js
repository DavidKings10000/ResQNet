import { auth } from '../../auth';
import Link from 'next/link';

export default async function DashboardPage() {
  const session = await auth();
  if (!session?.user) {
    return <div className="page-shell"><div className="container"><h1>Access denied</h1></div></div>;
  }

  return (
    <main className="page-shell">
      <div className="container">
        <h1>Dashboard</h1>
        <p>Signed in as {session.user.email} with role {session.user.role}.</p>
        <div className="metrics" style={{ marginTop: '1.5rem' }}>
          <div className="metric"><strong>Role</strong><div>{session.user.role}</div></div>
          <div className="metric"><strong>Access</strong><div>Protected route</div></div>
          <div className="metric"><strong>Profile</strong><div><Link href="/profile">View profile</Link></div></div>
        </div>
      </div>
    </main>
  );
}
