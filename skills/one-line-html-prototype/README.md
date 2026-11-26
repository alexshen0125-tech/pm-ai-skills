# 一句话出 HTML 原型（one-line-html-prototype）

**版本：** v1.0 · **日期：** 2026-11-09

**实测：** 实测通过（2026-11-10）：在本机 Claude Code 里项目级安装真跑，「出个能点的原型」自动调用，先用 3 行复述 + 5 条假设请你确认；问低保真和高保真区别时不调用。同一句需求说「直接出」时：装后 97 分、不装 73 分。装后的页面脚本无语法错、示例数据都标了（示例）、有空状态 / 通知失败 / 发送前确认，并附 7 条交互自检和假设清单；不装的版本没有失败状态、数据没标示例，还多出 4 个统计卡。装后反而更快更短（115 秒对 179 秒）。样本 1 次，仅供参考。

## 用处

### 解决什么问题
评审时只有文字，大家对页面的想象各不相同；画线框图又要半天。

### 适合谁
做 B 端后台、管理系统的产品经理；评审前要一个能点的东西的人。

### 什么时候用 / 什么时候别用
| 用 | 别用 |
|---|---|
| 评审、演示前要一个能点的页面<br>列表页、表单页、详情页、看板页 | 要能上线的生产代码<br>要改设计稿文件<br>只要文字版交互说明 |

### 用前 / 用后
**用前：** 一句「做个订单管理」，拿回 8 个页面，带登录页，引用了三个外部字体和图标库，断网打不开；评审时点「删除」直接删了，没有确认；列表一筛就白屏，没有空状态。

**用后：** 先被确认 3 行复述和 3 条假设；拿到一个 `order-list.html`，离线能开，能筛选、能看抽屉详情、能切空状态，取消订单有二次确认写清「已支付的原路退款」；页面底部列着假设，评审逐条过。

## 用法

### 安装
仓库地址：`alexshen0125-tech/pm-ai-skills`，这个 Skill 在 `skills/one-line-html-prototype/`。整个文件夹一起放，不要只拷 `SKILL.md`（还用到 `reference/` 和 `templates/`）。

#### Claude Code
```bash
git clone --depth 1 https://github.com/alexshen0125-tech/pm-ai-skills.git /tmp/pm-ai-skills && mkdir -p ~/.claude/skills && cp -R /tmp/pm-ai-skills/skills/one-line-html-prototype ~/.claude/skills/ && rm -rf /tmp/pm-ai-skills
```

只在某个项目里用：把命令里的 `~/.claude/skills` 换成项目根目录下的 `.claude/skills`。装好后新开一个会话，说一句下面的触发说法；也可以输入 `/one-line-html-prototype` 直接调用。

#### Codex CLI
```bash
git clone --depth 1 https://github.com/alexshen0125-tech/pm-ai-skills.git /tmp/pm-ai-skills && mkdir -p ~/.agents/skills && cp -R /tmp/pm-ai-skills/skills/one-line-html-prototype ~/.agents/skills/ && rm -rf /tmp/pm-ai-skills
```

装好后新开会话，输入 `/skills` 能看到它；也可以输入 `$one-line-html-prototype` 点名调用。

#### Cursor / Gemini CLI
同样的命令，把目标目录换成 `~/.cursor/skills` 或 `~/.gemini/skills`。Gemini 第一次用会弹「是否启用这个 Skill」，同意即可。

#### Windows
下载仓库 zip，解压后把 `skills/one-line-html-prototype` 整个文件夹放进 `%USERPROFILE%\.claude\skills`（Codex 是 `%USERPROFILE%\.agents\skills`）。

#### 网页版（DeepSeek、Kimi、豆包、通义等）：复制全文粘贴
1. 打开文件夹里的 `SKILL.md`，全选复制。
2. 新开一个对话，先粘贴 `SKILL.md` 全文，再另起一行写你的需求；步骤里提到的模板文件（`templates/` 下）需要时一起贴。
3. 同一个对话里接着干活；换新对话要重新粘贴。

### 3 句触发说法
- 「出个原型：门店订单列表，能按状态筛、能取消」
- 「把这个需求做成能点的页面给老板看」
- 「一句话生成 HTML 原型：……」

### 一次完整使用示例
| | 内容 |
|---|---|
| 你说了什么 | 「出个原型：门店订单列表，能按状态筛、能取消。」 |
| 它问了你什么 | 先用 3 行复述（谁用 / 完成什么 / 完成标志），再列 3–5 条假设，例如「每页 20 条」「取消需要二次确认」「只有待发货能取消」，等你确认。 |
| 它交付了什么 | 一个 `order-list.html`：双击就能打开、不联网；能筛选、能看右侧抽屉详情、能切空状态，取消订单有二次确认；另附 7 条交互自检结果和页面底部的假设清单。 |

### 常见问题
**说了触发说法，它没反应怎么办？** 先确认文件夹名和 `SKILL.md` 第二行 `name:` 一致、放对了目录（见上面「安装」里你用的那个 AI）、新开了对话。还不行，直接说「用 one-line-html-prototype 这个 Skill」点名调用；或者把你平时的说法加进 `SKILL.md` 开头 `description:` 那一行里——它只靠这一行判断要不要出场。

**怎么改成自己团队的版本？** 不要一上来就大改。先照原样用 3 次，每次把它的产出和你手改后的版本都存下来，然后让 AI 对比两版、说出你改动背后的规则，把规则写进 `SKILL.md` 的步骤或「不要做」里；模板换成你们团队的格式，放进 `templates/` 覆盖同名文件即可。改完在 README「更新记录」里写一行。

**能直接拿去给研发开发吗？** 不能。它是演示原型，示例数据都标了「示例」；评审时逐条过页面底部的假设，确认后写进 PRD。

## 包里有什么
| 文件 | 用途 |
|---|---|
| `SKILL.md` | 四步流程、7 条交互自检 |
| `reference/页面规矩.md` | 列表 / 表单 / 详情 / 看板各自的规矩 |
| `templates/skeleton.html` | 能直接打开的列表页骨架（示例数据） |

## 更新记录
- v1.0（2026-11-09）：首发。
- v1.0（2026-11-26）：放进 pm-ai-skills 公开仓库，安装改为从仓库拷贝。
