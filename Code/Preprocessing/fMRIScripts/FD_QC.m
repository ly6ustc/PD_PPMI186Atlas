function FDcheck
% This script use to check time point which exceed FD threshold
% edit by ly 2019.6.17
%Output FDscrubinfo are name of subjects and position of time point, ...
%FDscrubinfo are number of exclude time points and percentage for total time points

Dir=uigetdir(pwd,'please choose RealighParameter dir');

% choice = questdlg('Please choose kind of FDparameter?', ...
% 'choose kind of FDparameter', ...
% 'Power','Jenkinson','VanDijk','Power');
T=inputdlg('please input Threshold(mm) for FD power','Threshold',1,{'0.5'});
choice2 = questdlg('Please choose kind of scrubbling?', ...
'choose kind of Scrubb', ...
'Just1point','1before&2after(4point)','1before&1after(3point)','Just1point');





T=str2double(T{:});

% switch choice
%     case 'Power'
%         FD='FD_Power_';
%     case 'Jenkinson'
%         FD='FD_Jenkinson_';
%     case 'VanDijk'
%         FD='FD_VanDijk_';
% end
list=dir(Dir);
subjects={list([list.isdir]).name};
subjects=subjects(3:end);
FDscrubinfo={};



switch choice2
    case 'Just1point'
        for i=1:length(subjects)
            session=dir([Dir,'/',subjects{i},'/ses-*']);
            session={session(:).name};
            if ~isempty(session)
                for j=1:length(session)
                    tempname=dir(fullfile(Dir,subjects{i},session{j},'FD*.par'));
                    tempname=tempname.name;
                    temp=importdata(fullfile(Dir,subjects{i},session{j},tempname));
                    temp=[0;temp.data];
                    index=find(temp>T);
                    FDscrubinfo{j,i,1}=subjects{i};
                    FDscrubinfo{j,i,2}=session{j};
                    FDscrubinfo{j,i,3}=length(index);
                    FDscrubinfo{j,i,4}=length(index)/length(temp);
                    FDscrubinfo{j,i,5}=index;
                    FDscrubinfo{j,i,6}=mean(temp(2:end));
                end
                    
            else
                    tempname=dir(fullfile(Dir,subjects{i},'FD*.par'));
                    tempname=tempname.name;
                    temp=importdata(fullfile(Dir,subjects{i},tempname));
                    temp=[0;temp.data];
                    index=find(temp>T);
                    FDscrubinfo{i,1}=subjects{i};
                    FDscrubinfo{i,2}=length(index);
                    FDscrubinfo{i,3}=length(index)/length(temp);
                    FDscrubinfo{i,4}=index;
                    FDscrubinfo{i,5}=mean(temp(2:end));
            end
        end
    case '1before&1after(3point)'
        for i=1:length(subjects)
            session=dir([Dir,'/',subjects{i},'/ses-*']);
            session={session(:).name};
            if ~isempty(session)
                for j=1:length(session)
                    tempname=dir(fullfile(Dir,subjects{i},session{j},'FD*.par'));
                    tempname=tempname.name;
                    temp=importdata(fullfile(Dir,subjects{i},session{j},tempname));
                    temp=[0;temp.data];
                    index=find(temp>T);
                    index1=index+1;
                    index2=index-1;
                    index=union(index,index1);
                    index=union(index,index2);
                    index=intersect(index,[1:length(temp)]);
                    FDscrubinfo{j,i,1}=subjects{i};
                    FDscrubinfo{j,i,2}=session{j};
                    FDscrubinfo{j,i,3}=length(index);
                    FDscrubinfo{j,i,4}=length(index)/length(temp);
                    FDscrubinfo{j,i,5}=index;
                    FDscrubinfo{j,i,6}=mean(temp(2:end));
                end
                    
            else
                    tempname=dir(fullfile(Dir,subjects{i},'FD*.par'));
                    tempname=tempname.name;
                    temp=importdata(fullfile(Dir,subjects{i},tempname));
                    temp=[0;temp.data];
                    index=find(temp>T);
                    index1=index+1;
                    index2=index-1;
                    index=union(index,index1);
                    index=union(index,index2);
                    index=intersect(index,[1:length(temp)]);
                    FDscrubinfo{i,1}=subjects{i};
                    FDscrubinfo{i,2}=length(index);
                    FDscrubinfo{i,3}=length(index)/length(temp);
                    FDscrubinfo{i,4}=index;
                    FDscrubinfo{i,5}=mean(temp(2:end));
            end    

        end
    case '1before&2after(4point)'
        for i=1:length(subjects)
            session=dir([Dir,'/',subjects{i},'/ses-*']);
            session={session(:).name};
            if ~isempty(session)
                for j=1:length(session)
                    tempname=dir(fullfile(Dir,subjects{i},session{j},'FD*.par'));
                    tempname=tempname.name;
                    temp=importdata(fullfile(Dir,subjects{i},session{j},tempname));
                    temp=[0;temp.data];
                    index=find(temp>T);
                    index0=index+1;
                    index1=index+2;
                    index2=index-1;
                    index=union(index,index0);
                    index=union(index,index1);
                    index=union(index,index2);
                    index=intersect(index,[1:length(temp)]);
                    FDscrubinfo{j,i,1}=subjects{i};
                    FDscrubinfo{j,i,2}=session{j};
                    FDscrubinfo{j,i,3}=length(index);
                    FDscrubinfo{j,i,4}=length(index)/length(temp);
                    FDscrubinfo{j,i,5}=index;
                    FDscrubinfo{j,i,6}=mean(temp(2:end));
                end
                    
            else
                    tempname=dir(fullfile(Dir,subjects{i},'FD*.par'));
                    tempname=tempname.name;
                    temp=importdata(fullfile(Dir,subjects{i},tempname));
                    temp=[0;temp.data];
                    index=find(temp>T);
                    index0=index+1;
                    index1=index+2;
                    index2=index-1;
                    index=union(index,index0);
                    index=union(index,index1);
                    index=union(index,index2);
                    index=intersect(index,[1:length(temp)]);
                    FDscrubinfo{i,1}=subjects{i};
                    FDscrubinfo{i,2}=length(index);
                    FDscrubinfo{i,3}=length(index)/length(temp);
                    FDscrubinfo{i,4}=index;
                    FDscrubinfo{i,5}=mean(temp(2:end));
            end    

        end
