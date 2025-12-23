$env.__GO_INFO_CACHE   = { pwd: ""  value: "" }

def --env update_go_info_cache [] {
  let cwd = (pwd)
  if $env.__GO_INFO_CACHE.pwd == $cwd { return }

  let go_ver = (
    try { ^go version | str trim } | default ""
  )

  $env.__GO_INFO_CACHE = {
    pwd: $cwd
    value: $go_ver
  }
}

$env.config.hooks.env_change.PWD = (
  $env.config.hooks.env_change.PWD? | append [
    {
      condition: {|| ['go.mod' 'go.work'] | any {|el| $el | path exists}}
      code: {|| update_go_info_cache }
    }
  ]
)

def go_version   [] { echo $env.__GO_INFO_CACHE.value   }
