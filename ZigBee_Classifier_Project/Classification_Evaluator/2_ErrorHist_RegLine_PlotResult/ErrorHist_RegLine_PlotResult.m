function output = ErrorHist_RegLine_PlotResult( varargin )


    %% Section 0: Preliminaries
    
    %% Section 1: Extraction of Essential Parameters
        % Level 1: Extraction of Input
            inputSet = inputParser();
            inputSet.CaseSensitive = false; 
            inputSet.KeepUnmatched = true; 
            inputSet.addParameter('classLabels_from_Net', []);
            inputSet.addParameter('classLabels_from_Original_or_ReducedForApplication_DataBank', []);
            inputSet.addParameter('general_PlotTitle', []); 
            inputSet.addParameter('special_Plot_Title', []);
            inputSet.addParameter('subplot_Resize_Percentage', .5);
            inputSet.addParameter('type_of_Data', []);
            inputSet.addParameter('application_or_Training', []);

            inputSet.parse(varargin{:});

            classLabels_from_Net                                                  = inputSet.Results.classLabels_from_Net;
            classLabels_from_Original_or_ReducedForApplication_DataBank           = inputSet.Results.classLabels_from_Original_or_ReducedForApplication_DataBank;
            general_PlotTitle                                                     = inputSet.Results.general_PlotTitle;
            special_Plot_Title                                                    = inputSet.Results.special_Plot_Title;
            subplot_Resize_Percentage                                             = inputSet.Results.subplot_Resize_Percentage;
            type_of_Data                                                          = inputSet.Results.type_of_Data;
            application_or_Training                                               = inputSet.Results.application_or_Training;

            if    ( isempty( classLabels_from_Net ) == 1 )        
                error ( 'You should Enter the "classLabels from Net" for evaluation of " Error Histogram Registeration Line ".' );

            elseif    ( isempty( classLabels_from_Original_or_ReducedForApplication_DataBank ) == 1 )        
                error ( 'You should Enter the "classLabels from DataBank" for evaluation of " Error Histogram Registeration Line ".' );

            end          
        
        % Level 2: Converting the 'classLabels_from_Net' and 'classLabels_from_DataBank' to 'Horizontal Vactors'                                    
            classLabels_from_Original_or_ReducedForApplication_DataBank = classLabels_from_Original_or_ReducedForApplication_DataBank ( : )';   
            temp_classLabels_from_Net                                   = classLabels_from_Net; 

    %% Section 2: Plot    
        classLabels_from_Net = [temp_classLabels_from_Net.roundedClamped_Output];
        classLabels_from_Net = classLabels_from_Net ( : )';
        current_Field_Name   = 'roundedClamped_Output';

        k = figure( 'Name', 'ErrorHist_RegLine_PlotResult', 'NumberTitle', 'off' );

        if ( isempty ( general_PlotTitle ) == 0 )
            part_1     = sprintf ( '%s', general_PlotTitle (1, : ) );
            part_2     = sprintf ( '%s', general_PlotTitle (2, : ) );
            part_3     = sprintf ( '%s', general_PlotTitle (3, : ) );
            part_4     = type_of_Data;
            temp_Index = strfind ( part_4, '_' );
            
            if ( strcmp ( application_or_Training, 'Application' ) == 1 )
                part_4 = [ '(' application_or_Training '__' upper( current_Field_Name(1, 1) )   current_Field_Name(1, 2:end)   part_4(1, end )];
            
            elseif ( strcmp ( application_or_Training, 'Training' ) == 1 )
                part_4 = [ '(' application_or_Training '__' part_4(1, 2 : temp_Index(1,1) - 1 )  '_' upper( current_Field_Name(1, 1) )   current_Field_Name(1, 2:end)   part_4(1, end )];
            end            

            set(0,'DefaultTextInterpreter','none');
            Title   = sprintf ('%s\n%s\n%s\n%s', part_1, part_2, part_3, part_4 );
            suptitle( Title );
            set(0,'DefaultTextInterpreter','tex');

        else
            part_1     = [];
            part_2     = type_of_Data;
            temp_Index = strfind ( type_of_Data, '_' );
            part_2 = [ part_2(1, 1 : temp_Index(1,1) - 1 )  '_' upper( current_Field_Name(1, 1) )   current_Field_Name(1, 2:end)   part_4(1, end )];

            set(0,'DefaultTextInterpreter','none');
            Title   = sprintf ('%s\n%s', part_1, part_2 );        
            suptitle( Title );
            set(0,'DefaultTextInterpreter','tex');

        end 

        % classLabels_from_DataBank & classLabels_from_Net 
            g = subplot (2, 2, 1 );
            plot  ( classLabels_from_Net, 'b-o', 'linewidth', 2 );
            hold on;
            plot  ( classLabels_from_Original_or_ReducedForApplication_DataBank, 'g--*', 'linewidth', 2 );
            legend( 'Model-Labels', 'DataBank-Labels' );
            xlabel( 'X (Data-Point Index)' )
            ylabel( 'Y (Class Label)' )
            title ( 'DataBank-Labels and Model-Labels' );
            
            unique_ClassLabels_from_Original_or_ReducedForApplication_DataBank = unique ( classLabels_from_Original_or_ReducedForApplication_DataBank );            
            ylim([min(unique_ClassLabels_from_Original_or_ReducedForApplication_DataBank)  max(unique_ClassLabels_from_Original_or_ReducedForApplication_DataBank)]);
            set(gca,'YTick', min(unique_ClassLabels_from_Original_or_ReducedForApplication_DataBank):max(unique_ClassLabels_from_Original_or_ReducedForApplication_DataBank) )
            
            p = get(g,'position');
            p(4) = p(4) * subplot_Resize_Percentage;
            p(2) = .9 * p(2);
            set(g, 'position', p);

            set(gca,'fontsize',12)  

            grid on

        % Correlation Plot
            g = subplot(2,2,2);
            plot(classLabels_from_Original_or_ReducedForApplication_DataBank, classLabels_from_Net,'bo', 'LineWidth', 1);
            hold on;
            xmin = min( min( classLabels_from_Original_or_ReducedForApplication_DataBank ), min( classLabels_from_Net ) );
            xmax = max( max( classLabels_from_Original_or_ReducedForApplication_DataBank ), max( classLabels_from_Net ) );
            plot( [xmin xmax], [xmin xmax], 'k', 'LineWidth', 2, 'LineStyle', '--' );
            legend( 'Model-Labels', 'Y = X' );
            correlation_Values    = corr( classLabels_from_Original_or_ReducedForApplication_DataBank', classLabels_from_Net');
            xlabel( 'X (Class Labels from Data Bank)' )
            ylabel( 'Y (Class Labels from Model)' ) 
            temp_Correlation_Title = [ '                        Correlation Plot                        ';
                                       '   R = E( [ML-E(ML)][DL-E(DL)] )/{\surd}(\sigma_M_L\sigma_D_L)  ';
                                       '= [ E( ML \times DL )-E(ML)E(DL) ]/{\surd}(\sigma_M_L\sigma_D_L)';
                                       '           = Cov(ML, DL)/{\surd}(\sigma_M_L\sigma_D_L)          ';];
            temp_Title = [ '= ' num2str(correlation_Values)];
            length_Difference = size ( temp_Correlation_Title, 2 ) - size ( temp_Title, 2 );
            space_1 = '';
            for index = 1 : floor ( length_Difference/2 )
                space_1 = [ space_1 ' ' ];
            end
            space_2 = '';
            for index = 1 : length_Difference - floor ( length_Difference/2 )
                space_2 = [ space_2 ' ' ];
            end
            temp_Title = [ space_1 temp_Title space_2 ];
            
            correlation_Title = [ temp_Correlation_Title; temp_Title ];
            title ( correlation_Title );
                                    
            unique_ClassLabels_from_Original_or_ReducedForApplication_DataBank = unique ( classLabels_from_Original_or_ReducedForApplication_DataBank );                        
            xlim([min(unique_ClassLabels_from_Original_or_ReducedForApplication_DataBank)  max(unique_ClassLabels_from_Original_or_ReducedForApplication_DataBank)])
            set(gca,'XTick', min(unique_ClassLabels_from_Original_or_ReducedForApplication_DataBank) : max(unique_ClassLabels_from_Original_or_ReducedForApplication_DataBank)   )
            ylim([min(unique_ClassLabels_from_Original_or_ReducedForApplication_DataBank)  max(unique_ClassLabels_from_Original_or_ReducedForApplication_DataBank)])

            set(gca,'YTick', min(unique_ClassLabels_from_Original_or_ReducedForApplication_DataBank):max(unique_ClassLabels_from_Original_or_ReducedForApplication_DataBank) )
            
            
            p = get(g,'position');
            p(4) = p(4) * subplot_Resize_Percentage;
            p(2) = .9 * p(2);
            set(g, 'position', p);

            set(gca,'fontsize',12)  

            grid on

        % error Plot
            g = subplot(2,2,3);

            error_Signal = classLabels_from_Net - classLabels_from_Original_or_ReducedForApplication_DataBank;

            plot ( error_Signal, 'r --*', 'LineWidth', 2 );

            temp = MS_Error (   'classLabels_from_Net',                                        classLabels_from_Net,                  ...
                                'classLabels_from_Original_or_ReducedForApplication_DataBank', classLabels_from_Original_or_ReducedForApplication_DataBank );

            MSE  = temp.mean_Square_Error_Value;
            RMSE = sqrt( MSE );
            xlabel( 'X (Data-Point Index)' )
            ylabel( 'Y (Label Difference)' )
                          
            % Temp_Tile_1                
                temp_Title_1 = [ '                Error Plot (ML - DL)               ';                
                                 'MSE = (1/N){\Sigma} (ML_i-DL_i)^2 =_{\mu=0}\sigma^2'];            
            % Temp_Tile_2
                temp_Title_2 = [ '= ' num2str( MSE )];
                length_Difference = size ( temp_Title_1, 2 ) - size ( temp_Title_2, 2 );
                space_1 = '';
                for index = 1 : floor ( length_Difference/2 )
                    space_1 = [ space_1 ' ' ];
                end
                space_2 = '';
                for index = 1 : length_Difference - floor ( length_Difference/2 )
                    space_2 = [ space_2 ' ' ];
                end
                temp_Title_2 = [ space_1 temp_Title_2 space_2 ];
                
            % Temp_Tile_3                
                temp_Title_3 = 'RMSE = {\surd}MSE =_{\mu=0}\sigma';
                length_Difference = size ( temp_Title_2, 2 ) - size ( temp_Title_3, 2 );
                space_1 = '';
                for index = 1 : floor ( length_Difference/2 )
                    space_1 = [ space_1 ' ' ];
                end
                space_2 = '';
                for index = 1 : length_Difference - floor ( length_Difference/2 )
                    space_2 = [ space_2 ' ' ];
                end
                temp_Title_3 = [ space_1 temp_Title_3 space_2 ];
            
            % Temp_Tile_4                
                temp_Title_4 = [ '= ' num2str( RMSE )];
                length_Difference = size ( temp_Title_3, 2 ) - size ( temp_Title_4, 2 );
                space_1 = '';
                for index = 1 : floor ( length_Difference/2 )
                    space_1 = [ space_1 ' ' ];
                end
                space_2 = '';
                for index = 1 : length_Difference - floor ( length_Difference/2 )
                    space_2 = [ space_2 ' ' ];
                end
                temp_Title_4 = [ space_1 temp_Title_4 space_2 ];
                
            % Tile
                Title = [ temp_Title_1;
                          temp_Title_2;
                          temp_Title_3;
                          temp_Title_4];
            
                title( Title );
            
            maximum_Possible_Error = max ( classLabels_from_Original_or_ReducedForApplication_DataBank ) - min( classLabels_from_Original_or_ReducedForApplication_DataBank );
            ylim([ - maximum_Possible_Error, maximum_Possible_Error ]);
            set(gca,'YTick', - maximum_Possible_Error : maximum_Possible_Error   )

            p = get(g,'position');
            p(4) = p(4) * subplot_Resize_Percentage;
            set(g, 'position', p);

            set(gca,'fontsize',12) 

            grid on

        % error Histogram            
            g = subplot(2,2,4);
            output = Histogram_Values_Extractor ( error_Signal, 50, '', '', '', '' );

            x_hist     = output.x_hist;
            y_hist     = output.y_hist;
            y_Sum_Value = output.y_Sum;

            x_dist = output.x_dist;
            y_dist = output.y_dist;    

            bar (x_hist, y_hist)
            hold on
            plot(x_dist, y_dist);
            eMean = mean(error_Signal);
            eStd=std(error_Signal);
            xlabel( 'X (Error)' )
            ylabel( 'Y (Probability of Error)' )    
            
            % Temp_Tile_4                
                temp_Title_4 = '\sigma = {\surd}(1/N) \Sigma([ML_i-DL_i]-\mu)^2 =_{\mu=0}RMSE';            
                
            % Temp_Tile_5
                temp_Title_5 = [ '= ' num2str( eStd )];
                length_Difference = size ( temp_Title_4, 2 ) - size ( temp_Title_5, 2 );
                space_1 = '';
                for index = 1 : floor ( length_Difference/2 )
                    space_1 = [ space_1 ' ' ];
                end
                space_2 = '';
                for index = 1 : length_Difference - floor ( length_Difference/2 )
                    space_2 = [ space_2 ' ' ];
                end
                temp_Title_5 = [ space_1 temp_Title_5 space_2 ];
                
            % Temp_Tile_3                
                temp_Title_3 = ['= ' num2str(eMean)];
                length_Difference = size ( temp_Title_4, 2 ) - size ( temp_Title_3, 2 );
                space_1 = '';
                for index = 1 : floor ( length_Difference/2 )
                    space_1 = [ space_1 ' ' ];
                end
                space_2 = '';
                for index = 1 : length_Difference - floor ( length_Difference/2 )
                    space_2 = [ space_2 ' ' ];
                end
                temp_Title_3 = [ space_1 temp_Title_3 space_2 ];
            
            % Temp_Tile_2                
                temp_Title_2 = '\mu = (1/N) \Sigma(ML_i-DL_i)';
                length_Difference = size ( temp_Title_3, 2 ) - size ( temp_Title_2, 2 );
                space_1 = '';
                for index = 1 : floor ( length_Difference/2 )
                    space_1 = [ space_1 ' ' ];
                end
                space_2 = '';
                for index = 1 : length_Difference - floor ( length_Difference/2 )
                    space_2 = [ space_2 ' ' ];
                end
                temp_Title_2 = [ space_1 temp_Title_2 space_2 ];
                
            % Temp_Tile_1                
                temp_Title_1 = 'Error Histogram';
                length_Difference = size ( temp_Title_2, 2 ) - size ( temp_Title_1, 2 );
                space_1 = '';
                for index = 1 : floor ( length_Difference/2 )
                    space_1 = [ space_1 ' ' ];
                end
                space_2 = '';
                for index = 1 : length_Difference - floor ( length_Difference/2 )
                    space_2 = [ space_2 ' ' ];
                end
                temp_Title_1 = [ space_1 temp_Title_1 space_2 ];                
                
            % Tile
                Title = [ temp_Title_1;
                          temp_Title_2;
                          temp_Title_3;
                          temp_Title_4;
                          temp_Title_5];
            
                title( Title );                
            
            xlim([ - maximum_Possible_Error, maximum_Possible_Error ]);

            p = get(g,'position');
            p(4) = p(4) * subplot_Resize_Percentage; 
            set(g, 'position', p);

            set(gca,'fontsize',11.5)

            legend ( sprintf ('Error Histogram/%d', y_Sum_Value ), 'Error Fitted Probability Distribution' )

            grid on
            hold off

            output = [];
            
        % Setting the current Figure Invisible              
            set (gcf, 'Visible', 'off')

end