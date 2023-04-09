# Directory File Manager

This Bash script allows you to add or remove files in a directory and its subdirectories, except for excluded directories. It is useful for managing files in large directory structures when you want to add or remove files in multiple subdirectories at once. The script uses the "rsync" command to add files and the "rm" command to remove files. It also supports verbose mode to show details of each action.

## Usage

### Running the script

Before running the script for the first time, you need to make it executable using the following command:

```
chmod +x script.sh
```

To use the script, run the following command:

```
./script.sh [OPTIONS] <ROOT_PATH>
```

Replace `[OPTIONS]` with any of the available options for the script, such as:

- `-r`: Add or remove files to/from the root directory.
- `-e <EXCLUDED_DIR>`: Exclude a directory and its subdirectories from being modified.
- `-f <FILE>`: Specify a file to add or remove. Can be specified multiple times.
- `-d`: Remove files instead of adding them.
- `-v`: Verbose mode: show details of each action.

Replace `<ROOT_PATH>` with the root path of the directory you want to modify.

### Using the script globally

To add a command "dfm" to execute your script, you can create an alias for your script in your bash profile or add it to your system's PATH. Here's an example of how to add an alias for your script:

1. Open your bash profile in a text editor. On Linux and macOS, the file is usually located at `~/.bashrc` or `~/.bash_profile`.

2. Add the following line to the file:

   ```
   alias dfm='/path/to/your/script.sh'
   ```

   Replace `/path/to/your/script.sh` with the actual path to your script.

3. Save the file and exit the text editor.

4. Reload your bash profile by running `source ~/.bashrc` or `source ~/.bash_profile`, depending on which file you edited.

After you've added the alias, you can use the command `dfm` followed by the options you want to pass to your script. For example:

```
dfm -f example.txt -e excluded my_directory
``` 

This will run the script with the options `-f example.txt -e excluded` and the root path `my_directory`.

## Examples

### Add a file to all subdirectories

The following command adds the file "example.txt" to all subdirectories of the directory "my_directory", except for the directory "my_directory/excluded":

```
./script.sh -f example.txt -e excluded my_directory
```

### Remove a file from all subdirectories

The following command removes the file "example.txt" from all subdirectories of the directory "my_directory", except for the directory "my_directory/excluded":

```
./script.sh -f example.txt -e excluded -d my_directory
```

### Add a file to the root directory

The following command adds the file "example.txt" to the root directory "my_directory":

```
./script.sh -r -f example.txt my_directory
```

### Remove a file from the root directory

The following command removes the file "example.txt" from the root directory "my_directory":

```
./script.sh -r -f example.txt -d my_directory
```

## License

This script is open source and is available under the [MIT license](LICENSE).

## Contributing

Contributions to this script are welcome. Feel free to submit a pull request or open an issue if you have any suggestions or bug reports.

## Credits

This script was created by [Anwer Awled Belhedi](https://github.com/belhedianwer).
