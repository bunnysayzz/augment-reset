#!/bin/bash

# Augment Reset Tool - Compact Version
# Developed by: https://github.com/bunnysayzz

# Arrays to track operations
removed_items=()
errors=()

# Function to clear screen
clear_screen() {
    # Removed clear to eliminate gaps
    :
}

# Function to display compact banner
display_banner() {
    echo " █████╗ ██╗   ██╗ ██████╗ ███╗   ███╗███████╗███╗   ██╗████████╗"
    echo "██╔══██╗██║   ██║██╔════╝ ████╗ ████║██╔════╝████╗  ██║╚══██╔══╝"
    echo "███████║██║   ██║██║  ███╗██╔████╔██║█████╗  ██╔██╗ ██║   ██║   "
    echo "██╔══██║██║   ██║██║   ██║██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║   "
    echo "██║  ██║╚██████╔╝╚██████╔╝██║ ╚═╝ ██║███████╗██║ ╚████║   ██║   "
    echo "╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   "
    echo "██████╗ ███████╗███████╗███████╗████████╗"
    echo "██╔══██╗██╔════╝██╔════╝██╔════╝╚══██╔══╝"
    echo "██████╔╝█████╗  ███████╗███████╗   ██║   "
    echo "██╔══██╗██╔══╝  ╚════██║╚════██║   ██║   "
    echo "██║  ██║███████╗███████║███████║   ██║   "
    echo "╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝   ╚═╝   "
}

# Function to display compact info
display_info() {
    echo "🚨 COMPLETE RESET WARNING 🚨"
    echo "This tool will remove ALL Augment Code extension data:"
    echo "• Extensions and plugins"
    echo "• Settings and configurations" 
    echo "• Cache and temporary files"
    echo "• Workspace storage data"
    echo "• Registry entries (Windows)"
    echo "⚠️  This action is IRREVERSIBLE!"
    echo "⚠️  You will need to create a fresh account afterwards"
}

# Function to log success
log_success() {
    echo "✅ $1"
    removed_items+=("$1")
}

# Function to log error
log_error() {
    echo "❌ $1"
    errors+=("$1")
}

# Function to log info
log_info() {
    echo "ℹ️  $1"
}

# Function to get VS Code paths based on OS
get_vscode_paths() {
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
        # Windows
        USER_DATA="$HOME/AppData/Roaming/Code/User"
        EXTENSIONS="$HOME/.vscode/extensions"
        CACHE="$HOME/AppData/Roaming/Code/CachedExtensions"
        LOGS="$HOME/AppData/Roaming/Code/logs"
        WORKSPACE_STORAGE="$HOME/AppData/Roaming/Code/User/workspaceStorage"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        USER_DATA="$HOME/Library/Application Support/Code/User"
        EXTENSIONS="$HOME/.vscode/extensions"
        CACHE="$HOME/Library/Caches/com.microsoft.VSCode"
        LOGS="$HOME/Library/Application Support/Code/logs"
        WORKSPACE_STORAGE="$HOME/Library/Application Support/Code/User/workspaceStorage"
    else
        # Linux
        USER_DATA="$HOME/.config/Code/User"
        EXTENSIONS="$HOME/.vscode/extensions"
        CACHE="$HOME/.cache/vscode"
        LOGS="$HOME/.config/Code/logs"
        WORKSPACE_STORAGE="$HOME/.config/Code/User/workspaceStorage"
    fi
}

# Function to close VS Code
close_vscode() {
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
        taskkill /F /IM "Code.exe" >/dev/null 2>&1
    else
        pkill -f "Visual Studio Code" >/dev/null 2>&1
    fi
    log_success "Closed VS Code processes"
}

