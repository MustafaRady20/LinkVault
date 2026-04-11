package main

import (
	"log"
)

func main() {
	app := &application{
		config: Config{
			Port: ":8080",
		},
	}

	mux := app.mount()
	err := app.run(mux)
	if err != nil {
		log.Fatal(err)
	}
}
