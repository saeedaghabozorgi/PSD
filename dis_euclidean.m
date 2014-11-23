function d=dis_euclidean(A,B)
       [hA,wA]=size(A);
             [hB,wB]=size(B);
             if wA ~= wB,  error(' second dimension of A and B must be the same'); end
              d=sqrt(sum(abs(A - B).^2));
             % d=sum(abs(A - B).^2);
end