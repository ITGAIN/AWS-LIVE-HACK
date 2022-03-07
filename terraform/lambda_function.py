import boto3
import subprocess
import urllib
import tarfile

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    
    for record in event['Records']:
        try:
            bucket_name = record['s3']['bucket']['name']
            object_key = record['s3']['object']['key']
            object_key = urllib.parse.unquote_plus(object_key)

            if object_key[-4:] != '.tar':
                print(f'Not a tar, abort')
                continue
            
            response = s3.get_object(
                Bucket=bucket_name,
                Key=object_key
            )
            
            tar_path = f'/tmp/{object_key.split("/")[-1]}'
            with open(tar_path, 'wb+') as file:
                file.write(response['Body'].read())

            tar_content = subprocess.check_output(
                f'tar -tf {tar_path}',
                shell=True,
                stderr=subprocess.STDOUT
            ).decode().rstrip()

            if "txt" in tar_content:
                s3.put_object_tagging(
                Bucket=bucket_name,
                Key=object_key,
                Tagging={
                    'TagSet': [
                        {
                            'Key': 'Type of Files',
                            'Value': "txt"
                        }
                    ]
                }
            )

        except Exception as e:
            print(f'Error on object {object_key} in bucket {bucket_name}:{e}')
    return
