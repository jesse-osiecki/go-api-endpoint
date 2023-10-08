package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
	"time"
)

func main() {
	var hostport string

	flag.StringVar(&hostport, "h", ":8080", "Specify <host>:<port> leaving the host blank for all")
	flag.Parse()

	http.HandleFunc("/", getEpoch)
	log.Fatal(http.ListenAndServe(hostport, nil))
}

func getEpoch(w http.ResponseWriter, r *http.Request) {
	now := time.Now().UTC()
	fmt.Printf("Now it is: %d\n", now.Unix())
	fmt.Fprintf(w, "{\"The current epoch time\": %d}\n", now.Unix())
}
