clear
clc
source_file1 = 'C:\Users\sajjad\Desktop\OScop\result_No.mat';
source_file2 = 'C:\Users\sajjad\Desktop\OScop\result_ga.mat';
dest_dir = 'C:\Users\sajjad\Desktop\OScop\';

load(source_file1,'No');
x=0.0039:0.0039:1;
for i = 1:length(No)
  a(i)=No{i,5}(40);
end


load(source_file2,'ga');
for i = 1:length(ga)
  b(i)=ga{i,5}(40);
end
hist(a,x)
hold on
hist(b,x)
h = findobj(gca, 'Type','patch');
set(h(1), 'FaceColor','r', 'EdgeColor','w')
set(h(2), 'FaceColor','b', 'EdgeColor','w')