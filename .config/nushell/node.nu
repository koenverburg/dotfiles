$env.__NODE_INFO_CACHE = {
  pwd: ""
  value: ""
}

def --env update_node_info_cache [] {
  let cwd = (pwd)

  if $env.__NODE_INFO_CACHE.pwd == $cwd {
    return
  }

  let node_ver = (
    try { ^node -v | str trim }
    | default ""
  )

  $env.__NODE_INFO_CACHE = {
    pwd: $cwd
    value: $node_ver
  }
}

def --env load_fnm [] {
  if not (which fnm | is-empty) {
    ^fnm env --json | from json | load-env

    $env.PATH = $env.PATH | prepend (
      $env.FNM_MULTISHELL_PATH | path join (
        if $nu.os-info.name == 'windows' { '' } else { 'bin' }
      )
    )

    ^fnm use --install-if-missing --log-level quiet
  }
}

$env.config.hooks.env_change.PWD = (
  $env.config.hooks.env_change.PWD? | append {
    condition: {|| ['.nvmrc' '.node-version' 'package.json'] | any {|el| $el | path exists}}
    code: {|| load_fnm }
  }
)

$env.config.hooks.env_change.PWD = (
  $env.config.hooks.env_change.PWD? | append {
    condition: {|| ['.nvmrc' '.node-version' 'package.json'] | any {|el| $el | path exists}}
    code: {|| update_node_info_cache }
  }
)

