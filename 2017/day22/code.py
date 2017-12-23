import time
import math
current_milli_time = lambda: int(round(time.time() * 1000))
start = current_milli_time()

inputdata=open("input.txt", 'r').read()

lines = inputdata.splitlines()

grid = {}
for i in range(len(lines)):
  for o in range(len(lines[i])):
    grid[(i,o)] = lines[i][o]

y = int(len(lines) / 2)
x = int(len(lines[1])/2)
d = 0
count = 0
for i in range(10000):
  if (y, x) not in grid.keys():
    grid[(y,x)] = "."
  if grid[(y, x)] == "#":
    grid[(y,x)] = "."
    d = d + 1
    if d == 4:
      d = 0
      y -= 1
    elif d == 3:
      x -= 1
    elif d == 2:
      y += 1
    elif d == 1:
      x += 1
  else:
    grid[(y,x)] = "#"
    d = d - 1
    if d == -1:
      d = 3
      x -= 1
    elif d == 0:
      y -= 1
    elif d == 1:
      x += 1
    elif d == 2:
      y += 1
    count += 1

print(count)

grid = {}
for i in range(len(lines)):
  for o in range(len(lines[i])):
    grid[(i,o)] = lines[i][o]

y = int(len(lines) / 2)
x = int(len(lines[1])/2)
d = 0
count = 0
for i in range(10000000):
  if (y, x) not in grid.keys():
    grid[(y,x)] = "."
  if grid[(y, x)] == "#":
    grid[(y,x)] = "F"
    d = d + 1
    if d == 4:
      d = 0
      y -= 1
    elif d == 3:
      x -= 1
    elif d == 2:
      y += 1
    elif d == 1:
      x += 1
  elif grid[(y,x)] == "F":
    grid[(y,x)] = "."
    d = d + 2
    if d == 2:
      y += 1
    elif d == 3:
      x -= 1
    elif d == 4:
      d = 0
      y -= 1
    elif d == 5:
      d = 1
      x += 1
  elif grid[(y,x)] == "W":
    grid[(y,x)] = "#"
    count += 1
    if d == 0:
      y -= 1
    elif d == 1:
      x += 1
    elif d == 2:
      y += 1
    elif d == 3:
      x -= 1
  else:
    grid[(y,x)] = "W"
    d = d - 1
    if d == -1:
      d = 3
      x -= 1
    elif d == 0:
      y -= 1
    elif d == 1:
      x += 1
    elif d == 2:
      y += 1

print(count)


print((current_milli_time() - start) / 1000.0)
