-- Local demo seed data for KAIRO Phase 0.
-- Safe to re-run: IDs are stable and INSERT OR REPLACE keeps the local dataset deterministic.

INSERT OR REPLACE INTO users (id, email, display_name, avatar_url, role, wallet_address, twitter_handle, telegram_handle, created_at, updated_at) VALUES
  ('user-founder-demo', 'founder@kairo.local', 'DORM Revival Lead', NULL, 'founder', '0x1111111111111111111111111111111111111111', '@dormrevival', NULL, '2026-06-26T00:00:00.000Z', '2026-06-26T00:00:00.000Z'),
  ('builder-demo', 'builder@kairo.local', 'KAIRO Builder', NULL, 'builder', '0x2222222222222222222222222222222222222222', '@kairo_builder', NULL, '2026-06-26T00:00:00.000Z', '2026-06-26T00:00:00.000Z'),
  ('supporter-demo', 'supporter@kairo.local', 'Genesis Supporter', NULL, 'supporter', '0x3333333333333333333333333333333333333333', '@genesis_support', NULL, '2026-06-26T00:00:00.000Z', '2026-06-26T00:00:00.000Z');

INSERT OR REPLACE INTO tokens (id, name, symbol, chain, contract_address, logo_url, website_url, twitter_url, telegram_url, status, created_at, updated_at) VALUES
  ('token-dorm', 'Dormant Protocol', 'DORM', 'Ethereum', '0x000000000000000000000000000000000000d0rm', NULL, 'https://example.com/dorm', 'https://x.com/dormrevival', NULL, 'sleeping', '2026-06-26T00:00:00.000Z', '2026-06-26T00:00:00.000Z');

INSERT OR REPLACE INTO bounties (id, token_id, created_by, title, description, reward_text, reward_type, funding_status, contact_info, deadline, status, boost_count, momentum_score, submission_count, featured, created_at, updated_at) VALUES
  ('bounty-dorm-comeback', 'token-dorm', 'user-founder-demo', 'DORM Comeback Catalyst', 'Design and ship a lightweight revival demo for the Dormant Protocol community.', 'Reward confirmed by KAIRO after Phase 0 review.', 'offchain', 'pledged', 'founder@kairo.local', '2026-08-01T00:00:00.000Z', 'active', 1, 250, 1, 1, '2026-06-26T00:00:00.000Z', '2026-06-26T00:00:00.000Z');

INSERT OR REPLACE INTO submissions (id, bounty_id, builder_id, name, tagline, demo_url, github_url, video_url, screenshot_url, description, status, boost_count, momentum_score, delivery_status, created_at, updated_at) VALUES
  ('submission-dorm-dashboard', 'bounty-dorm-comeback', 'builder-demo', 'DORM Revival Dashboard', 'A comeback dashboard that turns community signals into Momentum.', 'https://example.com/dorm-demo', 'https://github.com/example/dorm-demo', NULL, NULL, 'Phase 0 demo submission for the DORM comeback Catalyst.', 'submitted', 0, 0, 'in_progress', '2026-06-26T00:00:00.000Z', '2026-06-26T00:00:00.000Z');

INSERT OR REPLACE INTO boosts (id, user_id, bounty_id, submission_id, referrer_id, ip_hash, user_agent_hash, source, validity_status, created_at) VALUES
  ('boost-dorm-supporter', 'supporter-demo', 'bounty-dorm-comeback', NULL, NULL, NULL, NULL, 'seed', 'valid', '2026-06-26T00:00:00.000Z');

INSERT OR REPLACE INTO support_events (id, user_id, event_type, target_type, target_id, bounty_id, submission_id, referrer_id, points_delta, validity_status, source, metadata_json, created_at) VALUES
  ('support-event-dorm-boost', 'supporter-demo', 'boost', 'bounty', 'bounty-dorm-comeback', 'bounty-dorm-comeback', NULL, NULL, 50, 'valid', 'seed', '{"note":"Local Phase 0 seed Boost"}', '2026-06-26T00:00:00.000Z');

INSERT OR REPLACE INTO support_points (user_id, total_points, boost_points, referral_points, share_points, valid_boost_count, updated_at) VALUES
  ('supporter-demo', 50, 50, 0, 0, 1, '2026-06-26T00:00:00.000Z');

INSERT OR REPLACE INTO builder_scores (builder_id, total_score, submitted_count, shortlisted_count, won_count, completed_count, confirmed_reward_completed_count, boost_count, referral_boost_count, violation_count, dispute_lost_count, updated_at) VALUES
  ('builder-demo', 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, '2026-06-26T00:00:00.000Z');
