function fm=Calculate_Cluster_F_measure(c,p)

% Precision of Cj with respect to	Ti (as target) is the fraction of the
% series in Cj that has been correctly classified, i.e., Pij = |Cj ?Ti|/|Cj |.

% Recall of Cj with respect to Ti is the fraction of the series in Ti that
% has been correctly classified, i.e., Rij = |Cj ?Ti|/|	Ti|.

% c=[1 ;2; 2; 2; 2; 3; 2; 4];
% p=[1; 1 ;1; 2; 2; 1 ;3 ;4];

cluster_count=length(unique(c));
class_count=length(unique(p));

% calculate precision(i,j) and recall(i,j)
for j=1:cluster_count
    mem_c=find(c==j);
    for i=1:class_count
        mem_p=find(p==i);
        
        Pr=sum(ismember(mem_c,mem_p));
        pr(j,i)=Pr/size(mem_c,1);
        re(j,i)=Pr/size(mem_p,1);
    end
end

% Finding max Precision 
for i=1:cluster_count
    max_precision(i)= max(pr(i,:));
end
% Finding max  recall 
for i=1:class_count
     max_recall(i)= max(re(:,i));
end

   

% Finding max Precision and recall 
    precision= sum( max_precision)/cluster_count;
    recall= sum(max_recall)/class_count;
    
% F-measure (F ?[0, 1]) is defined as the harmonic mean between
% the Information Retrieval notions of precision (P) and recall (R):
fm= (2*precision*recall)/(precision+recall);

end
