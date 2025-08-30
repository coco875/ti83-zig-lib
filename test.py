import os
import shutil
import subprocess

out_dir = "output_headers"

def cleanup_output_directory():
    if os.path.exists(out_dir):
        shutil.rmtree(out_dir)
    os.makedirs(out_dir)

def convert_to_zig(filename) -> bool:
    output = os.path.join(out_dir, os.path.basename(filename) + ".zig")
    os.makedirs(os.path.dirname(output), exist_ok=True)
    cmd = ["zig", "translate-c", filename, "-Iinclude", "-target", "avr-freestanding-eabi"]
    p = subprocess.run(cmd, stdout=subprocess.PIPE)
    if p.returncode != 0:
        return False
    with open(output, "wb") as f:
        f.write(p.stdout)
    return True

def convert_cpp_to_zig(filename) -> bool:
    output = os.path.join(out_dir, os.path.basename(filename) + ".zig")
    os.makedirs(os.path.dirname(output), exist_ok=True)
    cmd = ["zig", "translate-c", filename, "-Iinclude/c++"]
    p = subprocess.run(cmd, stdout=subprocess.PIPE)
    if p.returncode != 0:
        return False
    with open(output, "wb") as f:
        f.write(p.stdout)
    return True

def list_headers(directory):
    headers = []
    for root, dirs, files in os.walk(directory):
        for filename in files:
            if filename.endswith(".h"):
                headers.append(os.path.join(root, filename))
    return headers

cleanup_output_directory()

for header in list_headers("include"):
    if "c++" in header:
        print(f"Skipping {header} (C++ header)")
        continue
    print(f"Converting {header}")
    if not convert_to_zig(header):
        print(f"Failed to convert {header}")
        exit(1)
    else:
        print(f"Converted {header} to Zig")

for header in list_headers("include/c++"):
    print(f"Converting C++ {header}")
    if not convert_cpp_to_zig(header):
        print(f"Failed to convert {header}")
        exit(1)
    else:
        print(f"Converted {header} to Zig")