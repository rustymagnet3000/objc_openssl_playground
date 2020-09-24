#!./env/bin/python3
import os
from pathlib import Path

EXTENSIONS = {'Headers': 'h', 'Library': 'a'}

def check_files_present(path, ext):
    found_files = []
    for root, dirs, files in os.walk(path, topdown=False):
        for filename in files:
            if filename.endswith(ext):
                found_files.append(os.path.join(root, filename))
    return(len(found_files))


def main():
    print("[*] Checking for OpenSSL Header files and library files in project folder...")
    path = Path(os.getcwd())
    for k, v in EXTENSIONS.items():
        num = check_files_present(path.parent, v)
        if num > 0:
            print("\t[*] ", k, " found = ", num)
        else:
            print("[*] ", k, " NOT found")

if __name__ == "__main__":
    main()
