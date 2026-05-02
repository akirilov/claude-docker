#!/bin/bash
if [ -z "$1" ]; then
    echo "Error: No argument provided."
    echo "Usage: $0 <target>"
    exit 1
fi

# CHANGE THIS
EFFORT="xhigh"
MODEL="opus"

IMAGE_NAME="claude-docker"
OUT_FOLDER_CONTAINER="/home/ubuntu/out"
IN_FOLDER_CONTAINER="/home/ubuntu/in"
CLAUDE="/home/ubuntu/.local/bin/claude"
INSTRUCTION_FILE="${IN_FOLDER_CONTAINER%/}/instructions.md"
TARGET="$1"
INPUT="./in/$TARGET"
OUTPUT="./out/$TARGET-$(uuidgen)"

mkdir $OUTPUT

docker run \
  --rm \
  -it \
  -v $OUTPUT:$OUT_FOLDER_CONTAINER \
  -v $INPUT:$IN_FOLDER_CONTAINER:ro \
  --env-file ./secrets.env \
  $IMAGE_NAME \
  bash -c "$CLAUDE \
    --dangerously-skip-permissions \
    --effort $EFFORT \
    --model $MODEL \
    -p --verbose --output-format stream-json \
    < $INSTRUCTION_FILE \
    &> $OUT_FOLDER_CONTAINER/claude.log"
