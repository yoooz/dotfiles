#!/usr/bin/env python3
"""Antigravity CLI の JSON をモデル・作業場所・context・利用枠の表示に変換する。"""

import json
import math
import subprocess
import sys
from datetime import datetime
from pathlib import Path


def color(text, code):
    return f"\033[{code}m{text}\033[0m"


def usage_color(used_percentage):
    if used_percentage >= 90:
        return 31
    if used_percentage >= 70:
        return 33
    return 32


def git_branch(directory):
    if not directory:
        return ""
    try:
        result = subprocess.run(
            ["git", "-C", directory, "rev-parse", "--abbrev-ref", "HEAD"],
            capture_output=True, text=True, timeout=0.5, check=True,
        )
        return result.stdout.strip()
    except (OSError, subprocess.SubprocessError):
        return ""


def context_segment(context):
    percentage = context.get("used_percentage")
    if percentage is None or not context.get("context_window_size"):
        return color("ctx --", 2)
    percentage = max(0, min(100, percentage))
    filled = math.ceil(percentage / 10)
    bar = "▰" * filled + "▱" * (10 - filled)
    return color(f"ctx {bar} {percentage:.0f}%", usage_color(percentage))


def quota_segment(name, quota, now):
    if quota.get("disabled"):
        return ""

    reset = None
    if quota.get("reset_time"):
        try:
            reset = datetime.fromisoformat(quota["reset_time"].replace("Z", "+00:00"))
            reset = reset.astimezone()
        except ValueError:
            pass
    # 更新前の古い残量を表示しない。次の payload で新しい枠が届くまで省略する。
    if reset is not None and reset <= now:
        return ""

    fraction = quota.get("remaining_fraction")
    amount = quota.get("remaining_amount")
    if fraction is not None:
        remaining = max(0, min(100, fraction * 100))
        label = f"{name} 残{remaining:.0f}%"
        code = usage_color(100 - remaining)
    elif amount is not None:
        label = f"{name} 残{amount:g}"
        code = 2
    else:
        return ""

    if reset is not None:
        fmt = "%H:%M" if reset.date() == now.date() else "%m/%d %H:%M"
        label += "→" + reset.strftime(fmt)
    return color(label, code)


def render_statusline(data):
    model = data.get("model") or {}
    directory = (data.get("workspace") or {}).get("current_dir") or data.get("cwd", "")
    heading = [color(model.get("display_name") or model.get("id") or "Antigravity", 36)]
    if directory:
        heading.append(color(Path(directory).name or directory, 2))
    branch = git_branch(directory)
    if branch:
        heading.append(color(f"⎇ {branch}", 2))

    segments = ["  ".join(heading), context_segment(data.get("context_window") or {})]
    now = datetime.now().astimezone()
    for name, quota in sorted((data.get("quota") or {}).items()):
        segment = quota_segment(name, quota, now)
        if segment:
            segments.append(segment)
    return "  │ ".join(segments)


if __name__ == "__main__":
    print(render_statusline(json.load(sys.stdin)))
