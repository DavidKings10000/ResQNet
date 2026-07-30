export default function ReportPage() {
  return (
    <main className="page-shell">
      <div className="container">
        <h1>Report Emergency</h1>
        <p>Submit a citizen incident report with location, media, and contact details.</p>
        <form className="form-grid" style={{ marginTop: '1.5rem' }}>
          <input className="input" placeholder="Emergency type" />
          <textarea className="textarea" placeholder="Describe the incident" />
          <input className="input" placeholder="GPS coordinates" />
          <input className="input" type="file" multiple />
          <button className="btn btn-primary" type="button">Submit Report</button>
        </form>
      </div>
    </main>
  );
}
