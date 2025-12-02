#!/usr/bin/env bash

content=$(<input.txt)

IFS=',' read -r -a fields <<<"$content"

length=${#fields[@]}
invalid=()

for ((i = 0; i < length; i++)); do
  IFS='-' read -r start end <<<${fields[$i]}
  for ((j = start; j <= end; j++)); do
    #echo "$j"
    len=${#j}
    if ((len % 2 == 0)); then
      half=$((len / 2))
      part1=${j:0:half}
      part2=${j:half}
      #echo "left: $part1"
      #echo "right: $part2"
      if [[ "$part1" == "$part2" ]]; then
        invalid+=($j)
      fi
    fi
  done
done

sum=0
for i in "${invalid[@]}"; do
  sum=$((sum + i))
done

echo $sum
