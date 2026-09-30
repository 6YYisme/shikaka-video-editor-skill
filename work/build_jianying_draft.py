import json
import os
import sys

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")
if hasattr(sys.stderr, "reconfigure"):
    sys.stderr.reconfigure(encoding="utf-8")


current_dir = os.path.dirname(os.path.abspath(__file__))
env_root = os.getenv("JY_SKILL_ROOT", "").strip()
skill_candidates = [
    env_root,
    os.path.join(current_dir, ".agent", "skills", "jianying-editor"),
    os.path.join(current_dir, ".trae", "skills", "jianying-editor"),
    os.path.join(current_dir, ".claude", "skills", "jianying-editor"),
    os.path.join(current_dir, "skills", "jianying-editor"),
    os.path.abspath(".agent/skills/jianying-editor"),
    os.path.dirname(current_dir),
]

scripts_path = None
attempted = []
for candidate in skill_candidates:
    if not candidate:
        continue
    candidate = os.path.abspath(candidate)
    attempted.append(candidate)
    if os.path.exists(os.path.join(candidate, "scripts", "jy_wrapper.py")):
        scripts_path = os.path.join(candidate, "scripts")
        break

if not scripts_path:
    raise ImportError(
        "Could not find jianying-editor/scripts/jy_wrapper.py\nTried:\n- "
        + "\n- ".join(attempted)
    )

if scripts_path not in sys.path:
    sys.path.insert(0, scripts_path)

from jy_wrapper import JyProject
import pyJianYingDraft as draft


OUTPUT_ROOT = r"D:\产出草稿\Calmotion_快捷指令_20260929_01"
DRAFTS_ROOT = os.path.join(OUTPUT_ROOT, "jianying_drafts")
PROJECT_NAME = "Calmotion_快捷指令_中文竖屏短视频_v3"
INTRO = os.path.join(OUTPUT_ROOT, "assets", "source_快捷指令素材.mp4")
VIDEO = os.path.join(OUTPUT_ROOT, "assets", "source_苹果干.mp4")
MUSIC = os.path.join(OUTPUT_ROOT, "assets", "music_The_gorgeous_Alysa_Liu.mp3")


def add_video_segment(project, media_path, source_start, duration, target_start):
    segment = project.add_clip(
        media_path,
        source_start=source_start,
        duration=duration,
        target_start=target_start,
        track_name="MainVideo",
    )
    if segment is None:
        raise RuntimeError(f"Failed to add video segment at {source_start}")
    segment.volume = 0.0
    segment.clip_settings = draft.ClipSettings(scale_x=1.222, scale_y=1.222)
    return segment


def add_subtitle_line(project, text, track_name, transform_y):
    segment = project.add_text_simple(
        text,
        start_time="0.05s",
        duration="2.15s",
        track_name=track_name,
        font=draft.FontType.SourceHanSansCN_Bold,
        style=draft.TextStyle(size=8.0, bold=True, color=(1.0, 1.0, 1.0), align=1),
        border=draft.TextBorder(alpha=0.0, color=(1.0, 0.0, 0.0), width=0.0),
        background=draft.TextBackground(
            color="#FF0000",
            style=1,
            alpha=1.0,
            round_radius=0.0,
            height=0.14,
            width=0.12,
        ),
        clip_settings=draft.ClipSettings(transform_y=transform_y),
    )
    if segment is None:
        raise RuntimeError(f"Failed to add subtitle: {text}")
    return segment


def main():
    os.makedirs(DRAFTS_ROOT, exist_ok=True)
    project = JyProject(
        PROJECT_NAME,
        width=1080,
        height=1920,
        drafts_root=DRAFTS_ROOT,
        overwrite=True,
    )

    add_video_segment(project, INTRO, "0s", "2.20s", "0s")
    add_video_segment(project, VIDEO, "1.72s", "2.60s", "2.20s")
    add_video_segment(project, VIDEO, "7.25s", "1.20s", "4.80s")

    bgm = project.add_audio_safe(
        MUSIC,
        start_time="0s",
        duration="6.00s",
        track_name="BGM",
    )
    if bgm is None:
        raise RuntimeError("Failed to add BGM")
    bgm.volume = 0.85
    bgm.add_keyframe(0, 0.0)
    bgm.add_keyframe(50_000, 0.85)
    bgm.add_keyframe(5_700_000, 0.85)
    bgm.add_keyframe(5_999_000, 0.0)

    add_subtitle_line(project, "怎么才知道苹果竟然", "Subtitle_Line1", 0.53)
    add_subtitle_line(project, "可以打开相机识别热量", "Subtitle_Line2", 0.42)

    save_result = project.save()
    tracks = []
    for name, track in project.script.tracks.items():
        tracks.append(
            {
                "name": name,
                "type": str(getattr(track, "track_type", getattr(track, "type", "unknown"))),
                "segments": len(track.segments),
            }
        )

    print(
        json.dumps(
            {
                "status": "SUCCESS",
                "draft_path": save_result["draft_path"],
                "resolution": [project.script.width, project.script.height],
                "tracks": tracks,
            },
            ensure_ascii=False,
        )
    )


if __name__ == "__main__":
    main()
