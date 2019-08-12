function func()
{
    local -n up_value=$1  # -n == nameref
    up_value=new_value
    echo "Changing '${!up_value}' in ${FUNCNAME[0]}"
}

aval=old_value
echo
echo "Before function call, aval is $aval"
func aval  # pass var *name* to func
echo "After function call, aval is $aval"