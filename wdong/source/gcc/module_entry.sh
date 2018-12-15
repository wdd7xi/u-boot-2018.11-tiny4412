
#################################################################
#
# Variable Settings in this Module
#
#################################################################
basename $1 2> /dev/null 
if [ $? -ne 0 ] || [ "gcc" != `basename $1` ]; then 
    echo "ERROR: gcc != \$1!!!"
    return ; ### exit
fi

SCRIPT_DIRNAME=$1
PARENT_DIRNAME=`basename $1`
SCRIPT_OPTIONS=$2
SCRIPT_OPTIONS=${PARENT_DIRNAME}  ### Force!!! Initialize this module

echo "The directory of this file is(dirname): ${SCRIPT_DIRNAME}"
echo "${PARENT_DIRNAME}"
echo "\`pwd\`: `pwd`"
echo "TOP_PWD:$TOP_PWD"


GCC_NAME_PREFIX=gcc-linaro-7.3.1-2018.05-x86_64_


#################################################################
#
# Function Definition of this Module
#
#################################################################
function download_gcc() 
{
  cd ${SCRIPT_DIRNAME}
  #echo "PWD:$PWD  OLDPWD:$OLDPWD"
  echo "download!!!"
  if [ -e ${GCC_NAME_PREFIX}arm-linux-gnueabihf.tar.xz ]
  then 
    echo ${GCC_NAME_PREFIX}arm-linux-gnueabihf.tar.xz exist
  else 
    echo downloading
    wget https://releases.linaro.org/components/toolchain/binaries/7.3-2018.05/arm-linux-gnueabihf/gcc-linaro-7.3.1-2018.05-x86_64_arm-linux-gnueabihf.tar.xz 
  fi

  if [ -e ${GCC_NAME_PREFIX}arm-linux-gnueabihf ]
  then 
    echo ${GCC_NAME_PREFIX}arm-linux-gnueabihf exist
  else 
    xz -dk ${GCC_NAME_PREFIX}arm-linux-gnueabihf.tar.xz 
    tar xf ${GCC_NAME_PREFIX}arm-linux-gnueabihf.tar 
    rm -rf ${GCC_NAME_PREFIX}arm-linux-gnueabihf.tar 
    #cp -rf ${GCC_NAME_PREFIX}arm-linux-gnueabihf/bin/* /usr/local/bin/ 
  fi

  cd $OLDPWD
  return 0;
}

function environment_variable_cfg_gcc() 
{
  echo "environment_variable_cfg!!!"
  #vim ~/.bashrc;  source ~/.bashrc 
  env | grep ${GCC_NAME_PREFIX}
  if [ $? -eq 1 ]
  then 
    export PATH="${TOP_PWD}/${SCRIPT_DIRNAME}/${GCC_NAME_PREFIX}arm-linux-gnueabihf/bin:$PATH" 
  else
    echo "env PATH Configured!!!"
  fi
  #export PATH="/home/disk3/wangdong/tiny4412/porting/wdong/source/gcc-linaro-7.3.1-2018.05-x86_64_arm-linux-gnueabihf/bin:$PATH"
  #arm-linux-gnueabihf-gcc -v
  #env | grep PATH
}

function prepare_gcc()
{
  echo "prepare!!!"
  #apt-get -y install git
}

function clean_files_gcc()
{
  echo "clean_files!!!"
  #rm -r source/${GCC_NAME_PREFIX}arm-linux-gnueabihf
}








#################################################################
#
# function call
#
#################################################################
if [ -n "${SCRIPT_OPTIONS}" ]; then
    case ${SCRIPT_OPTIONS} in
        ${PARENT_DIRNAME}) ### Initialize this module
            echo "${PARENT_DIRNAME}"
            download_${PARENT_DIRNAME}
            environment_variable_cfg_${PARENT_DIRNAME}
            #exit
            #prepare_${PARENT_DIRNAME}
            clean_files_${PARENT_DIRNAME}
            ;;   
        setup)
            echo "setup"
            ;;   
        clean)
            echo "clean"
            ;;   
        *)   
            echo "WARNING: Default Processing"
            ;;   
    esac 
fi

echo "including ${SCRIPT_DIRNAME}/module_entry.sh Done!!!"
unset SCRIPT_DIRNAME
unset PARENT_DIRNAME
unset SCRIPT_OPTIONS
echo

