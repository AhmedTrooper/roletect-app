#!/usr/bin/env bash
# ==============================================================================
# RoleTect - Unified Single-Line Installer for Linux and macOS
# Repo: https://github.com/AhmedTrooper/roletect-app
# ==============================================================================

set -e

# --- Visual Styling ---
BOLD='\033[1m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}${BOLD}"
echo "  ____       _     _____           _   "
echo " |  _ \ ___ | | __|_   _|__   ___| |_ "
echo " | |_) / _ \| |/ _ \| |/ _ \ / __| __|"
echo " |  _ < (_) | |  __/| |  __/| (__| |_ "
echo " |_| \_\___/|_|\___||_|\___(_)___|\__|"
echo -e "${NC}"
echo -e "${BOLD}RoleTect Privacy-First Application Installer${NC}\n"

# --- Architecture & OS Detection ---
OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
  Linux)
    OS_TYPE="linux"
    ;;
  Darwin)
    OS_TYPE="macos"
    ;;
  *)
    echo -e "${RED}Error: Unsupported Operating System: $OS${NC}"
    exit 1
    ;;
esac

case "$ARCH" in
  x86_64|amd64)
    ARCH_TYPE="x64"
    ;;
  aarch64|arm64)
    ARCH_TYPE="arm64"
    ;;
  *)
    echo -e "${RED}Error: Unsupported Architecture: $ARCH${NC}"
    exit 1
    ;;
esac

echo -e "Detected: ${BOLD}${OS_TYPE}${NC} (${ARCH_TYPE})"

# --- GitHub Release Lookup ---
REPO="AhmedTrooper/roletect-app"
API_URL="https://api.github.com/repos/${REPO}/releases/latest"

echo -e "Fetching latest release metadata from ${CYAN}${REPO}${NC}..."

RELEASE_JSON=$(curl -sSL -H "User-Agent: RoleTect-Installer" -H "Accept: application/vnd.github.v3+json" "$API_URL" || true)

# --- Download & Install for macOS ---
if [[ "$OS_TYPE" == "macos" ]]; then
  echo -e "\n${BLUE}==> Preparing macOS Installation...${NC}"
  
  if [[ "$ARCH_TYPE" == "arm64" ]]; then
    PATTERN="(aarch64|arm64).*\.dmg"
  else
    PATTERN="(x64|x86_64).*\.dmg"
  fi

  DOWNLOAD_URL=$(echo "$RELEASE_JSON" | grep -o 'https://[^"]*' | grep -iE "$PATTERN" | head -n 1 || true)

  if [[ -z "$DOWNLOAD_URL" ]]; then
    DOWNLOAD_URL=$(echo "$RELEASE_JSON" | grep -o 'https://[^"]*' | grep -iE '\.dmg$' | head -n 1 || true)
  fi

  if [[ -z "$DOWNLOAD_URL" ]]; then
    echo -e "${RED}Error: Could not locate a compatible macOS release asset.${NC}"
    echo -e "Please download manually from: ${CYAN}https://github.com/${REPO}/releases${NC}"
    exit 1
  fi

  TMP_DIR=$(mktemp -d)
  DMG_PATH="${TMP_DIR}/Roletect.dmg"

  echo -e "Downloading: ${CYAN}${DOWNLOAD_URL}${NC}"
  curl -# -L -o "$DMG_PATH" "$DOWNLOAD_URL"

  echo -e "Mounting DMG image..."
  MOUNT_DIR=$(mktemp -d)
  hdiutil attach "$DMG_PATH" -nobrowse -mountpoint "$MOUNT_DIR" -quiet

  echo -e "Installing to /Applications/Roletect.app..."
  rm -rf "/Applications/Roletect.app"
  cp -R "${MOUNT_DIR}/"*.app "/Applications/Roletect.app"

  echo -e "Detaching DMG image..."
  hdiutil detach "$MOUNT_DIR" -quiet || true
  rm -rf "$TMP_DIR" "$MOUNT_DIR"

  # Remove Gatekeeper quarantine attribute
  echo -e "Removing macOS quarantine flags..."
  xattr -cr "/Applications/Roletect.app" 2>/dev/null || true

  echo -e "\n${GREEN}${BOLD}✔ RoleTect was successfully installed to /Applications/Roletect.app!${NC}"
  echo -e "You can open it from Spotlight, Launchpad, or by running: ${CYAN}open -a Roletect${NC}\n"
  exit 0
fi

# --- Download & Install for Linux ---
if [[ "$OS_TYPE" == "linux" ]]; then
  echo -e "\n${BLUE}==> Preparing Linux Installation...${NC}"

  if [[ "$ARCH_TYPE" == "arm64" ]]; then
    PATTERN="(aarch64|arm64).*\.appimage"
  else
    PATTERN="(amd64|x86_64).*\.appimage"
  fi

  DOWNLOAD_URL=$(echo "$RELEASE_JSON" | grep -o 'https://[^"]*' | grep -iE "$PATTERN" | head -n 1 || true)

  if [[ -z "$DOWNLOAD_URL" ]]; then
    echo -e "${RED}Error: Could not locate a compatible Linux AppImage release asset for ${ARCH_TYPE}.${NC}"
    echo -e "Please download manually from: ${CYAN}https://github.com/${REPO}/releases${NC}"
    exit 1
  fi

  BIN_DIR="${HOME}/.local/bin"
  APP_DIR="${HOME}/.local/share/applications"
  ICON_DIR="${HOME}/.local/share/icons/hicolor/128x128/apps"

  mkdir -p "$BIN_DIR" "$APP_DIR" "$ICON_DIR"

  TARGET_BIN="${BIN_DIR}/roletect"

  echo -e "Downloading AppImage: ${CYAN}${DOWNLOAD_URL}${NC}"
  curl -# -L -o "$TARGET_BIN" "$DOWNLOAD_URL"
  chmod +x "$TARGET_BIN"

  # Download desktop icon
  ICON_PATH="${ICON_DIR}/com.ahmedtrooper.roletect.png"
  curl -sSL -o "$ICON_PATH" "https://raw.githubusercontent.com/${REPO}/main/src-tauri/icons/128x128.png" 2>/dev/null || true

  # Create Desktop Entry
  DESKTOP_FILE="${APP_DIR}/com.ahmedtrooper.roletect.desktop"
  cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Name=RoleTect
Comment=Privacy-First Job Application Vault & LaTeX Workspace
Exec=${TARGET_BIN} %U
Icon=com.ahmedtrooper.roletect
Type=Application
Terminal=false
Categories=Office;Development;Utility;
MimeType=application/x-roletect;
EOF
  chmod +x "$DESKTOP_FILE"

  # Update desktop database if tool is present
  if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "$APP_DIR" >/dev/null 2>&1 || true
  fi

  echo -e "\n${GREEN}${BOLD}✔ RoleTect was successfully installed!${NC}"
  echo -e "Binary location: ${CYAN}${TARGET_BIN}${NC}"
  echo -e "Application shortcut created in application menu."

  # Check PATH
  if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo -e "\n${YELLOW}Note: Add ${BIN_DIR} to your PATH by adding this line to your ~/.bashrc or ~/.zshrc:${NC}"
    echo -e "  export PATH=\"\$HOME/.local/bin:\$PATH\"\n"
  else
    echo -e "You can launch it anytime by running: ${CYAN}roletect${NC}\n"
  fi
  exit 0
fi
