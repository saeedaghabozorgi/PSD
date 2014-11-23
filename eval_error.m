function eval_error()
clear
clc
source_dir = 'C:\Temp\Oscop data\';
source_file1= [source_dir,'result_FCM_No.mat'];
source_file2= [source_dir,'result_FCM_ga.mat'];
dest_dir = 'C:\Temp\Oscop data\';

%data = xlsread(fullfile(source_dir, source_files(i).name));

% notr=find([No{:, 2}]==1);
% gama=find([No{:, 2}]==1);


load(source_file1,'No');
x=0.0039:0.0039:1;
for i = 1:size(No,1)
    NoA(i,:)=No{i,5};
end


load(source_file2,'ga');
for i = 1:size(ga,1)
    GaA(i,:)=ga{i,5};
end

data_size=size(No,1)+size(ga,1);

cen_No= mean(NoA);
cen_Ga= mean(GaA);

rcen_No= repmat(cen_No,size(NoA,1),1);
rcen_Ga= repmat(cen_Ga,size(GaA,1),1);
rcen_No2= repmat(cen_No,size(GaA,1),1);
rcen_Ga2= repmat(cen_Ga,size(NoA,1),1);

No_weight_to_No_cen=[No{:,3}]';
No_weight_to_Ga_cen=[No{:,4}]';
Ga_weight_to_Ga_cen=[ga{:,4}]';
Ga_weight_to_No_cen=[ga{:,3}]';


dis_No_from_cen_No=sum(sqrt(sum((rcen_No-NoA).^2,2)),1);
dis_No_from_cen_Ga=sum(sqrt(sum((rcen_Ga2-NoA).^2,2)),1);
dis_Ga_from_cen_Ga=sum(sqrt(sum((rcen_Ga-GaA).^2,2)),1);
dis_Ga_from_cen_No=sum(sqrt(sum((rcen_No2-GaA).^2,2)),1);



Wdis_No_from_cen_No=sum(sqrt(sum((rcen_No-NoA).^2,2)).*No_weight_to_No_cen,1);
Wdis_No_from_cen_Ga=sum(sqrt(sum((rcen_Ga2-NoA).^2,2)).*No_weight_to_Ga_cen,1);
Wdis_Ga_from_cen_Ga=sum(sqrt(sum((rcen_Ga-GaA).^2,2)).*Ga_weight_to_Ga_cen,1);
Wdis_Ga_from_cen_No=sum(sqrt(sum((rcen_No2-GaA).^2,2)).*Ga_weight_to_No_cen,1);



Error1=(dis_No_from_cen_No+dis_Ga_from_cen_Ga)/data_size %crispy error
Error2=(dis_No_from_cen_No+dis_Ga_from_cen_Ga+dis_No_from_cen_Ga+dis_Ga_from_cen_No)/(2*data_size) % it is equivalant to SSE:sum of Square Error
Error3=(Wdis_No_from_cen_No+Wdis_Ga_from_cen_Ga+Wdis_No_from_cen_Ga+Wdis_Ga_from_cen_No)/data_size %fuzzy error

