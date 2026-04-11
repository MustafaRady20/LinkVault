package main

func main() {
	app := &application{
		config: Config{
			Port: ":8080",
		},
	}

	mux := app.mount()
	app.run(mux)
}
