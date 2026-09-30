---
name: calmotion-short-video-workflow
description: Batch-create publish-ready 6-second Chinese vertical Calmotion shortcut videos from a rotating shortcut intro, food-camera recordings, title libraries, reference videos, and music. Use when editing the `快捷指令` project or a folder with the same structure; do not use for general long-form editing or Jianying draft creation.
---

# Calmotion 快捷指令短视频工作流

把用户提供的参考影片、快捷指令片头、拍摄录屏、三批标题和音乐组合成可直接发布的中文竖屏成片。

默认项目根目录是 `D:\视频素材\快捷指令`。如果用户给出其他目录，以用户指定目录为准。

## 开始前

1. 先运行 `scripts/inventory.ps1` 或做等价的只读检查，确认 FFmpeg、参考影片、三批标题、片头素材、拍摄录屏、音乐和输出目录确实存在。
2. 阅读 [references/workflow.md](references/workflow.md)，按其中的剪辑、轮换、预览和 QA 规则执行。
3. 不要声称转写、预览、渲染或质检已完成，除非已经取得相应文件或命令结果。

## 必须保持的成片规则

- 画面比例为 9:16，正式成片优先使用 1080x1920、60 fps。
- 每条成片总长 6 秒：前 2 秒为快捷指令素材，后 4 秒为对应拍摄录屏。
- 拍摄录屏必须同时交代使用动作与识别结果；如果录屏里已有快捷指令片段，裁掉重复部分。
- 标题从 `标题\第一批.txt`、`第二批.txt`、`第三批.txt` 轮换选择，并尽量与食品场景匹配。
- 片头素材和音乐也要轮换；有多个候选时避免连续复用同一个文件。
- 标题使用可商用中文无衬线粗体，置于画面上方安全区，不遮住快捷指令核心图标或按钮。
- 标题只存在于片头，最晚在 2.00 秒片头结束时完全消失，不能遮挡后续拍摄录屏。
- 不生成剪映草稿；最终 MP4 直接写入 `成品`，中间文件放在 `成品\_edit`。

## 交付前

先制作低分辨率预览并检查标题位置、切点和识别结果，再渲染正式成片。正式输出后运行 `scripts/validate_outputs.ps1` 或做等价检查，至少验证时长、分辨率、帧率、编解码、音轨和完整解码。

交付时报告：成品目录、文件清单、每条使用的标题批次/编号、片头与音乐选择、实际规格、QA 结果及任何未解决问题。
