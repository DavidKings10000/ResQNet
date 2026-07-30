export default function LoginPage() {
  return (
    <main className="page-shell">
      <div className="container">
        <h1>Login</h1>
        <p>Access your role-based dashboard.</p>
        <form className="form-grid" style={{ marginTop: '1.5rem' }}>
          <input className="input" placeholder="Email" />
          <input className="input" placeholder="Password" type="password" />
          <button className="btn btn-primary" type="button">Sign in</button>
        </form>
      </div>
    </main>
  );
}
