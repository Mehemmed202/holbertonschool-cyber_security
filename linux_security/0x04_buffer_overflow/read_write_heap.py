#!/usr/bin/python3
import sys

def print_usage_and_exit():
    print("Usage: read_write_heap.py pid search_string replace_string")
    sys.exit(1)

def main():
    if len(sys.argv) != 4:
        print_usage_and_exit()

    pid = sys.argv[1]
    search_str = sys.argv[2]
    replace_str = sys.argv[3]

    if not pid.isdigit():
        print_usage_and_exit()

    pid = int(pid)
    
    maps_filename = f"/proc/{pid}/maps"
    mem_filename = f"/proc/{pid}/mem"
    
    heap_start = None
    heap_end = None

    try:
        with open(maps_filename, 'r') as f:
            for line in f:
                if "[heap]" in line:
                    parts = line.split()
                    addr_range = parts[0].split('-')
                    heap_start = int(addr_range[0], 16)
                    heap_end = int(addr_range[1], 16)
                    break
    except Exception as e:
        print(f"Xəta: maps faylı oxunmadı: {e}")
        sys.exit(1)

    if heap_start is None:
        print("Xəta: Prosesin heap sahəsi tapılmadı.")
        sys.exit(1)

    print(f"[*] Heap tapıldı: {hex(heap_start)} - {hex(heap_end)}")

    try:
        with open(mem_filename, 'rb+') as mem_file:
            mem_file.seek(heap_start)
            heap_content = mem_file.read(heap_end - heap_start)
            
            index = heap_content.find(search_str.encode('ascii'))
            
            if index == -1:
                print(f"Xəta: '{search_str}' tapılmadı.")
                sys.exit(1)
            
            print(f"[*] '{search_str}' tapıldı: {hex(heap_start + index)}")
            
            mem_file.seek(heap_start + index)
            mem_file.write(replace_str.encode('ascii') + b'\0') 
            
            print("[*] String əvəzləndi!")

    except PermissionError:
        print("Xəta: İcazə rədd edildi (sudo istifadə edin).")
        sys.exit(1)
    except Exception as e:
        print(f"Xəta: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
