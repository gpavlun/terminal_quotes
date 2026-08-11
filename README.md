# Dependencies
For this program to work, you need to have python3 installed on your computer,
and any unix-like shell.  
# Setup
Download the program.  This can be done by clicking the `code` button followed
by `download zip`.  
Then, move the zip file to your preferred location and unzip it.  
Run either `./installer.sh` or `sh installer.sh`.
This will create a shortcut in `~/.local/bin` to the quote generator,
and modify `.bashrc`, `.zshrc`, `.config/fish/config.fish`, or `.profile`
to run the generator whenever you open a terminal (depending on which shell
you are using).  
If `get_quotes` doesn't run automatically, 
ensure `~/.local/bin` is in your system `$PATH` environment variable.  


# Updating
If you add quotes to `quotes.txt` (one per line), you will need to go to the 
folder where these files are and run `python3 update_indices.py`, or the
generator will not be able to find or use the new quotes.  

# Uninstalling
If you wish to uninstall the program, run `uninstaller.sh`.  It will undo
the setup done by `installer.sh`, and then give you the option to delete the
folder containing the programs.  
Please note that if you elect to delete this folder, you might end up in a
folder which no longer exists, causing errors if you attempt to run certain
commands.  If this happens, I recommend running `cd` to return to your home
folder.  

## sources for quotes
Public-domain quotes largely sourced from Project Gutenberg (gutenberg.org)
