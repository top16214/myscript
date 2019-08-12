#!/bin/bash
# do some test on array

cap=(london beijing tokyo paris)

# iterate all array elements
for name in "${cap[@]}";do
    echo "$name"
done

# for syntax C-style
for((i=0;i<${#cap[@]};i++))
do
    echo "$i is ${cap[$i]}"
done

# get all not-null elements's index
echo -e "idx of not-null elements are: ${!cap[@]}"


# Split string into an array
string="london:beijing:tokyo:paris"
IFS=':' read -r -a array <<< "$string"
printf "string has %d elements.\nThey'ar %s" ${#array[@]} "${array[*]}"
echo
