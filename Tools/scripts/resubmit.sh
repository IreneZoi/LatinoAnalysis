
#!/bin/bash

#from https://raw.githubusercontent.com/mpresill/PlotsConfigurations/master/Configurations/VBS_ZV/resubmit.sh

set -e 
#YEAR=NanoGardening__Summer16_102X_nAODv7_Full2016v7__MCl1loose2016v7
#YEAR=NanoGardening__Fall2017_102X_nAODv7_Full2017v7__MCl1loose2017v7
YEAR=NanoGardening__Autumn18_102X_nAODv7_Full2018v7__MCl1loose2018v7
#SAMPLES=(WmTo2L_WmTo2J_aQGC WpTo2L_WpTo2J_aQGC WpTo2L_WmTo2J_aQGC WpTo2J_WmTo2L_aQGC WmTo2L_ZTo2J_aQGC)
#SAMPLES=(WmTo2L_WmTo2J_aQGC  WpTo2J_WmTo2L_aQGC )


DIR=$PWD
JOB=/afs/cern.ch/work/i/izoi/VBSanalysis/logs/jobs/

QUEUE="microcentury"
newQUEUE="longlunch"

for SAMPLE in ${SAMPLES[*]}
do
    echo ${SAMPLE}
    sleep 2
    jobdir=${JOB}/${YEAR}/${SAMPLE}
    echo ${jobdir}
    sleep 5
    if [ ! -d ${jobdir} ] 
    then
        echo "Directory ${jobdir} DOES NOT exists." 
        exit 9999 # die with error code 9999
    fi
    cd ${jobdir}
    sleep 10

    for i in ${jobdir}/*jid
    #for i in *jid
    do 
	    CHECK=`echo "$i" | awk -F "/" '{print $NF}'`
        if [ ${CHECK} == "*jid" ]
        then
            echo "CONGRATULATIONS!! ALL JOB FINISHED"
            sleep 5
        else    
	        echo "sed -i \"s/${QUEUE}/${newQUEUE}/g\" ${i/jid/jds}"
	        sed -i "s/${QUEUE}/${newQUEUE}/g" ${i/jid/jds}
	        condor_submit ${i/jid/jds}
            condor_q
            sleep 2
	    fi
    done
done
cd $DIR
sleep 2
        



#for i in *jid; do sed -i "s/longlunch/microcentury/g" ${i/jid/jds}; condor_submit ${i/jid/jds}; done
