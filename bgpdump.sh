# Set the root directory
root_directory="."

# Set the output directory
output_directory="updates_preprocessed"

# Find all .bz2 files in subdirectories starting with "updates"
find "$root_directory" -type d -name "updates*" -print0 | while IFS= read -r -d '' dir; do
    for file in "$dir"/*.bz2; do
        # Extract subdirectory name from the input directory
        subdirectory=$(basename "$dir")
        
        # Create corresponding subdirectory in the output directory
        output_subdirectory="$output_directory/$subdirectory"
        mkdir -p "$output_subdirectory"
        
        # Process the file and write output to the corresponding subdirectory
        output_file="$output_subdirectory/$(basename "$file" .bz2).txt"
        bgpdump -m -O "$output_file" "$file"
    done
done
