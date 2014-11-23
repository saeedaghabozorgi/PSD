function [center,u,c]=do_Fuzzy_time(nor_traj,k,fuzziness)
eps=1e-10;
%fuzziness=m


for i=1:k
    center{i}=nor_traj{i};
end

N=length(nor_traj);

dim=length(nor_traj{1});
FClusDisMatrix=Mtx_Distance(nor_traj,center,'notsame','Org', 'dis_method','Euclid');
FClusDisMatrix(FClusDisMatrix==0)=eps;

u=zeros(N,k);
for i=1:N
    for j=1:k
        denominator=0;
        for kk=1:k
            denominator=denominator+(FClusDisMatrix(i,j)/FClusDisMatrix(i,kk))^(2/(fuzziness-1));
        end
        u(i,j)=1/denominator;   
    end
end


u0 = zeros(N,k);                % partition matrix
iter = 0;                       % iteration counter

while  max(max(u-u0)) > .01
    iter = iter + 1
    
    % recalculate the centers
    for j=1:k
        numerator=zeros(dim,1);
        for i=1:N
            numerator=numerator+(u(i,j).^fuzziness*nor_traj{i});
        end
        denominator=sum(u(:,j).^fuzziness);
        center{j}=numerator/denominator;
    end
    
    %update dist
    FClusDisMatrix=Mtx_Distance(nor_traj,center,'notsame','Org', 'dis_method','Euclid');
    
    % Update f0
    %d = (FClusDisMatrix+eps).^(-1/(fuzziness-1));
    %f0 = (d ./ (sum(d,2)*ones(1,k)));
    
    u0=u;
    
    for i=1:N
        for j=1:k
            denominator=0;
            for kk=1:k
                denominator=denominator+(FClusDisMatrix(i,j)/FClusDisMatrix(i,kk))^(2/(fuzziness-1));
            end
            u(i,j)=1/denominator;   
        end
    end
    
   % re assigning to clusteres
    [~,c]=max(u,[],2);

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


function d=dis_euclidean_matrix(A,B)
       [hA,wA]=size(A);
       [hB,wB]=size(B);
       
       %check for same dimensions
             if wA ~= wB,  error(' second dimension of A and B must be the same'); end
             for k=1:wA
                  C{k}= repmat(A(:,k),1,hB);
                  D{k}= repmat(B(:,k),1,hA);
             end
             S=zeros(hA,hB);
             for k=1:wA
                  S=S+(C{k}-D{k}').^2;
             end
             d=sqrt(S);
end

