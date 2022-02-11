#!/bin/bash
source $HOME/.profile
#echo "# Checking DEV region NORTH for untagged…"
#echo "… instances"
devnorthinstances=$(aws ec2 describe-instances --output text --query 'Reservations[].Instances[?!not_null(Tags[?Key == `BillTo`].Value)] | [].[InstanceId]' --profile dev-eu-north-1 | wc -l | xargs)
#cho "… volumes"
devnorthvolumes=$(aws ec2 describe-volumes --output text --query 'Volumes[?!not_null(Tags[?Key == `BillTo`].Value)] | [].[VolumeId]' --profile dev-eu-north-1 | wc -l | xargs)
#echo "… snapshots"
devnorthsnapshots=$(aws ec2 describe-snapshots --owner-ids self --output text --query 'Snapshots[?!not_null(Tags[?Key == `BillTo`].Value)] | [].[SnapshotId]' --profile dev-eu-north-1 | wc -l | xargs)
#echo "… network interfaces"
devnorthnetworkinterfaces=$(aws ec2 describe-network-interfaces --output text --query 'NetworkInterfaces[?!not_null(TagSet[?Key == `BillTo`].Value)] | [].[NetworkInterfaceId]' --profile dev-eu-north-1 | wc -l | xargs)

#echo "# Checking DEV region CENTRAL for untagged…"
#echo "… instances"
devcentralistances=$(aws ec2 describe-instances --output text --query 'Reservations[].Instances[?!not_null(Tags[?Key == `BillTo`].Value)] | [].[InstanceId]' --profile dev-eu-central-1 | wc -l | xargs)
#echo "… volumes"
devcentralvolumes=$(aws ec2 describe-volumes --output text --query 'Volumes[?!not_null(Tags[?Key == `BillTo`].Value)] | [].[VolumeId]' --profile dev-eu-central-1 | wc -l | xargs)
#echo "… snapshots"
devcentralsnapshots=$(aws ec2 describe-snapshots --owner-ids self --output text --query 'Snapshots[?!not_null(Tags[?Key == `BillTo`].Value)] | [].[SnapshotId]' --profile dev-eu-central-1 | wc -l | xargs)
#echo "… network interfaces"
devcentralnetworkinterfaces=$(aws ec2 describe-network-interfaces --output text --query 'NetworkInterfaces[?!not_null(TagSet[?Key == `BillTo`].Value)] | [].[NetworkInterfaceId]' --profile dev-eu-central-1 | wc -l | xargs)


#echo "# Checking PROD region NORTH for untagged…"
#echo "… instances"
prodnorthinstances=$(aws ec2 describe-instances --output text --query 'Reservations[].Instances[?!not_null(Tags[?Key == `BillTo`].Value)] | [].[InstanceId]' --profile prod-eu-north-1 | wc -l | xargs)
#echo "… volumes"
prodnorthvolumes=$(aws ec2 describe-volumes --output text --query 'Volumes[?!not_null(Tags[?Key == `BillTo`].Value)] | [].[VolumeId]' --profile prod-eu-north-1 | wc -l | xargs)
#echo "… snapshots"
prodnorthsnapshots=$(aws ec2 describe-snapshots --owner-ids self --output text --query 'Snapshots[?!not_null(Tags[?Key == `BillTo`].Value)] | [].[SnapshotId]' --profile prod-eu-north-1 | wc -l | xargs)
#echo "… network interfaces"
prodnorthnetworkinterfaces=$(aws ec2 describe-network-interfaces --output text --query 'NetworkInterfaces[?!not_null(TagSet[?Key == `BillTo`].Value)] | [].[NetworkInterfaceId]' --profile prod-eu-north-1 | wc -l | xargs)

#echo "# Checking PROD region CENTRAL for untagged…"
#echo "… instances"
prodcentralinstances=$(aws ec2 describe-instances --output text --query 'Reservations[].Instances[?!not_null(Tags[?Key == `BillTo`].Value)] | [].[InstanceId]' --profile prod-eu-central-1 | wc -l | xargs)
#echo "… volumes"
prodcentralvolumes=$(aws ec2 describe-volumes --output text --query 'Volumes[?!not_null(Tags[?Key == `BillTo`].Value)] | [].[VolumeId]' --profile prod-eu-central-1 | wc -l | xargs)
#echo "… snapshots"
prodcentralsnapshots=$(aws ec2 describe-snapshots --owner-ids self --output text --query 'Snapshots[?!not_null(Tags[?Key == `BillTo`].Value)] | [].[SnapshotId]' --profile prod-eu-central-1 | wc -l | xargs)
#echo "… network interfaces"
prodcentralnetworkinterfaces=$(aws ec2 describe-network-interfaces --output text --query 'NetworkInterfaces[?!not_null(TagSet[?Key == `BillTo`].Value)] | [].[NetworkInterfaceId]' --profile prod-eu-central-1 | wc -l | xargs)





echo -e "Subject: There are untagged AWS resources\n\n \
---\n \
${devnorthinstances} untagged instances in dev/north\n \
${devnorthvolumes} untagged volumes in dev/north\n \
${devnorthsnapshots} untagged snapshots in dev/north\n \
${devnorthnetworkinterfaces} untagged network interfaces in dev/north\n \
${devcentralistances} untagged instances in dev/central\n \
${devcentralvolumes} untagged volumes in dev/central\n \
${devcentralsnapshots} untagged snapshots in dev/central\n \
${devcentralnetworkinterfaces} untagged network interfaces in dev/central\n \
${prodnorthinstances} untagged instances in prod/north\n \
${prodnorthvolumes} untagged volumes in prod/north\n \
${prodnorthsnapshots} untagged snapshots in prod/north\n \
${prodnorthnetworkinterfaces} untagged network interfaces in prod/north\n \
${prodcentralinstances} untagged instances in prod/central\n \
${prodcentralvolumes} untagged volumes in prod/central\n \
${prodcentralsnapshots} untagged snapshots in prod/central\n \
${prodcentralnetworkinterfaces} untagged network interfaces in prod/central" > $HOME/latest.txt

if [ $devnorthinstances -eq "0" ] && [ $devnorthvolumes -eq "0" ] && [ $devnorthsnapshots -eq "0" ] && [ $devnorthnetworkinterfaces -eq "0" ] && [ $devcentralistances -eq "0" ] && [ $devcentralvolumes -eq "0" ] && [ $devcentralsnapshots -eq "0" ] && [ $devcentralnetworkinterfaces -eq "0" ] && [ $prodnorthinstances -eq "0" ] && [ $prodnorthvolumes -eq "0" ] && [ $prodnorthsnapshots -eq "0" ] && [ $prodnorthnetworkinterfaces -eq "0" ] && [ $prodcentralinstances -eq "0" ] && [ $prodcentralvolumes -eq "0" ] && [ $prodcentralsnapshots -eq "0" ] && [ $prodcentralnetworkinterfaces -eq "0" ]
then
      echo "all good"
else
	sendmail.py -v "Group.Hosting@nobia.com" < $HOME/latest.txt
	sendmail.py -v "Group.Networking@nobia.com" < $HOME/latest.txt
fi
