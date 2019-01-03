package main

import (
	"net/http"

	"github.com/labstack/echo"
	"github.com/labstack/echo/middleware"
)

func main() {

	e := echo.New()

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/", hello)

	e.Logger.Fatal(e.Start(":1323"))
}

func hello(context echo.Context) error {
	return context.String(http.StatusOK, "Hello..!")
}
