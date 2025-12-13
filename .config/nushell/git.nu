$env.__GIT_INFO_CACHE = {
  pwd: ""
  value: ""
}

def --env update_git_info_cache [] {
  let cwd = (pwd)

  if $env.__GIT_INFO_CACHE.pwd == $cwd {
    return
  }

  let icon_dirty = "*"
  let icon_stash = "∷"

  let match_staged   = '^M '
  let match_dirty    = '^ M'
  let find_untracked = '??'

  if not ((git rev-parse --is-inside-work-tree | complete | get stdout | str trim) == "true") {
    $env.__GIT_INFO_CACHE = { pwd: $cwd, value: "" }
    return
  }

  let porcelain = (git status --porcelain=v1)

  if ($porcelain | is-empty) {
    $env.__GIT_INFO_CACHE = { pwd: $cwd, value: "" }
    return
  }

  let branch = (git branch --show-current | str trim)

  let formatted_branch = match $branch {
    "main" => $branch,
    "develop" => $branch,
    _ => {
      if ($branch | str starts-with "OPP") {
        (git branch --show-current | str trim | str substring 0..8)
      } else { "" }
    }
  }

  let staged    = if (($porcelain | lines | find --regex $match_staged | length) > 0) { "+" } else { "" }
  let unstaged  = if (($porcelain | lines | find --regex $match_dirty | length) > 0) { $icon_dirty } else { "" }
  let untracked = if (($porcelain | lines | find $find_untracked | length) > 0) { "?" } else { "" }

  let stash = if ((git stash list | lines | length) > 0) { $icon_stash } else { "" }

  let value = $"(ansi dark_gray)(ansi cyan)($formatted_branch) (ansi green)($staged)(ansi yellow)($unstaged)(ansi white)($untracked)(ansi magenta) ($stash)(ansi dark_gray) (ansi reset)"

  $env.__GIT_INFO_CACHE = {
    pwd: $cwd
    value: $value
  }
}

$env.config.hooks.env_change.PWD = (
  $env.config.hooks.env_change.PWD? | append {
    condition: {|| true }
    code: {|| update_git_info_cache }
  }
)

