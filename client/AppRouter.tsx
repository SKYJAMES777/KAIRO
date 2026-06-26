import { Navigate, Route, Routes, useNavigate, useParams } from 'react-router-dom';
import App from '../src/App';
import { INITIAL_CATALYSTS } from '../src/mockData';
import ProofOfSupportPage from './pages/ProofOfSupportPage';

function LegacyWorkspace({ initialTab }: { initialTab?: string }) {
  return <App initialTab={initialTab} />;
}

function CatalystDeepLink() {
  const { id } = useParams();
  const navigate = useNavigate();
  const exists = INITIAL_CATALYSTS.some((catalyst) => catalyst.id === id);

  if (!exists) return <Navigate to="/catalysts" replace />;

  return <App initialTab="catalysts" initialCatalystId={id} onRouteBack={() => navigate('/catalysts')} />;
}

export default function AppRouter() {
  return (
    <Routes>
      <Route path="/" element={<LegacyWorkspace initialTab="arena" />} />
      <Route path="/catalysts" element={<LegacyWorkspace initialTab="catalysts" />} />
      <Route path="/catalysts/:id" element={<CatalystDeepLink />} />
      <Route path="/builder" element={<LegacyWorkspace initialTab="builderHub" />} />
      <Route path="/leaderboard" element={<LegacyWorkspace initialTab="leaderboard" />} />
      <Route path="/swap" element={<LegacyWorkspace initialTab="swap" />} />
      <Route path="/proof" element={<ProofOfSupportPage />} />
      <Route path="/admin" element={<LegacyWorkspace initialTab="catalysts" />} />
      <Route path="*" element={<Navigate to="/" replace />} />
    </Routes>
  );
}
