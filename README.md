# Directory File Manager

This Bash script allows you to add or remove files in a directory and its subdirectories, except for excluded directories. It is useful for managing files in large directory structures when you want to add or remove files in multiple subdirectories at once. The script uses the "rsync" command to add files and the "rm" command to remove files. It also supports verbose mode to show details of each action.

## Usage

To use the script, simply run the following command:

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

This script was created by [Your Name Here](https://github.com/yourname).
