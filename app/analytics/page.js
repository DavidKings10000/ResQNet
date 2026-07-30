export default function AnalyticsPage() {
  return (
    <main className="page-shell">
      <div className="container">
        <h1>Analytics</h1>
        <p>Response time, hotspot analysis, monthly trends, and public safety reporting.</p>
        <div className="metrics">
          <div className="metric"><strong>Avg. dispatch</strong><div>4.2 min</div></div>
          <div className="metric"><strong>Critical incidents</strong><div>18</div></div>
          <div className="metric"><strong>False reports</strong><div>3%</div></div>
          <div className="metric"><strong>Hospital load</strong><div>67%</div></div>
        </div>
      </div>
    </main>
  );
}
