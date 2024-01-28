# AwesomeWM Minimal Setup

<div align=center>

<a href="https://awesomewm.org/"><img alt="AwesomeWM Logo" height="150" src="https://upload.wikimedia.org/wikipedia/commons/0/07/Awesome_logo.svg"></a>

<div align="center">
    <img src ="https://img.shields.io/badge/Awesome-WM-blue?style=for-the-badge&logo=lua&logoColor=red&color=red"/>
    <img src ="https://img.shields.io/badge/Ubuntu-22.02-green?style=for-the-badge&logo=Ubuntu&logoColor=red&color=blue"/>
</div>


Welcome to my AwesomeWM configuration repository! This setup is tailored for a dual-monitor setup and includes a range of gadgets that enhance the AwesomeWM experience. 
I've recently transitioned to using Linux and Neovim (big thanks to ThePrimeagen! ❤️). So plz do not judge me, as I'm still exploring and learning :3


Horizontal monitor

![Horizontal monitor](https://github.com/Strikoder/CoolsomeWM/blob/main/Screenshots/FirstMonitor.png?raw=true)
![Horizontal monitor without blur](https://github.com/Strikoder/CoolsomeWM/blob/main/Screenshots/FirstMonitorWithoutBlur.png?raw=true)



Vertical monitor

![Vertical monitor](https://github.com/Strikoder/CoolsomeWM/blob/main/Screenshots/SecondMonitor.png?raw=true)

## Getting Started
Here's how you can set up my AwesomeWM configuration:

### 1. Installation of AwesomeWM
First, make sure you have AwesomeWM installed on your system.

### 2. Setting Up the Environment
- **Create the Awesome Directory**:
   - If it doesn't exist, create an `awesome` directory in your `.config` directory:
     ```bash
     mkdir -p ~/.config/awesome
     ```

- **Clone the Repository**:
   - Navigate to the `awesome` directory:
     ```bash
     cd ~/.config/awesome
     ```
   - Clone the repository here:
     ```bash
     git clone https://github.com/Strikoder/AwesomeWM
     ```

## Configuration Insights

This setup is optimized for the following monitor configuration:

- **Primary Monitor**: Vertical orientation (1600x2560)
- **Secondary Monitor**: Horizontal orientation (1920x1080)

**For Single Monitor Users**: Should you be using a single monitor setup, some tweaks are necessary. Look for comments tagged as `---- 2 monitor` in the configuration files for guidance on adjustments.


## Essential Packages

To fully enjoy this setup, ensure these packages are installed:

``` bash
sudo apt install neofetch htop cmatrix neovim maim
```

## Setting Up Zsh (Optional)
If you'd like to use my Zsh configuration:

### 1. Install Zsh and Oh My Zsh:
Follow the installation instructions for Zsh and Oh My Zsh.

### 2. Move the Zsh Configuration:
- **Place the .zshrc file in your home directory**:
  ```bash
  mv .zshrc /home/strikoder/.zshrc
  ```

## Note for Beginners: If you're new and find Zsh overwhelming, feel free to remove the .zshrc file after cloning the repository:
```bash
rm .zshrc
```
