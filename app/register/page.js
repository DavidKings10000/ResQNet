export default function RegisterPage() {
  return (
    <main className="page-shell">
      <div className="container">
        <h1>Create account</h1>
        <p>Register as a citizen, responder, hospital, or administrator.</p>
        <form className="form-grid" style={{ marginTop: '1.5rem' }}>
          <input className="input" placeholder="Full name" />
          <input className="input" placeholder="Email" />
          <input className="input" placeholder="Password" type="password" />
          <select className="select"><option>Citizen</option><option>Dispatcher</option><option>Ambulance</option><option>Police</option><option>Fire</option><option>Hospital</option><option>Administrator</option></select>
          <button className="btn btn-primary" type="button">Create account</button>
        </form>
      </div>
    </main>
  );
}
