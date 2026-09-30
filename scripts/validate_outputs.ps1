param(
    [string]$ProjectRoot = 'D:\视频素材\快捷指令',
    [double]$ExpectedDuration = 6.0,
    [double]$DurationTolerance = 0.05
)

$ErrorActionPreference = 'Stop'

if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
    throw 'ffmpeg is not available in PATH.'
}
if (-not (Get-Command ffprobe -ErrorAction SilentlyContinue)) {
    throw 'ffprobe is not available in PATH.'
}

$outputRoot = Join-Path $ProjectRoot '成品'
$files = @(Get-ChildItem -LiteralPath $outputRoot -File -Filter '*.mp4' | Sort-Object Name)
if ($files.Count -eq 0) {
    throw "No MP4 outputs found in $outputRoot"
}

function Convert-Rational([string]$Value) {
    $parts = $Value -split '/'
    if ($parts.Count -eq 2 -and [double]$parts[1] -ne 0) {
        return [double]$parts[0] / [double]$parts[1]
    }
    return [double]$Value
}

$results = foreach ($file in $files) {
    $probeText = (& ffprobe -v error -show_entries 'format=duration:stream=codec_type,codec_name,width,height,r_frame_rate,sample_rate,channels,pix_fmt' -of json $file.FullName 2>$null) -join "`n"
    $probe = $probeText | ConvertFrom-Json
    $video = @($probe.streams | Where-Object codec_type -eq 'video')[0]
    $audio = @($probe.streams | Where-Object codec_type -eq 'audio')[0]
    $duration = [double]$probe.format.duration
    $fps = Convert-Rational $video.r_frame_rate

    $decodeOutput = (& ffmpeg -v error -i $file.FullName -map 0 -f null NUL 2>&1 | Out-String).Trim()
    $decodeExit = $LASTEXITCODE

    $checks = [ordered]@{
        duration = [math]::Abs($duration - $ExpectedDuration) -le $DurationTolerance
        canvas = ($video.width -eq 1080 -and $video.height -eq 1920)
        fps = [math]::Abs($fps - 60.0) -lt 0.01
        videoCodec = $video.codec_name -eq 'h264'
        audioCodec = $audio.codec_name -eq 'aac'
        audioRate = $audio.sample_rate -eq '48000'
        stereo = $audio.channels -eq 2
        decode = $decodeExit -eq 0
    }

    [pscustomobject]@{
        file = $file.Name
        passed = -not ($checks.Values -contains $false)
        duration = $duration
        resolution = "$($video.width)x$($video.height)"
        fps = $fps
        videoCodec = $video.codec_name
        audioCodec = $audio.codec_name
        decodeExit = $decodeExit
        decodeOutput = $decodeOutput
        checks = $checks
    }
}

$results | ConvertTo-Json -Depth 6
if ($results.passed -contains $false) { exit 1 }
