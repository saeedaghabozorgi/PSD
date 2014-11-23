function FCM_sig()

clear
clc
%----saeed source files
source_dir = 'C:\Temp\Oscop data\';
source_file= [source_dir,'preprocessed.mat'];
dest_dir = 'C:\Temp\Oscop data\';
dest_file0=[dest_dir,'result_FCM.xls'];
dest_file1=[dest_dir,'result_FCM_no.mat'];
dest_file2=[dest_dir,'result_FCM_ga.mat'];

load(source_file,'signal');
sig_size=size(signal,1);

for i = 1:sig_size
  D(i,:)=signal{i,2};
  res{i,1}=signal{i,1};
end

 k=2;
[center,U,obj_fcn] = fcm(D,k,1.1);
[c,inx]=max(U);
 cent{1}=center(1,:);
 cent{2}=center(2,:);
 %Plot_time_series(2,1,inx',inx',cent,nor_traj,[],k,3,1);
 j=1;
 k=1;
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
          ga{k,1}=res{i,1};
          ga{k,2}=inx(1,i);
          ga{k,3}=U(1,i);
          ga{k,4}=U(2,i);
          ga{k,5}=D(i,:);
          ga{k,6}=signal{i,3};
          k=k+1;
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






