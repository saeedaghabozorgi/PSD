function preprocess()
clear
clc
%source_file = 'D:\PSDdata\rawdata.mat';
%dest_dir = 'D:\PSDdata';


%----saeed source files
source_dir = 'C:\Temp\Oscop data\';
source_file= [source_dir,'rawdata.mat'];
dest_dir = 'C:\Temp\Oscop data\';
dest_file=[dest_dir,'preprocessed.mat'];

load(source_file,'sig');

sig_size=size(sig,1);
signal=cell(sig_size,3);
for i = 1:sig_size
    i
    D(i,:)=sig{i,2};  %data
    y1 = D( i , :);
    y1= -1 * y1;
    
    % FIR filter
    y21 = filter(ones(1,4)/4,1,y1); 
    y31 = filter(ones(1,4)/4,1,y21);
    
    %pulse selection
    [~,inx] = max( y31);
    umin = inx - 50;
    umax = inx + 100;
    y11 = y31(umin: umax);   %new pulse
    
    %Normalization
    %[maxfornorm,~] = max(y11); %finding max for normalization 
    %y11norm = y11 / maxfornorm;

    %Normalization z-score
    [maxfornorm,~] = max(y11); %finding max for normalization 
    sig_mean=mean(y11);
    sig_std=std(y11);
    y11norm=(y11-sig_mean)/sig_std;
    
    %reduction
    [a2,inx2]= max(y11);
    yfinal = y11norm(inx2 : end);
    
    
    %saving
    signal{i,1}=sig{i,1}; %name of files
    signal{i,2}=yfinal;
    signal{i,3}=maxfornorm;
end

save(dest_file, 'signal');