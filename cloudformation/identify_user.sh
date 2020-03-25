#!/bin/zsh

# If overridden with an environment variable, use that.
if [[ -v $TOR_METRICS_SSH_KEY ]]; then
	echo $TOR_METRICS_SSH_KEY
	exit 0
done

# Otherwise, make a guess based on the username.
#
# The available key pairs can be found with:
#
#   aws ec2 describe-key-pairs | jq -r '.KeyPairs[].KeyName' | \
#   grep `aws iam get-user | jq -r .User.UserName`
declare -A keypairs
keypairs[acute]="acute yubikey 4"
keypairs[irl]="irl yubikey 4"
keypairs[karsten]="karsten's key"

cur_user=$(aws iam get-user | jq -r .User.UserName)

for key val in ${(kv)keypairs}; do
    if [ $key = $cur_user ]; then
        echo $val;
        break
    fi
done

