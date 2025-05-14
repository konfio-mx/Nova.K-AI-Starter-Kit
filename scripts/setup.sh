#!/usr/bin/env bash

# Nova.K AI Agent Starter Kit Setup Script
# This script installs all prerequisites for the Nova.K AI Agent Starter Kit

# Set strict mode
set -euo pipefail

# Text formatting
BOLD="\033[1m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
BLUE="\033[0;34m"
PURPLE="\033[0;35m"
NC="\033[0m" # No Color

# Function to print colored messages
print_message() {
  local type=$1
  local message=$2
  local emoji=""
  local color=""

  case $type in
  info)
    emoji="ℹ️  "
    color=$NC
    ;;
  success)
    emoji="✅  "
    color=$GREEN
    ;;
  warning)
    emoji="⚠️  "
    color=$YELLOW
    ;;
  error)
    emoji="❌  "
    color=$RED
    ;;
  progress)
    emoji="🔄  "
    color=$BLUE
    ;;
  header)
    emoji="🚀  "
    color="${BOLD}${PURPLE}"
    ;;
  esac

  echo -e "${color}${emoji}${message}${NC}"
}

# Function to print a separator line
print_separator() {
  local width=80
  local char="="
  printf "\n${PURPLE}%${width}s${NC}\n" | tr " " "$char"
}
print_separator_linebreak_end() {
  local width=80
  local char="="
  printf "${PURPLE}%${width}s${NC}\n" | tr " " "$char"
  printf "\n"
}

# Function to print section header with separator
print_section_header() {
  local title=$1
  print_separator
  echo -e "\t${BOLD}${PURPLE}$title"
  print_separator_linebreak_end
}

# Function to check if a command exists
command_exists() {
  command -v "$1" &>/dev/null
}

# Function to detect OS
detect_os() {
  case "$(uname -s)" in
  Darwin*)
    echo "macos"
    ;;
  Linux*)
    echo "linux"
    ;;
  MINGW* | MSYS* | CYGWIN*)
    echo "windows"
    ;;
  *)
    echo "unknown"
    ;;
  esac
}

# Function to detect architecture
detect_arch() {
  case "$(uname -m)" in
  x86_64 | amd64)
    echo "amd64"
    ;;
  arm64 | aarch64)
    echo "arm64"
    ;;
  *)
    echo "unknown"
    ;;
  esac
}

