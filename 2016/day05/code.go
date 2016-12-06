package main

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

func ReplaceAtIndex(str string, sub string, index int64) string {
	return str[:index] + sub + str[index+1:]
}

func ParseInt(str string) int64 {
	i, err := strconv.ParseInt(str, 10, 32)
	if err != nil {
		return -1
	}
	return i
}

func SolvePart1() {
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

	fmt.Println("Part 1 Password: " + password)
}

func SolvePart2() {
	PUZZLE_INPUT := "reyedfim"
	index := 0
	password := "zzzzzzzz"

	for strings.Contains(password, "z") {
		hash := GetMD5Hash(PUZZLE_INPUT + strconv.Itoa(index))

		if strings.HasPrefix(hash, "00000") {
			position, char := ParseInt(hash[5:6]), hash[6:7]

			if position > -1 && position < 8 {
				if password[position:position+1] == "z" {
					password = ReplaceAtIndex(password, char, position)
				}
			}
		}

		index += 1
	}

	fmt.Println("Part 2 Password: " + password)
}

func main() {
	SolvePart1()
	SolvePart2()
}
