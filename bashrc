# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

export DEV_ROOT="${HOME}/dev"

# Path to your oh-my-bash installation.
export OSH="${DEV_ROOT}/my-bash/oh-my-bash"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="agnoster"

# If you set OSH_THEME to "random", you can ignore themes you don't like.
# OMB_THEME_RANDOM_IGNORED=("powerbash10k" "wanelo")

# Uncomment the following line to use case-sensitive completion.
# OMB_CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# OMB_HYPHEN_SENSITIVE="false"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_OSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you don't want the repository to be considered dirty
# if there are untracked files.
# SCM_GIT_DISABLE_UNTRACKED_DIRTY="true"

# Uncomment the following line if you want to completely ignore the presence
# of untracked files in the repository.
# SCM_GIT_IGNORE_UNTRACKED="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.  One of the following values can
# be used to specify the timestamp format.
# * 'mm/dd/yyyy'     # mm/dd/yyyy + time
# * 'dd.mm.yyyy'     # dd.mm.yyyy + time
# * 'yyyy-mm-dd'     # yyyy-mm-dd + time
# * '[mm/dd/yyyy]'   # [mm/dd/yyyy] + [time] with colors
# * '[dd.mm.yyyy]'   # [dd.mm.yyyy] + [time] with colors
# * '[yyyy-mm-dd]'   # [yyyy-mm-dd] + [time] with colors
# If not set, the default value is 'yyyy-mm-dd'.
# HIST_STAMPS='yyyy-mm-dd'

# Uncomment the following line if you do not want OMB to overwrite the existing
# aliases by the default OMB aliases defined in lib/*.sh
# OMB_DEFAULT_ALIASES="check"

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder

# To disable the uses of "sudo" by oh-my-bash, please set "false" to
# this variable.  The default behavior for the empty value is "true".
OMB_USE_SUDO=true

# To enable/disable display of Python virtualenv and condaenv
# OMB_PROMPT_SHOW_PYTHON_VENV=true  # enable
# OMB_PROMPT_SHOW_PYTHON_VENV=false # disable

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
  git
  composer
  ssh
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  general
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  bashmarks
)

# Which plugins would you like to conditionally load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format:
#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi

source "$OSH"/oh-my-bash.sh

# system language
export LANG=en_US.UTF-8

# preferred editor
export EDITOR='nano'

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

# dev folder
_dev_complete() {
  local cur
  cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -d "${DEV_ROOT}/${cur}" 2>/dev/null | sed "s|${DEV_ROOT}/||") )
} && complete -F _dev_complete dev

dev()
{
  cd "${DEV_ROOT}/${@}"
}

# vcpkg
export VCPKG_DISABLE_METRICS
export VCPKG_ROOT="${DEV_ROOT}/vcpkg"
export PATH="${PATH}:${VCPKG_ROOT}"
export VCPKG_OVERLAY_PORTS="${DEV_ROOT}/vcpkg-registry/ports"

# cmake helpers
function cmake_debug()
{
  cmake --preset unix-debug "${@}"
}

function cmake_reldeb()
{
  cmake --preset unix-relwithdeb "${@}"
}

function cmake_rel()
{
  cmake --preset unix-release "${@}"
}

function ccat()
{
  pygmentize -g "${@}"
}

function designer()
{
  /usr/lib/qt6/bin/designer "${@}"
}

function python_venv()
{
  d="${1}"
  if [[ "${d}" == "" ]]; then
    d="./venv"
  fi
  python -m venv "${d}"
  echo "source ${d}/bin/activate"
}

alias lsblk='lsblk -io NAME,LABEL,SIZE,TYPE,MOUNTPOINTS,UUID,MODEL'

__sctl_last=""

function sctl()
{
  local cmd="${1}"
  local unit="${2}"
  if [[ "${cmd}" == "dr" || "${cmd}" == "daemon-reload" ]]; then
    sudo systemctl daemon-reload
    return $?
  fi
  if [[ "${unit}" == "" ]]; then
    unit="${__sctl_last}"
  fi

  __sctl_last="${unit}"
  sudo systemctl "${cmd}" "${unit}"
  return $?
}

function loginctl_session_type()
{
  loginctl show-session $(loginctl --json=short | jq -r '.[0].session') -p Type | cut -f 2- -d '='
}

function pkill()
{
  if [[ "${@}" == "" ]]; then
    echo 'pkill <search string>'
    return 1
  fi

  for p in "$(ps aux | grep "${@}" | grep -v grep | awk '{print $2}')"; do
    if [[ "${p}" == "" ]]; then
      continue
    fi
    echo ".. killing pid ${p}"
    kill -9 $p
  done
}