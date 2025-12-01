def turn_left(value, amount):
    click = 0
    for i in range(0, amount):
        value -= 1
        if value == 0:
            click += 1
        if value < 0:
            value = 99

    if value == 0:
        click -=1

    return value, click

def turn_right(value, amount):
    click = 0
    for i in range(0, amount):
        value += 1
        if value > 99:
            click += 1
            value = 0

    if value == 0:
        click -=1

    return value, click

input = ""
with open("./input.txt") as f:
    input = f.read()

start = 50
pw = 0

for line in input.split('\n'):
    if len(line) == 0:
        continue

    clicks = 0
    direction = line[0]
    amount = line[1:]

    if direction == "L":
        start, clicks = turn_left(start, int(amount))
    else:
        start, clicks= turn_right(start, int(amount))

    if clicks > 0:
        pw += clicks

    if start == 0:
        pw += 1

    print(start, clicks, pw)

print(pw)
