function k_means()

clear
clc
%----saeed source files
source_dir = 'C:\Temp\Oscop data\';
source_file= [source_dir,'preprocessed.mat'];
dest_dir = 'C:\Temp\Oscop data\';
dest_file0=[dest_dir,'result_kmeans.xls'];
dest_file1=[dest_dir,'result_kmeans_no.mat'];
dest_file2=[dest_dir,'result_kmeans_ga.mat'];

load(source_file,'signal');
sig_size=size(signal,1);

for i = 1:sig_size
  D(i,:)=signal{i,2};
  res{i,1}=signal{i,1};
end

k=2;
[inx,center] = kmeans(D,k);

%centroids
 cent{1}=center(1,:);
 cent{2}=center(2,:);
 
 %distance from centroids
avg1= repmat(cent{1},size(D,1),1);
E_distance(:,1) = sqrt(sum((avg1-D).^2,2));
avg2= repmat(cent{2},size(D,1),1);
E_distance (:,2)= sqrt(sum((avg2-D).^2,2));


U=E_distance./repmat(sum(E_distance,2),1,2);

 U=U';
 inx=inx';
 
 %Plot_time_series(2,1,inx',inx',cent,nor_traj,[],k,3,1);
 j=1;
 z=1;
 for i = 1:sig_size
     if inx(1,i)==1
         No{j,1}=res{i,1};
          No{j,2}=inx(1,i);
          No{j,3}=U(1,i);
          No{j,4}=U(2,i);
          No{j,5}=D(i,:);
          No{j,6}=signal{i,3};
          j=j+1;
     else
          ga{z,1}=res{i,1};
          ga{z,2}=inx(1,i);
          ga{z,3}=U(1,i);
          ga{z,4}=U(2,i);
          ga{z,5}=D(i,:);
          ga{j,6}=signal{i,3};
          z=z+1;
     end
 end
 
 for i = 1:sig_size
  res{i,2}=inx(1,i);
  res{i,3}=U(1,i);
  res{i,4}=U(2,i);
  res{i,5}=signal{i,3};
 end
%hist(res{:,5},res{:,3}) 

xlswrite(dest_file0, res);
save(dest_file1, 'No')
save(dest_file2, 'ga')






