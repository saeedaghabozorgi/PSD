function clustering_FCM_time_UCR

fnames = dir('data\dataset UCR\All\*');
tradata = cell(1,length(fnames));

for k=3:length(fnames)
    
    fname = fnames(k).name;
    files_name{k-2}=fname;
end


for dataset_no=1:length(files_name)
    file_name=['data\dataset UCR\All\' files_name{dataset_no}];
    disp(file_name);
    train_data = importdata(file_name);
    TRAIN_class_labels = train_data(:,1);     % Pull out the class labels.
    k=length(unique(TRAIN_class_labels));
    rows=size(train_data,1);
    data_len= size(train_data,2)-1;
    [nor_traj,t_traj]=Import_Data_UCR(1,rows,2,data_len+1,file_name);
    
    
    
    c=[];
    [c]= do_Fuzzy_time (nor_traj,k,3)  ;
    
    center=[];
    for i=1:k
        center{i}=centre_mean(c,i,nor_traj);
    end
    
    p=train_data(:,1);
    if(min(p)==0)
        p=p+1;
    end
    for i=1:k
        train_cluster_center{i}=centre_mean(p,i,nor_traj);
    end
    
    SSEP=calculate_Cluster_SSE(p,nor_traj,train_cluster_center);
    SSEC=calculate_Cluster_SSE(c,nor_traj,center);
    RS= calculate_Cluster_Rand_statistic(c,p);
    purity= Calculate_Cluster_Purity(c,p,2);
    
    details(dataset_no,1)=k;
    details(dataset_no,2)=rows;
    details(dataset_no,3)=data_len;
    details(dataset_no,4)=SSEP;
    details(dataset_no,5)=SSEC;
    details(dataset_no,6)=RS;
    details(dataset_no,7)=purity;
end

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


