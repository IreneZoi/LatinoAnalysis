This branch is used for the private production of WV semileptonic aQGC samples. The NanoAODv7 were produced by Matteo and can be found in 

    /eos/cms/store/group/phys_smp/VJets_NLO_VBSanalyses/Samples/NanoAOD/aQGCs/
    
To be in sync with the SM semilep analysis SMP-21-013 use the following instructions for the installation:

    cmsrel CMSSW_10_6_4
    cd CMSSW_10_6_4/src/
    cmsenv
    git clone --branch 13TeV https://github.com/latinos/setup.git LatinosSetup
    source $CMSSW_BASE/src/LatinosSetup/Functions.sh
    source LatinosSetup/SetupShapeOnly.sh 
    scram b -j4
    # remember to setup your log directory :)
    git remote add UniMiB https://github.com/UniMiBAnalyses/LatinoAnalysis.git
    git fetch UniMiB VBS_skim
    git checkout UniMiB/VBS_skim
    git checkout -b VBS_skim_prepDavide ca28a5e
    cd /afs/cern.ch/work/i/izoi/VBSanalysis/CMSSW_10_6_4/src/LatinoAnalysis/
    
Add the needed samples and cross sections in ```NanoGardener/python/framework/samples/``` eg Summer16_102X_nAODv7.py and samplesCrossSections2016.py for 2016.

To submit the jobs:

    mkPostProc.py -p ANNOmc -i nomeSTEPiniziale -s nomeSTEPdaProcessare -T sample1,sample2,sample3 -b -Q microcentury # -i is not needed at the first step
    mkPostProc.py -p Summer16_102X_nAODv7_Full2016v7 -s MCl1loose2016v7 -T WminusTo2LWminusTo2JJJ_aQGC 

The output files will appear in ```/eos/cms/store/group/phys_smp/VJets_NLO_VBSanalyses/``` in the corresponding period subdirectory

*NB* Some steps are actually a chain of steps. For it to be properly executed, it is important that the name in ```VBSjjlnu_samples.py``` matches the one in the python files (samples location file and cross section file) in ```NanoGardener/python/framework/samples/```
 
Steps and samples are summarized here https://docs.google.com/spreadsheets/d/1MMBBI677xkzVJ2ktDHf1-TIVEz1YsCfCfMMDmu5EOu4/edit?usp=sharing
