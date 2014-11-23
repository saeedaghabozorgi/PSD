function eval_chart1()
clear
clc
source_dir = 'C:\Temp\Oscop data\';
source_file1= [source_dir,'result_FCM_No.mat'];
source_file2= [source_dir,'result_FCM_ga.mat'];
dest_dir = 'C:\Temp\Oscop data\';

load(source_file1,'No');

for i = 1:length(No)
    a(i,1)=No{i,6};
    a(i,2)=No{i,3};
end


load(source_file2,'ga');
for i = 1:length(ga)
    b(i,1)=ga{i,6};
    b(i,2)=ga{i,3};
end

h(1)=scatter(b(:,2),b(:,1));
hold on
h(2)=scatter(a(:,2),a(:,1));


middel_area=(sum(a(:,2)<0.75)+sum(b(:,2)>0.25))*100/(size(No,1)+size(ga,1))