package main

import (
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"net/http"
	"os"
)

func main() {
	e := echo.New()

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/", hello)
	e.GET("/health", func(context echo.Context) error {
		return context.JSON(http.StatusOK, struct {
			Status string
		}{Status: "OK"})
	})

	httpPort := os.Getenv("HTTP_PORT")
	if httpPort == "" {
		httpPort = "1323"
	}

	e.Logger.Fatal(e.Start(":" + httpPort))
}

func hello(context echo.Context) error {
	return context.String(http.StatusOK, "Hello!!")
}
