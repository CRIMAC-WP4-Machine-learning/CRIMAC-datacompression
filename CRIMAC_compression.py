import argparse
import os
import shutil
import subprocess
from pathlib import Path


def copy_file_if_exists(filename, source_dir='/datain', dest_dir='/scratch'):
    source_file = Path(source_dir) / filename
    destination_file = Path(dest_dir) / filename
    # Check if the source file exists
    if source_file.exists():
        # Copy the file if it exists
        shutil.copy(source_file, destination_file)
        print(f'File "{filename}" copied successfully from "{source_dir}"')
    else:
        print(f'File "{filename}" does not exist in "{source_dir}".')

def delete_target_file_if_exists(filename, dest_dir='/dataout'):
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

# Print environment variables
print('CRIMAC-datacompression')
commit_sha = os.getenv('COMMIT_SHA')
if commit_sha:
    print(f'commit_sha: {commit_sha}')
version_number = os.getenv('VERSION_NUMBER')
if version_number:
    print(f'version_number: {version_number}')
# Set up argument parser

lsss_version = os.getenv('LSSS_VERSION')
if lsss_version:
    print(f'LSSS_version: {lsss_version}')

parser = argparse.ArgumentParser(description='Process a single file with Korona')
parser.add_argument('--filename', required=True, type=str, help='Name of the file to process')
args = parser.parse_args()

# Create a copy of the input file in the scratch directory
print('Copying files for procesing inside the container:')
copy_file_if_exists(args.filename)
copy_file_if_exists(args.filename.split('.')[0]+'.idx')
copy_file_if_exists(args.filename.split('.')[0]+'.bot')

# Delete the output files if they already exists
print('Delete output files if they already exist:')
delete_target_file_if_exists(args.filename)
delete_target_file_if_exists(args.filename.split('.')[0]+'.idx')
delete_target_file_if_exists(args.filename.split('.')[0]+'.bot')

# Run korona on the single file
cmdstr = ['/lsss-3.1.0-rc1/korona/KoronaCli.sh',
          'batch',
          '--cfs', '/app/compression.cfs',
          '--destination', '/dataout',
          '--source', '/scratch']
print(cmdstr)
subprocess.run(cmdstr, check=True)
