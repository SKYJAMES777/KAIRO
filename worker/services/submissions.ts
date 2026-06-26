import { createSubmissionSchema } from '../../shared/domain';
import { listRows, type Env } from '../db/d1';

export async function listSubmissions(env: Env, bountyId?: string) {
  if (bountyId) {
    return listRows(
      env.DB,
      `SELECT * FROM submissions WHERE bounty_id = ? ORDER BY momentum_score DESC, created_at DESC`,
      [bountyId],
    );
  }

  return listRows(
    env.DB,
    `SELECT * FROM submissions ORDER BY momentum_score DESC, created_at DESC LIMIT 50`,
  );
}

export async function createSubmission(env: Env, payload: unknown) {
  const input = createSubmissionSchema.parse(payload);
  const now = new Date().toISOString();
  const id = crypto.randomUUID();

  await env.DB.batch([
    env.DB.prepare(
      `INSERT INTO submissions (
        id, bounty_id, builder_id, name, tagline, demo_url, github_url,
        video_url, description, status, created_at, updated_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'submitted', ?, ?)`,
    ).bind(
      id,
      input.bountyId,
      input.builderId,
      input.name,
      input.tagline,
      input.demoUrl ?? null,
      input.githubUrl ?? null,
      input.videoUrl ?? null,
      input.description ?? null,
      now,
      now,
    ),
    env.DB.prepare(
      `UPDATE bounties
       SET submission_count = submission_count + 1, momentum_score = momentum_score + 300, updated_at = ?
       WHERE id = ?`,
    ).bind(now, input.bountyId),
  ]);

  return { id, ...input, status: 'submitted', boostCount: 0, momentumScore: 0, createdAt: now, updatedAt: now };
}
