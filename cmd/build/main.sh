file=$1
[[ -f $file && ! -z $file ]]
name=${file%.*} ext=${file##*.}
case $ext in
py)
    mkdir __tmp__
    for v in $( ls | grep -v __tmp__ ); do cp -r $v __tmp__; done
    cd __tmp__
    pkgs="pkg_resources.py2_warn"
    for pkg in $pkgs; do import_opt="$import_opt --hidden-import $pkg"; done
    shs run pyinstaller --onefile $import_opt $file
    mv dist/$name ../$name
    cd ..
    rm -r __tmp__
;;
cpp)
    shs run g++ $( ls *.cpp )
    mv a.out $name
;;
esac
