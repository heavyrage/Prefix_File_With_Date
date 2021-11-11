# Prefix_File_With_Date
Powershell script for duplicating a file using the current date as prefix

This script can be used for duplicating files when working with different versions based on the date.
For example, if you are working with <code>filename.txt</code>, then the output result will be a copy of it with current date as the prefix.

<code>YYYYMMDD_filename.txt</code>

If *YYYYMMDD_filename.txt* already exists, then the output will be 

<code>YYYYMMDD_hhmm_filename.txt</code>

## Installation
1. First you need to copy the script in your USER folder **You need to create the "scripts" folder**

<code>%USERPROFILE%\scripts\prefix.ps1</code>

2. Open a terminal

<code>Start > Run... > cmd</code>

3. Under terminal, go to the installation folder, where you downloaded this project

<code>cd *"installation_folder"*</code>

4. Run the installation script **You need a privileged account for this**

<code>install_prefix_script.bat</code>


## Usage
In the Windows file explorer, simply right-click the file you want to duplicate and select **"Duplicate and prefix with current date..."**