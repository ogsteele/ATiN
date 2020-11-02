% Script to split original recording for teaching practical

%% Load in Data

% Select raw trace to visualise
title_str = "1. Select quarter file of recording to split further";
if ~ispc; menu(title_str,'OK'); end
clear('title_str')
[file,path,~] = uigetfile('*.phy','1. Select quarter file of recording to split further');
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

% determine the length of the second half
len_second = round(length(S.array));
% determine the length of the five fifths of this
len_sec_fifth = round(len_second/5);
% determine time points of each section
start1 = 1;
end1 = len_sec_fifth;
len1 = end1-start1;
start2 = end1+1; 
end2 = len_sec_fifth + len_sec_fifth;
len2 = end2-start2;
start3 = end2+1;
end3 = end2+len_sec_fifth;
len3 = end3-start3;
start4 = end3+1;
end4 = end3+len_sec_fifth;
len4 = end4-start4;
start5 = end4+1;
end5 = end4+len_sec_fifth;
len5 = end5-start5;
total_len = len1 + len2 + len3 + len4 + len5;
% Create Quarters
ephysIO ('F1.phy',(S.array(start1:end1,:)),S.xunit,S.yunit,S.names,S.notes,'int16')
ephysIO ('F2.phy',(S.array(start2:end2,:)),S.xunit,S.yunit,S.names,S.notes,'int16')
ephysIO ('F3.phy',(S.array(start3:end3,:)),S.xunit,S.yunit,S.names,S.notes,'int16')
ephysIO ('F4.phy',(S.array(start4:end4,:)),S.xunit,S.yunit,S.names,S.notes,'int16')
ephysIO ('F5.phy',(S.array(start5:end5,:)),S.xunit,S.yunit,S.names,S.notes,'int16')