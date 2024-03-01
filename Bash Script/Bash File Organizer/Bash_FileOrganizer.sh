#!/usr/bin/bash



# Project: File Organizer
    # Bash script that organizes files in a specified directory based on their file types into separate subdirectories
    # Arguments: Directory path
    # Output: Create subdirectories based on the file extensions (e.g., "txt" for text files, "jpg" for image files).
    # Files with unknown or no file extensions should be placed in a "misc" subdirectory.
    # If a subdirectory for a particular file type already exists, the script should move the files into that existing directory.
    # The script should handle edge cases, such as files with no extensions or hidden files (those starting with a dot).


echo "----------- File Organizer ----------------"


#### Vaiable declarations

declare DIR_PATH=$1
declare FILEONLY
declare FILENAME
declare FILEEXTENSION

echo "Directory Path: $DIR_PATH"

# A function to make direcory for a specific extension and move files with these extensions to this directory

function MkDIrAndMoveFiles()
{
    mkdir -p "$DIR_PATH"/"$1"
    mv "$file" "$DIR_PATH"/"$1"
}


# A function to Iterate over files in the passed directory and organize them 
function OrganizeFiles()
{
    # Handle hidden files "$DIR_PATH"/.*"
    for file in "$DIR_PATH"/* "$DIR_PATH"/.*; do
        # First cut the file without the directory path
        FILEONLY=${file##*/}
        FILENAME=${FILEONLY%.*} # Extract file name
        FILEEXTENSION=${FILEONLY##*.} # Extract file extension

        # Skip if not a file
        if [ ! -f "$file" ]; then
            continue         
        fi

        # Skip .. and . files
        if [[ "${FILENAME}" == ".." || "${FILENAME}" == "." ]]; then
            continue
        fi

        # File has an extension
        if [[ "${FILENAME}" != "${FILEEXTENSION}" ]]; then
            # Handle unknown extension, assuming all other extensions are known
            if [[ "${FILEEXTENSION}" == "unknown" ]]; then
                # echo "File: ${FILENAME} has unknown extension"
                MkDIrAndMoveFiles misc
            else
                # File has a known extension    
                MkDIrAndMoveFiles "$FILEEXTENSION"
            fi
        else
            MkDIrAndMoveFiles misc
        fi
    done
}


function main() {
    OrganizeFiles
}



main













