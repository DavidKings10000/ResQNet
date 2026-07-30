import { auth } from '../../auth';

export default async function PermissionGuard({ allowedRoles, children }) {
  const session = await auth();
  if (!session?.user) {
    return null;
  }

  if (!allowedRoles.includes(session.user.role)) {
    return null;
  }

  return children;
}
