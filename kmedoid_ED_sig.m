function kmedoid_ED_sig()  
clear
clc

k=2;

%----saeed source files
source_dir = 'C:\Temp\Oscop data\';
source_file= [source_dir,'preprocessed.mat'];
dest_dir = 'C:\Temp\Oscop data\';
dest_file0=[dest_dir,'result_kmedoids_ED.xls'];
dest_file1=[dest_dir,'result_kmedoids_ED_no.mat'];
dest_file2=[dest_dir,'result_kmedoids_ED_ga.mat'];

load(source_file,'signal');
sig_size=size(signal,1);

for i = 1:sig_size
  D(i,:)=signal{i,2};
  res{i,1}=signal{i,1};
end


Dist = pdist(D);  %Euclidean distance



Dist = squareform(Dist);
n = size(D,1);

medoids = randsample(n,k);
%medoids=[1:k]';
[costs,labels] = min(Dist(medoids,:));
cost = sum(costs);

last = 0;

if length(medoids)~=k
    disp('set the correct medoids!');
    return;
end


while any(last ~= medoids)
    best_so_far_medoids = medoids;
    for i = 1:k %for each medoids point
        medoids_aux = medoids;
        for j = 1:n %for each non-medoids point
            if ismember(j, medoids)
                continue
            end
            medoids_aux(i) = j; %swap
            [costs_aux,labels_aux] = min(Dist(medoids_aux,:));
            cost_aux = sum(costs_aux);
            if (cost_aux < cost)
                best_so_far_medoids = medoids_aux;
                cost = cost_aux;
                labels = labels_aux;
            end
        end
    end
    last = medoids;
    medoids = best_so_far_medoids;
end

inx = labels';
cent1=D(medoids(1,1),:);
cent2=D(medoids(2,1),:);
 
U1=Dist(medoids,:);
U=U1./repmat(sum(U1),2,1)
[c,inx]=max(U);


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
          ga{j,6}=signal{i,3};
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

xlswrite(dest_file0,res);
save(dest_file1, 'No');
save(dest_file2, 'ga');



