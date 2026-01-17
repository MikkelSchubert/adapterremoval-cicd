#!/usr/bin/env python3
# pyright: strict
from __future__ import annotations

import argparse
import functools
import sys
import urllib.parse
from pathlib import Path


def parse_args(argv: list[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        formatter_class=functools.partial(
            argparse.ArgumentDefaultsHelpFormatter,
            width=79,
        ),
        allow_abbrev=False,
    )

    parser.add_argument("files", nargs="+", type=Path)
    parser.add_argument("--escape", action="store_true", default=False)

    return parser.parse_args(argv)


def main(argv: list[str]) -> int:
    args = parse_args(argv)
    lines: list[str] = []
    buffer = sys.stdout.buffer
    for filename in args.files:
        with open(filename) as handle:
            in_latest = False
            for line in handle:
                if line.startswith("## "):
                    if in_latest:
                        break
                    else:
                        in_latest = True

                lines.append(line.rstrip())
    lines.append("")  # trailing newline
    text = "\n".join(lines)
    if args.escape:
        text = urllib.parse.quote(text)

    buffer.write(text.encode("utf-8"))

    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
