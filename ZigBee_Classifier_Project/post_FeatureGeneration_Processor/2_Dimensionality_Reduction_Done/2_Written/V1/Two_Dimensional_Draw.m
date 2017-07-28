function Two_Dimensional_Draw ( fig_1,                                                ...
                                fig_2,                                                ...
                                matrix_of_DataPoints,                                 ...
                                classLabels_from_DataBank,                            ...
                                selected_Dimensions_for_Draw,                         ...
                                V,                                                    ...
                                projected_DataPoints,                                 ...
                                different_Classes,                                    ...
                                starting_and_Ending_Indices_of_all_Classes,           ...
                                legend_of_Starting_and_Ending_Indices_of_all_Classes, ...
                                colors_for_DataPoints,                                ...
                                colors_for_Lines,                                     ...
                                axis_Labels,                                          ...
                                graph_Text_Size)
                            
    % Common Parameters                            
       common_Elements_for_Projection_Plot = {   'figure_Hanle',                                           fig_2,                                                ...
                                                   'selected_Dimensions_for_Draw',                         selected_Dimensions_for_Draw,                         ...
                                                   'matrix_of_DataPoints',                                 matrix_of_DataPoints,                                 ...
                                                   'projected_DataPoints',                                 projected_DataPoints,                                 ...
                                                   'legend_of_Starting_and_Ending_Indices_of_all_Classes', legend_of_Starting_and_Ending_Indices_of_all_Classes, ...
                                                   'colors_for_DataPoints',                                colors_for_DataPoints,                                ...
                                                   'starting_and_Ending_Indices_of_all_Classes',           starting_and_Ending_Indices_of_all_Classes,           ...
                                                   'axis_Labels',                                          axis_Labels,                                          ...
                                                   'graph_Text_Size',                                      graph_Text_Size,                                      ...                                       
                                               };        
    
    % Level 1: Drawing the 'Pure Data-Points' 
               % of both 'Scatter Plot' and 'Projection Plot'

                % Stage 1: Scatter Plot
                    figure ( fig_1 );                                        
                    
                    different_Labeling_Sweep_Cases = combntns( 1 : size ( projected_DataPoints, 1 ), 2 );
                    
                    if ( size (different_Labeling_Sweep_Cases, 1) == 1 )
                        number_of_subPlots = 2;
                        subplot ( number_of_subPlots, 1, 1 )
                        
                    else
                        number_of_subPlots = ( round ( size ( different_Labeling_Sweep_Cases, 1 ) / 2 ) + 1 ) * 2;
                        subplot ( ( number_of_subPlots / 2 ), 2, [ 1 2 ] )
                        
                    end
                    
                    for class_Index = 1 : size ( different_Classes, 2 )
                        labels = ( different_Classes( 1, class_Index ) == classLabels_from_DataBank );
                        current_Class_of_pure_DataPoints = matrix_of_DataPoints ( :, labels );

                        X = current_Class_of_pure_DataPoints ( selected_Dimensions_for_Draw ( 1, 1 ), : );
                        Y = current_Class_of_pure_DataPoints ( selected_Dimensions_for_Draw ( 1, 2 ), : );                                       

                        h (1, class_Index ) = plot( X, Y, 'o', 'Color', colors_for_DataPoints ( class_Index, : ),  'MarkerSize', 10, 'DisplayName',sprintf ('Class: %d', different_Classes (1, class_Index) ));            
                        hold on

                    end

                    % Plotting the 'Component's Direction Lines'                                
                        for column_Index = 1 : size ( selected_Dimensions_for_Draw, 2 )                                         
                            h (1, class_Index + column_Index ) = plot([0 V( 1, column_Index )],[0 V( 2, column_Index )], 'Color', colors_for_Lines ( column_Index, : ), 'LineWidth', 3, 'DisplayName', sprintf ('Projection-Direction: %d', column_Index ) );

                        end

                    legend(h(1:end), 'Location','best') ;  
                    h = [];                                

                    if ( isempty ( axis_Labels ) == 0 )
                        additional_X_Label = sprintf ( ' (Datapoints (%d, :))', selected_Dimensions_for_Draw ( 1, 1 ) );
                        additional_Y_Label = sprintf ( ' (Datapoints (%d, :))', selected_Dimensions_for_Draw ( 1, 2 ) );
                        xlabel( [ axis_Labels{1} additional_X_Label ] );
                        y_Label = sprintf('%s\n%s', axis_Labels{2}, additional_Y_Label );
                        y = ylabel( y_Label, 'Rotation', 0 );                         
