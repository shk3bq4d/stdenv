#!/bin/python3
import time

blocks = []
block_size = 10 * 1024 * 1024  # 10MB per block
max_memory = 3000 * 1024 * 1024  # Max 500MB
interval = 1  # seconds

while sum(len(b) for b in blocks) < max_memory:
    blocks.append(bytearray(block_size))
    print(f"Allocated {len(blocks) * block_size / 1024 / 1024:.0f} MB")
    time.sleep(interval)

print(f"done, sleeping forever")

while True:
    time.sleep(interval)
