package main

import (
	"context"
	"fmt"
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"time"
)

func main() {
	lambda.Start(getEpoch)
}

func getEpoch(ctx context.Context, event events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	now := time.Now().UTC()
	fmt.Printf("Now it is: %d\n", now.Unix())
	response := events.APIGatewayProxyResponse{
		StatusCode: 200,
		Body:       fmt.Sprintf("{\"The current epoch time\": %d}\n", now.Unix()),
	}
	return response, nil
}
