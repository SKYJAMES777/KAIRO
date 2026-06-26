export interface SupportPoints {
  userId: string;
  totalPoints: number;
  boostPoints: number;
  referralPoints: number;
  sharePoints: number;
  validBoostCount: number;
  updatedAt: string | null;
}

export interface SupportEvent {
  id: string;
  userId: string;
  eventType: string;
  targetType: string;
  targetId: string;
  bountyId: string | null;
  submissionId: string | null;
  referrerId: string | null;
  pointsDelta: number;
  validityStatus: string;
  source: string;
  metadata: unknown;
  createdAt: string;
}

export interface ProofOfSupport {
  user: {
    id: string;
    role: string;
    isDemoFallback: boolean;
  };
  points: SupportPoints;
  validBoostCount: number;
  events: SupportEvent[];
}

const API_BASE_URL = ((import.meta as unknown as { env?: { VITE_API_BASE_URL?: string } }).env?.VITE_API_BASE_URL) ?? '';

export async function getProofOfSupport(): Promise<ProofOfSupport> {
  const response = await fetch(`${API_BASE_URL}/api/support/proof/me`, {
    headers: getCurrentUserHeaders(),
  });

  if (!response.ok) {
    throw new Error(`Unable to load Proof of Support (${response.status})`);
  }

  const body = (await response.json()) as { data: ProofOfSupport };
  return body.data;
}

function getCurrentUserHeaders(): HeadersInit {
  const userId = window.localStorage.getItem('kairo:userId');
  const role = window.localStorage.getItem('kairo:role');
  const headers: Record<string, string> = {};

  if (userId) headers['x-kairo-user-id'] = userId;
  if (role) headers['x-kairo-role'] = role;

  return headers;
}
