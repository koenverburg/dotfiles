package main

import (
	"fmt"
	"os"
	"regexp"

	git "github.com/go-git/go-git/v5"
)

func getBranch() string {
	path, err := os.Getwd()
	if err != nil {
		fmt.Println(err)
	}

  repo, err := git.PlainOpen(path)
	if err != nil {
		fmt.Println(err)
	}

  h, err := repo.Head()
	if err != nil {
		fmt.Println(err)
	}

  return h.Name().Short()
}

func getTicket(branch string) string {
  var re = regexp.MustCompile(`(?m)(\w+-\d+)`)

  matches := re.FindAllString(branch, -1)

  if len(matches) > 0 {
    return matches[0]
  }

  return ""
}

func main() {
  branch := getBranch()
  ticket := getTicket(branch)
  fmt.Println(ticket)
}
