import shutil
import os
from pathlib import Path
import subprocess

# Get env vars and write version to log file
file_name = os.getenv('FILE_NAME')
commit_sha = os.getenv('COMMIT_SHA')
version_number = os.getenv('VERSION_NUMBER')
print('CRIMAC-datacompression')
print('commit_sha: '+commit_sha)
print('version_number: '+version_number)

# Copy a single file to scratch disk  within the
# container (to only process a single file)
filein = Path('/datain', file_name)
filerun = Path('/scratch', file_name)
shutil.copy(filein, filerun)

# Run korona on the single file
cmdstr = ['/lsss-3.0.0/korona/KoronaCli.sh',
          'batch',
          '--cfs', '/app/compression.cfs',
          '--destination', '/dataout',
          '--source', '/scratch']

print(cmdstr)
subprocess.run(cmdstr, check=True)
