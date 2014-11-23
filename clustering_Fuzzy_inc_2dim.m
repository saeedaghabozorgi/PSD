function clustering_Fuzzy_inc_2dim()
clear all
close all
%D=rand(520,2);
%save('data\CAST_randData_2+100_inc', 'D');
%load('data\CAST_randData_2+100_inc.mat', 'D');
%path(path,'..\..\..\FUZZCLUST')
%data.X = D(1:400,:);
path(path,'C:\Users\Saeed\Documents\My Research\Research Works\My Codes\Fuzzy Clustering Algorithm\FuzzyClusteringToolbox_m\Demos\clusteringexamples\motorcycle')
load motorcycle.txt

data.X = motorcycle(:,[1 2]);




k=4

data=clust_normalize(data,'range');
D=data.X;
data.X=data.X(1:30,:)


figure(1);
hold off;
scatter(data.X(:,1),data.X(:,2),[],'b','c');
cc=hsv(250);
C=[];
eps=.001;
fuzziness =2;
alpha=.1;

% load('data\CAST_clusters_2+100_inc.mat', 'C');
% if ~isempty(C)
%     vv=C;
%     hold on;
%     for i=1:max(vv);
%         plot(D((vv==i),1),D((vv==i),2),'g+--');
%     end
%     for i=1:length(Data);
%         text(Data(i,1)+.01,Data(i,2), strcat('   ',num2str(i)) ,'FontSize',8,'color','black')
%     end
% end

clusterCount=k;

for j=1:clusterCount
    centroid(j,:)=data.X(j,:);
end


FClusDisMatrix=dis_euclidean_matrix(data.X,centroid);
OffMembership=zeros(length(data.X),clusterCount);
for i=1:length(data.X)
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

