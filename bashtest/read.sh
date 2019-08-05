# read [-ers] [-a array] [-d delim] [-i text] [-n nchars] [-N nchars]
#      [-p prompt] [-t timeout] [-u fd] [name ...] [name2 ...]

# read assigns the first word it finds to name, the second word to name2, etc. If there are more words than names, all remaining words are assigned to the last name specified. If only a single name is specified, the entire line is assigned to that variable.
# If no name is specified, the input is stored in a variable named REPLY.


# IFS= (with nothing after the equals sign) sets the internal field separator to "no value". Spaces, tabs, and newlines are therefore considered part of a word, which will preserve white space in the file names.
# Note that IFS= comes after while, ensuring that IFS is altered only inside the while loop. 
while IFS= read -r -d $'\0' file; do
  echo "$file"
done < <(find . -print0)


# echo "one two three four" | while read word1 word2 word3; do
#   echo "word1: $word1"
#   echo "word2: $word2"
#   echo "word3: $word3"
# done

# echo "one two three four" | while read -a wordarray; do
#   echo ${wordarray[1]}
# done

# while read -ep "Type something: " -i "My text is " text; do 
#   echo "$text";
# done