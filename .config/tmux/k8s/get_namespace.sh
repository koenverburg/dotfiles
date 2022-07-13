get_namespace() {
  if !(hash kubectl) 2>/dev/null
  then
    result="!k"
  else
    context_info=$(kubectl config get-contexts --no-headers)
    namespace=$(echo "$context_info" | grep "*" | awk '{print $5}')

    if [ -z "$namespace" ]
    then
      namespace="N/A"
    fi

    result="ns:#[bold]${namespace}#[nobold]"
  fi
  echo "$result"
}

get_namespace
