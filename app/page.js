import Link from 'next/link';

const features = [
  'AI triage and severity scoring',
  'Real-time GIS dispatch and routing',
  'Citizen alerts, dispatcher dashboards, and hospital coordination',
  'Blockchain-backed audit logs and evidence integrity',
];

export default function HomePage() {
  return (
    <main>
      <section className="hero section">
        <div className="container hero-grid">
          <div>
            <p className="eyebrow">Smart emergency coordination</p>
            <h1>ResQNet reduces response time when every second matters.</h1>
            <p className="lead">
              A Vercel-ready emergency coordination platform for citizens, dispatchers, ambulances, police,
              fire teams, hospitals, and county governments.
            </p>
            <div className="hero-actions">
              <Link href="/report" className="btn btn-primary">Report Emergency</Link>
              <Link href="/services" className="btn btn-secondary">Explore Platform</Link>
            </div>
          </div>
          <div className="card">
            <h3>Live operations snapshot</h3>
            <ul className="stack-list">
              <li>12 active incidents</li>
              <li>7 responders en route</li>
              <li>3 hospitals on standby</li>
              <li>98% incident visibility coverage</li>
            </ul>
          </div>
        </div>
      </section>

      <section className="section">
        <div className="container">
          <h2 className="section-title">Built for rapid, transparent response</h2>
          <div className="grid cards">
            {features.map((feature) => (
              <div key={feature} className="card">
                <h3>{feature}</h3>
                <p>Production-oriented modules for modern emergency coordination and future national rollout.</p>
              </div>
            ))}
          </div>
        </div>
      </section>
    </main>
  );
}
