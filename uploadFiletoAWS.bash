#!/bin/bash

# A script that will upload a specified file to an aws s3 bucket

setup() { 
    # Install aws cli
    read -p "Enter your access key ID: " aws_access_key_id
    read -p "Enter your secret access key: " aws_secret_access_key
    read -p "Enter your default region: " aws_default_region
    read -p "Enter your output format: " aws_output_format

    aws configure set aws_access_key_id "$aws_access_key_id"
    aws configure set aws_secret_access_key "$aws_secret_access_key"
    aws configure set default.region "$aws_default_region"
    aws configure set default.output "$aws_output_format"

    #lists s3 buckets then prompts user to select one
    echo "Listing all the buckets in the s3 account"
    aws s3 ls 
    read -p "Enter the name of the bucket you'd like to save to: " bucket_name

    echo "You selected bucket: $bucket_name"

}

upload() {
    #uploads a file to s3 bucket
    read -p "Enter the name of your file: " file_name
    aws s3 cp $file_name s3://$bucket_name/

    #checks whether file was uploaded successfully
    if [ $? -eq 0 ]; then
        echo "File uploaded successfully!"
    else
        echo "File upload failed."
    fi
}


setup
upload