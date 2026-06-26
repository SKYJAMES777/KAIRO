import { listRows, type Env } from '../db/d1';

export async function getLeaderboard(env: Env) {
  const hottestCatalysts = await listRows(
    env.DB,
    `SELECT id, title, momentum_score, boost_count, submission_count
     FROM bounties
     ORDER BY momentum_score DESC
     LIMIT 20`,
  );

  const topBuilders = await listRows(
    env.DB,
    `SELECT builder_id, total_score, submitted_count, won_count, boost_count
     FROM builder_scores
     ORDER BY total_score DESC
     LIMIT 20`,
  );

  const curatedItems = await listRows(
    env.DB,
    `SELECT *
     FROM curated_items
     WHERE status = 'active'
     ORDER BY sort_order ASC, created_at DESC
     LIMIT 30`,
  );

  return { hottestCatalysts, topBuilders, curatedItems };
}
