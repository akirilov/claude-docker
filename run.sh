IMAGE_NAME="claude-docker"
OUTPUT_FOLDER="/home/ubuntu/out"
INPUT_FOLDER="/home/ubuntu/in"
CLAUDE="/home/ubuntu/.local/bin/claude"
INSTRUCTION_FILE="instructions.md"


docker run \
  --rm \
  -it \
  -v ./out:$OUTPUT_FOLDER \
  -v ./in:$INPUT_FOLDER:ro \
  --env-file ./secrets.env \
  $IMAGE_NAME \
  bash -c "$CLAUDE --dangerously-skip-permissions"
#  bash -c "$CLAUDE --dangerously-skip-permissions -p --verbose < $UTILS_FOLDER/$INSTRUCTION_FILE &> $OUTPUT_FOLDER/claude.log"
