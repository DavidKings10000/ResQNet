import { auth } from '../../auth';

export default async function ProfilePage() {
  const session = await auth();
  if (!session?.user) {
    return <div className="page-shell"><div className="container"><h1>Access denied</h1></div></div>;
  }

  return (
    <main className="page-shell">
      <div className="container">
        <h1>User profile</h1>
        <p>Email: {session.user.email}</p>
        <p>Role: {session.user.role}</p>
      </div>
    </main>
  );
}
