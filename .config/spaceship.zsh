SPACESHIP_PROMPT_ORDER=(
  time           # Time stamps section
  nix_shell      # Nix shell
  # user           # Username section
  dir            # Current directory section
  host           # Hostname section
  git            # Git section (git_branch + git_status)
  # package        # Package version
  # venv           # virtualenv section
  # hg             # Mercurial section (hg_branch  + hg_status)
  # node           # Node.js section
  # bun            # Bun section
  # deno           # Deno section
  # ruby           # Ruby section
  # python         # Python section
  # elm            # Elm section
  # elixir         # Elixir section
  # xcode          # Xcode section
  # swift          # Swift section
  # golang         # Go section
  # perl           # Perl section
  # php            # PHP section
  # rust           # Rust section
  # haskell        # Haskell Stack section
  # scala          # Scala section
  # kotlin         # Kotlin section
  # java           # Java section
  # lua            # Lua section
  # dart           # Dart section
  # julia          # Julia section
  # crystal        # Crystal section
  docker         # Docker section
  # docker_compose # Docker section
  # aws            # Amazon Web Services section
  # gcloud         # Google Cloud Platform section
  # azure          # Azure section
  # conda          # conda virtualenv section
  # dotnet         # .NET section
  # ocaml          # OCaml section
  # vlang          # V section
  # zig            # Zig section
  # purescript     # PureScript section
  # erlang         # Erlang section
  # kubectl        # Kubectl context section
  # ansible        # Ansible section
  # terraform      # Terraform workspace section
  # pulumi         # Pulumi stack section
  # ibmcloud       # IBM Cloud section
  # gnu_screen     # GNU Screen section
  exec_time      # Execution time
  # async          # Async jobs indicator
  line_sep       # Line break
  # battery        # Battery level and status
  jobs           # Background jobs indicator
  exit_code      # Exit code section
  sudo           # Sudo indicator
  char           # Prompt character
)
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true

# Exec time
SPACESHIP_EXEC_TIME_ELAPSED=2
SPACESHIP_EXEC_TIME_PRECISION=2

SPACESHIP_PROMPT_DEFAULT_PREFIX=""
SPACESHIP_CHAR_SYMBOL="λ"
SPACESHIP_CHAR_SYMBOL_ROOT="!#!"
SPACESHIP_CHAR_SUFFIX=" "

# Git
SPACESHIP_GIT_STATUS_COLOR="magenta"
SPACESHIP_GIT_PREFIX=""
SPACESHIP_GIT_SYMBOL=" "

SPACESHIP_DIR_PREFIX=""
SPACESHIP_PROMPT_ASYNC=true

SPACESHIP_VENV_SYMBOL=" "
SPACESHIP_VENV_PREFIX="("
SPACESHIP_VENV_SUFFIX=") "
SPACESHIP_VENV_GENERIC_NAMES=false

SPACESHIP_PYTHON_SHOW=false

SPACESHIP_VI_MODE_SHOW=false
SPACESHIP_VI_MODE_INSERT=""
SPACESHIP_VI_MODE_NORMAL=""
