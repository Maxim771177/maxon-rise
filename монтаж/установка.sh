#!/bin/bash
# Ставит инструменты монтажа. Безопасно запускать повторно. Вызывается хуком SessionStart.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

ROOT="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"
cd "$ROOT/монтаж"

# системные библиотеки для MediaPipe (libEGL) — только если их нет
if ! ldconfig -p | grep -q 'libEGL.so.1'; then
  apt-get update -qq && apt-get install -y -qq libegl1 libgles2 libgl1
fi

# Remotion
(cd remotion && npm install --no-audit --no-fund --loglevel=error)

# Python: распознавание речи и трекинг лица.
# av<17: faster-whisper 1.2.x не работает с av 17+
pip3 install -q --root-user-action=ignore faster-whisper opencv-python-headless mediapipe "av>=14,<17"

# модель детектора лица для MediaPipe (в git не кладём)
if [ ! -s модели/face_detector.tflite ]; then
  mkdir -p модели
  curl -sSfL -o модели/face_detector.tflite \
    https://storage.googleapis.com/mediapipe-models/face_detector/blaze_face_short_range/float16/1/blaze_face_short_range.tflite
fi

echo "монтаж: инструменты готовы"
