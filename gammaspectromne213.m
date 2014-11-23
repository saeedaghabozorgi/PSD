function gammaspectromne213()

dest_dir = 'C:\Temp\Oscop data\';
dest_file=[dest_dir,'rawdata.mat'];

G_size=1;
N_size=1;
t=0 : 0.1 : 20;


G_domain=18+randn(G_size,1)*4;
G= -1*G_domain*(exp( -(3.714+t) /5.578) + exp( -(3.714+t)/3.482) -0.017*exp( -(3.714+t)/11.52));
G_noise = awgn(G,20,'measured'); % Add white Gaussian noise. 
plot(t,G,t,G_noise) % Plot both signals.

%hold on

N_domain=9.32+randn(N_size,1)*4;
N_noise= -1*N_domain*(exp( -(3.544+t) /4.317) + exp(-(3.544+t)/3.537) - 0.017*exp(-(3.544+t)/38.14));
%N_noise = awgn(N,10,'measured'); % Add white Gaussian noise. 
%plot(t,N,t,N_noise) % Plot both signals.

for i = 1:G_size
    sig{i,1}='G';
    sig{i,2}=[zeros(100,1);G_noise(i,:)';zeros(100,1)];
end

for i = 1:N_size
    sig{G_size+i,1}='N';
    sig{G_size+i,2}=[zeros(100,1);N_noise(i,:)';zeros(100,1)];
end


save(dest_file, 'sig')

end