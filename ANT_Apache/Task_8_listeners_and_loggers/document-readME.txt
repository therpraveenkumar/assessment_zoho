8. Listeners & Loggers

1. run below command on cmd prompt

COMMAND: ant -logger org.apache.tools.ant.XmlLogger -verbose -logfile build_log.xml

you can find build_log.xml file in your build.xml folder itself

2. run below command for listener

COMMAND: ant -logger org.apache.tools.ant.listener.ProfileLogger