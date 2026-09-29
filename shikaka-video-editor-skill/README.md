# 食卡卡剪辑助理 Skill

一个面向食卡卡 App 宣传视频的 Codex/Agent Skill。它把手机实拍、录屏或混合素材整理成竖屏短视频，并保留可审核的剪辑决策、720p 预览、QA 证据、1080p 正式成片，以及按需生成的可编辑剪映草稿。

## 适合的内容

- 餐食拍照识别：食物 → 拍照/扫描 → 热量与宏量营养结果 → 品牌收尾
- 功能路径演示：识别结果 → 加入饮食记录 → 查看每日营养
- 食物热量对比系列：多种食物依次展示、识别与结果揭晓

这个 Skill 默认保护原素材，不复用旧项目的硬编码路径、时间点、音乐或产品名。纯视觉演示在原声静音时不做无意义的语音转写；需要保留口播时才进入逐字时间码流程。

## 安装

从 GitHub 安装：

```sh
npx skills add <你的GitHub用户名>/shikaka-video-editor-skill --skill shikaka-video-editor --full-depth
```

从本地仓库安装：

```sh
npx skills add . --skill shikaka-video-editor --full-depth
```

如果你的 Agent 不支持 `npx skills`，也可以把 `skills/shikaka-video-editor/` 整个文件夹复制到对应的 skills 目录。必须连同 `references/` 与 `agents/` 一起复制。

## 使用示例

```text
请使用 $shikaka-video-editor，把我提供的食卡卡素材剪成一条 9:16、约 15 秒的英文功能演示。先检查素材并给我剪辑策略；我确认后做完整 720p 预览。原声静音，使用我提供的音乐，结尾品牌名用“食卡卡”。
```

```text
请使用 $shikaka-video-editor，把这些食物识别素材做成热量对比系列。每种食物保留“食物—扫描—结果”，字幕放上方安全区。预览通过后，再给我 1080×1920 成片和可编辑剪映草稿。
```

## 工作方式

1. 检查素材、生成画面索引，并保护原文件。
2. 选择“快速扫描”“功能漏斗”或“对比系列”的最小叙事。
3. 先提出 4–8 句剪辑策略并记录确认状态。
4. 用 EDL 逐段粗剪，最后加入字幕与已授权音乐。
5. 先渲染和检查 720×1280 完整预览。
6. 预览确认后，输出并重新检查 1080×1920 正式成片；剪映草稿按需生成。

## 建议环境

- FFmpeg 与 ffprobe
- 能生成图片字幕的 Pillow 或等效工具
- 已授权的英文字体 Poppins Bold；中文字幕使用已授权且验证过字形的 CJK 字体
- 需要可编辑剪映工程时，另行安装 `jianying-editor` skill

## 仓库结构

```text
skills/
└── shikaka-video-editor/
    ├── SKILL.md
    ├── agents/openai.yaml
    └── references/
        ├── brand-and-story.md
        ├── editing-workflow.md
        ├── output-contract.md
        └── qa-checklist.md
```

## 来源与许可

本项目的安全分阶段思路参考了 [Jaycheng1103/chatgpt-video-editing-skills](https://github.com/Jaycheng1103/chatgpt-video-editing-skills)，并结合食卡卡既有的产品演示剪辑流程重新设计。第三方说明见 [THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md)。本仓库以 MIT License 发布。
