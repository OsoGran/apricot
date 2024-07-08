# Apricot Roadmap and SW Dev Plan
## Software Requirements
### Signal Managment
1. The Signal Management functionality shall close the apricot file manager when a SIGINT is received.
2. The Signal Management functionality shall resize the file manager upon receiving a SIGWINCH signal.
3. The Signal Management functionality shall use the Zig standard library for signal handling

### Arguments
1. Running apricot with no arguments shall open the file explorer in the working directory
2. Running apricot with command line options --version or -v shall cause the program to immediately print the version to stdout and close.

### Navigation
1. When the navigate up key is pressed, the current selected file shall change to the file listed above it.
2. When the navigate down key is pressed, the current selected file shall change to the file listed below it.
3. When the navigate right key is pressed and the current selection is a file, apricot shall open the current selected file.
4. When the navigate right key is pressed and the current selection is a directory, apricot shall navigate to the selected child directory.
5. When the navigate left key is pressed apricot shall navigate to the parent directory.

### Vim Shortcuts
1. Vim shortcuts shall be hardcoded temporarily.

### Layout

### Previews

## Software Design
### main 
1. Calls init()
2. Call tui_init()
3. MORE

### init
1. sigemptyset
2. sigaddset
3. Set Locale to LC_ALL
4. Get uid
5. Get home directory of user
6. Set the shell
7. Set the editor
8. Get the cache directory path
9. Make the cache direcory
10. Set the path for the clipboard file
11. Set the path for the bookmarks file
12. Set the path for the scripts directory
13. Set the path for the temp clipboard file
14. Set the path for the trash
15. Set dir as current directory

## Desired Unimplemented Features
### Window Resizing
### Bookmarks
### Clipboard
### git Integration
### File Previews
### cli options
### Customizable rc file
