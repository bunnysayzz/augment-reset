# Augment Reset Tool

A powerful and compact shell script to completely reset and clean all Augment Code extension data from your system.

## 🚀 Features

- **Complete Data Removal**: Removes all Augment-related extensions, settings, cache, and temporary files
- **Cross-Platform Support**: Works on Windows, macOS, and Linux
- **Compact Terminal Interface**: Beautiful ASCII art with minimal screen footprint
- **Safe Confirmation**: Requires user confirmation before proceeding
- **Automatic Backup**: Creates backups of important files before modification
- **Network Cache Reset**: Flushes DNS and network caches

## 🛠️ Installation

### Option 1: Clone Repository
```bash
git clone https://github.com/bunnysayzz/augment-reset.git
cd augment-reset
chmod +x augment-reset.sh
./augment-reset.sh
```

### Option 2: Direct Download (Copy-Paste)

#### For macOS/Linux:
```bash
curl -o augment-reset.sh https://raw.githubusercontent.com/bunnysayzz/augment-reset/main/augment-reset.sh && chmod +x augment-reset.sh
./augment-reset.sh
```

#### For Windows (Git Bash/WSL):
```bash
curl -o augment-reset.sh https://raw.githubusercontent.com/bunnysayzz/augment-reset/main/augment-reset.sh && chmod +x augment-reset.sh
./augment-reset.sh
```

#### For Windows (PowerShell):
```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/bunnysayzz/augment-reset/main/augment-reset.sh" -OutFile "augment-reset.sh"
bash augment-reset.sh
```

### Option 3: Manual Copy-Paste
1. Visit: https://raw.githubusercontent.com/bunnysayzz/augment-reset/main/augment-reset.sh
2. Copy the entire content
3. Create a new file: `augment-reset.sh`
4. Paste the content and save
5. Make executable: `chmod +x augment-reset.sh`

## 🎯 Usage

```bash
./augment-reset.sh
```

The script will:
1. Request administrator privileges
2. Display a beautiful ASCII art banner
3. Show a warning about what will be removed
4. Ask for confirmation
5. Perform the complete reset process

## 🔧 What Gets Removed

The tool removes the following Augment-related data:

- **Extensions**: All Augment Code extensions and plugins
- **Settings**: VS Code settings and keybindings related to Augment
- **Cache**: Extension cache and temporary files
- **Workspace Storage**: Workspace-specific Augment data
- **System Temp**: Temporary files in system directories
- **Network Cache**: DNS and network caches

## ⚠️ Important Notes

- **Irreversible Action**: This tool permanently deletes data
- **Fresh Account Required**: You'll need to create a new Augment account after reset
- **VS Code Restart**: VS Code will be closed during the process
- **System Restart**: Recommended after completion for best results

## 🖥️ Supported Operating Systems

- **Windows**: Windows 10/11 (Git Bash, WSL, or PowerShell)
- **macOS**: macOS 10.14+
- **Linux**: Most distributions with bash

## 📁 File Locations Cleaned

- VS Code user data directory
- Extension directories
- Cache and log directories
- System temporary directories
- Workspace storage

## 🔍 Troubleshooting

### Common Issues

**Permission Denied**
```bash
chmod +x augment-reset.sh
```

**Script Won't Run**
```bash
ls -la augment-reset.sh
bash augment-reset.sh
```

**Authentication Issues**
- Ensure you have administrator privileges
- Enter your password when prompted

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 👨‍💻 Author

**bunnysayzz**

- GitHub: [@bunnysayzz](https://github.com/bunnysayzz)

## ⭐ Show your support

Give a ⭐️ if this project helped you!

---

**Disclaimer**: Use this tool at your own risk. Always backup important data before running system cleanup tools.
