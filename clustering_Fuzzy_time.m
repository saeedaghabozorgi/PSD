function clustering_Fuzzy_time
eps=.001;
fuzziness =3;
k=20;
fprintf('Importing data .. \n\r');
[nor_traj,t_traj]=ImportBankData(1,200,'sequence',1,360);
%----------------------------------------
fprintf('Dimensionaly reduction of  data .. \n\r');

data_len      = 360;
global nseg;
nseg          = 36;

global alphabet_size;
alphabet_size = 10;

for i=1:length(nor_traj)
    SAX_nor_traj{i}= timeseries2symbol(nor_traj{i}, data_len, nseg, alphabet_size);
end

%----------------------------------------
maxRow=length(nor_traj);
for i=1:k
    center{i}=nor_traj{i};
    center_SAX{i}=SAX_nor_traj{i};
end

clusterCount=k;
FClusDisMatrix=Mtx_SAX_Min_Distance(SAX_nor_traj,center_SAX,'');
OffMembership=zeros(length(SAX_nor_traj),clusterCount);

for i=1:length(SAX_nor_traj)
    denominator=0;
    for j=1:clusterCount
        if FClusDisMatrix(i,j)==0 ;
            FClusDisMatrix(i,j)=eps;
        end
        denominator=denominator+(1/FClusDisMatrix(i,j))^fuzziness;
    end
    for j=1:clusterCount
        mem=((1/FClusDisMatrix(i,j))^fuzziness)/denominator;
        f0(i,j)=mem;
    end
end



N=length(SAX_nor_traj);
f = zeros(N,clusterCount);                % partition matrix
iter = 0;                       % iteration counter

while  max(max(f0-f)) > .01
    iter = iter + 1;
    f = f0;
    
    % recalculate the centers
    fm = f.^fuzziness;
    sumf = sum(fm);
    %  v = (fm'*data.X)./(sumf'*ones(1,2));
    for j=1:clusterCount
        numerator=zeros(1,length(SAX_nor_traj{1}));
        for i=1:length(SAX_nor_traj)
            numerator=numerator+(fm(i,j)*SAX_nor_traj{i});
        end
        %numerator=(fm(:,j)'*data.X);
        denominator=sumf(1,j);
        center_SAX{j}=numerator/denominator;
    end
    
    %update dist
    FClusDisMatrix=Mtx_SAX_Min_Distance(SAX_nor_traj,center_SAX,'');
    
    
    % Update f0
    d = (FClusDisMatrix+1e-10).^(-1/(fuzziness-1));
    f0 = (d ./ (sum(d,2)*ones(1,clusterCount)));
    
    % re assigning to clusteres
    [~,c]=max(f,[],2);


for i=1:k
    center{i}=centre_mean(c,i,nor_traj);
    cl_count_h(i,1)=size(find(c==i),1);
end

disp(cl_count_h);
Plot_time_series(5,4,c,center,nor_traj,t_traj,clusterCount);
  pause;  
    
end

for i=1:k
    center{i}=centre_mean(c,i,nor_traj);
    cl_count_h(i,1)=size(find(c==i),1);
end

disp(cl_count_h);
Plot_time_series(5,4,c,center,nor_traj,t_traj,clusterCount);
end

function mmean=centre_mean(c,clusterNum,nor_traj)
t=find(c(:,1)==clusterNum);
n=length(nor_traj{1});
cluster_mem=zeros(1,n);
for j=1:size(t,1)
    cluster_mem(j,:)=nor_traj{t(j)};
end
mmean=mean(cluster_mem,1);
end