end

%Maxium 
MaxiumHeadMotioninfo={};

for i=1:length(subjects)
        session=dir([Dir,'/',subjects{i},'/ses-*']);
        session={session(:).name};
        if ~isempty(session)
            for j=1:length(session)
                tempname=dir(fullfile(Dir,subjects{i},session{j},'Realigh*.par'));
                tempname=tempname.name;
                temp=importdata(fullfile(Dir,subjects{i},session{j},tempname));


                MaxiumHeadMotioninfo{j,i,1}=subjects{i};
                MaxiumHeadMotioninfo{j,i,2}=session{j};
                MaxiumHeadMotioninfo{j,i,3}=max(max(abs(temp(:,4:6))));
                MaxiumHeadMotioninfo{j,i,4}=max(max(abs(temp(:,1:3))))*180/pi;
            end

        else
                tempname=dir(fullfile(Dir,subjects{i},'Realigh*.par'));
                tempname=tempname.name;
                temp=importdata(fullfile(Dir,subjects{i},tempname));

                MaxiumHeadMotioninfo{i,1}=subjects{i};
                MaxiumHeadMotioninfo{i,2}=length(index);
                MaxiumHeadMotioninfo{i,3}=max(max(abs(temp(:,4:6))));
                MaxiumHeadMotioninfo{i,4}=max(max(abs(temp(:,1:3))))*180/pi;
        end
end


save(fullfile(Dir,'HeadMotioninfo'),'FDscrubinfo','MaxiumHeadMotioninfo');
cd(Dir);
