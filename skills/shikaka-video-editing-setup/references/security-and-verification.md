# Security and verification

## Mutation boundaries

Inspection is read-only. Before any installation, download, clone, pull, dependency change, font write, junction/symlink creation, Skills registration, credential-file change, or administrator command, present the exact change list and wait for explicit approval.

Approval for one list does not authorize later additions. Re-run repository and destination checks after an approval wait because the filesystem may have changed.

Never use destructive repair such as hard reset, forced checkout, forced link replacement, or deletion of an unexpected path. Stop and show the evidence.

## Downloads and repositories

- Accept `video-use` only from `https://github.com/browser-use/video-use.git`.
- Accept Source Han Sans only from `https://github.com/adobe-fonts/source-han-sans` on its official release branch.
- Follow current official installation documentation for Git, Python, uv, FFmpeg, and optional tools.
- Verify downloaded fonts or archives before reporting them ready. Do not delete a failed or suspicious existing file automatically.
- Do not embed local absolute paths, credentials, or private campaign assets into the public 食卡卡 skill repository.

## Credentials

Use `ELEVENLABS_API_KEY` only from a process environment variable or a user-approved protected local secret file. Prefer the environment variable.

Never ask the user to paste the key into chat. Never print its value, length, prefix, suffix, or a redacted-looking substitute. Never pass it as a visible command-line argument or write it into logs, repository files, commit messages, examples, or shell history.

Before preparing a local `.env`:

1. Obtain approval for that exact file.
2. Verify with Git that `.env` is ignored before the file exists.
3. Ask the user to write the value outside the conversation.
4. Confirm only that the file is a regular local file with appropriately restricted access; do not read its contents.

On macOS/Linux, verify restrictive permission bits. On Windows, verify the file is on a local filesystem and review its ACL without displaying contents; do not weaken inherited security or rewrite ACLs without a separate approved plan.

Setup never calls a paid endpoint. Before the first later media upload, obtain separate consent naming the file, provider, transcription purpose, and possible quota or cost.

## Readiness report

Report each capability independently:

| Capability | Evidence |
| --- | --- |
| Base editing | Git, Python, uv/pip path, FFmpeg, ffprobe, clean official video-use checkout, helpers, registration target |
| Chinese captions | exact font files, license/source, format validation, successful `食卡卡` glyph sample |
| Speech transcription | approved credential source exists; no value shown and no paid call made |
| JianYing draft | installed skill resolves and configured drafts root is writable; no draft created during setup |
| Web animation | requested engine and runtime verified under current upstream requirements |

Use one of: `ready`, `not ready`, or `not requested`. A skipped optional capability must not make base editing fail. If a check fails, state the next proposed mutation and wait.
