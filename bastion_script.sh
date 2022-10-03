#setting up bastion
1. create ssh-user in bastion-instance for ssh-tunnel
2. assign ssh user to dbt-cloud
3. add ssh-public key from dbt-cloud to authorized_key.sh

export BASTION_USER=ec2-user
export BASTION_HOST=ec2-18-143-137-77.ap-southeast-1.compute.amazonaws.com
export REDSHIFT_HOST=ldi-redshift-qa.chkfbg3jrkto.ap-southeast-1.redshift.amazonaws.com

# ssh -i /path/my-key-pair.pem username@instance-id -L localport:targethost:destport
#ssh -i "~/Git/bastion/ec2-bastion-keypair.pem" ec2-user@ec2-18-143-137-77.ap-southeast-1.compute.amazonaws.com -p 22 -N -C -L 5439:${REDSHIFT_HOST}:5439

INSTANCE_ID=$(aws ec2 describe-instances --filter "Name=tag:Name,Values=bastion-redshift" --query "Reservations[].Instances[?State.Name == 'running'].InstanceId[]" --output text)
aws ssm start-session --target $INSTANCE_ID --document-name AWS-StartPortForwardingSession --parameters '{"portNumber":["5439"],"localPortNumber":["5439"]}'

