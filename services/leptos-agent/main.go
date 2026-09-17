package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	commonstructs "github.com/alwinsden/kmp-monorepo/services/commonStructs"
)

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc(fmt.Sprintf("%s /health", commonstructs.ApiTypes.GET), func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(HealthResponse{Status: "ok"})
	})

	addr := ":8080"
	log.Printf("leptos-agent service listening on %s", addr)
	if err := http.ListenAndServe(addr, mux); err != nil {
		log.Fatal(err)
	}
}
