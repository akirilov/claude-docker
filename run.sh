usage() {
  echo "Usage: $0 <target>"
  echo "Arguments:"
  echo "  -i   Run in interactive mode"
  echo "  -v   Run verbose"
  exit 1
}

INTERACTIVE=false
VERBOSE=false

while getopts ":iv" opt; do
  case ${opt} in
    i)
      INTERACTIVE=true
      ;;
    v)
      VERBOSE=true
      ;;
    *)
      usage
      ;;
  esac
done

shift $((OPTIND -1))

#!/bin/bash
if [ -z "$1" ]; then
  echo "Error: No argument provided."
  usage
fi

IMAGE_NAME="claude-docker"
OUT_FOLDER_CONTAINER="/home/ubuntu/out"
IN_FOLDER_CONTAINER="/home/ubuntu/in"
CLAUDE="/home/ubuntu/.local/bin/claude"
CLAUDE_SETTINGS="/home/ubuntu/.claude/settings.json"

INSTRUCTION_FILE="${IN_FOLDER_CONTAINER%/}/instructions.md"
TARGET="$1"
INPUT="./in/$TARGET"
OUTPUT="./out/$TARGET-$(uuidgen)"
SETTINGS="./settings.json"

OPTS_INTERACTIVE=""
OPTS_VERBOSE=""
if ! $INTERACTIVE; then
  OPTS_INTERACTIVE="-p \
                    < $INSTRUCTION_FILE \
                    &> $OUT_FOLDER_CONTAINER/claude.log"
fi
if $VERBOSE; then
  OPTS_VERBOSE="--verbose --output-format stream-json"
fi

mkdir $OUTPUT

docker run \
  --rm \
  -it \
  -v $OUTPUT:$OUT_FOLDER_CONTAINER \
  -v $INPUT:$IN_FOLDER_CONTAINER:ro \
  -v $SETTINGS:$CLAUDE_SETTINGS:ro \
  --env-file ./secrets.env \
  $IMAGE_NAME \
  bash -c "$CLAUDE \
    $OPTS_VERBOSE \
    $OPTS_INTERACTIVE"
