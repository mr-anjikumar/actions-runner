#### with the pat

mkdir actions-runner && cd actions-runner

curl -o actions-runner-linux-x64-2.336.0.tar.gz -L \
  https://github.com/actions/runner/releases/download/v2.336.0/actions-runner-linux-x64-2.336.0.tar.gz

echo "04cf0be1aff4c3ec3554466c39124ca250e3effd8873bb7e8d68535aa9505d5d  actions-runner-linux-x64-2.336.0.tar.gz" | sha256sum -c

tar xzf ./actions-runner-linux-x64-2.336.0.tar.gz

export GH_PAT=""

REG_TOKEN=$(curl -sf -X POST \
  -H "Authorization: Bearer $GH_PAT" \
  -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/mr-anjikumar/actions-runner/actions/runners/registration-token" \
  | jq -r .token)

./config.sh --unattended \
  --url https://github.com/mr-anjikumar/actions-runner \
  --token "$REG_TOKEN" \
  --labels self-hosted,linux,x64


sudo ./svc.sh install ec2-user
sudo ./svc.sh start
sudo ./svc.sh status

unset GH_PAT


## to check the detilas 
cat ~/actions-runner/.runner