import argparse
import os
import shutil
import subprocess
from pathlib import Path

# Print environment variables
print('CRIMAC-datacompression')
commit_sha = os.getenv('COMMIT_SHA')
if commit_sha:
    print(f'commit_sha: {commit_sha}')
version_number = os.getenv('VERSION_NUMBER')
if version_number:
    print(f'version_number: {version_number}')

# Set up argument parser
parser = argparse.ArgumentParser(description='Process a single file with Korona')
parser.add_argument('--filename', required=True, type=str, help='Name of the file to process')
args = parser.parse_args()

# Create a copy of the input file in the scratch directory
filename = args.filename
idxname = filename.split('.')[0]+'.idx'
botname = filename.split('.')[0]+'.bot'
print(filename)
print(idxname)
print(botname)

shutil.copy(
    Path('/datain', filename), 
    Path('/scratch', filename)
    )

shutil.copy(
    Path('/datain', idxname), 
    Path('/scratch', idxname)
    )

shutil.copy(
    Path('/datain', botname), 
    Path('/scratch', botname)
    )

# Run korona on the single file
cmdstr = ['/lsss-3.0.0/korona/KoronaCli.sh',
          'batch',
          '--cfs', '/app/compression.cfs',
          '--destination', '/dataout',
          '--source', '/scratch']
print(cmdstr)
subprocess.run(cmdstr, check=True)
