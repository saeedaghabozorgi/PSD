clear
clc
source_dir = 'C:\Temp\Oscop data\Oscop data out';
source_files = dir(fullfile(source_dir, '*.xls'));
for i = 1:length(source_files)
    i
  data = xlsread(fullfile(source_dir, source_files(i).name));
  sig{i,1}=source_files(i).name;
  sig{i,2}=data( : , 2);
end

save('C:\Temp\Oscop data\sig.mat', 'sig')