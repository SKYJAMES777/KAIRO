你负责开发 KAIRO MVP。

KAIRO 是一个 Crypto Comeback Launchpad，核心是让项目方发布 Catalyst，AI Builder 提交 Demo，社区通过 Boost 和分享帮助方案上榜。第一版不做链上众筹、不做发币、不做智能合约、不做平台币。重点是 Catalyst、Submission、Boost、Momentum、排行榜、推荐链接、Funding Status、Proof of Support、人工种子榜单和管理后台。

技术栈必须使用：
- Vite + React + TypeScript
- Tailwind CSS + shadcn/ui
- React Router
- TanStack Query
- Cloudflare Workers
- Hono
- Zod
- Cloudflare D1
- Cloudflare KV
- Cloudflare R2 预留
- Cloudflare Queues 预留
- Wrangler
- Cloudflare Vite Plugin

不要使用：
- Next.js
- Supabase
- Vercel
- NestJS
- FastAPI
- PostgreSQL
- Redis
- Docker
- 智能合约

必须实现的核心模块：
1. 用户基础登录和角色选择。
2. Token Profile。
3. Catalyst 创建、列表、详情、审核。内部表名可继续使用 bounties。
4. Catalyst funding_status：unverified / pledged / escrowed / partially_paid / paid / disputed / cancelled。
5. 前端禁止展示 “escrowed by KAIRO / 托管”等文案，escrowed 状态前端展示为 “Reward confirmed by KAIRO / 奖励已由 KAIRO 确认”。
6. Funding Events / Reward Records 记录奖励确认和支付事件，内部表可使用 escrow_events。
7. Builder Submission 创建、列表、详情、审核。
8. Boost Catalyst / Boost Submission。
9. Momentum：根据有效 Boost、分享、推荐、提交数等生成社区势能。
10. Referral 链接和来源记录。
11. KAIRO Score，交付权重大于 Boost。
12. Support Points：用户积分余额。
13. Support Events：不可变支持事件流水，作为 Proof of Support 的基础。
14. Proof of Support 页面：展示用户支持过哪些 Catalyst / Builder。
15. Leaderboard：Hottest Catalysts、Confirmed Reward Catalysts、Top Builders、Most Boosted Submissions、Dormant Giants、Breakout Stories、Comeback Hall、Genesis Candidates。
16. Curated Items：允许管理员手动添加首页种子内容和榜单内容，必须包含 item_type 和 placement。
17. Admin 后台：审核 Catalyst、审核 Submission、标记 funding_status、添加 funding events、标记 Winner、标记 Completed、删除异常 Boost、管理 support_events、管理 curated_items。
18. 分享文案：每个 Catalyst 和 Submission 都可复制 X / Telegram 分享文本。

数据库使用 Cloudflare D1，至少包含：
users
tokens
bounties
submissions
boosts
builder_scores
support_points
support_events
referrals
escrow_events
curated_items
admin_actions

首页不能出现空榜单。若真实数据不足，使用 curated_items 填充。

代码要求：
- 品牌上显示 KAIRO / Catalyst / KAIRO Score / Dormant Giants / Breakout Stories / Genesis Candidates。
- 动作统一叫 Boost。
- 社区势能统一叫 Momentum。
- 内部代码可以继续使用 bounties / boosts / builder_scores 等简单命名。
- 业务逻辑和 D1 查询分层，降低 Cloudflare vendor lock-in。
- D1 作为事实源，KV 只做缓存。
- 所有 API 使用 Zod 校验。
- 普通用户不能访问 Admin API。
- 用户只能编辑自己的内容。
- Boost 必须有基础反刷限制。
- Support Events 尽量只追加，不物理删除；异常通过 validity_status 标记。
- MVP 阶段不实现托管服务费，不把 Funding Status 描述为托管服务。
- README 写清楚本地开发、D1 migration、Wrangler 部署流程。

完成标准：
- 本地可运行。
- Cloudflare 可部署。
- 前端页面可访问。
- API 可读写 D1。
- 用户可发布 Catalyst、提交方案、Boost、查看榜单。
- 用户可查看 Proof of Support。
- 管理员可审核和配置首页内容。
