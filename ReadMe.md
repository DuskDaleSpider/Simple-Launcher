# Simple Launcher with Powershell

This is a simple launcher application using a PowerShell script.

It is configurable via the Programs.JSON file in the same directory.
I have included a sample Programs.JSON as an example.

## Instructions

1. Place Launcher.ps1 and Programs.json in a directory
2. Edit Programs.json to add your applications to launch 
3. Create a Windows shortcut with this location (Replace <your_dir> with your path to Launcher.ps1): 
	* C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -noprofile -file "<your_dir>\Launcher.ps1" -PROGRAM_JSON_DIR "<your_dir>"
	* e.x. C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -noprofile -file "%onedrive%\Documents\Launcher\Launcher.ps1" -PROGRAM_JSON_DIR "%onedrive\Documents\Launcher\"
4. Start the shortcut

### Programs.json options
The Programs.json has a "Programs" array. This array contains objects with a few properties. 

* Title: This is the name that will show on it's button in the Launcher
* FilePath: This is a full path to the .exe or program executable
* ArgumentList: String of arguments or parameters for the executable
* IsSelected: Either true or false. If true, that program will already be selected to start when launcher opens.  