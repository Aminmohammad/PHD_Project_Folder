function suprvised_PCA_Result = WrittenV2_SPCA_postProc ( varargin ) 

% Inputs:
%           matrix_of_DataPoints (Matrix):
%
%                              DataPoints
%                           __              __
%                           |                |
%                           |                |            
%              Dimensions   |                |
%                           |_              _|



%           classLabels_from_DataSet (Vector):
%
%                                 Labels
%                           __              __
%                           |_               _|                                   
%
%                                    or                            
%                                  __  __
%                                  |    |
%                                  |    |            
%                          Labels  |    |
%                                  |_  _|
   %% Section 0: Preliminaries

    %% Section  1: Extraction of Essential Parameters
        % Level 1: Extraction of Input
            inputSet = inputParser();
            inputSet.CaseSensitive = false;
            inputSet.KeepUnmatched = true;
            inputSet.addParameter('selected_Indices_of_Devices_for_postProcessing', '');
            inputSet.addParameter('selected_Type_of_FingerPrints_for_postProcessing', '');                            
            inputSet.addParameter('draw_or_Not', 1 );     
            inputSet.addParameter('selected_Dimensions_for_Draw', [ 1 2 ] );
            inputSet.addParameter('axis_Labels', 1 ); 
            inputSet.addParameter('special_PlotTitle', [] );            
            inputSet.addParameter('general_PlotTitle', [] );                        

            inputSet.addParameter('matrix_of_DataPoints', []);
            inputSet.addParameter('classLabels_from_DataBank', []);             

            inputSet.addParameter('special_Structure_of_Parameters_for_postProcessing', []);              
            inputSet.parse(varargin{:});

            selected_Indices_of_Devices_for_postProcessing                                           = inputSet.Results.selected_Indices_of_Devices_for_postProcessing;
            selected_Type_of_FingerPrints_for_postProcessing                                         = inputSet.Results.selected_Type_of_FingerPrints_for_postProcessing;
            do_you_Want_to_Draw_Raw_and_Projected_DataPoints_in_a_two_or_three_Dimensional_Plot      = inputSet.Results.draw_or_Not;            
            selected_Dimensions_for_Draw                                                             = inputSet.Results.selected_Dimensions_for_Draw;
            axis_Labels                                                                              = inputSet.Results.axis_Labels;
            special_PlotTitle                                                                        = inputSet.Results.special_PlotTitle;
            general_PlotTitle                                                                        = inputSet.Results.general_PlotTitle;
            
            matrix_of_DataPoints                                                                     = inputSet.Results.matrix_of_DataPoints;
            classLabels_from_DataBank                                                                = inputSet.Results.classLabels_from_DataBank;

            special_Structure_of_Parameters_for_postProcessing                                       = inputSet.Results.special_Structure_of_Parameters_for_postProcessing;
            
          
            if        ( isempty( matrix_of_DataPoints ) == 1 )        
                error ( 'You should Enter the "matrix of DataPoints" for "Outlier Detection".' );

            elseif    ( isempty( classLabels_from_DataBank ) == 1 )        
                error ( 'You should Enter the "classLabels from DataBank" for "Outlier Detection".' );
            
            end  

            if ( isempty ( special_Structure_of_Parameters_for_postProcessing ) == 0 && isempty ( isfield ( special_Structure_of_Parameters_for_postProcessing, 'graph_Text_Size' ) ) == 0 )
                graph_Text_Size   = special_Structure_of_Parameters_for_postProcessing.graph_Text_Size;
                
            else 
                graph_Text_Size = .07;
                
            end        
            
        % Level 2: Converting the 'classLabels_from_DataSet' to 'Horizontal Vactors'
            classLabels_from_DataBank    = classLabels_from_DataBank ( : )';
          
        % Level 3: Converting the 'selected_Dimensions_for_Draw' to 'Horizontal Vactors'
            selected_Dimensions_for_Draw = selected_Dimensions_for_Draw ( : )';
          
        % Level 4: Checking if each of 'selected_Dimensions_of_Components_for_Draw'    
                %  is bigger than the number of dimensions of 'matrix_of_DataPoints'
                    if ( max ( selected_Dimensions_for_Draw ) > size ( matrix_of_DataPoints, 1 ) ) %#ok<UDIM>
                        fprintf ( 'none of "selected Dimensions of Components for Draw" can not be bigger than "Row-Number" of "matrix_of_DataPoints" which is Dimension-Number (P).\n' )
                        fprintf ( 'Then we reduced "selected Dimensions of DataPoints for Draw" to "1:%d (p)" \n', size ( matrix_of_DataPoints, 1 ) )
                        selected_Dimensions_for_Draw = 1 : size ( matrix_of_DataPoints, 1 ); %#ok<*NASGU>
          
                    end

