package auth

import (
    "github.com/golang-jwt/jwt/v5"
    "time"
	"os"
)

var jwtKey = []byte(os.Getenv("JWT_KEY"))
var tokens []string

type Claims struct {
    Username string `json:"username"`
    jwt.RegisteredClaims
}

func generateJWT(username string) (string, error) {
    expirationTime := time.Now().Add(5 * time.Minute)

    claims := &Claims{
        Username: username,
        RegisteredClaims: jwt.RegisteredClaims{
            ExpiresAt: jwt.NewNumericDate(expirationTime),
			 IssuedAt: jwt.NewNumericDate(time.Now()),
        },
    }

    token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)

    return token.SignedString(jwtKey)

}