import os
import pandas as pd

SUBJECTS_DIR="../freesurfer/"
output=SUBJECTS_DIR

aparcstatsfiles=['aparc','aparc.a2009s', 'aparc.DKTatlas', 'aparc.pial']
#meassure=['area', 'volume', 'thickness', 'thicknessstd', 'meancurv', 'gauscurv', 'foldind', 'curvind']
meassure=['area', 'volume', 'thickness', 'meancurv', 'gauscurv']

command="export SUBJECTS_DIR={}; output={}; sub=$(ls $SUBJECTS_DIR -l |grep \"^d\" |awk '{{print $9}}' |grep -v fsaverage); echo -n >$output/subjects.txt; \
for i in $sub; do echo $i >>$output/subjects.txt; done".format(SUBJECTS_DIR,output)
os.system(command)
command="export SUBJECTS_DIR={}; output={}; asegstats2table --subjectsfile $output/subjects.txt --delimiter comma --tablefile $output/aseg_volume_stats.csv".format(SUBJECTS_DIR,output)
os.system(command)

for i in aparcstatsfiles:
    writer=pd.ExcelWriter("{}/{}.xlsx".format(output,i))
    for j in meassure:
    	for k in ['lh','rh']:
            command="export SUBJECTS_DIR={}; output={}; aparcstats2table --subjectsfile $output/subjects.txt --hemi {} --meas {} --delimiter comma --tablefile $output/{}_{}_{}.csv".\
format(SUBJECTS_DIR,output,k,j,i,j,k)
            os.system(command)
            csv = pd.read_csv('{}/{}_{}_{}.csv'.format(output,i,j,k), encoding='utf-8')
            csv.to_excel(writer, sheet_name='{}_{}'.format(j,k))
            os.system("rm {}/{}_{}_{}.csv".format(output,i,j,k))
    writer.save()