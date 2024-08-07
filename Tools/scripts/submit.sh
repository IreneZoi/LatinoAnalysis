#!/bin/bash

# YEAR=Autumn18_102X_nAODv7_Full2018v7
# ISTEP=MCl1loose2018v7__MCCorr2018v7
# OSTEP=MCCombJJLNu2018
# YEAR=Fall2017_102X_nAODv7_Full2017v7
# ISTEP=MCl1loose2017v7__MCCorr2017v7
# OSTEP=MCCombJJLNu2017
YEAR=Summer16_102X_nAODv7_Full2016v7
ISTEP=MCl1loose2016v7__MCCorr2016v7
OSTEP=MCCombJJLNu2016
# YEAR=NanoGardening__Autumn18_102X_nAODv7_Full2018v7__MCCorr2018v7 #_METdo #MupTup #ElepTdo #MCCorr2018v7 #MCl1loose2018v7
# SAMPLES=(WmToLNu_WmTo2J_aQGC WpToLNu_WpTo2J_aQGC WpToLNu_WmTo2J_aQGC WpTo2J_WmToLNu_aQGC WmToLNu_ZTo2J_aQGC WpToLNu_ZTo2J_aQGC )
# 2016
# SAMPLES=(WpTo2J_WmToLNu_aQGC_eboliv2 WmToLNu_ZTo2J_aQGC_eboliv2 ) #( WmToLNu_WmTo2J_aQGC_eboliv2 WpToLNu_ZTo2J_aQGC_eboliv2 WpToLNu_WpTo2J_aQGC_eboliv2)
# 2017
# SAMPLES=WpTo2J_WmToLNu_aQGC_eboliv2,WmToLNu_ZTo2J_aQGC_eboliv2 #ZTo2L_ZTo2J_aQGC_eboliv2 WpTo2J_ZTo2L_aQGC_eboliv2 WmToLNu_WmTo2J_aQGC_eboliv2 WpToLNu_ZTo2J_aQGC_eboliv2 WpToLNu_WpTo2J_aQGC_eboliv2)
# 2018
# SAMPLES=( WpTo2J_WmToLNu_aQGC_eboliv2 WpToLNu_WpTo2J_aQGC_eboliv2 WmToLNu_WmTo2J_aQGC_eboliv2 WmToLNu_ZTo2J_aQGC_eboliv2 WpToLNu_ZTo2J_aQGC_eboliv2 WpTo2J_ZTo2L_aQGC_eboliv2)
# SAMPLES=(WpToLNu_WpTo2J_aQGC_eboliv2 ) #WmToLNu_WmTo2J_aQGC_eboliv2 WmToLNu_ZTo2J_aQGC_eboliv2 WpToLNu_ZTo2J_aQGC_eboliv2 WpTo2J_ZTo2L_aQGC_eboliv2)
# SAMPLES=(WmToLNu_WmTo2J_aQGC_eboliv2_official  ) # ZZTo2L2Q_AMCNLOFXFX) # WmToLNu_WmTo2J_aQGC_eboliv2 WmToLNu_ZTo2J_aQGC_eboliv2 WpToLNu_ZTo2J_aQGC_eboliv2 WpTo2J_ZTo2L_aQGC_eboliv2)
SAMPLES=(WpToLNu_WpTo2J_aQGC_eboliv2_official WpToLNu_WpTo2J_aQGC_eboliv2_official WpToLNu_WmTo2J_aQGC_eboliv2_official WpTo2J_WmToLNu_aQGC_eboliv2_official WmToLNu_ZTo2J_aQGC_eboliv2_official WpToLNu_ZTo2J_aQGC_eboliv2_official)
#SAMPLES=(WpToLNu_WpTo2J_aQGC_eboliv2_official WmToLNu_WmTo2J_aQGC_eboliv2_official WpToLNu_WpTo2J_aQGC_eboliv2_official WpToLNu_WmTo2J_aQGC_eboliv2_official WpTo2J_WmToLNu_aQGC_eboliv2_official WmToLNu_ZTo2J_aQGC_eboliv2_official WpToLNu_ZTo2J_aQGC_eboliv2_official)

variations=(do up) # do)
# uncertainties=( fatjetJMS) #JER
# uncertainties=(fatjetJMS) #JER
# uncertainties=(ElepT MupT MET JES fatjetJES fatjetJER fatjetJMR fatjetJMS)
# uncertainties=(  fatjetJMR fatjetJMS)
uncertainties=(ElepT MupT MET JES JER fatjetJES fatjetJER fatjetJMR fatjetJMS) #JER
# uncertainties=(fatjetJMS) #JER

DIR=$PWD
JOB=/afs/cern.ch/work/i/izoi/VBSanalysis/logs/jobs/

for unc in ${uncertainties[*]}
do
    echo ----- ${unc} ------
    for variation in ${variations[*]}
    do
        echo ----- ${variation} ------
        for SAMPLE in ${SAMPLES[*]}
        do
            echo ${SAMPLE}

            mkPostProc.py -p ${YEAR} -i ${ISTEP}  -s  ${OSTEP}_${unc}${variation} -b -Q workday   -T ${SAMPLE}
        done
    done
done
cd $DIR
