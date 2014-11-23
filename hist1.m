clear
clc
source_file1 = 'C:\Temp\Oscop data\result_No.mat';
source_file2 = 'C:\Temp\Oscop data\result_ga.mat';
dest_dir = 'C:\Temp\Oscop data\';

load(source_file1,'No');
for i = 1:length(No)
  a=No{i,5}(1:120)
end




load(source_file1,'ga');
for i = 1:length(ga)
  b=No{i,5}(1:120)
end