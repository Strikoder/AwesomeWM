# AwesomeWM Minimal Setup
Welcome to my AwesomeWM configuration repository! This setup is tailored for a dual-monitor setup and includes a range of gadgets that enhance the AwesomeWM experience. 
I've recently transitioned to using Linux and Neovim (big thanks to ThePrimeagen! ❤️). So plz do not judge me, as I'm still exploring and learning :3

## Getting Started
To use this configuration:

0. Install awesomeWM!

1. **Create the Awesome Directory**:
   - Run the following command to create the `awesome` directory in your `.config` directory, if it doesn't already exist:
     ```bash
     mkdir -p ~/.config/awesome
     ```

2. **Clone the Repository**:
   - Change into the newly created `awesome` directory:
     ```bash
     cd ~/.config/awesome
     ```
   - Clone the repository directly into this directory:
     ```bash
     git clone https://github.com/Strikoder/AwesomeWM .
     ```

## Configuration Details

This setup is designed for a dual-monitor arrangement:

- **Primary Monitor**: Vertical 1600x2560
- **Secondary Monitor**: Horizontal 1920x1080

**Note for Single Monitor Users**: If you're using a single monitor, you'll need to edit and omit certain parts of the configuration. Look for comments marked with `---- 2 monitor` to identify these sections.

## Required Packages

For the full experience, install the following packages:

``` bash
sudo apt install neofetch htop cmatrix neovim maim
```
