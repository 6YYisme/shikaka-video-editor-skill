---
name: shikaka-video-editing-setup
description: "Inspect, install, repair, and verify the local runtime used by the 食卡卡 video-editing workflow. Use when the user asks to check or prepare Git, Python, uv, FFmpeg, ffprobe, video-use, caption fonts, transcription credentials, optional JianYing integration, or animation tooling. Do not edit, transcribe, or render media during setup."
---

# 食卡卡剪辑环境设置

Prepare the machine for the 食卡卡 editing workflow and produce an evidence-backed readiness report. Setup ends before any media upload, transcription, creative decision, preview, or render.

## Read first

Read [setup runbook](references/setup-runbook.md) before checking or changing the machine. Read [security and verification](references/security-and-verification.md) before downloading software, handling credentials, registering a skill, or declaring readiness.

At execution time, also read the checked-out `video-use/install.md`, `video-use/SKILL.md`, and package metadata. Upstream instructions can change; this skill supplies safety boundaries, not a frozen substitute for current upstream documentation.

## Readiness profiles

Report readiness by capability instead of treating every optional tool as mandatory:

- **Base editing:** Git, Python 3.10 or newer, `uv` or a supported Python installer path, FFmpeg, ffprobe, a verified `video-use` checkout, and whole-repository skill registration.
- **Chinese captions:** an approved Source Han Sans SC/TW font or other verified licensed CJK brand font with working glyph coverage.
- **Speech transcription:** a protected ElevenLabs credential only when retained speech needs word-level transcription. A muted, visual-only 食卡卡 demo does not require it.
- **Editable JianYing draft:** the `jianying-editor` skill and a verified drafts location, only when the user requests an editable project.
- **Web animation:** Node.js and an approved animation engine only when the editing strategy requires HTML, CSS, GSAP, Remotion, or equivalent animation.

## Required sequence

1. Inspect the operating system, architecture, active agent, Skills directory, and actual command results for Git, Python, uv, FFmpeg, and ffprobe. A command shim that cannot return a real version is missing.
2. Inspect existing repositories as Git worktrees using `git rev-parse`; record exact origin, branch or detached commit, and status. Never infer repository validity from the presence of a `.git` directory.
3. Treat an existing non-repository path, missing origin, unexpected origin, invalid commit, or dirty worktree as a hard stop for repository mutation. Do not pull, reset, overwrite, reclone, or rewrite the remote.
4. List every proposed mutation with its exact target and reason: package installation, clone or update, dependency install, font download, directory junction or symlink, Skills registration, credential file, or optional large dependency. Wait for explicit approval that covers that list.
5. After approval, follow the platform branch in the runbook. Recheck repository identity and cleanliness immediately before dependency installation and skill registration.
6. Verify locally without uploading media or making paid API calls. Record command paths and versions, repository evidence, helper availability, font validity, registration target, and requested optional capabilities.
7. Hand off to `$shikaka-video-editor` only when the capability needed for the requested edit is ready. Report optional skipped capabilities as “not requested,” not failed.

## Secrets and paid services

Never request an API key in chat, echo it, inspect its value, place it in a command argument, or commit it. Prefer an existing process environment variable. A local secret file may be prepared only after explicit approval and ignore-path verification; the user writes the value outside the conversation.

Before the first later upload of any media, the editing workflow must name the file, identify the transcription service and purpose, mention possible quota or charges, and obtain separate file-specific consent. Setup authorization is not upload authorization.

## Completion boundary

“Ready” means the required readiness profile passed observable checks. If a requirement remains missing, report the exact gap and next proposed action. Do not create an `edit/` directory, touch source media, or claim that a video workflow works based only on planned commands.
