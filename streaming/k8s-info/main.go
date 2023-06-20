package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os/exec"
	"regexp"
	"strings"

	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	ctrl "sigs.k8s.io/controller-runtime"
)

func checkForErr(err error) {
	if err != nil {
		panic(err)
	}
}

func prettyString(in interface{}) {
	b, err := json.MarshalIndent(in, "", "  ")
	if err != nil {
		fmt.Println(err)
	}
	fmt.Print(string(b))
}

func runCommand(cmdStr string) string {
	commandList := strings.Split(cmdStr, " ")

	head := commandList[0]
	tail := commandList[1:]

	executable, _ := exec.LookPath(head)
	cmdGoVer := &exec.Cmd{
		Path:   executable,
		Args:   append([]string{executable}, tail...),
		// Stdout: os.Stdout,
		// Stderr: os.Stderr,
	}

  out, err := cmdGoVer.Output()
  checkForErr(err)

  return string(out)
}

func getClusterAndNamespace() (string, string) {
  output := runCommand("kubectl config get-contexts --no-headers")
  var re = regexp.MustCompile(`(?m)(\*.*)`)

  var context = re.FindAllString(output,-1)[0]
  var words = strings.Fields(context)

  return words[2], words[len(words)-1]
}

func getContext(clientset *kubernetes.Clientset, ctx context.Context) (string, error) {
	list, err := clientset.CoreV1().Nodes().List(ctx, metav1.ListOptions{})
	if err != nil {
		return "", err
	}

	context := list.Items[0]

	return context.GetName(), nil
}

func getPodCount(clientset *kubernetes.Clientset, ctx context.Context, namespace string) (int, error) {
	list, err := clientset.CoreV1().Pods(namespace).List(ctx, metav1.ListOptions{})
	if err != nil {
		return 0, err
	}

	return len(list.Items), err
}

func format(name string, value string) string {
  lhs := fmt.Sprintf("#[fg=#979BAC]%s", name )

  rhs := fmt.Sprintf("#[fg=#c6c8d1]#[bold]%s#[nobold]", value)

  return fmt.Sprintf("%s:%s", lhs, rhs)
}

func main() {
	ctx := context.Background()
	config := ctrl.GetConfigOrDie()
	clientset := kubernetes.NewForConfigOrDie(config)

  cluster, namespace := getClusterAndNamespace()

	pods, err := getPodCount(clientset, ctx, namespace)
	checkForErr(err)

	// context, err := getContext(clientset, ctx)
	// checkForErr(err)

  list := []string{
    format("clu", cluster),
    // format("ctx", context),
    format("ns", namespace),
    format("p", fmt.Sprintf("%v", pods)),
  }

  fmt.Println(strings.Join(list, " "))
}
