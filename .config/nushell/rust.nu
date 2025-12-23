$env.__RUST_INFO_CACHE = { pwd: ""  value: "" }

def --env update_rust_info_cache [] {
  let cwd = (pwd)
  if $env.__RUST_INFO_CACHE.pwd == $cwd { return }

  let rust_ver = (
    try { ^rustc --version | str trim | str substring 0..11 } | default ""
  )

  $env.__RUST_INFO_CACHE = {
    pwd: $cwd
    value: $"($rust_ver) "
  }
}

$env.config.hooks.env_change.PWD = (
  $env.config.hooks.env_change.PWD? | append [
    {
      condition: {|| ['Cargo.toml' 'rust-toolchain' 'rust-toolchain.toml'] | any {|el| $el | path exists}}
      code: {|| update_rust_info_cache }
    }
  ]
)

def rust_version [] { echo $env.__RUST_INFO_CACHE.value }
