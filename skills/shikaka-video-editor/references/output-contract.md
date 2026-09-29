# Output contract

Keep new project artifacts together. The source remains outside this structure and unchanged.

```text
edit/
├── project.md
├── source-manifest.json
├── story-map.md
├── edl.json
├── master.srt
├── transcripts/
│   └── state.json
├── clips/
├── overlays/
├── audio/
├── qa/
│   ├── preview-contact.jpg
│   ├── preview-qa.json
│   └── final-qa.json
├── preview.mp4
└── deliverables/
    ├── final.mp4
    └── delivery-note.md
```

Create only the directories the project actually needs. A visual-only product demo may have a small `transcripts/state.json` documenting that no transcript or cloud upload was required. An editable JianYing draft normally lives in the user's configured drafts root; record its verified path in `project.md` and `delivery-note.md` rather than copying it into `edit/` without permission.

## Required records

- `source-manifest.json`: source paths, fingerprints, probe data, and inspection time.
- `story-map.md`: observed moments and candidate ranges; it is not an approved EDL.
- `project.md`: brief, approved strategy, approvals, creative decisions, render history, tool choices, unresolved issues, and legacy-name check.
- `edl.json`: exact source and output ranges, beat, reason, captions, and audio decisions.
- `master.srt`: the editable output-timeline caption record when timed text is used.
- `qa/*.json`: observed technical and visual checks for the exact file identified by path and fingerprint.
- `delivery-note.md`: what was delivered, what was verified, and what remains pending.

Do not claim `final.mp4` exists until it has been rendered. Do not promote a preview into `deliverables/` by renaming it. Do not mark visual review as passed when it is still pending manual inspection.
