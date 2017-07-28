function Projection_Plot ( varargin )

    inputSet = inputParser();
    inputSet.CaseSensitive = false;
    inputSet.KeepUnmatched = true;
    inputSet.addParameter('figure_Hanle', '');
    inputSet.addParameter('strategy', '');
    inputSet.addParameter('selected_Dimensions_for_Draw', '');
    inputSet.addParameter('matrix_of_DataPoints', '');
    inputSet.addParameter('projected_DataPoints', '');
    inputSet.addParameter('legend_of_Starting_and_Ending_Indices_of_all_Classes', '');
    inputSet.addParameter('colors_for_DataPoints', '');
    inputSet.addParameter('starting_and_Ending_Indices_of_all_Classes', '');
    inputSet.addParameter('axis_Labels', '');
    inputSet.addParameter('graph_Text_Size', '');
    inputSet.parse(varargin{:});

    figure_Hanle                                         = inputSet.Results.figure_Hanle;
    strategy                                             = inputSet.Results.strategy;
    selected_Dimensions_for_Draw                         = inputSet.Results.selected_Dimensions_for_Draw;
    matrix_of_DataPoints                                 = inputSet.Results.matrix_of_DataPoints;       
    projected_DataPoints                                 = inputSet.Results.projected_DataPoints;
    legend_of_Starting_and_Ending_Indices_of_all_Classes = inputSet.Results.legend_of_Starting_and_Ending_Indices_of_all_Classes;
    colors_for_DataPoints                                = inputSet.Results.colors_for_DataPoints;    
    starting_and_Ending_Indices_of_all_Classes           = inputSet.Results.starting_and_Ending_Indices_of_all_Classes;    
    axis_Labels                                          = inputSet.Results.axis_Labels;    
    graph_Text_Size                                      = inputSet.Results.graph_Text_Size;    

    % Stage 1: Projection Plot for 'Pure Data'
        figure ( figure_Hanle );
        if ( strcmp ( strategy, 'Drawing_Pure_DataPoints' ) )

            for dimension_Index = 1 : size ( selected_Dimensions_for_Draw, 2 ) 
                current_Dimension_of_pure_DataPoints = matrix_of_DataPoints ( dimension_Index, : );

                subplot ( size ( selected_Dimensions_for_Draw, 2 ) + size ( projected_DataPoints, 1 ), 1, dimension_Index )
                legend_Text = sprintf (' Raw Data -- User Draw Dimension: %d', dimension_Index );
                legend_Text = [ legend_Text '-->' legend_of_Starting_and_Ending_Indices_of_all_Classes ];
                g = plot( current_Dimension_of_pure_DataPoints, 'Color', colors_for_DataPoints ( dimension_Index, : ), 'DisplayName', legend_Text, 'LineWidth', 3 );            
                legend( g, 'Location', 'best' ) ;  

                hold on

                yL = get(gca,'YLim');
                for class_Index = 1 : size ( starting_and_Ending_Indices_of_all_Classes, 1 )                            
                    X = starting_and_Ending_Indices_of_all_Classes( class_Index, 2);
                    point = [ X X ];                            
                    line( point, yL, 'Color','k', 'LineStyle', '--');

                end

                hold off

                if ( isempty ( axis_Labels ) == 0 )
                    additional_Y_Label = sprintf ( ' (Datapoints (%d, :))', selected_Dimensions_for_Draw ( 1, dimension_Index ) );
                    y_Label = sprintf ( '%s\n%s',  axis_Labels{1, dimension_Index}, additional_Y_Label );
                    y = ylabel( y_Label, 'Rotation', 0 );
                    set(y, 'position', get(y,'position')-[7,0,0]);

                end

                set( gca, 'FontSize', graph_Text_Size )

            end
            
    % Stage 2: Projection Plot for 'Projected Data'            
        elseif ( strcmp ( strategy, 'Drawing_Projected_DataPoints' ) )
  
            maximum_Dimensions = 1 : size ( projected_DataPoints, 1 );
            for dimension_Index = 1 : size( maximum_Dimensions, 2 )
                current_Dimension_of_projected_DataPoints = projected_DataPoints ( dimension_Index, : );

                subplot ( size ( selected_Dimensions_for_Draw, 2 ) + size ( projected_DataPoints, 1 ), 1, dimension_Index + size ( selected_Dimensions_for_Draw, 2 ) )
                legend_Text = sprintf ('Projected Data -- Auto. Projection Dimension: %d', dimension_Index );
                legend_Text = [ legend_Text '-->' legend_of_Starting_and_Ending_Indices_of_all_Classes ];
                g = plot( current_Dimension_of_projected_DataPoints, 'Color', colors_for_DataPoints ( end - dimension_Index, : ), 'DisplayName', legend_Text, 'LineWidth', 3 );            
                legend(g, 'Location','best') ;

                hold on

                yL = get(gca,'YLim');
                for class_Index = 1 : size ( starting_and_Ending_Indices_of_all_Classes, 1 )                            
                    X = starting_and_Ending_Indices_of_all_Classes( class_Index, 2);
                    point = [ X X ];                            
                    line( point, yL, 'Color','k', 'LineStyle', '--');

                end

                hold off

                if ( isempty ( axis_Labels ) == 0 ) 

                    if ( dimension_Index == size ( projected_DataPoints, 1 ) )
                        xlabel( 'Index' )

                    end

                    y_Label = sprintf ( 'Projected \nDataPoints (%d, :)', dimension_Index );
                    y = ylabel( y_Label, 'Rotation', 0 );
                    set(y, 'position', get(y, 'position')-[7,0,0]);

                end  

                set( gca, 'FontSize', graph_Text_Size )                        

            end
        end
    
        
end