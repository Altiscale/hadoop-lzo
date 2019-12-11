#!/bin/bash -l

# find this script and establish base directory
SCRIPT_DIR="$( dirname "${BASH_SOURCE[0]}" )"
cd "$SCRIPT_DIR" &> /dev/null
MY_DIR="$(pwd)"
echo "[INFO] Executing in ${MY_DIR}"

# PATH does not contain mvn in this login shell
export M2_HOME=/opt/mvn3
export JAVA_HOME=/opt/sapjvm_7
export PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH
DATE_STRING=`date +%Y%m%d%H%M%S`
ARTIFACT_VERSION=0.4.18-${DATE_STRING}

#------------------------------------------------------------------------------
#
#  ***** compile and package hadoop-lzo *****
#
#------------------------------------------------------------------------------

mvn versions:set -DnewVersion=0.4.18-${DATE_STRING}

if [ "$RUN_UNIT_TESTS" == "true" ]; then
  mvn clean package
else
  mvn clean package -DskipTests
fi

# fail-fast if maven build fails
if [[ "$?" -ne 0 ]] ; then
  echo 'Error compiling and packaging hadoop-lzo'; exit 1
fi

#---------------------------------------------------------------------------------------------
#  ***** exporting hadoop-lzo jar and native libraries required for hadoop packaging *****
#---------------------------------------------------------------------------------------------

ARTIFACT_DIR="$MY_DIR/hadoop-lzo-artifacts"
mkdir --mode=0755 -p ${ARTIFACT_DIR}

# exporting the ARTIFACT_VERSION in properties file to use when exporting the hadoop-lzo artifacts to nexus
echo "ARTIFACT_VERSION=${ARTIFACT_VERSION}" > ${ARTIFACT_DIR}/build.properties

#mv $MY_DIR/target/hadoop-lzo-[0-9]*.[0-9]*.[0-9]*-[0-9]*[0-9].jar $ARTIFACT_DIR/hadoop-lzo-${ARTIFACT_VERSION}.jar
#cd $MY_DIR/target/native/Linux-amd64-64/
#tar -czvf "$ARTIFACT_DIR/hadoop-lzo-libgplcompression-${ARTIFACT_VERSION}.tar.gz" lib/

#exit 0
