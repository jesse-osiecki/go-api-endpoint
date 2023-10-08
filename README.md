# go-api-endpoint

This is an example of a go api that responds to a single GET at `/` returning the epoch time.
It is containerized and deployed on AWS Lambda.
For information about testing a container locally with a Lambda runtime [see](https://docs.aws.amazon.com/lambda/latest/dg/images-test.html)

## Pre-Deployment

To deploy the go-api-endpoint you'll need to install `docker`, the `awscli` and `terraform`.
Platform specific dependencies are platform specific, but on Arch Linux the can be installed as such:
```
# pacman -S aws-cli-v2 terraform docker docker-buildx
```

## Deployment

Ensure that your default AWS credentials are set to the account which you intend to deploy this in.
Override `vars.tf` if you intend to change the region or the name of the deployment.
To build and deploy this container, simply run `make` which runs `terraform apply`.
This will build the docker image, push it to ECR, and create the subsequent AWS resources.
The output of Terraform will include the `url` of the api. This should return the payload:
```
{"The current epoch time": <EPOCH_TIME>
```
where <EPOCH_TIME> is an integer representing the current epoch time in seconds
