get_context() {
  if !(hash kubectl) 2>/dev/null
  then
    result="kubectl not found!"
  else
    context=$(kubectl config current-context)

    if [ -z "$context" ]
    then
      context="N/A"
    fi

    result="ctx:#[bold]${context}#[nobold]"
  fi
  echo "$result"
}

get_context
