package main

// import s "strings"
import (
	"crypto/md5"
	"encoding/hex"
	"fmt"
	"strconv"
	"strings"
)

func GetMD5Hash(text string) string {
	hasher := md5.New()
	hasher.Write([]byte(text))
	return hex.EncodeToString(hasher.Sum(nil))
}

func main() {
	PUZZLE_INPUT := "reyedfim"
	index := 0
	password := ""

	for len(password) < 8 {
		hash := GetMD5Hash(PUZZLE_INPUT + strconv.Itoa(index))

		if strings.HasPrefix(hash, "00000") {
			password += hash[5:6]
		}

		index += 1
	}

	fmt.Println("Final Password: " + password)
}
