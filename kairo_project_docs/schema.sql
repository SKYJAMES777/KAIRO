-- KAIRO MVP Cloudflare D1 Schema v3.2

CREATE TABLE users (
  id TEXT PRIMARY KEY,
  email TEXT,
  display_name TEXT,
  avatar_url TEXT,
  role TEXT DEFAULT 'supporter',
  wallet_address TEXT,
  twitter_handle TEXT,
  telegram_handle TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

CREATE TABLE tokens (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  symbol TEXT NOT NULL,
  chain TEXT,
  contract_address TEXT,
  logo_url TEXT,
  website_url TEXT,
  twitter_url TEXT,
  telegram_url TEXT,
  status TEXT DEFAULT 'sleeping',
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

CREATE TABLE bounties (
  id TEXT PRIMARY KEY,
  token_id TEXT NOT NULL,
  created_by TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  reward_text TEXT,
  reward_type TEXT DEFAULT 'offchain',
  funding_status TEXT DEFAULT 'unverified',
  contact_info TEXT,
  deadline TEXT,
  status TEXT DEFAULT 'pending_review',
  boost_count INTEGER DEFAULT 0,
  momentum_score INTEGER DEFAULT 0,
  submission_count INTEGER DEFAULT 0,
  featured INTEGER DEFAULT 0,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

CREATE TABLE submissions (
  id TEXT PRIMARY KEY,
  bounty_id TEXT NOT NULL,
  builder_id TEXT NOT NULL,
  name TEXT NOT NULL,
  tagline TEXT NOT NULL,
  demo_url TEXT,
  github_url TEXT,
  video_url TEXT,
  screenshot_url TEXT,
  description TEXT,
  status TEXT DEFAULT 'submitted',
  boost_count INTEGER DEFAULT 0,
  momentum_score INTEGER DEFAULT 0,
  delivery_status TEXT DEFAULT 'not_started',
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

CREATE TABLE boosts (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  bounty_id TEXT,
  submission_id TEXT,
  referrer_id TEXT,
  ip_hash TEXT,
  user_agent_hash TEXT,
  source TEXT DEFAULT 'direct',
  validity_status TEXT DEFAULT 'valid',
  created_at TEXT NOT NULL
);

CREATE TABLE support_points (
  user_id TEXT PRIMARY KEY,
  total_points INTEGER DEFAULT 0,
  boost_points INTEGER DEFAULT 0,
  referral_points INTEGER DEFAULT 0,
  share_points INTEGER DEFAULT 0,
  valid_boost_count INTEGER DEFAULT 0,
  updated_at TEXT NOT NULL
);

CREATE TABLE support_events (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  event_type TEXT NOT NULL,
  target_type TEXT NOT NULL,
  target_id TEXT NOT NULL,
  bounty_id TEXT,
  submission_id TEXT,
  referrer_id TEXT,
  points_delta INTEGER DEFAULT 0,
  validity_status TEXT DEFAULT 'valid',
  source TEXT DEFAULT 'direct',
  metadata_json TEXT,
  created_at TEXT NOT NULL
);

CREATE TABLE builder_scores (
  builder_id TEXT PRIMARY KEY,
  total_score INTEGER DEFAULT 0,
  submitted_count INTEGER DEFAULT 0,
  shortlisted_count INTEGER DEFAULT 0,
  won_count INTEGER DEFAULT 0,
  completed_count INTEGER DEFAULT 0,
  confirmed_reward_completed_count INTEGER DEFAULT 0,
  boost_count INTEGER DEFAULT 0,
  referral_boost_count INTEGER DEFAULT 0,
  violation_count INTEGER DEFAULT 0,
  dispute_lost_count INTEGER DEFAULT 0,
  updated_at TEXT NOT NULL
);

CREATE TABLE referrals (
  id TEXT PRIMARY KEY,
  referrer_id TEXT NOT NULL,
  referred_user_id TEXT,
  bounty_id TEXT,
  submission_id TEXT,
  source TEXT,
  created_at TEXT NOT NULL
);

CREATE TABLE escrow_events (
  id TEXT PRIMARY KEY,
  bounty_id TEXT NOT NULL,
  actor_id TEXT NOT NULL,
  event_type TEXT NOT NULL,
  amount_text TEXT,
  proof_url TEXT,
  note TEXT,
  created_at TEXT NOT NULL
);

CREATE TABLE curated_items (
  id TEXT PRIMARY KEY,
  item_type TEXT NOT NULL,
  placement TEXT DEFAULT 'home',
  target_type TEXT NOT NULL,
  target_id TEXT,
  title TEXT NOT NULL,
  description TEXT,
  image_url TEXT,
  external_url TEXT,
  sort_order INTEGER DEFAULT 0,
  status TEXT DEFAULT 'active',
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

CREATE TABLE admin_actions (
  id TEXT PRIMARY KEY,
  admin_id TEXT NOT NULL,
  action_type TEXT NOT NULL,
  target_type TEXT NOT NULL,
  target_id TEXT NOT NULL,
  note TEXT,
  created_at TEXT NOT NULL
);

CREATE INDEX idx_bounties_status ON bounties(status);
CREATE INDEX idx_bounties_funding_status ON bounties(funding_status);
CREATE INDEX idx_bounties_momentum ON bounties(momentum_score);
CREATE INDEX idx_submissions_bounty_id ON submissions(bounty_id);
CREATE INDEX idx_submissions_builder_id ON submissions(builder_id);
CREATE INDEX idx_boosts_user_id ON boosts(user_id);
CREATE INDEX idx_boosts_bounty_id ON boosts(bounty_id);
CREATE INDEX idx_boosts_submission_id ON boosts(submission_id);
CREATE INDEX idx_support_events_user_id ON support_events(user_id);
CREATE INDEX idx_support_events_target ON support_events(target_type, target_id);
CREATE INDEX idx_curated_items_type_placement ON curated_items(item_type, placement);