%                         set(y, 'position', get(y, 'position')-[.3,0,0]);

                    end
                    
                    set( gca, 'FontSize', graph_Text_Size )

                % Stage 2: Projection Plot                                                       
                    projection_Data_Paramters = [  {'strategy', 'Drawing_Pure_DataPoints'}, ...
                                                  common_Elements_for_Projection_Plot,     ...
                                                 ];
                                                       
                    Projection_Plot (  projection_Data_Paramters{:}  )
                    
% Level 2: Drawing the 'projected Data Points' 
            % of both 'Scatter Plot' and 'Projection Plot'

                % Stage 1: Scatter Plot
                    figure ( fig_1 );   
                    maximum_Dimensions = size ( different_Labeling_Sweep_Cases, 1 );
                    for dimension_Index = 1 : maximum_Dimensions                                                
                        if ( size (different_Labeling_Sweep_Cases, 1) == 1 )
                            number_of_subPlots = 2;
                            subplot ( number_of_subPlots, 1, dimension_Index + 1 )

                        else
                            number_of_subPlots = ( round ( size ( different_Labeling_Sweep_Cases, 1 ) / 2 ) + 1 ) * 2;
                            subplot ( ( number_of_subPlots / 2 ), 2, dimension_Index + 2 )

                        end  
                        
                        row_Indices = different_Labeling_Sweep_Cases ( dimension_Index, : );

                        for class_Index = 1 : size ( different_Classes, 2 )
                            column_Indices = ( different_Classes ( 1, class_Index ) == classLabels_from_DataBank );                                                        
                            current_Class_of_projected_DataPoints_for_Selected_Dimensions = projected_DataPoints ( row_Indices, column_Indices );

                            X = current_Class_of_projected_DataPoints_for_Selected_Dimensions ( 1, : );
                            Y = current_Class_of_projected_DataPoints_for_Selected_Dimensions ( 2, : );                                       

                            dimensions_Text = sprintf ( '%d ', row_Indices);
                            dimensions_Text = sprintf ( 'Auto. Projection Dimensions : [%s]', dimensions_Text(1, 1 : end - 1));
                            h (1, class_Index ) = plot( X, Y, 'o', 'Color', colors_for_DataPoints ( class_Index, : ),  'MarkerSize', 10, 'DisplayName',[ dimensions_Text sprintf(' -- Class: %d', different_Classes (1, class_Index) ) ] );             %#ok<*SAGROW>
                            hold on
                        end

                        legend(h(1:end), 'Location','best') ;  
                        h = [];

                        x_Label = sprintf ( 'Projected DataPoints (%d, :)', row_Indices ( 1, 1 ) );
                        xlabel( x_Label, 'Rotation', 0 )
                        
                        y_Label = sprintf ( 'Projected \n DataPoints (%d, :)', row_Indices ( 1, 2 ) );
                        y = ylabel( y_Label, 'Rotation', 0 );
%                         set(y, 'position', get(y, 'position')-[.3,0,0]);

                        set( gca, 'FontSize', graph_Text_Size )
                    
                    end                      

                % Stage 2: Projection Plot
                    projection_Data_Paramters = [  {'strategy', 'Drawing_Projected_DataPoints'}, ...
                                                  common_Elements_for_Projection_Plot,     ...
                                                 ];
                                                       
                    Projection_Plot (  projection_Data_Paramters{:}  )               
                    
