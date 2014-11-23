function NMI = Calculate_Cluster_NMI(cluster_labels,true_labels)
%Compute normalized mutual information (NMI) using the true and cluster labels
%   Input    : true_labels    : N-by-1 vector containing true labels
%              cluster_labels : N-by-1 vector containing cluster labels
%
%   Output   : score          : NMI value
%
%   Based on the version written by  Wen-Yen Chen (wychen@alumni.cs.ucsb.edu)

% Compute the confusion matrix 'cmat'
n = length(true_labels);
cat = spconvert([(1:n)' true_labels ones(n,1)]);
cls = spconvert([(1:n)' cluster_labels ones(n,1)]);
cls = cls';
cmat = full(cls * cat);

n_i = sum(cmat, 1); % Total number of data for each true label (CAT), n_i
n_j = sum(cmat, 2); % Total number of data for each cluster label (CLS), n_j

% Calculate n*n_ij / n_i*n_j
[row, col] = size(cmat);
product = repmat(n_i, [row, 1]) .* repmat(n_j, [1, col]);
index = find(product > 0);
n = sum(cmat(:));
product(index) = (n*cmat(index)) ./ product(index);
% Sum up n_ij*log()
index = find(product > 0);
product(index) = log(product(index));
product = cmat .* product;
NMI = sum(product(:));
% Divide by sqrt( sum(n_i*log(n_i/n)) * sum(n_j*log(n_j/n)) )
index = find(n_i > 0);
n_i(index) = n_i(index) .* log(n_i(index)/n);
index = find(n_j > 0);
n_j(index) = n_j(index) .* log(n_j(index)/n);
denominator = sqrt(sum(n_i) * sum(n_j));

% Check if the denominator is zero
if denominator == 0
  NMI = 0;
else
  NMI = NMI / denominator;
end
