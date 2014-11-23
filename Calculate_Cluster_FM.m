% it is Rand Folkes and Mallow index 

function FM=Calculate_Cluster_FM(c,p)
rows=length(c);
a_count=0; % True Positive. (TP) decision assigns two similar documents to the same cluster
b_count=0; % False Positive. (FP) decision assigns two dissimilar documents to the same cluster
c_count=0; % False Negative. (FN) decision assigns two similar documents to different clusters
d_count=0; % True Negative. (TN) decision assigns two dissimilar documents to different clusters

for i=1:rows-1
    for j=i+1:rows
        if (c(i)==c(j) && p(i)==p(j))
            a_count=a_count+1;
        elseif (c(i)==c(j) && p(i)~= p(j))
            b_count=b_count+1;
        elseif (c(i)~=c(j) && p(i)== p(j))
            c_count=c_count+1;
        elseif (c(i)~=c(j) && p(i)~= p(j))
            d_count=d_count+1;
        end
    end
end

FM= sqrt((a_count/(a_count+b_count))*(a_count/(a_count+c_count)));