function eval_hist()
clear
clc

source_dir = 'C:\Temp\Oscop data\';
source_file1= [source_dir,'result_FCM_No.mat'];
source_file2= [source_dir,'result_FCM_ga.mat'];

load(source_file1,'No');
load(source_file2,'ga');
x=0.015625:0.015625:4;

No_size=size(No,1);
for i = 1:No_size
  a(i)=No{i,6};
end


ga_size=size(ga,1);
for i = 1:ga_size
  b(i)=ga{i,6};
end

subplot(2,1,1)
hist(a,x)
subplot(2,1,2)
hist(b,x)
%h = findobj(gca, 'Type','patch');
%set(h(1), 'FaceColor','r', 'EdgeColor','w')
%set(h(2), 'FaceColor','b', 'EdgeColor','w')