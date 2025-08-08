import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path

# Set default paths for input and output directories
datain_path = os.getenv('DATAIN_PATH', '/datain')
dataout_path = os.getenv('DATAOUT_PATH', '/dataout')

def copy_file_if_exists(filename, source_dir=datain_path, dest_dir='/scratch'):
    source_file = Path(source_dir) / filename
    destination_file = Path(dest_dir) / filename
    # Check if the source file exists
    if source_file.exists():
        # Copy the file if it exists
        shutil.copy(source_file, destination_file)
        print(f'File "{filename}" copied successfully from "{source_dir}"')
    else:
        print(f'File "{filename}" does not exist in "{source_dir}".')

def delete_target_file_if_exists(filename, dest_dir=dataout_path):
    main_filename, extension = os.path.splitext(filename)
    filename = main_filename+'-korona'+extension
    target_file = Path(dest_dir) / filename
    # Check if the target file exists
    if target_file.exists():
        # Copy the file if it exists
        os.remove(target_file)
        print(f'File "{target_file}" deleted successfully from "{dest_dir}"')
    else:
        print(f'File "{target_file}" does not exist in "{dest_dir}".')

def _print_variables():
    """Prints environment variables for debugging purposes."""
    commit_sha = os.getenv('COMMIT_SHA')
    if commit_sha:
        print(f'commit_sha: {commit_sha}')
    version_number = os.getenv('VERSION_NUMBER')
    if version_number:
        print(f'version_number: {version_number}')
    lsss_version = os.getenv('LSSS_VERSION')
    if lsss_version:
        print(f'LSSS_version: {lsss_version}')
    print(f'datain_path: {datain_path}')
    print(f'dataout_path: {dataout_path}')

def main(filename: str = None):
    """Main function to execute the script."""
    print('CRIMAC - Data Compression', flush=True)

    # Print environment variables
    _print_variables()
    
    # Ensure that a filename is provided
    if not filename:
        raise ValueError('Filename must be provided as an argument.')
    
    # Print message
    print("\n> Preparing files for processing", flush=True)
    
    # Create a copy of the input file in the scratch directory
    print(f"\n{'#'*5} Copying files {'#'*5}", flush=True)
    copy_file_if_exists(filename)
    copy_file_if_exists(filename.split('.')[0]+'.idx')
    copy_file_if_exists(filename.split('.')[0]+'.bot')

    # Delete the output files if they already exists
    print(f"\n{'#'*5} Deleting output files if exists {'#'*5}", flush=True)
    delete_target_file_if_exists(filename)
    delete_target_file_if_exists(filename.split('.')[0]+'.idx')
    delete_target_file_if_exists(filename.split('.')[0]+'.bot')

    # Run korona on the single file
    korona_script = '/lsss-3.1.0-rc1/korona/KoronaCli.sh'
    
    # Check if the script exists
    if not os.path.exists(korona_script):
        raise FileNotFoundError(f"KoronaCli.sh not found at {korona_script}")
    
    # Always use shell=True for shell scripts in Alpine
    cmd = f"{korona_script} batch --cfs /app/compression.cfs --destination {dataout_path} --source /scratch"
    print(f"\n> Executing command\n$ {cmd}\n", flush=True)
    
    try:
        result = subprocess.run(cmd, shell=True, check=True, capture_output=True, text=True)
        print(result.stdout, flush=True)
        print(result.stderr, flush=True)
        sys.exit(result.returncode)
    except subprocess.CalledProcessError as e:
        print(e.stdout, flush=True)
        print(e.stderr, flush=True)
        sys.exit(e.returncode)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Process a single file with Korona')
    parser.add_argument('--filename', required=False, type=str, default=None, help='Name of the file to process')
    args = parser.parse_args()
    
    # Ensure that we have a valid filename either from the command line or set in environment variable
    filename = args.filename
    if not args.filename:
        # parent_dir = os.getenv('AWE_TRIGGERED_PARENT_DIR')
        filename = os.getenv('AWE_TRIGGERED_FILENAME')
    if not filename:
        raise ValueError('Filename must be provided either as a command line argument or set in the environment variable "AWE_TRIGGERED_FILENAME".')

    main(filename)
    
