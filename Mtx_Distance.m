function dismatrix=Mtx_Distance(x,y,cond,cond2,varargin)


options = struct('dis_method','-','dtw_bound',0,'alphabet_size',0,'compression_ratio',0);
optionNames = fieldnames(options);
nArgs = length(varargin);
%if round(nArgs/2)~=nArgs/2
%     error('EXAMPLE needs propertyName/propertyValue pairs')
% end

for pair = reshape(varargin,2,[]) %# pair is {propName;propValue}
    inpName = lower(pair{1}); %# make case insensitive
    if any(strmatch(inpName,optionNames))
        options.(inpName) = pair{2};
        %    else
        %         error('%s is not a recognized parameter name',inpName)
    end
end


%compression_ratio: original_data_len / symbolic_len
if strcmp(cond,'same')
    data_n = length(x);
    dismatrix=zeros(data_n,data_n);
    for i = 1:data_n
        % disp(num2str(i));
        a=x{i};
        for j = i:data_n,
            if i ~= j
                b=x{j};
                switch options.dis_method
                    case 'Euclid'
                        dis=dis_euclidean(a,b);
                        
                    case 'Triangle'
                        dis=dis_triangle(a,b);
                    case 'DTW'
                        dis=dis_dtw3(a,b,fix(size(a,2)*options.dtw_bound));
                        %                          dis=dis_dtw3(a,b,1);
                        %                          [dis,~,~,~]=dis_dtw_complete(a,b);
                        %                         [dtw_Dist,D,dtw_k,w,s1w,s2w]=dis_dtw4(a,b,1);
                    case 'LB_Keogh'
                        dis=dis_lb_keogh(a,b,fix(size(a,2)*options.dtw_bound));
                    case 'DTW_ratio'
                        dis= (dis_euclidean(a,b)+dis_lb_keogh(a,b,fix(size(a,2)*options.dtw_bound)))/2;
                    case 'LCSS'
                        dis=dis_lcs(a, b, 3, .3);
                    case 'SAXminDis'
                        dis=dis_min_dist(a, b, options.alphabet_size,options.compression_ratio);
                    case 'SAXmaxDis'
                        dis=dis_max_dist(a, b, options.alphabet_size,options.compression_ratio);
                    case 'SAXDIST'
                        dis=dis_SAX_apx(a, b, options.alphabet_size,options.compression_ratio);
                    case 'SAX_MEANDIST'
                        dis=dis_SAX_MEANDIST(a, b, options.alphabet_size,options.compression_ratio);
                        
                    otherwise
                        error(sprintf('DOCLUSTERING - unsupported algorithm "%s"',dis_method))
                end %of switch/case
                dismatrix(i, j) =dis;
                dismatrix(j, i)=dis;
            end
        end
    end
else
    dismatrix=zeros(length(x),length(y));
    for i = 1:length(x)
        a=x{i};
        for j = 1:length(y)
            b=y{j};
            if (length(a) ~= length(b))
                display('error: the strings must have equal length!');
                return;
            end
            switch options.dis_method
                case 'Euclid'
                    dis=dis_euclidean(a,b);
                case 'Triangle'
                    dis=dis_triangle(a,b);
                case 'DTW'
                    dis=dis_dtw3(a,b,fix(size(a,2)*options.dtw_bound));
                    %  [dis,~,~,~]=dis_dtw_complete(a,b);
                case 'LB_Keogh'
                    dis=dis_lb_keogh(a,b,fix(size(a,2)*options.dtw_bound));
                case 'DTW_ratio'
                    dis= (dis_euclidean(a,b)+dis_lb_keogh(a,b,fix(size(a,2)*options.dtw_bound)))/2;
                case 'LCSS'
                    dis=dis_lcs(a, b, 3, .3);
                case 'SAXminDis'
                    dis=dis_min_dist(a, b, options.alphabet_size,options.compression_ratio);
                case 'SAXmaxDis'
                    dis=dis_max_dist(a, b, options.alphabet_size,options.compression_ratio);
                case 'SAXDIST'
                    dis=dis_SAX_apx(a, b, options.alphabet_size,options.compression_ratio);
                case 'SAX_MEANDIST'
                    dis=dis_SAX_MEANDIST(a, b, options.alphabet_size,options.compression_ratio);
                otherwise
                    error(sprintf('DOCLUSTERING - unsupported algorithm "%s"',dis_method))
            end %of switch/case
            dismatrix(i, j) =dis;
            
            %t(j)=toc;
            
        end
    end
end
if strcmp(cond2,'Norm')
    Nor = dismatrix - min( dismatrix(:) );
    if max( Nor(:) ) ~= 0
        dismatrix = Nor / max( Nor(:) );
    else
        dismatrix=Nor;
    end
end
end