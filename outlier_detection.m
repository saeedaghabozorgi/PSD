function outlier_detection()

clear
clc
%----saeed source files
source_dir = 'C:\Temp\Oscop data\';
source_file= [source_dir,'preprocessed.mat'];
dest_dir = 'C:\Temp\Oscop data\';
dest_file=[dest_dir,'preprocessed.mat'];

load(source_file,'signal');
sig_size=size(signal,1);
for i = 1:sig_size
    D(i,:)=signal{i,2};
end


avg=mean(D);
avg= repmat(avg,size(D,1),1);
E_distance = sqrt(sum((avg-D).^2,2));
hist(E_distance)
outliers= E_distance>1.5;

signal(outliers,:)=[];
outliers_size=size(outliers,1);
%c=hsv(outliers_size);
%for i=1:outliers_size
% p(i)=outliers(i,1);
%plot(p(i), 'color',c(i,:)*0.8)
%plot(p(i))
%hold on
%end

% the outliers should be removed here


% Y = pdist(D);
% Z = linkage(Y);
% dendrogram(Z);
% c = cophenet(Z,Y)
%
% Y = pdist(D,'cityblock');
% Z = linkage(Y,'average');
% dendrogram(Z);
% c = cophenet(Z,Y)


save(dest_file, 'signal');
end