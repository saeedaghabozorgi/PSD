% read from excel Files and make a .mat file
clear
clc
source_dir = 'D:\PSDdata\921213 Oscope n-g Pulses 12000';
dest_dir = 'D:\PSDdata';
source_files = dir(fullfile(source_dir, '*.xls'));
sig=cell(1200,2);  %preallocating
for i = 1:length(source_files)
    data = xlsread(fullfile(source_dir, source_files(i).name));
    y1 = data( : , 2);
    sig{i,1}=source_files(i).name;
    sig{i,2}=y1;
 end

save('D:\PSDdata\rawdata.mat', 'sig')

