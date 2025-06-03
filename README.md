# jenkins-demo


docker login -u dockerswatik
Doker token/password
dckr_pat_ySwJzADH48Dz9cLdzKpH2CiZuHA

# Step 1: Create plugin directory if it doesn't exist
mkdir -p ~/.docker/cli-plugins

# Step 2: Download the latest buildx binary
curl -SL https://github.com/docker/buildx/releases/latest/download/buildx-linux-amd64 -o ~/.docker/cli-plugins/docker-buildx

# Step 3: Make it executable
chmod +x ~/.docker/cli-plugins/docker-buildx

# Step 4: Verify buildx is installed
docker buildx version

