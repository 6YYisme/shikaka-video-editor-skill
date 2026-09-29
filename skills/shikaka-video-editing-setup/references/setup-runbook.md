# Setup runbook

Use this runbook for inspection and for user-approved environment changes. Do not edit or upload media during setup.

## 1. Identify the platform and real executables

Record the OS, CPU architecture, active agent, home directory, and Skills directory. Check actual version output, not only command discovery.

Required base tools:

| Tool | Requirement | Notes |
| --- | --- | --- |
| Git | working executable | Needed for verified upstream checkouts |
| Python | 3.10 or newer | Current `video-use` package metadata requires `>=3.10` |
| uv | preferred | A current upstream-supported `pip install -e .` path may be used if uv is unavailable |
| FFmpeg | working executable | Required for render and decode operations |
| ffprobe | working executable | Required for source and output inspection |

### Windows inspection

Use PowerShell and record the resolved command path plus successful version output:

```powershell
$names = 'git','python','py','uv','ffmpeg','ffprobe'
Get-Command $names -ErrorAction SilentlyContinue |
  Select-Object Name, Source, CommandType

git --version
python --version
uv --version
ffmpeg -version
ffprobe -version
```

If `python` resolves to the Microsoft Store alias but cannot execute a real interpreter, mark Python missing. If `py` works, record the selected Python version and executable. Do not install into or modify Codex's bundled runtime as the user's permanent video environment.

### macOS/Linux inspection

```sh
uname -s
uname -m
command -v git python3 uv ffmpeg ffprobe
git --version
python3 --version
uv --version
ffmpeg -version | head -1
ffprobe -version | head -1
```

## 2. Inspect the official video-use checkout

Accepted origin:

```text
https://github.com/browser-use/video-use.git
```

Recommended stable paths:

- Windows: `%USERPROFILE%\Developer\video-use`
- macOS/Linux: `~/Developer/video-use`

An absent path may be proposed for cloning. Any existing path must pass all checks: it is a Git worktree, `HEAD` resolves, origin matches exactly, and `git status --short` is empty. A clean fork or SSH URL is still not the accepted origin for this workflow. Never rewrite a remote automatically.

PowerShell inspection pattern:

```powershell
function Test-ExpectedRepo {
  param([string]$Repo, [string]$ExpectedOrigin)

  if (-not (Test-Path -LiteralPath $Repo)) { return 2 }
  $inside = git -C $Repo rev-parse --is-inside-work-tree 2>$null
  if ($LASTEXITCODE -ne 0 -or $inside -ne 'true') { throw "Not a Git worktree: $Repo" }
  $commit = git -C $Repo rev-parse --verify HEAD
  if ($LASTEXITCODE -ne 0) { throw "Invalid HEAD: $Repo" }
  $branch = git -C $Repo branch --show-current
  $origin = git -C $Repo remote get-url origin
  if ($LASTEXITCODE -ne 0 -or $origin -ne $ExpectedOrigin) { throw "Unexpected origin: $origin" }
  $status = @(git -C $Repo status --short)
  if ($status.Count -gt 0) { throw "Dirty repository: $Repo" }
  [pscustomobject]@{ Repo=$Repo; Origin=$origin; Branch=$branch; Commit=$commit; Status='clean' }
}
```

On macOS/Linux, use equivalent `git -C` checks. Do not test only whether `.git` is a directory because linked worktrees use a `.git` file.

## 3. Propose changes before performing them

For every missing requirement, show the user:

- what will be installed or changed;
- the exact target path;
- the source or package identifier;
- whether it needs administrator rights, downloads a large payload, creates a junction/symlink, or may affect other projects;
- how it will be verified.

Wait for approval. After approval, query current official package metadata or the selected package manager before installing. Do not assume a stale package ID.

Suggested platform choices, subject to user approval and current official documentation:

