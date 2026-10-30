#!/usr/bin/env python3
"""Git clean filter: omit Codex's local project trust entries (Python 3.11+)."""

import re
import sys
import tomllib


def strip_projects(source: str) -> str:
    expected = tomllib.loads(source)
    if "projects" not in expected:
        return source
    del expected["projects"]

    # Codex writes trust entries as [projects."/absolute/path"] tables.
    # Preserve all other text, including comments and formatting.
    project_header = re.compile(r'''^\s*\[\s*(?:projects|"projects"|'projects')\s*[.\]]''')
    output = []
    in_projects = False
    for line in source.splitlines(keepends=True):
        if line.lstrip().startswith("["):
            next_is_projects = bool(project_header.match(line))
            if next_is_projects:
                while output and not output[-1].strip():
                    output.pop()
            elif in_projects and output:
                output.append("\r\n" if line.endswith("\r\n") else "\n")
            in_projects = next_is_projects
        if not in_projects:
            output.append(line)

    result = "".join(output)
    # Fail closed for unsupported TOML layouts, including misleading headers
    # inside multiline strings. Never silently remove other settings.
    if tomllib.loads(result) != expected:
        raise ValueError("cannot remove projects without changing other settings")
    return result


if __name__ == "__main__":
    try:
        result = strip_projects(sys.stdin.buffer.read().decode("utf-8"))
    except (ValueError, UnicodeError) as error:
        sys.exit(f"codex-config filter: {error}")
    sys.stdout.buffer.write(result.encode("utf-8"))
