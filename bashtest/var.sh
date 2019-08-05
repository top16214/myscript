#!/bin/bash
# test the scope of global and local variables

VAR="this is a global variable"
var="this is another global variable"

function one(){
    echo "$FUNCNAME is running"
    VAR="fixed in func one"
    local var="try to change the global variable from outside of func"      # local means it could not effect outside of func
    echo "inside func, VAR=$VAR"
    echo "inside func, var=$var"

    var3="created in func one"            # any variable not set "local" preceded, it is setted to 'global' by default.
    echo "inside func, var3=$var3"

}



function another(){
    echo "$FUNCNAME running..."
    echo "\$var3 from func one,var3=$var3"
    var3="changed in $FUNCNAME"         # var3 was defined in func one, var3 is global either, can be changed in any other func.
}


echo "before running func, two global variables are set to:"
echo 'VAR="this is a global variable"'
echo 'var="this is another global variable"'
echo
echo "Initial status..."
echo $VAR
echo $var
echo

one

echo
echo "After func one runned..."
echo "outside func, VAR=$VAR"       # the output demostrates the global VAR has been modified by the func
echo "outside func, var=$var"       # the output demostrates the global var has NOT been modified by the func
echo
echo "variable that no 'local' preceded in func still alives outside the func,var3=$var3"
echo

echo
echo "After func another runned..."
another
echo "outside func, var3=$var3"


# 总结：
# 1、函数里面，local申明的变量是局部变量，生命周期和作用范围只在本函数体；也不能被本函数外部访问；
# 2、凡是没有local申明的变量，默认是global变量，不管是在函数外，还是在函数内申明，都是全局变量；
# 3、除非执行了unset操作，全局变量的生命周期是整个脚本，作用域是全局。所以在funcA内申明的全局变量，在funcB内依然可以访问，修改
