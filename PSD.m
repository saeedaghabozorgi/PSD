clear
clc
%read input data( Excels files)
%importdata();
gammaspectromne213(); %generator

% preprocessing including filtering, normalization
preprocess();
Drraw_plot();

%outlier detection
outlier_detection();

%Clustering
FCM_sig();
%kmedoid_ED_sig();
%kmedoid_DTW_sig();


%evaluation
eval_hist();
eval_error();
eval_chart1();
eval_accuracy();
