# $Id$
#!/bin/sh
. ./setCommonEnv.sh
NOOFARGS=$#

displayUsage()
{
	echo "Usage:" 
	echo ".........................................................."
	echo " sh changeKey.sh <newECTag>"
	echo ".........................................................."
	exit 1
}

if [ ${NOOFARGS} -ne 1 -a ${NOOFARGS} -ne 0 ]; then
	echo "Invaild arguments"
	displayUsage
fi

JAVA_OPTS="-Dserver.home=$SERVER_HOME -Dapp.home=$SERVER_HOME -Ddb.home=$DB_HOME -Djava.library.path=$SERVER_HOME/lib/native -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Duser.language=en -Dfile.encoding=utf8 -Dorg.bouncycastle.fips.approved_only=true -Djava.security.properties=../conf/fips.security "

CLASS_PATH=$SERVER_HOME/lib:$SERVER_HOME/bin/run.jar:$SERVER_HOME/lib/tomcat/tomcat-juli.jar:$SERVER_HOME/lib/conf.jar:$SERVER_HOME/lib/fips/bc-fips-1.0.2.3.jar:$SERVER_HOME/lib/fips/bcpkix-fips-1.0.7.jar:$SERVER_HOME/lib/fips/bctls-fips-1.0.14.jar

$JAVA -cp $CLASS_PATH $JAVA_OPTS com.adventnet.mfw.ChangeECTag $1
