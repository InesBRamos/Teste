package main

import (
	"context"
	"fmt"
	"os"
	"time"

	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type document struct {
}

func main() {
	mongoClient, err := mongo.Connect(context.TODO(), options.Client().ApplyURI(os.Getenv("MONGODB_CONNSTRING")))
	if err != nil {
		fmt.Printf("Failed to connect to mongodb: %v\n", err)
		panic(err)
	}
	defer mongoClient.Disconnect(context.TODO())

	collection := mongoClient.Database("dockerCoaching").Collection("myDocs")

	ticker := time.NewTicker(10 * time.Second)
	for range ticker.C {
		insertRes, insertErr := collection.InsertOne(
			context.TODO(),
			document{},
		)

		if insertErr != nil {
			fmt.Printf("Failed to insert document with error: %v\n", insertErr)
		} else {
			fmt.Printf("Inserted document with ID: %v\n", insertRes.InsertedID)
		}
	}
}
