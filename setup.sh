#!/bin/bash

# Update and install necessary packages
sudo dnf update -y
sudo dnf install -y curl wget gnupg2 software-properties-common

# Add Visual Studio Code repository and install it
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install -y code

# Install extensions
code --install-extension esbenp.prettier-vscode
code --install-extension dbaeumer.vscode-eslint
code --install-extension CoenraadS.bracket-pair-colorizer
code --install-extension eamodio.gitlens
code --install-extension christian-kohler.path-intellisense
code --install-extension ms-python.python
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-vscode-remote.remote-ssh
code --install-extension vscodevim.vim
code --install-extension ms-vsliveshare.vsliveshare
code --install-extension zhuangtongfa.material-theme
code --install-extension shd101wyy.markdown-preview-enhanced
code --install-extension mhutchie.git-graph
code --install-extension ms-vscode-remote.remote-containers

# Ensure the settings directory exists
mkdir -p ~/.config/Code/User/

# Set VSCode settings
cat <<EOL > ~/.config/Code/User/settings.json
{
  "editor.tabSize": 2,
  "editor.formatOnSave": true,
  "editor.wordWrap": "on",
  "editor.minimap.enabled": false,
  "editor.cursorSmoothCaretAnimation": true,
  "editor.renderWhitespace": "all",
  "editor.codeActionsOnSave": {
    "source.fixAll": true
  },
  "explorer.confirmDragAndDrop": false,
  "explorer.confirmDelete": false,
  "files.autoSave": "onFocusChange",
  "files.exclude": {
    "**/.git": true,
    "**/.DS_Store": true
  },
  "terminal.integrated.fontFamily": "monospace",
  "terminal.integrated.fontSize": 14,
  "terminal.integrated.cursorBlinking": true,
  "git.autofetch": true,
  "git.confirmSync": false,
  "git.enableSmartCommit": true,
  "git.path": "/usr/bin/git",
  "prettier.singleQuote": true,
  "prettier.trailingComma": "all",
  "prettier.printWidth": 80,
  "eslint.format.enable": true,
  "eslint.autoFixOnSave": true,
  "docker.dockerPath": "/usr/local/bin/docker",
  "docker.languageserver.featureFlags": {
    "lspHover": true,
    "lspDiagnostics": true
  },
  "workbench.colorTheme": "Material Theme Ocean High Contrast",
  "workbench.iconTheme": "material-icon-theme",
  "markdown-preview-enhanced.enableZenMode": true,
  "markdown-preview-enhanced.scrollSync": true,
  "remote.containers.showLog": true
}
EOL

# Set VSCode keybindings
cat <<EOL > ~/.config/Code/User/keybindings.json
[
  {
    "key": "ctrl+shift+b",
    "command": "workbench.action.tasks.build"
  },
  {
    "key": "ctrl+shift+t",
    "command": "workbench.action.terminal.openNativeConsole"
  },
  {
    "key": "ctrl+shift+d",
    "command": "editor.action.copyLinesDownAction"
  },
  {
    "key": "ctrl+shift+u",
    "command": "editor.action.undo"
  },
  {
    "key": "ctrl+\\",
    "command": "workbench.action.splitEditor"
  },
  {
    "key": "ctrl+1",
    "command": "workbench.action.focusFirstEditorGroup"
  },
  {
    "key": "ctrl+2",
    "command": "workbench.action.focusSecondEditorGroup"
  },
  {
    "key": "ctrl+k ctrl+o",
    "command": "workbench.action.files.openFolder"
  },
  {
    "key": "ctrl+k ctrl+w",
    "command": "workbench.action.closeFolder"
  },
  {
    "key": "ctrl+k ctrl+s",
    "command": "workbench.action.files.saveAll"
  },
  {
    "key": "ctrl+k ctrl+t",
    "command": "workbench.action.terminal.new"
  }
]
EOL

# Kernel build specific tweaks
echo "alias makedefconfig='make O=out ARCH=arm64 defconfig'" >> ~/.bashrc
echo "alias makeconfig='make O=out ARCH=arm64 menuconfig'" >> ~/.bashrc
echo "alias makekernel='make O=out ARCH=arm64 -j$(nproc)'" >> ~/.bashrc
echo "export PATH=\$PATH:/usr/lib/llvm-16/bin" >> ~/.bashrc

source ~/.bashrc

echo "VSCode setup is complete!"
