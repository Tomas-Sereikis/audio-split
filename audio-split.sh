#!/usr/bin/env bash

if [ -z $(command -v ffmpeg) ]; then
  echo "Error: ffmpeg is not installed."
  exit 1
fi

while [[ $# -gt 0 ]]; do
  key="$1"
  case "$key" in
    -f|--file)
      shift
      FILE="$1";;
    -d|--durtion)
      shift
      DURATION="$1";;
    *)
      echo "Unknown option '$key'"
      exit 1;;
  esac
  shift
done

if [ ! -f ${FILE} ]; then
  echo "File -f or --file is not passed."
  exit 1
fi

if [ -z ${DURATION} ]; then
  echo "Duration -d or --duration not passed."
  exit 1
fi

PATTERN="\.mp3"
REPLACE="_%03d.mp3"
OUTPUTFILE=${FILE//$PATTERN/$REPLACE}

ffmpeg -i "${FILE}" -f segment -segment_time "${DURATION}" -c copy "${OUTPUTFILE}"
