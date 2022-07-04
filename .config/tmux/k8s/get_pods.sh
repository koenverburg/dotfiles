get_running_pods() {
  pods=$(kubectl get pods --no-headers --field-selector=status.phase=Running --request-timeout 1s | wc -l | awk '{ print $1 }')
  echo "p:#[bold]$pods#[nobold]"
}

get_running_pods
