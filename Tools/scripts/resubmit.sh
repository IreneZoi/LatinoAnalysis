#!/bin/bash

#from https://raw.githubusercontent.com/mpresill/PlotsConfigurations/master/Configurations/VBS_ZV/resubmit.sh
echo 'here'
#set -e 
# YEAR=NanoGardening__Summer16_102X_nAODv7_Full2016v7__MCCombJJLNu2016 #MCl1loose2016v7 MCCorr2016v7 MCCombJJLNu2016 
# YEAR=NanoGardening__Fall2017_102X_nAODv7_Full2017v7__MCCombJJLNu2017 #MCl1loose2017v7 MCCorr2017v7 MCCombJJLNu2017 
YEAR=NanoGardening__Autumn18_102X_nAODv7_Full2018v7__MCCombJJLNu2018  #MCl1loose2018v7 MCCorr2018v7 MCCombJJLNu2018 
# SAMPLES=(WmToLNu_WmTo2J_aQGC WpToLNu_WpTo2J_aQGC WpToLNu_WmTo2J_aQGC WpTo2J_WmToLNu_aQGC WmToLNu_ZTo2J_aQGC WpToLNu_ZTo2J_aQGC )
# 2016
# SAMPLES=(WpTo2J_WmToLNu_aQGC_eboliv2 WmToLNu_ZTo2J_aQGC_eboliv2 ) #( WmToLNu_WmTo2J_aQGC_eboliv2 WpToLNu_ZTo2J_aQGC_eboliv2 WpToLNu_WpTo2J_aQGC_eboliv2)
# 2017
# SAMPLES=(WmTo2J_ZTo2L_aQGC_eboliv2) # WpTo2J_WmToLNu_aQGC_eboliv2 WmToLNu_ZTo2J_aQGC_eboliv2 ) #ZTo2L_ZTo2J_aQGC_eboliv2 WpTo2J_ZTo2L_aQGC_eboliv2 WmToLNu_WmTo2J_aQGC_eboliv2 WpToLNu_ZTo2J_aQGC_eboliv2 WpToLNu_WpTo2J_aQGC_eboliv2)
# 2018
# SAMPLES=( WmToLNu_WmTo2J_aQGC_eboliv2 WmToLNu_ZTo2J_aQGC_eboliv2 WpToLNu_ZTo2J_aQGC_eboliv2 WpTo2J_ZTo2L_aQGC_eboliv2)
# SAMPLES=( WpToLNu_ZTo2J_aQGC_eboliv2 ) #WpTo2J_WmToLNu_aQGC_eboliv2 WpToLNu_WpTo2J_aQGC_eboliv2 WmToLNu_WmTo2J_aQGC_eboliv2 WmToLNu_ZTo2J_aQGC_eboliv2 WpToLNu_ZTo2J_aQGC_eboliv2 WpTo2J_ZTo2L_aQGC_eboliv2)

#SAMPLES=(WpToLNu_WpTo2J_aQGC_eboliv2_official) # ZZTo2L2Q_AMCNLOFXFX)
#SAMPLES=(WmToLNu_WmTo2J_aQGC_eboliv2_official  WpToLNu_WmTo2J_aQGC_eboliv2_official WpTo2J_WmToLNu_aQGC_eboliv2_official WmToLNu_ZTo2J_aQGC_eboliv2_official WpToLNu_ZTo2J_aQGC_eboliv2_official WpToLNu_WpTo2J_aQGC_eboliv2_official)
# SAMPLES=(WpToLNu_WmTo2J_aQGC_eboliv2_official WpTo2J_WmToLNu_aQGC_eboliv2_official WmToLNu_ZTo2J_aQGC_eboliv2_official WpToLNu_ZTo2J_aQGC_eboliv2_official WpToLNu_WpTo2J_aQGC_eboliv2_official WmToLNu_WmTo2J_aQGC_eboliv2_official)
SAMPLES=(WpToLNu_WmTo2J_aQGC_eboliv2_officialv2 WpTo2J_WmToLNu_aQGC_eboliv2_officialv2 WmToLNu_ZTo2J_aQGC_eboliv2_officialv2) # WpToLNu_ZTo2J_aQGC_eboliv2_officialv2 WpToLNu_WpTo2J_aQGC_eboliv2_officialv2 WmToLNu_WmTo2J_aQGC_eboliv2_officialv2)

# variations=(do up)
# uncertainties=(ElepT MupT MET JES  fatjetJES fatjetJER fatjetJMR fatjetJMS) 
# uncertainties=(ElepT MupT MET JES JER fatjetJES fatjetJER fatjetJMR fatjetJMS) #JER

DIR=$PWD
JOB=/afs/cern.ch/work/i/izoi/VBSanalysis/logs/jobs/

QUEUE="microcentury"
newQUEUE="longlunch"

# for unc in ${uncertainties[*]}
# do
#       echo ----- ${unc} ------
#       for variation in ${variations[*]}
#       do
#          echo ----- ${variation} ------
        for SAMPLE in ${SAMPLES[*]}
        do
            echo ${SAMPLE}

            # jobdir=${JOB}/${YEAR}_${unc}${variation}/${SAMPLE}
           jobdir=${JOB}/${YEAR}/${SAMPLE}
 
            echo ${jobdir}
            #sleep 5
            if [ ! -d ${jobdir} ] 
            then
                echo "Directory ${jobdir} DOES NOT exists." 
                break
                #exit 9999 # die with error code 9999
            fi
            
            cd ${jobdir}
            #sleep 10

            for i in ${jobdir}/*jid
            #for i in *jid
            do 
        	    CHECK=`echo "$i" | awk -F "/" '{print $NF}'`
                if [ ${CHECK} == "*jid" ]
                then
                    echo "CONGRATULATIONS!! ALL JOB FINISHED"
                    #sleep 5
                else    
        	        echo "sed -i \"s/${QUEUE}/${newQUEUE}/g\" ${i/jid/jds}"
        	        sed -i "s/${QUEUE}/${newQUEUE}/g" ${i/jid/jds}
        	        condor_submit ${i/jid/jds}
                    condor_q
                    #sleep 2
        	    fi
            done
        done
#      done # unc
# done #variations
cd $DIR
#sleep 2