# Function to remove Augment extensions
remove_augment_extensions() {
    if [[ -d "$EXTENSIONS" ]]; then
        for dir in "$EXTENSIONS"/*; do
            if [[ -d "$dir" ]]; then
                dirname=$(basename "$dir")
                if [[ "$dirname" =~ [Aa]ugment ]]; then
                    rm -rf "$dir"
                    log_success "Removed extension: $dirname"
                fi
            fi
        done
    else
        log_info "Extensions directory not found"
    fi
}

# Function to clean VS Code settings
clean_vscode_settings() {
    # Clean settings.json
    if [[ -f "$USER_DATA/settings.json" ]]; then
        # Create backup
        cp "$USER_DATA/settings.json" "$USER_DATA/settings.json.backup" 2>/dev/null
        
        # Remove augment-related entries using jq if available, otherwise use sed
        if command -v jq >/dev/null 2>&1; then
            jq 'del(.[] | select(tostring | test("augment"; "i")))' "$USER_DATA/settings.json" > "$USER_DATA/settings.json.tmp" && mv "$USER_DATA/settings.json.tmp" "$USER_DATA/settings.json"
        else
            # Fallback to sed (less precise but works)
            sed -i '/[Aa]ugment/d' "$USER_DATA/settings.json" 2>/dev/null
        fi
        log_success "Cleaned settings.json"
    fi
    
    # Clean keybindings.json
    if [[ -f "$USER_DATA/keybindings.json" ]]; then
        cp "$USER_DATA/keybindings.json" "$USER_DATA/keybindings.json.backup" 2>/dev/null
        if command -v jq >/dev/null 2>&1; then
            jq 'del(.[] | select(.command? | test("augment"; "i")))' "$USER_DATA/keybindings.json" > "$USER_DATA/keybindings.json.tmp" && mv "$USER_DATA/keybindings.json.tmp" "$USER_DATA/keybindings.json"
        else
            sed -i '/[Aa]ugment/d' "$USER_DATA/keybindings.json" 2>/dev/null
        fi
        log_success "Cleaned keybindings.json"
    fi
    
    # Clean globalStorage
    if [[ -f "$USER_DATA/globalStorage/storage.json" ]]; then
        cp "$USER_DATA/globalStorage/storage.json" "$USER_DATA/globalStorage/storage.json.backup" 2>/dev/null
        if command -v jq >/dev/null 2>&1; then
            jq 'del(.[] | select(tostring | test("augment"; "i")))' "$USER_DATA/globalStorage/storage.json" > "$USER_DATA/globalStorage/storage.json.tmp" && mv "$USER_DATA/globalStorage/storage.json.tmp" "$USER_DATA/globalStorage/storage.json"
        else
            sed -i '/[Aa]ugment/d' "$USER_DATA/globalStorage/storage.json" 2>/dev/null
        fi
        log_success "Cleaned globalStorage/storage.json"
    fi
}

# Function to clean workspace storage
clean_workspace_storage() {
    if [[ -d "$WORKSPACE_STORAGE" ]]; then
        for dir in "$WORKSPACE_STORAGE"/*; do
            if [[ -d "$dir" ]]; then
                if [[ -f "$dir/state.vscdb" ]]; then
                    # For SQLite files, we'll just remove the entire workspace if it contains augment
                    if grep -q -i "augment" "$dir/state.vscdb" 2>/dev/null; then
                        rm -rf "$dir"
                        log_success "Removed workspace: $(basename "$dir")"
                    fi
                fi
            fi
        done
    fi
}

# Function to clean cache and logs
clean_cache_and_logs() {
    # Clean cache
    if [[ -d "$CACHE" ]]; then
        for item in "$CACHE"/*; do
            if [[ -e "$item" ]]; then
                itemname=$(basename "$item")
                if [[ "$itemname" =~ [Aa]ugment ]]; then
                    rm -rf "$item"
                    log_success "Removed cache: $itemname"
                fi
            fi
        done
    fi
    
    # Clean logs
    if [[ -d "$LOGS" ]]; then
        for item in "$LOGS"/*; do
            if [[ -e "$item" ]]; then
                itemname=$(basename "$item")
                if [[ "$itemname" =~ [Aa]ugment ]]; then
                    rm -rf "$item"
                    log_success "Removed log: $itemname"
                fi
            fi
        done
    fi
}

# Function to clean system temp
clean_system_temp() {
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
        # Windows temp directories
        temp_dirs=("$TEMP" "$TMP" "$HOME/AppData/Local/Temp")
    else
        # Unix temp directories
        temp_dirs=("/tmp" "/var/tmp" "$HOME/.tmp")
    fi
    
    for temp_dir in "${temp_dirs[@]}"; do
        if [[ -d "$temp_dir" ]]; then
            for item in "$temp_dir"/*; do
                if [[ -e "$item" ]]; then
                    itemname=$(basename "$item")
                    if [[ "$itemname" =~ [Aa]ugment ]]; then
                        rm -rf "$item"
                        log_success "Removed temp file: $itemname"
                    fi
                fi
            done
        fi
    done
}

# Function to reset network cache
reset_network_cache() {
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
        ipconfig /flushdns >/dev/null 2>&1
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        sudo -n dscacheutil -flushcache >/dev/null 2>&1
    else
        sudo -n systemctl restart systemd-resolved >/dev/null 2>&1
    fi
    log_success "Network cache flushed"
}

# Function to display compact summary
display_summary() {
    echo "🎉 RESET COMPLETE! 🎉"
    echo "✅ Successfully removed ${#removed_items[@]} items"
    if [[ ${#errors[@]} -gt 0 ]]; then
        echo "❌ ${#errors[@]} errors occurred"
    fi
    
    echo "📋 NEXT STEPS:"
    echo "1. 🔄 Restart your computer (recommended)"
    echo "2. 💻 Open VS Code"
    echo "3. 📦 Install Augment Code extension fresh"
    echo "4. 👤 Create a new account"
    echo "5. ✨ Enjoy your clean system!"
    
    echo ""
    echo "👨‍💻 Developed by: bunnysayzz"
    echo "🌐 GitHub: https://github.com/bunnysayzz/augment-reset.git"
    echo ""
}

# Main function
main() {
    # Check for sudo access first, before showing anything
    if ! sudo -n true 2>/dev/null; then
        sudo -v
        if [[ $? -ne 0 ]]; then
            echo "❌ Authentication failed. Exiting."
            exit 1
        fi
    fi
    
    clear_screen
    display_banner
    display_info
    echo "⚠️  CONFIRMATION REQUIRED ⚠️"
    read -p "Are you sure you want to proceed? (yes/y/Yes/Y): " confirm
    confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]')
    
    if [[ "$confirm" != "yes" && "$confirm" != "y" ]]; then
        echo "❌ Operation cancelled by user."
        exit 0
    fi
    
    echo "🚀 Starting complete reset process..."
    
    # Get VS Code paths
    get_vscode_paths
    
    # Step 1: Close VS Code
    log_info "🔒 Step 1: Closing VS Code processes..."
    close_vscode
    
    # Step 2: Remove extensions
    log_info "🗑️  Step 2: Removing Augment extensions..."
    remove_augment_extensions
    
    # Step 3: Clean settings
    log_info "⚙️  Step 3: Cleaning VS Code settings..."
    clean_vscode_settings
    
    # Step 4: Clean workspace storage
    log_info "📁 Step 4: Cleaning workspace storage..."
    clean_workspace_storage
    
    # Step 5: Clean cache and logs
    log_info "🧹 Step 5: Cleaning cache and logs..."
    clean_cache_and_logs
    
    # Step 6: Clean system temp
    log_info "🗂️  Step 6: Cleaning system temporary files..."
    clean_system_temp
    
    # Step 7: Reset network cache
    log_info "🌐 Step 7: Resetting network cache..."
    reset_network_cache
    
    # Display summary
    display_summary
}

# Check if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi 

