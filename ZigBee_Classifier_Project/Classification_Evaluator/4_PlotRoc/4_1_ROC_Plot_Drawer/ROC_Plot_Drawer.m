function ROC_Plot_Drawer ( input )

%% Section 1: Essential Information Extraction
    graph_Type = fieldnames ( input );
    graph_Type = char ( graph_Type );
    input      = input. (graph_Type);

%% ROC-Plot Draweing 
    over_all_Figure_Name  = sprintf ( 'Overall %s%s ROC Plot (all Cases Together)', upper(graph_Type ( 1, 1 )), lower( graph_Type( 1, 2 : end ) ));
    overall_Figure_Handle = figure ( 'name', over_all_Figure_Name );
    set( overall_Figure_Handle, 'NumberTitle', 'off' );

    % Part 2: Plotting
        fontSize = 12;
        line_Width = 2;
        marker_Size = 6;
        
        figure_Specifications.fontSize    = fontSize;
        figure_Specifications.line_Width  = line_Width;
        figure_Specifications.marker_Size = marker_Size;
    
        number_of_Spoofing_Cases = numel ( input );
        colors_Matrix            = hsv ( number_of_Spoofing_Cases );

        for spoofing_Case_Index = 1 : number_of_Spoofing_Cases
            current_Spoofed_Device  = input ( 1, spoofing_Case_Index ). reference_Device_Index;
            current_Spoofing_Device = input ( 1, spoofing_Case_Index ). testing_Device_Index;
            
            current_X_Values       = input ( 1, spoofing_Case_Index ). x_Values;
            current_Y_Values       = input ( 1, spoofing_Case_Index ). y_Values;
            
            [ current_X_Values, sorting_Indioces ] = sort ( current_X_Values );
            current_Y_Values                       = current_Y_Values ( 1, sorting_Indioces );
            
            thresholds                             = input ( 1, spoofing_Case_Index ). thresholds; 
            thresholds                             = thresholds ( 1, sorting_Indioces );
            
            reference_Device_probabilities         = input ( 1, spoofing_Case_Index ). reference_Device_probabilities; 
            testing_Device_probabilities           = input ( 1, spoofing_Case_Index ). testing_Device_probabilities; 
            
            % Seperate Figures: Each Case on a seperate Figure
                Separate_ROCPlot_Drawer (  graph_Type,                               ...
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
                                   
            % Overall Figure: all Cases together
                figure ( overall_Figure_Handle );                
                g ( 1, spoofing_Case_Index ) = plot ( current_X_Values, current_Y_Values, '-*', 'MarkerSize', marker_Size, 'LineWidth', line_Width, 'Color', colors_Matrix ( spoofing_Case_Index, : ), 'DisplayName', sprintf ( 'Rogue/Spoofing Device: %d - Authorized/Spoofed Device: %d', current_Spoofing_Device, current_Spoofed_Device) );
                hold on
                stem ( current_X_Values( 1, 1 ), current_Y_Values( 1, 1 ), 'LineWidth', line_Width, 'Marker', 'none', 'Color', colors_Matrix ( spoofing_Case_Index, : ) )  
                hold on                
                     
        end
        graph_Type = [ upper(graph_Type(1, 1)) lower(graph_Type(1, 2:end))];
        Title = ['ROC Plot for ' upper(graph_Type( 1, 1 )) lower( graph_Type( 1, 2 : end )) ' Case' ];
        if      ( strcmp ( graph_Type, 'Negative' ) == 1 )
                Title = sprintf ( '%s.\nNegative Case: Detecting "Rogue(Spoofing)/Authorized(Spoofed)" Device as "Authorized(Spoofed)" Device', Title );
            
            elseif ( strcmp ( graph_Type, 'Positive' ) == 1 )
                Title = sprintf ( '%s.\nPositive Case: Detecting "Rogue(Spoofing)/Authorized(Spoofed)" Device as "Rogue(Spoofing)" Device', Title );
            
        end
        
        title( Title, 'Interpreter', 'none' );    
        xlim ( gca, [ -.01 1.01 ] )
        ylim ( gca, [ -.01 1.01 ] )
        g ( 1, spoofing_Case_Index + 1 ) = plot ( [0 1], [0 1], 'Color', [ .5 .5 .5 ], 'DisplayName', 'Chance Line' );
        xlabel( [ 'False ' upper(graph_Type( 1, 1 )) lower( graph_Type( 1, 2 : end )) ' Rate' ] )
        ylabel( [ 'True '  upper(graph_Type( 1, 1 )) lower( graph_Type( 1, 2 : end )) ' Rate' ] )
        set(gca,'fontsize', fontSize) 
        legend ( g, 'location', 'southeast' )
        grid on 
        
        hold off;

end