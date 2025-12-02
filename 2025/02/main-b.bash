#!/usr/bin/env bash

# 1111
# 121212
# 123123123

slide_me() {
  local input=$1
  local length=${#input}
  local max_length=$((length / 2))
  local valid=1
  local last=""

  for ((i = 1; i <= max_length; i++)); do
    for ((j = 0; j < length; j += i)); do
      if ((j + i <= length)); then
        echo -n "${input:j:i} "
      fi
    done
    echo -n ":"
  done
}

split_at_delimiter() {
  local input=$1
  IFS=':' read -r -a fields <<<"$input"
  local length=${#fields[@]}
  for ((i = 0; i < length; i++)); do
    x="${fields[$i]}"
    echo "${x::-1}"
  done
}

read_out_file() {
  while IFS= read -r line; do
    IFS=' ' read -r -a fields <<<$line
    length=${#fields[@]}
    local tmp=""
    local invalid=0
    for ((i = 0; i < length; i++)); do
      echo "${fields[$i]}"
      if ! [[ "$tmp" == "${fields[$i]}" ]] && [[ "$i" != 0 ]]; then
        echo $i
        invalid=1
      fi
      tmp="${fields[$i]}"
    done
    echo "done"
    if [[ "$invalid" == 0 ]]; then
      echo "-1"
    else
      echo "1"
    fi
  done <out.txt
}

#test="11111111"
#test2="123123"
#test3="12312352"
#a=$(slide_me "$test2")
#echo $a
#split_at_delimiter "$a" >out.txt
##ed -s out.txt <<<$'1d\nw\nq'
#read_out_file
#exit

content=$(<input-test-2.txt)

IFS=',' read -r -a fields <<<"$content"

length=${#fields[@]}
invalid=()
iter=0

for ((i = 0; i < length; i++)); do
  echo "i: $i"
  IFS='-' read -r start end <<<${fields[$i]}
  for ((j = start; j <= end; j++)); do
    echo "iter: $iter"
    iter=$((iter + 1))
    not_valid=$(slide_me $j)
    s=$(slide_me "${fields[$j]}")
    split_at_delimiter "$s" >out.txt
    exit
    valid=$(read_out_file)
    if ((valid == 0)); then
      invalid+=($j)
    fi
  done
done

sum=0
for i in "${invalid[@]}"; do
  sum=$((sum + i))
done

echo $sum
