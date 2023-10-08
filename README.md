# go-api-endpoint

This is an example of a go api that responds to a single GET at `/` returning the epoch time.
It is containerized and deployed on AWS Lambda.
For information about testing a container locally with a Lambda runtime see [here](https://docs.aws.amazon.com/lambda/latest/dg/images-test.html).

## Pre-Deployment

To deploy the go-api-endpoint you'll need to install `docker`, the `awscli` and `terraform`.
Platform specific dependencies are platform specific, but on Arch Linux the can be installed as such:
```
# pacman -S aws-cli-v2 terraform docker docker-buildx
```

## Deployment

Ensure that your default AWS credentials are set to the account which you intend to deploy this in.
Override `vars.tf` if you intend to change the region or the name of the deployment.
To build and deploy this container, simply run `make` (which runs `terraform apply`).
This will build the docker image, push it to ECR, and create the subsequent AWS resources.
The output of Terraform will include the `url` of the api. This should return the payload:
```
{"The current epoch time": <EPOCH_TIME>}
```
where <EPOCH_TIME> is an integer representing the current epoch time in seconds


## Undeployment

Run `make destroy` which runs `terraform destroy` for you

## Github actions

Github actions exist in this repo to lint and provide an alternative repository for pulling the container.
For my user this would be `docker pull ghcr.io/jesse-osiecki/go-api-endpoint:main` where `main` is the branch.


## Arch

This deployment is minimal and should remain in AWS free tier with reasonable use cases.

```mermaid
graph TD;
    User-->API Gateway;
    API Gateway-->Lambda;
```
