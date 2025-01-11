import sys
import os

if __name__ == '__main__':
    file_path = sys.argv[1]
    new_path = file_path.split('.')[0] + '_new.pdf'
    os.system('ocrmypdf "' + file_path + '" "' + new_path + '"')
    os.system('sioyek "' + new_path + '"')
