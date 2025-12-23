$env.__LUA_INFO_CACHE  = { pwd: ""  value: "" }

def --env update_lua_info_cache [] {
  let cwd = (pwd)
  if $env.__LUA_INFO_CACHE.pwd == $cwd { return }

  let lua_ver = (
    try { ^lua -v | str trim | str substring 0..8 } | default ""
  )

  $env.__LUA_INFO_CACHE = {
    pwd: $cwd
    value: $lua_ver
  }
}

$env.config.hooks.env_change.PWD = (
  $env.config.hooks.env_change.PWD? | append [
    {
      condition: {|| ['.luarc.json' '.luacheckrc'] | any {|el| $el | path exists}}
      code: {|| update_lua_info_cache }
    }
  ]
)

def lua_version  [] { echo $env.__LUA_INFO_CACHE.value  }
