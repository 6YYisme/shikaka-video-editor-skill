# Editing workflow

## 1. Preflight

Inspect each source with `ffprobe` and run a decode check when practical. Record a source fingerprint, streams, duration, dimensions, frame rate, rotation, color metadata, and audio state. Confirm the intended platform, language, approximate duration, and whether the user needs a preview, final MP4, editable JianYing draft, or all three.

Create the workspace only after the source is readable. Never alter the source.

## 2. Visual map

Generate a contact sheet or representative frames at useful intervals. For long takes, inspect denser frames around likely food, phone-entry, shutter, recognition-result, add-meal, and nutrient-panel moments. Record promising ranges in `story-map.md` with plain-language observations.

When the source contains speech that will not be used, do not transcribe it. Record `transcription: not_required`, `source_audio: muted` or `unused`, and `cloud_upload: false`. When speech is retained, use reliable word-level timing and align cuts to complete words.

## 3. Strategy approval

Propose the narrative and deliverables before cutting. Include:

- the opening hook and audience takeaway;
- the chosen story mode and beat order;
- what will be removed, especially idle recognition time;
- estimated runtime and pacing;
- caption language and brand treatment;
- whether source audio, BGM, effects, final export, and JianYing draft are included.

Store the approved version and approval state in `project.md`.

## 4. EDL and rough cut

Create `edl.json` before rendering. Each segment should contain at least:

```json
{
  "id": "result",
  "source": "<absolute source path>",
  "source_start": 12.3,
  "source_end": 17.1,
  "timeline_start": 4.7,
  "timeline_end": 9.5,
  "beat": "Readable calorie and macro result",
  "reason": "Later stable take is clearer",
  "source_audio": "muted"
}
```

Do not copy values from this example or an old campaign. Extract each approved range independently, normalize it to the timeline canvas and frame rate, verify the clip, then concatenate. For retained speech, keep word-boundary padding and short audio fades at cut edges. For muted product demos, preserve the full visible action rather than optimizing around speech.

## 5. Titles, captions, and mix

Create caption assets from the approved copy. Keep editable caption data in `master.srt` or a structured equivalent even when the cards are designed as images. Build the picture first, then overlays, then captions. Validate font licensing and glyph coverage.

Trim approved BGM to the exact runtime. Use gentle entrance and exit fades and avoid clipping. If the source contains useful interaction sound, mix it deliberately rather than keeping or deleting it by accident.

## 6. Preview

Render one complete 720×1280 preview at 30 fps unless the source or platform brief requires another frame rate. The preview must include every approved picture, caption, and audio choice. Record its hash, file size, probe data, decode result, contact sheet, cut-boundary samples, and self-fix count.

Show the complete preview for approval. Do not call it the final.

## 7. Final and optional JianYing draft

After preview approval, render a 1080×1920 H.264/AAC final, normally at the approved preview timing. Re-run the full QA checklist on the final itself.

When an editable JianYing draft is requested:

1. Load the installed `jianying-editor` skill and its relevant setup, core, media, text, and acceptance instructions.
2. Put the campaign build script in the current project, never inside the skill directory.
3. Discover the JianYing skill and drafts root; do not hard-code another machine's path.
4. Use a unique, descriptive draft name. Refuse accidental overwrite of an existing draft.
5. Create separate main-video, BGM, and editable text tracks where practical.
6. Confirm the draft directory and inspect the saved project structure before delivery.

An editable draft is not proof that a final MP4 exists, and a final MP4 is not proof that the draft is editable. Report them separately.
