% Script to split original recording for teaching practical

%% Load in Data

% Select raw trace to visualise
title_str = "1. Select raw file of recording to split";
if ~ispc; menu(title_str,'OK'); end
clear('title_str')
[file,path,~] = uigetfile('*.tdms','1. Select raw .tdms of recording');
% Display file selection selection
if isequal(file,0)
   disp('User selected Cancel')
   % If user selects cancel here, script will end here.
   return
else
    disp(['User selected ', fullfile(path, file)])
    % Navigate to directory and load file with ephysIO
    cd(path)
    S = ephysIO(file);
end
clear('file', 'path')

% calculate the length and positions of splits
base_length = round(length(S.array));
third_length = round(base_length/3);
% Split original file into three
ephysIO ('Compound.phy',(S.array(1:third_length,:)),S.xunit,S.yunit,S.names,S.notes,'int16')
ephysIO ('AMPAR.phy',(S.array(end-third_length:end,:)),S.xunit,S.yunit,S.names,S.notes,'int16')
% Load in the AMPAR pure recording
S = ephysIO('AMPAR.phy');
% determine the length of the second half
len_second = length(S.array);
% determine the length of the four quarters of this
len_sec_quarter = len_second/4;
% determine time points of each section
start1 = 1;
end1 = len_sec_quarter;
len1 = end1-start1;
start2 = end1+1; 
end2 = len_sec_quarter + len_sec_quarter;
len2 = end2-start2;
start3 = end2+1;
end3 = end2+len_sec_quarter;
len3 = end3-start3;
start4 = end3+1;
end4 = end3+len_sec_quarter;
len4 = end4-start4;
total_len = len1 + len2 + len3 + len4;
% Create Quarters
ephysIO ('Q1.phy',(S.array(start1:end1,:)),S.xunit,S.yunit,S.names,S.notes,'int16')
ephysIO ('Q2.phy',(S.array(start2:end2,:)),S.xunit,S.yunit,S.names,S.notes,'int16')
ephysIO ('Q3.phy',(S.array(start3:end3,:)),S.xunit,S.yunit,S.names,S.notes,'int16')
ephysIO ('Q4.phy',(S.array(start4:end4,:)),S.xunit,S.yunit,S.names,S.notes,'int16')