- Windows: a user-selected package manager such as `winget`, or official installers. Verify exact package IDs with `winget show` before `winget install`.
- macOS: Homebrew or official installers; wait before any `brew install` if not already authorized.
- Debian/Ubuntu: official repositories for Git, Python, and FFmpeg; commands requiring `sudo` must be shown to the user first.
- Other Linux distributions: use the user's package manager or give the official manual-install page instead of guessing.

## 4. Install or repair video-use

At execution time, read the current official files in the checkout or on GitHub:

- `install.md`
- `SKILL.md`
- `pyproject.toml`
- lockfile or package-manager instructions

For a missing path, after approval:

```powershell
# Windows PowerShell
$videoUse = Join-Path $env:USERPROFILE 'Developer\video-use'
git clone https://github.com/browser-use/video-use.git $videoUse
```

```sh
# macOS/Linux
git clone https://github.com/browser-use/video-use.git "$HOME/Developer/video-use"
```

Immediately re-run repository verification. Then install Python dependencies with the method documented by that checkout. Current upstream prefers:

```sh
uv sync
```

and currently allows:

```sh
pip install -e .
```

Do not mix installers within one environment without a reason. Do not pull or repair a dirty or unexpected checkout.

## 5. Register the whole repository

Register the whole `video-use` directory because its `helpers/` must remain next to `SKILL.md`. Never copy only the entrypoint file.

For Codex, resolve the active destination from `$CODEX_HOME` or the user's `.codex/skills` directory. Preflight the exact destination. If a file, directory, junction, or symlink already exists, inspect it and stop unless it is already the exact intended registration.

On Windows, prefer a directory junction when symlink creation is unavailable. On macOS/Linux, use a plain directory symlink. Never force-replace an existing destination.

Example after approval:

```powershell
$videoUse = Join-Path $env:USERPROFILE 'Developer\video-use'
$codexRoot = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $env:USERPROFILE '.codex' }
$destination = Join-Path $codexRoot 'skills\video-use'
if (Test-Path -LiteralPath $destination) { throw "Destination already exists: $destination" }
New-Item -ItemType Junction -Path $destination -Target $videoUse
```

```sh
destination="${CODEX_HOME:-$HOME/.codex}/skills/video-use"
test ! -e "$destination" && test ! -L "$destination" || exit 1
ln -s "$HOME/Developer/video-use" "$destination"
```

## 6. Fonts

Choose fonts from the campaign language:

- Simplified Chinese: approved brand font or Source Han Sans SC.
- Traditional Chinese: approved brand font or Source Han Sans TW.
- English: user-supplied licensed Poppins Bold is preferred for the established 食卡卡 style.

Only download Source Han Sans from Adobe's official repository `https://github.com/adobe-fonts/source-han-sans`, using the `release` branch and correct regional subset. Never overwrite an existing font path or silently substitute another font.

On Windows, a project-managed font directory such as `%LOCALAPPDATA%\ShikakaVideoEditing\fonts` is acceptable and avoids changing system-wide fonts; renderers must use the explicit file path. On macOS/Linux, a user font directory or a project-managed directory is acceptable. Verify each OpenType/CFF file begins with the `OTTO` magic bytes and render a sample containing `食卡卡` before calling it ready.

## 7. Optional capabilities

### Speech transcription

Only prepare ElevenLabs when retained speech needs word-level timing. Follow the security reference. Never run a transcription during setup.

### Editable JianYing draft

When requested, verify the `jianying-editor` skill can be loaded, its validator succeeds, and a writable drafts root is known. Do not create or overwrite a real draft during setup.

### Web animation

Only inspect or propose Node.js and an animation engine when the brief needs web animation. Follow the chosen engine's current official documentation and lockfile. Do not install every animation stack by default.

## 8. Local verification

Base readiness requires evidence for:

- Git and Python version/path;
- uv or the approved Python dependency path;
- FFmpeg and ffprobe version/path;
- verified clean `video-use` checkout with official origin and `helpers/`;
- exact skill registration destination and target;
- a no-cost helper command such as `timeline_view.py --help`;
- no media upload, transcription, edit, preview, or render performed during setup.

Verify fonts, credentials, JianYing, and animation tooling only when requested by the current capability profile.
