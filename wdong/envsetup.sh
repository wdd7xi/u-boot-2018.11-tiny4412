
function set_cross_compile_path() {
    if [ -n "WDONG_SET_CROSS_COMPILE_PATH" ]; then
      export CROSS_COMPILE_PATH=""
    fi

    if [ ! "$CROSS_COMPILE_PATH" ]; then
              export CROSS_COMPILE_PATH=/home/disk3/wangdong/tiny4412/porting/wdong/source/gcc-linaro-7.3.1-2018.05-x86_64_arm-linux-gnueabihf/bin

      export WDONG_SET_CROSS_COMPILE_PATH=true
    fi
    
}

#if [ "x$SHELL" != "x/bin/bash" ]; then
#    case `ps -o command -p $$` in
#        *bash*)
#            ;;
#        *)
#            echo "WARNING: Only bash is supported, use of other shell would lead to erroneous results"
#            ;;
#    esac
#fi

# Execute the contents of any module_entry.sh files we can find.
for f in `test -d wdong && find -L wdong -maxdepth 4 -name 'module_entry.sh' 2> /dev/null | sort` \
         `test -d other && find -L other -maxdepth 4 -name 'module_entry.sh' 2> /dev/null | sort`
do
    echo "including $f"
    . $f `dirname $f`
done
unset f

#set_cross_compile_path
#echo $PATH
#addcompletions
