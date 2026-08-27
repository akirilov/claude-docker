# Make output directory to avoid docker creating it as root
mkdir -p ./out

# Copy default settings
if [ ! -f settings.json ]; then
  cp settings.json.example settings.json
fi

# Remind the user to set secret
if [ ! -f secrets.env ]; then
  echo -e "\e[31mDon't forget to set your secrets!\e[0m"
  cp secrets.env.example secrets.env
fi

docker build \
  --build-arg USER_ID=$(id -u) \
  --build-arg GROUP_ID=$(id -g) \
  -t claude-docker .
