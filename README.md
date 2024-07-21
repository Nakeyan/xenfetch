# XenFetch

XenFetch is a lightweight and customizable tool to display system information in the terminal with an ASCII logo.

## Features

- Displays detailed system information
- Customizable ASCII logos
- Supports various Linux distributions

## Needed packages
- coreutils
- glib2
- xorg-xrandr

## Usage

After installation, you can run XenFetch by simply typing:

xenfetch

## Customization

You can customize the displayed ASCII logo and system information by editing the configuration files located in /usr/local/bin/edit.

## Example Output

Here is an example of what the output might look like:

[Example](https://imgur.com/a/T0cMa7V)

---

## Tutorial

### Step-by-Step Guide

1. **Download the Installer**

   Download the install script using wget:

   wget https://github.com/Nakeyan/xenfetch/releases/download/install/install.sh

2. **Make the Script Executable**

   Change the permissions of the script to make it executable:

   chmod +x install.sh 

3. **Run the Installer**

   Run the install script to set up XenFetch:

   ./install.sh

4. **Run XenFetch**

   After installation, you can display your system information by running:

   xenfetch

### Customizing XenFetch

1. **Locate Configuration Files**

   The configuration files for customization are located in:

   /usr/local/bin/edit

2. **Edit logo.txt**

   Modify the logo.txt file to change the ASCII logo displayed by XenFetch.

3. **Edit sysinfo.txt**

   Modify the sysinfo.txt file to customize the system information output.


## Contributing

Feel free to submit issues and pull requests. Contributions are welcome!

## License

This project is licensed under the MIT License.