# Function to install package manager if not present
install_package_manager() {
  local os=$1

  if [[ "$os" == "macos" ]]; then
    if ! command_exists brew; then
      print_message progress "Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

      # Add Homebrew to PATH for the current session
      if [[ "$(detect_arch)" == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      else
        eval "$(/usr/local/bin/brew shellenv)"
      fi

      print_message success "Homebrew installed successfully!"
    else
      print_message success "Homebrew is already installed."
    fi
  elif [[ "$os" == "windows" ]]; then
    if ! command_exists winget; then
      print_message error "Winget is not installed. Please install the App Installer from the Microsoft Store."
      print_message info "Visit: https://www.microsoft.com/p/app-installer/9nblggh4nns1"
      exit 1
    else
      print_message success "Winget is already installed."
    fi
  elif [[ "$os" == "linux" ]]; then
    # For Linux, we'll use the system's package manager
    print_message success "Using system package manager for Linux."
  else
    print_message error "Unsupported operating system: $os"
    exit 1
  fi
}

# Function to install Git
install_git() {
  local os=$1

  if ! command_exists git; then
    print_message progress "Installing Git..."

    if [[ "$os" == "macos" ]]; then
      brew install git
    elif [[ "$os" == "windows" ]]; then
      winget install -e --id Git.Git
    elif [[ "$os" == "linux" ]]; then
      if command_exists apt; then
        sudo apt update && sudo apt install -y git
      elif command_exists dnf; then
        sudo dnf install -y git
      elif command_exists yum; then
        sudo yum install -y git
      elif command_exists pacman; then
        sudo pacman -Sy git --noconfirm
      else
        print_message error "Unsupported Linux distribution. Please install Git manually."
        exit 1
      fi
    fi

    print_message success "Git installed successfully!"
  else
    print_message success "Git is already installed."
  fi
}

# Function to install Docker
install_docker() {
  local os=$1

  if ! command_exists docker; then
    print_message progress "Installing Docker..."

    if [[ "$os" == "macos" ]]; then
      brew install --cask docker
      print_message info "Please open Docker Desktop to complete the installation."
    elif [[ "$os" == "windows" ]]; then
      winget install -e --id Docker.DockerDesktop
      print_message info "Please open Docker Desktop to complete the installation."
    elif [[ "$os" == "linux" ]]; then
      if command_exists apt; then
        sudo apt update
        sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        sudo apt update
        sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
        sudo usermod -aG docker "$USER"
        print_message info "Please log out and log back in to use Docker without sudo."
      elif command_exists dnf; then
        sudo dnf -y install dnf-plugins-core
        sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
        sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
        sudo systemctl start docker
        sudo systemctl enable docker
        sudo usermod -aG docker "$USER"
        print_message info "Please log out and log back in to use Docker without sudo."
      else
        print_message error "Unsupported Linux distribution. Please install Docker manually."
        exit 1
      fi
    fi

    print_message success "Docker installed successfully!"
  else
    print_message success "Docker is already installed."
  fi
}

# Function to install mise
install_mise() {
  if ! command_exists mise; then
    print_message progress "Installing Tool Version Manager (mise)..."

    local os=$(detect_os)
    if [[ "$os" == "macos" ]]; then
      brew install mise
    elif [[ "$os" == "windows" ]]; then
      winget install -e --id jdx.mise
    elif [[ "$os" == "linux" ]]; then
      curl https://mise.run | sh
    fi

    print_message success "mise installed successfully!"
  else
    print_message success "mise is already installed."
  fi
}

# Function to install Task
install_task() {
  if ! command_exists task; then
    print_message progress "Installing Task Runner (Task)..."

    local os=$(detect_os)
    if [[ "$os" == "macos" ]]; then
      brew install go-task/tap/go-task
    elif [[ "$os" == "windows" ]]; then
      winget install -e --id Task.Task
    elif [[ "$os" == "linux" ]]; then
      if command_exists apt; then
        sudo sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin
      elif command_exists dnf; then
        sudo sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin
      else
        print_message error "Unsupported Linux distribution. Please install Task manually."
        exit 1
      fi
    fi

    print_message success "Task installed successfully!"
  else
    print_message success "Task is already installed."
  fi
}

# Function to setup the project
setup_project() {
  print_section_header "Project Setup"
  print_message progress "Setting up the project..."

  # Initialize mise
  if command_exists mise; then
    print_message progress "Installing environment dependencies ..."
    mise install
  else
    print_message error "mise is not installed. Cannot continue with setup."
    exit 1
  fi

  # Run task setup
  if command_exists task; then
    print_message progress "Running task setup..."
    task setup
  else
    print_message error "Task is not installed. Cannot continue with setup."
    exit 1
  fi

  print_message success "Project setup completed successfully!"
}

# Main function
main() {
  print_section_header "Nova.K AI Agent Starter Kit Setup"
  print_message info "Detecting system information..."

  local os=$(detect_os)
  local arch=$(detect_arch)

  print_message info "Operating System: $os"
  print_message info "Architecture: $arch"

  # Install prerequisites
  print_section_header "Installing OS Package Manager"
  install_package_manager "$os"

  print_section_header "Installing Git"
  install_git "$os"

  print_section_header "Installing Docker"
  install_docker "$os"

  print_section_header "Installing mise"
  install_mise

  print_section_header "Installing Task"
  install_task

  # Setup the project
  setup_project

  print_section_header "Setup Complete! 🎉"
  print_message header "You can now start using Nova.K AI Agent Starter Kit."
  print_message info "Run 'task start' to start all services."
}

# Execute main function
main
