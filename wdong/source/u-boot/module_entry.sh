
#################################################################
#
# Variable Settings in this Module
#
#################################################################
basename $1 2> /dev/null 
if  [ $? -ne 0 ] || [ "u-boot" != `basename $1` ]; then 
    echo "ERROR: u-boot != \$1!!!"
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


export U_BOOT_VERSION=2018.11


#################################################################
#
# Function Definition of this Module
#
#################################################################
function download_u-boot() 
{
  cd ${SCRIPT_DIRNAME}
  #echo "PWD:$PWD  OLDPWD:$OLDPWD"
  echo "download!!!"

  if [ -e $TOP_PWD/u-boot-${U_BOOT_VERSION} ]
  then 
    echo u-boot-${U_BOOT_VERSION} exist
  else 
    if [ -e u-boot-${U_BOOT_VERSION}.tar.bz2 ]
      then 
        echo u-boot-${U_BOOT_VERSION}.tar.bz2 exist
      else 
        echo downloading
        wget http://ftp.denx.de/pub/u-boot/u-boot-${U_BOOT_VERSION}.tar.bz2
        if  [ $? -eq 0 ]; then 
          tar -jxf u-boot-${U_BOOT_VERSION}.tar.bz2 -C $TOP_PWD/
        else 
          echo "wget failed!!!"
        fi
    fi
  fi

  cd $OLDPWD
  return 0;
}

function environment_variable_cfg_u-boot() 
{
  echo "environment_variable_cfg!!!"

}

function prepare_u-boot()
{
  echo "prepare!!!"
  #apt-get -y install git
}

function clean_files_u-boot()
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

