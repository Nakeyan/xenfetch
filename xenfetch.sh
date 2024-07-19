#!/bin/bash

# MIT License
#
# Copyright (c) 2024 Nakeyan
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Function to download information about Distribution
get_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo $PRETTY_NAME
    else
        uname -s
    fi
}

# Function to download information about CPU
get_cpu_info() {
    local model_name=$(awk -F: '/model name/ {print $2; exit}' /proc/cpuinfo | sed 's/^[ \t]*//')
    local cores=$(grep -c ^processor /proc/cpuinfo)
    local freq=$(awk -F: '/cpu MHz/ {print $2; exit}' /proc/cpuinfo | sed 's/^[ \t]*//')
    echo "$model_name ($cores cores @ $freq MHz)"
}

# Function to download information about Memory(RAM)
get_memory_info() {
    local mem_total=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
    local mem_free=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
    local mem_used=$((mem_total - mem_free))
    echo "$(awk "BEGIN {print $mem_used / 1024 / 1024}") GB / $(awk "BEGIN {print $mem_total / 1024 / 1024}") GB"
}

# Function to download information about GPU
get_gpu_info() {
    local gpu_info=$(lspci 2>/dev/null | grep -i 'vga\|3d\|2d' | cut -d: -f3 | sed 's/^[ \t]*//')
    echo "${gpu_info:-N/A}"
}

# Function to download information about theme
get_theme() {
    if command -v gsettings &> /dev/null; then
        local theme=$(gsettings get org.gnome.desktop.interface gtk-theme)
        echo "${theme//\'}"
    else
        echo "N/A"
    fi
}

# Function to download information about icons
get_icons() {
    if command -v gsettings &> /dev/null; then
        local icons=$(gsettings get org.gnome.desktop.interface icon-theme)
        echo "${icons//\'}"
    else
        echo "N/A"
    fi
}

# Function to download information about Desktop Environment
get_desktop_environment() {
    echo "${XDG_CURRENT_DESKTOP:-Unknown}"
}

# Function to download information about Window Manager
get_window_manager() {
    echo "${XDG_SESSION_TYPE:-Unknown}"
}

# Function to download information about Terminal
get_shell() {
    local parent_pid=$(ps -o ppid= -p $$)
    local terminal=$(ps -o comm= -p $parent_pid | tail -n 1)
    echo "${terminal:-N/A}"
}

# Function to download information about Motherboard
get_motherboard() {
    local product_name=$(cat /sys/class/dmi/id/board_name 2>/dev/null)
    local manufacturer=$(cat /sys/class/dmi/id/board_vendor 2>/dev/null)
    echo "${manufacturer:-N/A} - ${product_name:-N/A}"
}

# Function to download information about Screen
get_screen() {
    local screen=$(xrandr --listmonitors | grep '\*' | awk '{print $4}')
    echo "${screen:-N/A}"
}

# Function to download information about Shell
get_terminal() {
    local current_pid=$$
    while [ $current_pid -ne 1 ]; do
        local parent_pid=$(ps -o ppid= -p $current_pid)
        local terminal=$(ps -o comm= -p $parent_pid)

        case $terminal in
            gnome-terminal*|konsole|xterm|urxvt|alacritty|lxterminal|terminator|tilix)
                echo "$terminal"
                return
                ;;
        esac

        current_pid=$parent_pid
    done

    echo "Unknown"
}

# Function to download information about Resolution
get_resolution() {
    local resolution=$(xrandr | grep '*' | awk '{print $1}')
    echo "${resolution:-N/A}"
}

# Function to download information about Current User
get_current_user() {
    echo "$USER"
}

# Function to show ASCII LOGO
display_logo() {
    local logo_file="/usr/local/share/xenfetch/edit/logo.txt"
    if [ -f "$logo_file" ]; then
        cat "$logo_file"
    else
        echo "Logo file not found."
    fi
}

# Function to download UPTIME informations
get_uptime() {
    uptime -p
}

# Show informations about OS
display_info() {
    local info_file="/usr/local/share/xenfetch/edit/sysinfo.txt"
    if [ -f "$info_file" ]; then
        source "$info_file"
    else
        echo "System information file not found."
    fi
}

# Function call
display_logo
display_info
