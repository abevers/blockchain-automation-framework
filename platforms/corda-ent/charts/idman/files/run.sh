#!/bin/sh

# main run
if [ -f {{ .Values.config.volume.baseDir }}/identitymanager.jar ]
then
    sha256sum {{ .Values.config.volume.baseDir }}/identitymanager.jar 
    cat etc/idman.conf
    echo
    echo "CENM: starting Identity Manager process ..."
    echo
    java -Xmx{{ .Values.cordaJar.memorySize }}{{ .Values.cordaJar.unit }} -jar {{ .Values.config.volume.baseDir }}/identitymanager.jar -f {{ .Values.config.configPath }}/idman.conf
    EXIT_CODE=${?}
else
    echo "Missing Identity Manager jar file in {{ .Valuesconfig.volume.baseDir }} folder:"
    ls -al {{ .Values.config.volume.baseDir }}
    EXIT_CODE=110
fi

if [ "${EXIT_CODE}" -ne "0" ]
then
    HOW_LONG={{ .Values.config.sleepTimeAfterError }}
    echo
    echo "exit code: ${EXIT_CODE} (error)"
    echo "Going to sleep for requested ${HOW_LONG} seconds to let you login and investigate."
fi
sleep ${HOW_LONG}
echo