[N,n] = size(data.X);
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
        numerator=(fm(:,j)'*data.X);
        denominator=sumf(1,j);
        centroid(j,:)=numerator/denominator;
    end
    
    %update dist
    FClusDisMatrix=dis_euclidean_matrix(data.X,centroid);
    
    
    % Update f0
    d = (FClusDisMatrix+1e-10).^(-1/(fuzziness-1));
    f0 = (d ./ (sum(d,2)*ones(1,clusterCount)));
    
    % re assigning to clusteres
    [~,C]=max(f,[],2);
    
    
end

hold off;
scatter(data.X(:,1),data.X(:,2),[],'b','c');
if ~isempty(C)
    hold on;
    for j=1:max(C);
        plot(data.X((C==j),1),data.X((C==j),2),'g+--');
        hold on;
        scatter(data.X((C==j),1),data.X((C==j),2),[],cc(j*10,:),'filled');
        hold on;
        scatter(centroid(j,1),centroid(j,2),[],'rs','filled');
        hold on;
        text(centroid(j,1)+.01,centroid(j,2), strcat('  ',num2str(j)) ,'FontSize',8,'color','red');
    end
    for i=1:length(data.X);
        text(data.X(i,1)+.01,data.X(i,2), strcat('  ',num2str(i)) ,'FontSize',8);
    end
end

%----------------------------------------------------------------
% cluster distances
disCluster= dis_euclidean_matrix(centroid,centroid);
disCluster=squareform(disCluster);
%---------------------------------------------------------

        %partition coefficient (PC)
        fm = f.^fuzziness;
        PC = 1/length(data.X)*sum(sum(fm));
        %classification entropy (CE)
        fm = f.*log(f);
        CE = -1/length(data.X)*sum(sum(fm));




OffMembership=f;
for ii=1:300
    new_node=length(data.X)+1
    data.X(new_node,:)=D(new_node,:);
    x=D(new_node,:);
    C(new_node)=0;
    
    
    hold on;
    scatter(data.X(new_node,1),data.X(new_node,2),[],'k','filled');
    hold on;
    text(x(1,1)+.01,x(1,2), strcat('  ',num2str(new_node)) ,'FontSize',8);
     pause
    % calculate distances for new point
    newFClusDisMatrix=zeros(1,clusterCount);
    
    for i=new_node:new_node
        for j=1:clusterCount
            a=centroid(j,:);
            b=data.X(i,:);
            FClusDisMatrix(i,j)=dis_euclidean_matrix(a,b);
        end
    end
    
    
    
    % calculate membership for new point
    % OffMembership=zeros(1,clusterCount);
    eps=.001;
    for i=new_node:new_node
        denominator=0;
        for j=1:clusterCount
            if FClusDisMatrix(i,j)==0;
                FClusDisMatrix(i,j)=eps;
            end
            denominator=denominator+(1/FClusDisMatrix(i,j))^fuzziness;
        end
        for j=1:clusterCount
            mem=((1/FClusDisMatrix(i,j))^fuzziness)/denominator;
            OffMembership(i,j)=mem;
        end
    end
    
    outliers=zeros(1,1);
    for objInx=new_node : new_node
        %-- outlier ?------------------------------------------------------
        %-- conditions to finding outliers
        newMem=OffMembership(objInx,:);
        [~,r]=max(newMem);
        %1.findding if all its memebership close t0 1/c
        rr=1/clusterCount;
        pp=OffMembership(objInx,:);
        xx=1/clusterCount-OffMembership(objInx,:);
        con1= abs(1/clusterCount-OffMembership(objInx,:)) < alpha;
        con1=min(con1);
        
        %2.finding min distance between centers
        con2= FClusDisMatrix(objInx,:) >  (min(disCluster))/2;
        con2=min(con2);
        con=min([con1,con2]);
        
        
        if con==0
            outliers(objInx,1)=0;
            
        else
            outliers(objInx,1)=1;
        end
    end
    
    
    
    % create cluster for outliers
    %------------------------------------------------------------------
    %-- Create ------------------------------------------------------
    changedCluster=zeros(1,clusterCount);
%     if sum(outliers)>0
%         dd=1;
%         newCluster= clusterCount+1;
%         clusterCount=clusterCount+1;
%         % C(new_node,1)=newCluster;
%         changedCluster(newCluster)=1;
%         centroid(newCluster,:)=data.X(new_node,:);
%         outliers(new_node,1)=0;
%         
%         %-- Update distance  ------------------------------------------------------
%         xx=dis_euclidean_matrix(data.X,centroid(newCluster,:));
%         FClusDisMatrix=[FClusDisMatrix,xx];
%         
%         d = (FClusDisMatrix+1e-10).^(-1/(fuzziness-1));
%         OffMembership = (d ./ (sum(d,2)*ones(1,clusterCount)));
%         
%     end
    
    
    % assign not outliers
    %------------------------------------------------------------------
    %-- Assign ------------------------------------------------------
    for objInx=new_node : new_node
        newMem=OffMembership(objInx,:);
        [~,r]=max(newMem);
        if ~outliers(objInx,1)
            C(objInx,1)=r;
            changedCluster(r)=1;
        end
    end
    
    % Update changed clusters
    %------------------------------------------------------------------
    %-- Update centers ------------------------------------------------------
    f=OffMembership;
    fm = f.^fuzziness;
    sumf = sum(fm);
    v = (fm'*data.X)./(sumf'*ones(1,2));
    for j=1:clusterCount
      %  if changedCluster(j)==1
            numerator=(fm(:,j)'*data.X);
            denominator=sumf(1,j);
            centroid(j,:)=numerator/denominator;
      %  ends
    end
    
    
    % Update distance MTX
    %------------------------------------------------------------------
    %-- Update distance  ------------------------------------------------------
    for i=1:new_node
        for j=1:clusterCount
            if changedCluster(j)==1
                a=centroid(j,:);
                b=data.X(i,:);
                FClusDisMatrix(i,j)=dis_euclidean_matrix(a,b);
            end
        end
    end
    
    
    
    % Update fuzzy MTX
    %------------------------------------------------------------------
    %-- Update fuzzy MTX------------------------------------------------------
    % Update f0
    d = (FClusDisMatrix+1e-10).^(-1/(fuzziness-1));
    OffMembership = (d ./ (sum(d,2)*ones(1,clusterCount)));
    
    
    
    % Update center distance
    %------------------------------------------------------------------
    %-- Update center distance------------------------------------------------------
    disCluster= dis_euclidean_matrix(centroid,centroid);
    disCluster=squareform(disCluster);
    
    
    %---- re assign
    
    [~,C]=max(f,[],2);
    
  %  if mod(length(data.X),10)==0
        hold off;
        scatter(data.X(:,1),data.X(:,2),[],'b','c');
        if ~isempty(C)
            hold on;
            for j=1:max(C);
                plot(data.X((C==j),1),data.X((C==j),2),'g+--');
                hold on;
                scatter(data.X((C==j),1),data.X((C==j),2),[],cc(j*10,:),'filled');
                hold on;
                scatter(centroid(j,1),centroid(j,2),[],'rs','filled');
                hold on;
                text(centroid(j,1)+.01,centroid(j,2), strcat('  ',num2str(j)) ,'FontSize',8,'color','red');
            end
            for i=1:length(data.X);
                text(data.X(i,1)+.005,data.X(i,2), strcat('  ',num2str(i)) ,'FontSize',8);
            end
        end
        pause
  %  end
    
    
    
end


end
