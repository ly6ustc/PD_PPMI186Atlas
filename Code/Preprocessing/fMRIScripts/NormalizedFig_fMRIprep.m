function NormalizedFig(overlaydir,underlay,output,key,n_job)
if ~exist('overlaydir','var') || isempty(overlaydir)
    overlaydir=uigetdir(pwd,'Please Choose RealignParameter dir')
end
if ~exist('underlay','var') || isempty(underlay)
    underlay='/home/z/Data/Toolbox/MatlabToolBox/ly/DPABI_V4.3_200401/DPABI_V4.3_200401/Templates/ch2.nii';
    if ~exist(underlay,'file')
        disp(['Cant not find file ',underlay])
    end
end
if ~exist('output','var') || isempty(output)
   [filepath,name,ext]= fileparts(overlaydir);
   output=fullfile(filepath,'PicturesForChkNormalization');
end

if ~exist('key','var') || isempty(key)
    key='space-MNI152NLin2009cAsym_res-2';
end

if ~exist('n_job','var') || isempty(key)
    n_job=10;
end

mkdir(output)

list=dir(overlaydir);
list={list([list(:).isdir]).name};
list=list(3:end);

poolobj = gcp('nocreate');% If no pool,  create new one.
if isempty(poolobj)
    parpool(n_job);
else
    disp('Already initialized'); %说明并行环境已经启动。
end


parfor i=1:length(list)
    file=dir(fullfile(overlaydir,list{i},'func',['*',key,'_boldref.nii.gz']));
    file={file(:).name};
    if ~isempty(file)
        if size(file,2)>1
            disp(['More 2 files are found in ',fullfile(overlaydir,list{i})]);
        else
            H = figure;
%             H = y_Call_spm_orthviews(underlay,0,0,0,18,fullfile(overlaydir,list{i},'func',file{1}),jet(64),0,250,H,0.85);
            H = y_Call_spm_orthviews(underlay,0,0,0,18,fullfile(overlaydir,list{i},'func',file{1}),jet(64),0,8000,H,0.85);
%             eval(['print(''-dtiff'',''-r100'',''',fullfile(output,list{i}),'.tif'',H);']);
            print('-dtiff','-r100',fullfile(output,[list{i},'-',key,'.tif']),H);
            fprintf(['Generating the pictures for checking normalization: ',list{i},' OK\n']);
            close(H)
        end
    end

end
fprintf('Congraduations! \n')
delete(gcp('nocreate'));