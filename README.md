# PM AI Skills

面向产品经理的 Codex / Claude Skills 合集，覆盖：

`需求发现 -> 机会判断 -> PRD -> 开发拆分 -> 测试风险 -> 上线表达`

## 一键安装

### Codex

```bash
curl -fsSL https://raw.githubusercontent.com/alexshen0125-tech/pm-ai-skills/main/install.sh | bash -s -- codex
```

### Claude Code

```bash
curl -fsSL https://raw.githubusercontent.com/alexshen0125-tech/pm-ai-skills/main/install.sh | bash -s -- claude
```

### 两套一起安装

```bash
curl -fsSL https://raw.githubusercontent.com/alexshen0125-tech/pm-ai-skills/main/install.sh | bash -s -- both
```

默认安装完整组合。只想安装 4 个高频 Skills：

```bash
curl -fsSL https://raw.githubusercontent.com/alexshen0125-tech/pm-ai-skills/main/install.sh | bash -s -- codex minimal
curl -fsSL https://raw.githubusercontent.com/alexshen0125-tech/pm-ai-skills/main/install.sh | bash -s -- claude minimal
```

## 安装位置

- Codex：`~/.agents/skills/<skill-name>/SKILL.md`（Codex 官方目录；老版本用过 `~/.codex/skills`）
- Claude Code：`~/.claude/skills/<skill-name>/SKILL.md`

已有同名 Skill 时安装脚本会跳过，不覆盖本地修改。安装后建议重启 Codex 或 Claude Code。

## Codex 组合

- summarize-interview
- analyze-feature-requests
- opportunity-solution-tree
- prioritize-features
- create-prd
- user-stories
- wwas
- test-scenarios
- pre-mortem
- release-notes
- one-line-html-prototype

## Claude 组合

- summarize-interview
- customer-journey-map
- competitor-analysis
- product-strategy
- create-prd
- prioritize-features
- ui-ux-pro-max
- pre-mortem
- slides
- release-notes
- one-line-html-prototype

## 单独安装：one-line-html-prototype

一句话出一个能点的单文件 HTML 原型：先复述需求、列假设等你确认，再按页面类型套骨架出页，带空状态、失败提示、危险操作二次确认，最后附 7 条交互自检和假设清单。说明见 [skills/one-line-html-prototype/README.md](skills/one-line-html-prototype/README.md)。

```bash
# Claude Code（Codex 把目标目录换成 ~/.agents/skills）
git clone --depth 1 https://github.com/alexshen0125-tech/pm-ai-skills.git /tmp/pm-ai-skills && mkdir -p ~/.claude/skills && cp -R /tmp/pm-ai-skills/skills/one-line-html-prototype ~/.claude/skills/ && rm -rf /tmp/pm-ai-skills
```

## 使用提醒

Skill 提供的是可复用工作流，不保证业务结论正确。用户事实、公司规则、数据真实性、优先级和最终决策仍需人工确认。
