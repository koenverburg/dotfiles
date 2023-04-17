package main

import (
	"fmt"
	"os"
	"path/filepath"
	"regexp"

	"github.com/go-git/go-git/v5"
	"github.com/pkg/errors"
)

func findTopLevelGitDir(workingDir string) (string, error) {
	dir, err := filepath.Abs(workingDir)
	if err != nil {
		return "", errors.Wrap(err, "invalid working dir")
	}

	for {
		if _, err := os.Stat(filepath.Join(dir, ".git")); err == nil {
			return dir, nil
		}

		parent := filepath.Dir(dir)
		if parent == dir {
			return "", errors.New("no git repository found")
		}
		dir = parent
	}
}

func getBranch() string {
	path, err := os.Getwd()
	if err != nil {
		fmt.Println(err)
	}

  topLevel, err := findTopLevelGitDir(path)
	if err != nil {
		fmt.Println(err)
	}

	repo, err := git.PlainOpen(topLevel)
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
	re := regexp.MustCompile(`(?m)(\w+-\d+)`)

	matches := re.FindAllString(branch, -1)

	if len(matches) > 0 {
		return matches[0]
	}

	return ""
}

func main() {
	branch := getBranch()

  fmt.Println(branch)

	// ticket := getTicket(branch)

	// fmt.Println(ticket)
}