% save('z2.mat','z2'), hgjgjhg
%%%%%%%%%%%%%%%
% impute missingmatrix_of_DataPointsfor 10 days
% fclassLabels_from_DataBank=(mod(0:209,5)+1)';
% for icheck=1:length(fclassLabels_from_DataBank)
%     if fclassLabels_from_DataBank(icheck)==classLabels_from_DataBank(icheck)
%         continue;
%     else
%         dayindex=fclassLabels_from_DataBank(icheck);
%         lastind=find(dayindex==classLabels_from_DataBank(1:(icheck-1)),1,'last');
%         nextind=find(dayindex==classLabels_from_DataBank(icheck:end),1,'first') + icheck-1;
%         impdata=mean([data(lastind,:);data(nextind,:)],1);
%         % impute classLabels_from_DataBank and data
%         data=[data(1:(icheck-1),:);impdata;data(icheck:end,:)];
%         classLabels_from_DataBank=[classLabels_from_DataBank(1:(icheck-1));fclassLabels_from_DataBank(icheck);classLabels_from_DataBank(icheck:end)];
%     end;
% end;
%%%%%%%%%%%%%%%

%% Visualize Raw Data
% figure();clf;
% plot(7,300,'r-','linewidth',1.5);
% hold on;plot(0,0,'cv-','linewidth',1.5);
% plot(7,300,'g-.','linewidth',1.5);
% plot(7,300,'m--','linewidth',1.5);
% plot(7,300,'bx-','linewidth',1.5);
% 
% [~,order]=sort(rand(1,210));
% for (i=order)
%     if(classLabels_from_DataBank(i)==1);
%         plot([7:(17/67):24],data(i,:),'r-','linewidth',1.5);
%     elseif (classLabels_from_DataBank(i)==2);
%         plot([7:(17/67):24],data(i,:),'cv-','linewidth',1.5);
%     elseif(classLabels_from_DataBank(i)==3);
%         plot([7:(17/67):24],data(i,:),'g-.','linewidth',1.5);
%     elseif(classLabels_from_DataBank(i)==4);
%         plot([7:(17/67):24],data(i,:)','m--','linewidth',1.5);
%     else
%         plot([7:(17/67):24],data(i,:)','bx-','linewidth',1.5);
%     end;
% end;
%     set(gca,'XTick',[8:2:24])
%     xlim([7,24])
% h_legend=legend('Mon','Tue','Wed','Thu','Fri');
% set(h_legend,'fontsize',20);
%     set(gca,'fontsize',20);
% xlabel(['Time of Day'],'fontsize',25);
% ylabel('Call Volume','fontsize',25);

%% Normalize Data
% normalize arrival rates through square root transformation
X=matrix_of_DataPoints'; 
classLabels_from_DataBank=classLabels_from_DataBank';

% create dummy variables for classLabels_from_DataBank index
labels = unique (classLabels_from_DataBank);
Y = [];
for index = 1 : length (labels)
    temp = (classLabels_from_DataBank == labels ( index, 1 ));
    Y = [ Y temp ]; 
    
end

% calculate average arrival rates in each 15-min interval across days
avgX=mean(X,1); 
X=bsxfun(@minus,X,avgX); % center each column

Y=bsxfun(@minus,Y,mean(Y,1)); % center supervision data
Y=Y(:,1:(end-1)); % make Y full column rank to avoid overfitting

%% select rank for X based on scree plot
% figure();clf;
% [~,D,~]=svd(X,'econ');
% scree=diag(D).^2/sum(diag(D).^2);
% plot([1:10],scree(1:10),'b.-','linewidth',1.5,'markersize',30);
% xlabel('Rank','fontsize',15);
% ylabel('Variance Explained','fontsize',15);
% set(gca,'fontsize',15);
% title('Scree Plot of X','fontsize',20)

% set rank for X
r = 200;

%% Identify low-rank structure with different methods
% SVD (or equivalently PCA, since X has been column centered)
% [~,~,V]=svds(X,r);
% V=bsxfun(@times,V,[-1,1,1,1]);
% U=X*V;

% SupPCA
[B_s,V_s,U_s,se2_s,Sf_s]=SupPCA(Y,X,r);
signV=diag(sign(V_s'*V_s))';
V_s=bsxfun(@times,V_s,signV);
B_s=bsxfun(@times,B_s,signV);
temp = U_s'; % temp: 200 X 641
suprvised_PCA_Result = [ temp(1:200, :); classLabels_from_DataBank' ];

% % SupSFPC only with smoothness
% [B_sf1,V_sf1,U_sf1,se2_sf1,Sf_sf1]=SupSFPCA(Y,X,r,struct('lambda',0,'gamma',0));
% signV=diag(sign(V_sf1'*V))';
% V_sf1=bsxfun(@times,V_sf1,signV);
% B_sf1=bsxfun(@times,B_sf1,signV);
% 
% 
% % SupSFPC with smoothness and sparsity
% [B_sf2,V_sf2,U_sf2,se2_sf2,Sf_sf2]=SupSFPCA(Y,X,r);
% I=[1;3;4;2]; % change the order of loadings for better comparison with other methods
% V_sf2=V_sf2(:,I);
% B_sf2=B_sf2(:,I);
% Sf_sf2=Sf_sf2(I,I);
% signV=diag(sign(V_sf2'*V))';
% V_sf2=bsxfun(@times,V_sf2,signV);
% B_sf2=bsxfun(@times,B_sf2,signV);



%% Visualize Loading Estimates 
% figure();clf;
% for i=1:4
%     subplot(2,2,i)
%     plot([7:(17/67):24],V(:,i),'b-','linewidth',2); hold on;
%     plot([7:(17/67):24],V_s(:,i),'k:','linewidth',2); hold on;
%     plot([7:(17/67):24],V_sf1(:,i),'r-','linewidth',2); hold on;
%     plot([7:(17/67):24],V_sf2(:,i),'m-.','linewidth',2); hold on;
%     h_legend=legend('SVD','SupPCA','SupSFPCA (smooth only)','SupSFPCA (smooth and sparse)');
%     set(h_legend,'fontsize',20);
%     set(gca,'fontsize',20);
%     set(gca,'XTick',[8:2:24])
%     plot([7,24],[0,0],'k-');
%     xlim([7,24])
% %     ylim([-.15,.35])
%     xlabel(['Time of Day'],'fontsize',20);
%     title(['Loading V_',num2str(i)],'fontsize',30);
% end;
% 
% 
% 
% %% Visualize Supervision Effect
% % of day-of-week index on arrival patterns
% % using SupSFPCA with smoothness only
% super=bsxfun(@plus,(Y*B_sf1*V_sf1')',avgX').^2-.25; % inverse transform supervision-driven structure to original scale
% size(super)
% 
% figure(1);clf;
% plot([7.125:0.25:23.875],super(:,1),'color','r','Marker','d','markersize',6,'linewidth',3); % Monday
% hold on;
% plot([7.125:0.25:23.875],super(:,2),'color','c','Marker','o','markersize',6,'linewidth',3); % tuesday
% plot([7.125:0.25:23.875],super(:,3),'color','g','Marker','^','markersize',6,'linewidth',3); % wed
% plot([7.125:0.25:23.875],super(:,4),'color','m','Marker','s','markersize',6,'linewidth',3); % thur
% plot([7.125:0.25:23.875],super(:,5),'color','b','Marker','v','markersize',6,'linewidth',3); % fr
% h=legend('Mon','Tue','Wed','Thu','Fri');
% set(h,'fontsize',25);
% set(gca,'fontsize',25,'Xtick',[8:2:24]);
% xlim([7,24]);
% ylim([0,2500]);
% xlabel('Time of Day','fontsize',25);
% ylabel('Arrival Rates','fontsize',25);
% title('Day-of-Week Arrival Pattern','fontsize',30)
% 

%% One-Day-Ahead Forecasting
% % use past 150 days ofmatrix_of_DataPointsto forecast arrival rates for the next day
% % use dimension reduction methods + AR(1) on each score vector for forecasting
% % See more details in Li et al. (2016)
% % *This may take some time (hours) to finish*
% 
% 
% Xpred1=zeros(60,p); % SVD+AR(1)
% Xpred2=zeros(60,p); % SupPCA+AR(1)
% Xpred3=zeros(60,p); % SupSFPCA+AR(1)
% Xpred4=zeros(60,p); % historical average for the same classLabels_from_DataBank (benchmark)
% 
% 
% start=150; 
% for i=(start+1):n
%     X_train=X((i-start):(i-1),:);
%     Y_train=Y((i-start):(i-1),:);
%     classLabels_from_DataBank_train=classLabels_from_DataBank((i-start):(i-1));
%     
%     
%     % SVD + AR(1)
%     %%%%%%%%%%%%%%%%%%%%%%
%     [~,~,V]=svds(X_train,r);
%     U=X_train*V;
%     U_pred=zeros(1,r);
%     for j=1:r
%         tempX=[ones(size(Y_train,1)-1,1),Y_train(1:(end-1),:),U(1:(end-1),j)];
%         tempY=U(2:end,j);
%         param=(inv(tempX'*tempX))*tempX'*tempY;
%         U_pred(j)=[1,Y_train(end,:),U(end,j)]*param;
%     end;
%     Xpred1(i-start,:)=U_pred*V';
%     %%%%%%%%%%%%%%%%%%%%%%%
% 
%     
% 
%     % SupPCA + AR(1)
%     %%%%%%%%%%%%%%%%%%%%%%%%
%     [B,V,U,se2,Sf]=SupPCA(Y_train,X_train,r);
%     U_pred=zeros(1,r);
%     for j=1:r
%         tempX=[ones(size(Y_train,1)-1,1),Y_train(1:(end-1),:),U(1:(end-1),j)];
%         tempY=U(2:end,j);
%         param=(inv(tempX'*tempX))*tempX'*tempY;
%         U_pred(j)=[1,Y_train(end,:),U(end,j)]*param;
%     end;
%     Xpred2(i-start,:)=U_pred*V';
%     %%%%%%%%%%%%%%%%%%%%%%%%
%     
%    
%    
%     % SupSFPC (smooth only) + AR(1)
%     %%%%%%%%%%%%%%%%%%%%%%%%
%     [B,V,U,se2,Sf]=SupSFPCA(Y_train,X_train,r,struct('lambda',0,'gamma',0));
%     U_pred=zeros(1,r);
%     for j=1:r
%         tempX=[ones(size(Y_train,1)-1,1),Y_train(1:(end-1),:),U(1:(end-1),j)];
%         tempY=U(2:end,j);
%         param=(inv(tempX'*tempX))*tempX'*tempY;
%         U_pred(j)=[1,Y_train(end,:),U(end,j)]*param;
%     end;
%     Xpred3(i-start,:)=U_pred*V';
%     %%%%%%%%%%%%%%%%%%%%%%%%
%     
%     
%     
%     % Historical Avg for that day of week (Benchmark)
%     %%%%%%%%%%%%%%%%%%%%%%%
%     Xpred4(i-start,:)=mean(X_train(classLabels_from_DataBank_train==classLabels_from_DataBank(i),:),1);
%     %%%%%%%%%%%%%%%%%%%%%%%
%     
% 
% end;
% 
% 
% % Convert Xpred to Rawmatrix_of_DataPointslevel
% Npred1=(bsxfun(@plus,Xpred1,avgX).^2) -.25;
% Npred2=(bsxfun(@plus,Xpred2,avgX).^2) -.25;
% Npred3=(bsxfun(@plus,Xpred3,avgX).^2) -.25;
% Npred4=(bsxfun(@plus,Xpred4,avgX).^2) -.25;
% Ntrue=data((start+1):end,:); % true raw data
% 
% 
% % Measure prediction errors
% RMSE1=sqrt(mean((Npred1-Ntrue).^2,2));
% RMSE2=sqrt(mean((Npred2-Ntrue).^2,2));
% RMSE3=sqrt(mean((Npred3-Ntrue).^2,2));
% RMSE4=sqrt(mean((Npred4-Ntrue).^2,2));
% %
% MRE1=100*mean(abs(Npred1-Ntrue)./Ntrue,2);
% MRE2=100*mean(abs(Npred2-Ntrue)./Ntrue,2);
% MRE3=100*mean(abs(Npred3-Ntrue)./Ntrue,2);
% MRE4=100*mean(abs(Npred4-Ntrue)./Ntrue,2);
% 
% % compare different methods
% quantile(RMSE1,[0.25,0.5,0.75]) % SVD
% quantile(RMSE2,[0.25,0.5,0.75]) % SupPCA
% quantile(RMSE3,[0.25,0.5,0.75]) % SupSFPCA (smooth only)
% quantile(RMSE4,[0.25,0.5,0.75]) % HA
% %
% quantile(MRE1,[0.25,0.5,0.75]) % SVD
% quantile(MRE2,[0.25,0.5,0.75]) % SupSVD
% quantile(MRE3,[0.25,0.5,0.75]) % SupSFPCA (smooth only)
% quantile(MRE4,[0.25,0.5,0.75]) % HA
% 
% 
% % plot forecasting errors
% figure(1);clf;
% boxplot([RMSE1,RMSE2,RMSE3,RMSE4],...
%     'positions', [1,3,5,7], 'labels', {'SVD','SupPCA','SupSFPCA','HA'});
% hold on;
% plot([0,8],[0,0],'k-');
% ylabel('RMSE','fontsize',20);
% title(['Boxplot for Rolling Forecasting Errors'],'fontsize',25);
% 
% 
% 
% figure(2);clf;
% boxplot([MRE1,MRE2,MRE3,MRE4],...
%     'positions', [1,3,5,7], 'labels', {'SVD','SupPCA','SupSFPCA','HA'});
% hold on;
% plot([0,8],[0,0],'k-');
% ylabel('MRE','fontsize',20);
% title(['Boxplot for Rolling Forecasting Errors'],'fontsize',25);