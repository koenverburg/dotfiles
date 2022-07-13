#!/bin/bash

get_cluster() {
  if !(hash kubectl) 2>/dev/null
  then
    result="!k"
  else
    context_info=$(kubectl config get-contexts --no-headers)
    cluster=$(echo "$context_info" | grep "*" | awk '{print $3}')

    if [ -z "$cluster" ]
    then
      cluster="N/A"
    fi

    result="clu:#[bold]${cluster}#[nobold]"
  fi
  echo "$result"
}

get_cluster
