function Separate_ROCPlot_Drawer ( graph_Type,                               ...
                                   current_Spoofed_Device,                   ...
                                   current_Spoofing_Device,                  ...
                                   current_X_Values,                         ...
                                   current_Y_Values,                         ...
                                   figure_Specifications,                    ...
                                   spoofing_Case_Index,                      ...
                                   thresholds,                               ...
                                   reference_Device_probabilities,           ...
                                   testing_Device_probabilities,             ...
                                   colors_Matrix )

    fontSize    = figure_Specifications.fontSize;
    line_Width  = figure_Specifications.line_Width;
    marker_Size = figure_Specifications.marker_Size;
    graph_Type  = [ upper(graph_Type( 1, 1 )) lower( graph_Type( 1, 2:end )) ];

    current_Figure_Name = sprintf ( 'ROC Plot for %s ROC Plot Case  (Spoofed Device: %d - Spoofing Device: %d)', graph_Type, current_Spoofed_Device, current_Spoofing_Device );
    r = figure ( 'name', current_Figure_Name, 'numbertitle', 'off' );
    set( r, 'NumberTitle', 'off' );   
    
    % Making Margins Disapear
        make_it_tight = true;
        gap_between_subPlots = 0.15;
        margin_Bottom = 0.1;
        margin_Top    = 0.1;
        margin_Left   = 0.1;
        margin_Right  = 0.1;
        subplot = @(m,n,p) subtightplot (m, n, p, [gap_between_subPlots 0.05], [margin_Bottom margin_Top], [margin_Left margin_Right]);
        if ~make_it_tight,  clear subplot;  end
    
    if      ( numel (thresholds) <= 5 )
        do_you_Want_to_Write_Text_on_subPlots = 'Yes';
        
    elseif  ( numel (thresholds) > 5 && numel (thresholds)< 30 )
        do_you_Want_to_Write_Text_on_subPlots = 'Just-Index';
        
    else 
        do_you_Want_to_Write_Text_on_subPlots = 'No';
        
    end
    
    %% Negative subPlot ( Plot: 2 )
        subplot ( 3, 1, 2 ) 
        if     ( strcmp ( graph_Type, 'Negative' ) == 1 )
            stem (  testing_Device_probabilities, 1 : size ( testing_Device_probabilities, 2 ), 'MarkerSize', marker_Size, 'LineWidth', line_Width, 'Color', 'g' );
        
        elseif ( strcmp ( graph_Type, 'Positive' ) == 1 )
            stem (  reference_Device_probabilities, 1 : size ( reference_Device_probabilities, 2 ), 'MarkerSize', marker_Size, 'LineWidth', line_Width, 'Color', 'g' );

        end
        hold on

    %% Positive subPlot ( Plot: 3 )
        subplot ( 3, 1, 3 )   
        if     ( strcmp ( graph_Type, 'Negative' ) == 1 )
            stem (  reference_Device_probabilities, 1 : size ( reference_Device_probabilities, 2 ), 'MarkerSize', marker_Size, 'LineWidth', line_Width, 'Color', 'g' );

        elseif ( strcmp ( graph_Type, 'Positive' ) == 1 )
            stem (  testing_Device_probabilities, 1 : size ( testing_Device_probabilities, 2 ), 'MarkerSize', marker_Size, 'LineWidth', line_Width, 'Color', 'g' );
        
        end
        hold on

    %% Drawing Thresholds subPlots ( Plot: 1, 2, 3 )        
        for threshold_Index = 1 : numel ( thresholds )
            % Negative subPlot ( Plot: 2 )
                subplot ( 3, 1, 2 ) 
                line([thresholds( 1, threshold_Index ) thresholds( 1, threshold_Index )], ylim)
                y_Position_for_Text = randsample ( floor(numel(testing_Device_probabilities)/2)  :   floor ( .9 * numel(testing_Device_probabilities)), 1 );                
                
                xlim ( gca, [min(thresholds)-.0001 max(thresholds)+.0001] )
                
                if     ( strcmp ( graph_Type, 'Negative' ) == 1 )
                    
                    if     (strcmp ( do_you_Want_to_Write_Text_on_subPlots, 'Yes' ))
                        text( thresholds( 1, threshold_Index ),  y_Position_for_Text, sprintf ( 'Threshold (%d)\n FN: (Ps. > Threshold)\n(Threshold:%1.4f)\n-->', threshold_Index, thresholds( 1, threshold_Index ) ) )
                    
                    elseif (strcmp ( do_you_Want_to_Write_Text_on_subPlots, 'Just-Index' ))
                        text( thresholds( 1, threshold_Index ),  y_Position_for_Text, sprintf ( '(%d)->', threshold_Index ) )
                    
                    end
                    Title = sprintf ( 'False Negative Rate (by Applying the Rogue/Spoofing Device (%d) to the Model of Authorized/Spoofed Device (%d))', current_Spoofing_Device, current_Spoofed_Device );
                    xlabel( sprintf ( 'Rogue/Spoofing Device (%d) Data-Points Probabilities Assigned by Data-Bank Model of Spoofed Device (%d)', current_Spoofing_Device, current_Spoofed_Device ) )
                    ylabel( sprintf ( 'Rogue/Spoofing \nDevice (%d) \nIndices', current_Spoofing_Device ) )
                    
                    ylim ( gca, [ 1 numel(testing_Device_probabilities) ] )
                                    
                elseif ( strcmp ( graph_Type, 'Positive' ) == 1 )
                    if     (strcmp ( do_you_Want_to_Write_Text_on_subPlots, 'Yes' ))
                        text( thresholds( 1, threshold_Index ),  y_Position_for_Text, sprintf ( 'Threshold (%d)\n FP: (Ps. < Threshold)\n(Threshold:%1.4f)\n<--', threshold_Index, thresholds( 1, threshold_Index ) ) )
                    
                    elseif (strcmp ( do_you_Want_to_Write_Text_on_subPlots, 'Just-Index' ))
                        text( thresholds( 1, threshold_Index ),  y_Position_for_Text, sprintf ( '<-(%d)', threshold_Index ) )
                    
                    end
                    Title = sprintf ( 'False Positive Rate (by Applying the Authorized/Spoofed Device (%d) to the Model of Authorized/Spoofed Device (%d))', current_Spoofed_Device, current_Spoofed_Device );
                    xlabel( sprintf ( 'Authorized/Spoofed Device (%d) Data-Points Probabilities Assigned by Data-Bank Model of Spoofed Device (%d)', current_Spoofed_Device, current_Spoofed_Device ) )
                    ylabel( sprintf ( 'Authorized/Spoofed \nDevice (%d) \nIndices', current_Spoofed_Device ) )
                    
                    ylim ( gca, [ 1 numel(reference_Device_probabilities) ] )
                                    
                end
                
                title ( Title );
                set(gca,'fontsize', fontSize) 
                grid on 

            % Positive subPlot ( Plot: 3 )
                subplot ( 3, 1, 3 ) 
                line([thresholds( 1, threshold_Index ) thresholds( 1, threshold_Index )], ylim)
                y_Position_for_Text = randsample ( floor(numel(testing_Device_probabilities)/2)  :   floor ( .9 * numel(testing_Device_probabilities)), 1 );
                
                if     ( strcmp ( graph_Type, 'Negative' ) == 1 )             
                    if     (strcmp ( do_you_Want_to_Write_Text_on_subPlots, 'Yes' ))
                        text( thresholds( 1, threshold_Index ),  y_Position_for_Text, sprintf ( 'Threshold (%d)\n TN: (Ps. > Threshold)\n(Threshold:%1.4f)\n-->', threshold_Index, thresholds( 1, threshold_Index ) ) ) 
                        
                    elseif (strcmp ( do_you_Want_to_Write_Text_on_subPlots, 'Just-Index' ))
                        text( thresholds( 1, threshold_Index ),  y_Position_for_Text, sprintf ( '(%d)->', threshold_Index ) )
                    
                    end
                    Title = sprintf ( 'True Negative Rate (by Applying the Authorized/Spoofed Device (%d) to the Model of Authorized/Spoofed Device (%d))', current_Spoofed_Device, current_Spoofed_Device );
                    xlabel( sprintf ( 'Authorized/Spoofed Device (%d) Data-Points Probabilities Assigned by Data-Bank Model of Spoofed Device (%d)', current_Spoofed_Device, current_Spoofed_Device ) )
                    ylabel( sprintf ( 'Authorized/Spoofed \nDevice (%d) \nIndices', current_Spoofed_Device ) )
                    
                    ylim ( gca, [ 1 numel(reference_Device_probabilities) ] )
                    
                    xlim ( gca, [min([ min(thresholds) min( reference_Device_probabilities )] )-.0001     max([ max(thresholds) max( reference_Device_probabilities )] )+.0001] ) 
                                    
                elseif ( strcmp ( graph_Type, 'Positive' ) == 1 )
                    if     (strcmp ( do_you_Want_to_Write_Text_on_subPlots, 'Yes' ))
                        text( thresholds( 1, threshold_Index ),  y_Position_for_Text, sprintf ( 'Threshold (%d)\n TN: (Ps. < Threshold)\n(Threshold:%1.4f)\n<--', threshold_Index, thresholds( 1, threshold_Index ) ) )
                    
                    elseif (strcmp ( do_you_Want_to_Write_Text_on_subPlots, 'Just-Index' ))
                        text( thresholds( 1, threshold_Index ),  y_Position_for_Text, sprintf ( '<-(%d)', threshold_Index ) )
                    
                    end
                    Title = sprintf ( 'True Positive Rate (by Applying the Rogue/Spoofing Device (%d) to the Model of Authorized/Spoofed Device (%d))', current_Spoofing_Device, current_Spoofed_Device );
                    xlabel( sprintf ( 'Rogue/Spoofing Device (%d) Data-Points Probabilities Assigned by Data-Bank Model of Spoofed Device (%d)', current_Spoofing_Device, current_Spoofed_Device ) )
                    ylabel( sprintf ( 'Rogue/Spoofing \nDevice (%d) \nIndices', current_Spoofing_Device ) )
                    
                    ylim ( gca, [ 1 numel(testing_Device_probabilities) ] )
                    
                    xlim ( gca, [min([ min(thresholds) min( testing_Device_probabilities )] )-.0001     max([ max(thresholds) max( testing_Device_probabilities )] )+.0001] )
                                    
                end
                
                title ( Title );
                set(gca,'fontsize', fontSize) 
                grid on 
            
        %% ROC Plot ( Plot: 1 )  
            subplot ( 3, 1, 1 )
            plot ( current_X_Values ( 1, 1 : threshold_Index ), current_Y_Values ( 1, 1 : threshold_Index ), 'o', 'MarkerSize', 4 * marker_Size, 'Color', colors_Matrix ( spoofing_Case_Index, : ) );
            hold on 
            h (1, 1 ) = plot ( current_X_Values ( 1, 1 : threshold_Index ), current_Y_Values ( 1, 1 : threshold_Index ), '-*', 'MarkerSize', marker_Size, 'LineWidth', line_Width, 'Color', colors_Matrix ( spoofing_Case_Index, : ), 'DisplayName', sprintf ( 'Rogue/Spoofing Device: %d - Authorized/Spoofed Device: %d', current_Spoofing_Device, current_Spoofed_Device) );
            hold on
            for index = 1 : threshold_Index
                text( current_X_Values ( 1, index ), current_Y_Values ( 1, index ), sprintf ( '%d', index ) )
                
            end
            hold on

            if ( threshold_Index == 1 )
                stem ( current_X_Values( 1, 1 ), current_Y_Values( 1, 1 ), 'LineWidth', line_Width, 'Marker', 'none', 'Color', colors_Matrix ( spoofing_Case_Index, : ) )                                  

                h (1, 2 ) = plot ( [0 1], [0 1], 'Color', [ .5 .5 .5 ], 'DisplayName', 'Chance Line' );

            end

            xlim ( gca, [ -.01 1.01 ] )
            ylim ( gca, [ -.01 1.01 ] )
           
            if      ( strcmp ( graph_Type, 'Negative' ) == 1 )
                subplot_1_Title = sprintf ( '%s.\nNegative Case: Detecting "Rogue(Spoofing)/Authorized(Spoofed)" Device as "Authorized(Spoofed)" Device', current_Figure_Name );
            
            elseif ( strcmp ( graph_Type, 'Positive' ) == 1 )
                subplot_1_Title = sprintf ( '%s.\nPositive Case: Detecting "Rogue(Spoofing)/Authorized(Spoofed)" Device as "Rogue(Spoofing)" Device', current_Figure_Name );
            
            end
            
            title ( subplot_1_Title );
            xlabel( [ 'False ' graph_Type ' Rate' ] )
            ylabel( [ 'True '  graph_Type ' Rate' ] )
            set(gca,'fontsize', fontSize)
            legend(h, 'Location', 'SouthEast')
            grid on 

%             pause ( 3 )
            
        end

    