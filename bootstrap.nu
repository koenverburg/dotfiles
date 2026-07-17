#!/usr/bin/env nu
# Bootstrap symlink manager
# Supports macOS and Linux/Ubuntu config mappings

# --- Platform config dictionaries ---

def linux-configs [] {
  {
    gitconfig: { source: ".config/gitconfig/.gitconfig",                     target: "~/.gitconfig"                      }
    tmux:      { source: "./ansible/playbooks/roles/tmux/files/.tmux.conf",  target: "~/.tmux.conf"                      }
    nvim:      { source: "./.config/nvim",                                   target: "~/.config/nvim"                    }
    fish:      { source: "./ansible/playbooks/roles/fish/files/config.fish", target: "~/.config/fish/config.fish"        }
    alacritty: { source: "./.config/alacritty/alacritty.yml",                target: "~/.config/alacritty/alacritty.yml" }
    lazygit:   { source: ".config/lazygit/config.yml",                       target: "~/.config/lazygit/config.yml"      }
  }
}

def linux-dirs [] {
  ["~/.config/alacritty" "~/code/tools"]
}

def macos-configs [] {
  {
    rootjust:  { source: ".config/justfile/justfile",    target: "~/.justfile"  }
    gitconfig: { source: ".config/gitconfig/.gitconfig", target: "~/.gitconfig" }

    k9s:            { source: ".config/k9s",                           target: "~/.config/k9s"                     }
    # nvim:           { source: ".config/nvim",                          target: "~/.config/nvim"                    }
    alacritty:      { source: ".config/alacritty/alacritty.macos.yml", target: "~/.config/alacritty/alacritty.yml" }
    zellij_layouts: { source: ".config/zellij/layouts",                target: "~/.config/zellij/layouts"          }
    zellij_config:  { source: ".config/zellij/config.kdl",             target: "~/.config/zellij/config.kdl"       }

    lazygit:        { source: ".config/lazygit/config.yml",             target: "~/Library/Application Support/lazygit/config.yml"             }
    nushell_config: { source: ".config/nushell/config.nu",              target: "~/Library/Application Support/nushell/config.nu"              }
    nushell_theme:  { source: ".config/nushell/black-metal-bathory.nu", target: "~/Library/Application Support/nushell/black-metal-bathory.nu" }
  }
}

def macos-dirs [] {
  [
    "~/.config/yabai"
    "~/.config/limelight"
    "~/.config/skhd"
    "~/.config/starship/themes"
    "~/.config/zellij"
    "~/Library/Application Support/lazygit"
    "~/Library/Application Support/nushell"
  ]
}

# --- Platform helpers ---

def configs [platform: string] {
  if $platform == "macos" { macos-configs } else { linux-configs }
}

def extra-dirs [platform: string] {
  if $platform == "macos" { macos-dirs } else { linux-dirs }
}

# --- Filesystem helpers ---

def path-exists [p: string] {
  (do { ^test -e $p } | complete).exit_code == 0
}

def is-symlink [p: string] {
  (do { ^test -L $p } | complete).exit_code == 0
}

def make-link [target: string, source: string] {
  let t = ($target | path expand --no-symlink)
  let s = ($source | path expand)
  if not ($s | path exists) {
    print $"Source missing: ($s); skipping ($t)"
    return
  }
  let parent = ($t | path dirname)
  mkdir $parent
  try { rm -rf $t }
  ln -s $s $t
  print $"Linked ($s) -> ($t)"
}

def maybe-link [target: string, source: string] {
  let t = ($target | path expand --no-symlink)
  let s = ($source | path expand)
  if ($t | path exists) {
    print $"Already exists: ($t); skipped"
    return
  }
  if not ($s | path exists) {
    print $"Source missing: ($s); skipping ($t)"
    return
  }
  let parent = ($t | path dirname)
  mkdir $parent
  try { rm -rf $t }
  ln -s $s $t
  print $"Linked ($s) -> ($t)"
}

def remove-link [target: string] {
  let t = ($target | path expand --no-symlink)
  if not (is-symlink $t) and not (path-exists $t) {
    print $"Not present: ($t)"
    return
  }
  ^rm -f $t
  print $"Removed ($t)"
}

# --- Operations ---

def create-extra-dirs [platform: string] {
  for d in (extra-dirs $platform) { mkdir ($d | path expand --no-symlink) }
}

def sync-all [platform: string] {
  create-extra-dirs $platform
  (configs $platform) | items { |name, cfg| make-link $cfg.target $cfg.source } | ignore
}

def sync-one [platform: string, name: string] {
  let cfg = (configs $platform) | get $name
  make-link $cfg.target $cfg.source
}

def init-all [platform: string] {
  create-extra-dirs $platform
  (configs $platform) | items { |name, cfg| maybe-link $cfg.target $cfg.source } | ignore
}

def init-one [platform: string, name: string] {
  let cfg = (configs $platform) | get $name
  maybe-link $cfg.target $cfg.source
}

def remove-one [platform: string, name: string] {
  let cfg = (configs $platform) | get $name
  remove-link $cfg.target
}

def list-configs [platform: string] {
  print $"Available configs for ($platform):"
  (configs $platform) | columns | sort | each { |c| print $"  - ($c)" } | ignore
}

# --- CLI ---

def main [
  platform: string = "linux"
  cmd: string = "sync"
  name?: string
] {
  match $cmd {
    "sync" => { if $name != null { sync-one $platform $name } else { sync-all $platform } }
    "init" => { if $name != null { init-one $platform $name } else { init-all $platform } }
    "remove" => {
      if $name == null {
        print "Usage: bootstrap.nu <platform> remove <name>"
        exit 1
      }
      remove-one $platform $name
    }
    "list" => { list-configs $platform }
    _ => { print $"Unknown command: ($cmd)"; exit 1 }
  }
}
