function Plot_time_series(wplot,hplot,c,p,centroid,nor_traj,t_traj,clusterCount,fig_no,showMems)

if (wplot==0 || hplot==0)
    wplot=ceil(nthroot(clusterCount,2));
    if (wplot*(wplot-1))>clusterCount
        hplot= wplot-1;
    else
        hplot=wplot;
    end
end
%--incremental Plot--------------------------------------------------------------
if clusterCount> wplot*hplot;
    clusterCount=2;
    rrr=wplot*hplot;
    %     if wplot==hplot || wplot>hplot
    %         hplot=hplot+1;
    %     else
    %         wplot=wplot+1;
    %     end
else
    rrr=clusterCount;
end

if isempty(t_traj)
    for i=1:length(nor_traj)
    t_traj{i}=[1:1:length(nor_traj{1})];
    end
end

clus=cell(1,clusterCount);
figure(fig_no);
clf(fig_no);
hold off

for j=1:clusterCount
    memStr=[];
    clus{j}=find(c(:,1)==j);

    %combinedStr=strcat('(cluster:',num2str(j),')');
    ax = subplot(hplot,wplot,j);
    cla(ax);
    ttt=10;
    cc=hsv(ttt); %(length(clus{j}));
    
    if length(clus{j})<ttt 
        ttt=length(clus{j});
    end
    for i=1:ttt %length(clus{j})
        ind=clus{j}(i,1);
        if showMems==1
            memStr = strcat(memStr,',',num2str(ind));
        elseif showMems==2
            memStr = strcat(memStr,',',num2str(p(ind)));
        end
        color=cc(i,:);
        plot(t_traj{ind},nor_traj{ind},'color',color,'LineWidth',2)
        hold on
    end
    if ~isempty(centroid)
        ti=(1:length(centroid{j}));
        plot(ti,centroid{j},'--b','LineWidth',2)
    end
    combinedStr = strcat('Clus(',num2str(length(clus{j})),')');
   
    if showMems>0
        combinedStr = strcat(combinedStr,'-',memStr);
    end
    title(combinedStr);
end