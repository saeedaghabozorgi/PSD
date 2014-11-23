function eval_accuracy()
clear
clc
source_dir = 'C:\Temp\Oscop data\';
source_file1= [source_dir,'result_FCM_No.mat'];
source_file2= [source_dir,'result_FCM_ga.mat'];
dest_dir = 'C:\Temp\Oscop data\';

load(source_file1,'No');

for i = 1:size(No,1)
    a(i,1)=No{i,6};
    a(i,2)=No{i,3};
    c(i,1)=No{i,1};
    p(i,1)='N';
end


load(source_file2,'ga');
for i = 1:size(ga,1)
    b(i,1)=ga{i,6};
    b(i,2)=ga{i,3};
    c(i+size(No,1),1)=ga{i,1};
    p(i+size(No,1),1)='G';
end



Clus(c=='N')=1;
Clus(c=='G')=2;
Class(p=='N')=1;
Class(p=='G')=2;

 RI =Calculate_Cluster_RandIndex(Clus',Class')
 jacard=Calculate_Cluster_Jaccard(Clus',Class')
 NMI = Calculate_Cluster_NMI(Clus',Class')
end