package main

import (
	"os"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

var logger *zap.Logger

func healthzHandler(c *gin.Context) {
	clientIP := c.ClientIP()
	logger.Info("Healthz check", zap.String("method", c.Request.Method), zap.String("path", c.Request.URL.Path), zap.String("client_ip", clientIP))
	c.String(200, "OK")
}

func setGinMode() string {
	ginMode := "debug"
	ginModeVal, ginModePresent := os.LookupEnv("GIN_MODE")
	if ginModeVal == "" || !ginModePresent {
		os.Setenv("GIN_MODE", ginMode)
		ginModeVal = ginMode
	}

	return ginModeVal
}

func main() {
	var err error
	logger, err = zap.NewProduction()
	if err != nil {
		panic(err)
	}
	defer logger.Sync()

	gin.SetMode(setGinMode())

	r := gin.New()
	r.Use(gin.Recovery())

	r.SetTrustedProxies([]string{})

	r.GET("/healthz", healthzHandler)

	r.NoRoute(func(c *gin.Context) {
		clientIP := c.ClientIP()
		logger.Warn("Invalid request", zap.String("method", c.Request.Method), zap.String("path", c.Request.URL.Path), zap.String("client_ip", clientIP))
		c.String(404, "Not Found")
	})

	logger.Info("Starting server", zap.String("port", ":8080"))
	if err := r.Run(":8080"); err != nil {
		logger.Fatal("Error starting server: ", zap.Error(err))
	}
}
