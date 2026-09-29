---
name: shikaka-video-editor
description: "Turn user-supplied 食卡卡 product footage into short vertical app promos, calorie-scan demos, or food-comparison episodes. Use when the user asks to inspect, storyboard, cut, caption, preview, QA, export, or create an editable JianYing draft for a 食卡卡 campaign. Do not use for unrelated video editing or environment-only setup."
---

# 食卡卡剪辑助理

Create concise, verifiable 9:16 promotional videos for 食卡卡 from user-supplied media. Protect the originals, keep claims grounded in visible product behavior, and treat an editable project, a preview, and a verified final as different deliverables.

## Route the request

1. Read [brand and story rules](references/brand-and-story.md) for every project.
2. Read [editing workflow](references/editing-workflow.md) before creating an edit plan or timeline.
3. Read [output contract](references/output-contract.md) when creating files.
4. Read [QA checklist](references/qa-checklist.md) before presenting a preview or final.
5. If the user requests an editable JianYing project, also load the installed `jianying-editor` skill before writing or running project code. Keep project-specific scripts outside every skill installation directory.

## Operating boundaries

- Start only when at least one source file or clear source directory is available. Inspect it with `ffprobe` before editing.
- Never overwrite, rename, move, or delete source media. Put generated artifacts in a source-adjacent `edit/` directory unless the user names another output directory.
- Discover tools and skill paths at runtime. Never copy machine-specific absolute paths from an older project into a reusable workflow.
- Treat historical projects as visual and process references only. Do not copy an old campaign name, date, calorie value, music file, source range, or claim into a new video unless the current footage and brief support it.
- Do not expose internal paths, usernames, prior project names, or private campaign information in outward-facing titles, captions, metadata, or repository files.
- Use only music, fonts, logos, screenshots, and reference videos supplied by the user or confirmed as licensed for this campaign.

## Required decision flow

### 1. Inspect and map the media

Record source identity, duration, streams, dimensions, frame rate, rotation, color metadata, audio, and decode status. Build a contact sheet or representative frames so that food, scan, result, log, nutrient, and end-card moments are chosen from visible evidence rather than filenames.

For a visual-only product demo with muted source audio, skip speech transcription and record that no upload or transcription was needed. If retained speech drives the edit, obtain word-level timing with a user-approved local or cloud path and never upload media without explicit consent.

### 2. Select a story mode

Choose the smallest story that proves the requested benefit:

- **Rapid scan:** meal → photo/scan → readable result → brand.
- **Feature funnel:** meal → scan → result → add to food log → daily nutrients → brand.
- **Comparison episode:** repeat food → scan/action → readable result for several foods, then a short CTA or brand close.

Use the timing guidance in the brand reference as a starting point, not a fixed template. Results must remain readable long enough to understand.

### 3. Propose the edit before cutting

Give a 4–8 sentence plain-language strategy covering the hook, story mode, selected beats, removed material, estimated runtime, caption language, audio plan, and requested deliverables. Wait for approval before fixing edit points, choosing music, adding effects, or creating a formal final. A user may pre-approve these choices in the original request; record that authorization in `project.md`.

### 4. Build from an explicit EDL

After approval, create `edl.json` with source path, source start/end, output start/end, beat, reason, caption, and any audio decision for each segment. Extract and verify segments individually before concatenation. Use hard cuts by default; add transitions only when they improve comprehension and were requested or approved.

Apply overlays after picture lock and captions last. For visual demos, mute source audio only when that is the approved plan. Keep any useful tap or interaction sound when it improves clarity and does not expose private speech.

### 5. Preview, approve, then deliver

Render a complete 720×1280 preview first, normally H.264/AAC at 30 fps. Inspect the rendered file at every cut and across the full duration. Make at most three evidence-based self-fix passes.

Do not render or present the formal 1080×1920 final until the preview is approved, unless the user explicitly pre-authorized final export from the approved strategy. Verify the final independently; preview QA does not prove the final.

If an editable JianYing draft is requested, create a uniquely named 1080×1920 project after preview approval. Do not overwrite an existing draft unless the user explicitly requested that exact replacement. Verify the draft directory and its project files before reporting success.

## Communication

Report what was actually inspected or rendered, not what a command was intended to do. Clearly distinguish: strategy proposed, preview rendered, preview approved, draft created, final rendered, and final verified. Deliver one formal final outwardly, plus the requested editable draft and concise QA evidence.
