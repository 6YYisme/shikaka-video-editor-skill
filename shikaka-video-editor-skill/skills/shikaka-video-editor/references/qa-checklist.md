# QA checklist

Run this checklist against the complete preview, then repeat it against the rendered final. Save evidence for the exact inspected file.

## Technical

- File exists, is non-empty, and has a recorded fingerprint.
- Full decode completes without errors.
- Preview is normally 720×1280; final is normally 1080×1920.
- Frame rate matches the approved timeline, normally 30 fps.
- Video is H.264 with a broadly compatible pixel format; audio is AAC when audio is present.
- Duration matches the EDL within a small documented tolerance.
- Fast-start metadata is enabled when practical for social delivery.

## Visual

- First frame hooks with visible food or the intended product moment; no accidental empty-plate lead-in.
- Every cut is checked immediately before and after for flash frames, black frames, jumps, repeated frames, and missing action.
- Phone, meal, result values, log confirmation, and nutrient panel remain inside frame and are readable.
- Captions use the approved text, font, language, line breaks, outline, and upper safe area.
- Chinese glyphs render correctly; no tofu boxes or silent fallback.
- End card says 食卡卡 or the currently approved localized name; no historical product name remains.
- No private notifications, account details, health data, faces, or location clues are unintentionally visible.
- Color and exposure are consistent enough that the food and phone screen are clear. Do not apply a style grade merely to make the checklist pass.

## Audio

- The source audio decision matches the approved strategy.
- No clicks, pops, clipped peaks, sudden starts, or abrupt endings.
- BGM is licensed or user-supplied, uses the selected passage, ends cleanly, and does not mask useful interaction sound or speech.
- Audio and video end together.

## Evidence and stopping rules

Create a contact sheet plus boundary samples around every cut. Review the complete render, not only still images. Make a self-fix only when the evidence identifies a concrete problem, and stop after three unsuccessful passes with a clear issue report.

Technical checks and visual review are separate. A technically valid file with `visual_review: pending` is not deliverable. Record preview approval before creating the formal final unless the user explicitly pre-authorized final export.
