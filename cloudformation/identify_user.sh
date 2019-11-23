#!/bin/bash
#aws ec2 describe-key-pairs | jq -r '.KeyPairs[].KeyName' | grep `aws iam get-user | jq -r .User.UserName`
declare -A keypairs
keypairs["acute"]="acute yubikey 4"
keypairs["irl"]="irl yubikey 4"
keypairs["karsten"]="karsten's key"

cur_user=$(aws iam get-user | jq -r .User.UserName)

for key in ${!keypairs[@]}; do
    if [ $key == $cur_user ]; then
        echo ${keypairs[${key}]};
        break
    fi
done

