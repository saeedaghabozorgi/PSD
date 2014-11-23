

% 
% function [Dist]=dis_dtw3(t,r)
% %Dynamic Time Warping Algorithm
% %Dist is unnormalized distance between t and r
% %D is the accumulated distance matrix
% %k is the normalizing factor
% %w is the optimal path
% %t is the vector you are testing against
% %r is the vector you are testing
% [rows,N]=size(t);
% [rows,M]=size(r);
% %for n=1:N
% %    for m=1:M
% %        d(n,m)=(t(n)-r(m))^2;
% %    end
% %end
% d=(repmat(t(:),1,M)-repmat(r(:)',N,1)).^2; %this replaces the nested for loops from above Thanks Georg Schmitz
% 
% D=zeros(size(d));
% D(1,1)=d(1,1);
% 
% for n=2:N
%     D(n,1)=d(n,1)+D(n-1,1);
% end
% for m=2:M
%     D(1,m)=d(1,m)+D(1,m-1);
% end
% for n=2:N
%     for m=2:M
%         D(n,m)=d(n,m)+min([D(n-1,m),D(n-1,m-1),D(n,m-1)]);
%     end
% end
% 
% Dist=D(N,M);
% 
% end


function [Dist]=dis_dtw3(t,r,Delta)
%Dynamic Time Warping Algorithm
%Dist is unnormalized distance between t and r
%D is the accumulated distance matrix
%k is the normalizing factor
%w is the optimal path
%t is the vector you are testing against
%r is the vector you are testing

[rows,N]=size(t);
[rows,M]=size(r);
%for n=1:N
%    for m=1:M
%        d(n,m)=(t(n)-r(m))^2;
%    end
%end

d=(repmat(t(:),1,M)-repmat(r(:)',N,1)).^2; %this replaces the nested for loops from above Thanks Georg Schmitz

D=zeros(size(d));
D=D+1000;
D(1,1)=d(1,1);
% added by saeed
if Delta>=size(d,1)
    Delta = size(d,1)-2;
end
for n=2:2+Delta
    D(n,1)=d(n,1)+D(n-1,1);
end
for m=2:2+Delta
    D(1,m)=d(1,m)+D(1,m-1);
end
for n=2:N
    for m = (n-Delta):1:(n+Delta),
        if (m<=1 | m>N);
        else
            D(n,m)=d(n,m)+min([D(n-1,m),D(n-1,m-1),D(n,m-1)]);
        end
    end
end

Dist=sqrt(D(N,M));

end
