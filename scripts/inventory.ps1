param(
    [string]$ProjectRoot = 'D:\视频素材\快捷指令'
)

$ErrorActionPreference = 'Stop'
$mediaExtensions = @('.mp4', '.mov', '.m4v', '.mkv', '.webm', '.mp3', '.wav', '.m4a', '.aac')

function Get-MediaFiles([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path)) { return @() }
    return @(Get-ChildItem -LiteralPath $Path -Recurse -File | Where-Object {
        $mediaExtensions -contains $_.Extension.ToLowerInvariant()
    } | Sort-Object FullName | ForEach-Object { $_.FullName })
}

function Get-TitleCount([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path)) { return 0 }
    return @(Get-Content -LiteralPath $Path -Encoding UTF8 | Where-Object {
        $_ -match '^\s*\d+\s*[\.、]\s*\S+'
    }).Count
}

$paths = [ordered]@{
    references = Join-Path $ProjectRoot '参考影片'
    titleRoot = Join-Path $ProjectRoot '标题'
    intros = Join-Path $ProjectRoot '素材\快捷指令素材'
    recordings = Join-Path $ProjectRoot '素材\拍摄录屏'
    music = Join-Path $ProjectRoot '音乐'
    outputs = Join-Path $ProjectRoot '成品'
}

$report = [ordered]@{
    projectRoot = $ProjectRoot
    ffmpeg = (Get-Command ffmpeg -ErrorAction SilentlyContinue).Source
    ffprobe = (Get-Command ffprobe -ErrorAction SilentlyContinue).Source
    paths = [ordered]@{}
    titleCounts = [ordered]@{}
    media = [ordered]@{
        references = @(Get-MediaFiles $paths.references)
        intros = @(Get-MediaFiles $paths.intros)
        recordings = @(Get-MediaFiles $paths.recordings)
        music = @(Get-MediaFiles $paths.music)
        outputs = @(Get-MediaFiles $paths.outputs | Where-Object { $_ -notmatch '[\\/]_edit[\\/]' })
    }
}

foreach ($entry in $paths.GetEnumerator()) {
    $report.paths[$entry.Key] = [ordered]@{
        path = $entry.Value
        exists = Test-Path -LiteralPath $entry.Value
    }
}

foreach ($batch in @('第一批', '第二批', '第三批')) {
    $titlePath = Join-Path $paths.titleRoot "$batch.txt"
    $report.titleCounts[$batch] = [ordered]@{
        path = $titlePath
        exists = Test-Path -LiteralPath $titlePath
        count = Get-TitleCount $titlePath
    }
}

$report | ConvertTo-Json -Depth 8
