# level 1 --  #
# level 2 -- git #
# level 3 -- dir + git #

# level 0 --  # - no right side

$env.__PROMPT_LEVEL = {
  value: 1,
  in_zellij: false
}

def --env prompt [value: number = 1] {
  let in_zellij = ($env.ZELLIJ? | is-not-empty)

  $env.__PROMPT_LEVEL = {
    value: $value,
    in_zellij: $in_zellij
  }
}

