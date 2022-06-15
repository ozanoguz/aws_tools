#!/bin/bash
export AWS_REGION="eu-west-1"
aws eks delete-nodegroup --cluster-name EKSdemocluster-$1 --nodegroup-name EKSdemocluster-ng-$1 --output text
echo "Waiting for 5min to delete NodeGroup"
sleep 300
aws eks delete-cluster --name EKSdemocluster-$1 --output text


aws iam detach-role-policy --policy-arn  arn:aws:iam::aws:policy/AmazonEKSClusterPolicy --role-name EKSdemoClusterRole-$1 --output text
aws iam delete-role --role-name EKSdemoClusterRole-$1 --output text

aws iam detach-role-policy --policy-arn  arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy --role-name EKSdemoNodeRole-$1 --output text
aws iam detach-role-policy --policy-arn  arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly --role-name EKSdemoNodeRole-$1 --output text
aws iam detach-role-policy --policy-arn  arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy --role-name EKSdemoNodeRole-$1 --output text
aws iam delete-role --role-name EKSdemoNodeRole-$1 --output text

echo "Delete the VPC ..."

