#!/usr/bin/python3
"""
Module that finds and replaces a string in the heap of a running process
"""

import sys


def main():
    """
    Locates a string in the heap of a process and replaces it
    """
    if len(sys.argv) != 4:
        sys.stderr.write("Usage: read_write_heap.py pid search replace\n")
        sys.exit(1)

    pid = sys.argv[1]
    search_str = sys.argv[2]
    replace_str = sys.argv[3]

    if search_str == "":
        return

    try:
        with open(f"/proc/{pid}/maps", "r") as maps_file:
            for line in maps_file:
                if "[heap]" in line:
                    fields = line.split()
                    addr_range = fields[0].split('-')
                    start = int(addr_range[0], 16)
                    end = int(addr_range[1], 16)
                    break
            else:
                sys.stderr.write("Error: Heap not found\n")
                sys.exit(1)

        with open(f"/proc/{pid}/mem", "rb+") as mem_file:
            mem_file.seek(start)
            heap_data = mem_file.read(end - start)

            try:
                index = heap_data.index(search_str.encode('ascii'))
            except ValueError:
                sys.stderr.write(f"Error: {search_str} not found\n")
                sys.exit(1)

            mem_file.seek(start + index)
            mem_file.write(replace_str.encode('ascii'))
            
            if len(replace_str) < len(search_str):
                mem_file.write(b'\0')

    except Exception:
        sys.exit(1)


if __name__ == "__main__":
    main()
