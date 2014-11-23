function importdata()
% read from excel Files and make a .mat file
clear
clc
%----sajjad files
%source_dir = 'D:\PSDdata\921213 Oscope n-g Pulses 12000';
%dest_dir = 'D:\PSDdata';


%----saeed source files
source_dir = 'C:\Temp\Oscop data\Oscop data in';
dest_dir = 'C:\Temp\Oscop data\';
dest_file=[dest_dir,'rawdata.mat'];

source_files = dir(fullfile(source_dir, '*.xls'));
sig_size=size(source_files,1);
sig=cell(sig_size,2);  %preallocating
for i = 1:sig_size
    i
    data = xlsread(fullfile(source_dir, source_files(i).name));
    y1 = data( : , 2);
    sig{i,1}=source_files(i).name;
    sig{i,2}=y1;
end

save(dest_file, 'sig')

