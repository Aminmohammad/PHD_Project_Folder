function [ vertical_Structure_of_Raw_Seperated_Mapped_DataPoints_to_PCA_Space_for_all_Classes, vertical_Structure_of_DimReduced_Seperated_Mapped_DataPoints_to_PCA_Space_for_all_Classes ] = FaradarsV2_DimRed_PostProc ( varargin )

% Inputs:
%           matrix_of_DataPoints (Matrix):
%
%                              DataPoints
%                           __              __
%                           |                |
%                           |                |            
%              Dimensions   |                |
%                           |_              _|



%           classLabels_from_DataBank (Vector):
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
            inputSet.addParameter('matrix_of_DataPoints', []);
            inputSet.addParameter('classLabels_from_DataBank', []);
            
            inputSet.addParameter('draw_or_Not', 1);
            inputSet.addParameter('selected_Dimensions_of_Components', 1);
            inputSet.addParameter('selected_Components_for_Draw', 1);
            inputSet.addParameter('selected_Dimensions_of_Components_for_Draw', [ 1 2 ]);
            inputSet.addParameter('axis_Labels', '');
            inputSet.addParameter('plot_Title', '');

            inputSet.parse(varargin{:});

            matrix_of_DataPoints                                                                     = inputSet.Results.matrix_of_DataPoints;
            classLabels_from_DataBank                                                                = inputSet.Results.classLabels_from_DataBank;
            selected_Components_for_Draw                                                             = inputSet.Results.selected_Components_for_Draw;
            selected_Dimensions_of_Components                                                        = inputSet.Results.selected_Dimensions_of_Components;
            selected_Dimensions_of_Components_for_Draw                                               = inputSet.Results.selected_Dimensions_of_Components_for_Draw;
            do_you_Want_to_Draw_nonOutlier_and_Outlier_DataPoints_in_a_two_or_three_Dimensional_Plot = inputSet.Results.draw_or_Not;
            axis_Labels                                                                              = inputSet.Results.axis_Labels;
            plot_Title                                                                               = inputSet.Results.plot_Title;
            
            if    ( isempty( matrix_of_DataPoints ) == 1 )        
                error ( 'You should Enter the "matrix of DataPoints" for "postProcessing PCA Dimension Reduction".' );

            elseif    ( isempty( classLabels_from_DataBank ) == 1 )        
                error ( 'You should Enter the "classLabels from DataBank" for "postProcessing PCA Dimension Reduction".' );

            end  
            
        % Level 2: Tranposing the 'matrix_of_DataPoints' for 'PCA'
                  % After Tranposing:
                  %                               Dimensions
                  %                           __              __
                  %                           |                |
                  %                           |                |            
                  %              DataPoints   |                |
                  %                           |_              _|
            matrix_of_DataPoints      = matrix_of_DataPoints';
               
        % Level 3: Converting the 'classLabels_from_DataBank' to 'Horizontal Vactors'
            classLabels_from_DataBank = classLabels_from_DataBank ( : );

        % Level 4: Converting the 'selected_Dimensions_for_Draw' to 'Horizontal Vactors'
            selected_Dimensions_of_Components_for_Draw = selected_Dimensions_of_Components_for_Draw(:)';
        
        % Level 5: Determination of Size of each Class
            label_of_Different_Classes = unique ( classLabels_from_DataBank );
            for class_Index = 1 : size ( label_of_Different_Classes, 1 )
                indices_of_Different_Classes ( class_Index, 1 ).indices = ( classLabels_from_DataBank == label_of_Different_Classes ( class_Index, 1 ) );
                size_of_all_Classes ( 1, class_Index ) = sum ( [ indices_of_Different_Classes( class_Index, 1 ).indices ] );
                
            end
            
        % Level 6: Checking if each of 'selected_Dimensions_of_Components_for_Draw'    
                %  is bigger than the number of dimensions of 'matrix_of_DataPoints'
                    if ( max ( selected_Dimensions_of_Components_for_Draw ) > size ( matrix_of_DataPoints, 2 ) )
                        fprintf ( 'non of "selected Dimensions of Components for Draw" can not be bigger than "Row-Number" of "matrix_of_DataPoints" which is Dimension-Number (P).\n' )
                        fprintf ( 'Then we reduced "selected Dimensions of Components for Draw" to "1:%d(p)" \n', size ( matrix_of_DataPoints, 2 ) )
                        selected_Dimensions_of_Components_for_Draw = 1 : size ( matrix_of_DataPoints, 2 );
                        
                    end

    %% Section  2: Calculation of 'PCA'
        % Level 1: PCA
            [ principal_Component_Coordinations, principal_Component_Mapped_DataPoints, principal_Component_Variances ]=pca( matrix_of_DataPoints );
principal_Component_Coordinations            
size(principal_Component_Mapped_DataPoints)
size(principal_Component_Variances)
kjhkjh
        % Level 2: Sepertion of 'Raw Mapped DataPoints in PC Space'     
            for class_Index = 1 : size ( size_of_all_Classes, 2 )
                
                if ( class_Index == 1 )
                    vertical_Structure_of_Raw_Seperated_Mapped_DataPoints_to_PCA_Space_for_all_Classes ( class_Index, 1 ). mapped_DataPoint_for_a_Single_Class = principal_Component_Mapped_DataPoints ( 1 : size_of_all_Classes ( 1, class_Index ), : );
                    
                else
                    
                    start_Index = sum ( size_of_all_Classes ( 1, 1 : class_Index - 1 ) ) + 1; 
                    end_Index   = sum ( size_of_all_Classes ( 1, 1 : class_Index - 1 ) ) + size_of_all_Classes ( 1, class_Index );
                    
                    vertical_Structure_of_Raw_Seperated_Mapped_DataPoints_to_PCA_Space_for_all_Classes ( class_Index, 1 ). mapped_DataPoint_for_a_Single_Class = principal_Component_Mapped_DataPoints ( start_Index : end_Index, : );

                end                
                
            end

        % Level 3: Sepertion of 'Dimreduced Mapped DataPoints in PC Space'             
            matrix_of_Mapped_DataPoints =[];
            for class_Index = 1 : size ( label_of_Different_Classes, 1 )
                matrix_of_Mapped_DataPoints = [ matrix_of_Mapped_DataPoints; [vertical_Structure_of_Raw_Seperated_Mapped_DataPoints_to_PCA_Space_for_all_Classes( class_Index, 1 ). mapped_DataPoint_for_a_Single_Class] ];
            end

            for class_Index = 1 : size ( label_of_Different_Classes, 1 )
                current_Class_Indices = [ indices_of_Different_Classes( class_Index, 1 ).indices ];                                                     

                vertical_Structure_of_DimReduced_Seperated_Mapped_DataPoints_to_PCA_Space_for_all_Classes( class_Index, 1 ). dimReduced_Mapped_DataPoint_for_a_Single_Class = matrix_of_Mapped_DataPoints ( current_Class_Indices, selected_Dimensions_of_Components );


            end

        % Level 4: Formation of 'Seperators' for Determination of Direction of Principle Components   
            for component_Index = 1 : size ( principal_Component_Coordinations, 2 )
                principal_Component_Coordinations( :, component_Index ) = sqrt( principal_Component_Variances ( component_Index, 1 ) ) * principal_Component_Coordinations( :, component_Index );

            end

    %% Section  3: Plot     
        % Level 1: Formation of 'principal_Component_Coordinations' using 'selected_Components_for_Draw'
            principal_Component_Coordinations_for_Draw = principal_Component_Coordinations ( :, selected_Components_for_Draw );
    
            if ( do_you_Want_to_Draw_nonOutlier_and_Outlier_DataPoints_in_a_two_or_three_Dimensional_Plot )
                Colors=hsv(size ( principal_Component_Coordinations_for_Draw, 1 ) + size ( label_of_Different_Classes, 1 ));

                if   ( size ( selected_Dimensions_of_Components_for_Draw, 2 ) <= 3 )

                    if   ( size ( selected_Dimensions_of_Components_for_Draw, 2 ) == 2 )

                        % Input
                            figure
                            for class_Index = 1 : size ( label_of_Different_Classes, 1 )
                                current_Class_Indices = [ indices_of_Different_Classes( class_Index, 1 ).indices ];                     
                              
                                X = matrix_of_DataPoints ( current_Class_Indices, selected_Dimensions_of_Components_for_Draw ( 1, 1 ) );
                                Y = matrix_of_DataPoints ( current_Class_Indices, selected_Dimensions_of_Components_for_Draw ( 1, 2 ) );              
                                h ( class_Index, 1 ) = plot( X, Y, 'o', 'Color', Colors ( class_Index, : ),  'MarkerSize', 10, 'DisplayName',sprintf ('Class: %d', class_Index ) );
                                hold on

                            end

                            for component_Index = 1 : size ( principal_Component_Coordinations_for_Draw, 2 )
                                first_Component_Point  = principal_Component_Coordinations_for_Draw ( selected_Dimensions_of_Components_for_Draw ( 1, 1 ), component_Index );
                                second_Component_Point = principal_Component_Coordinations_for_Draw ( selected_Dimensions_of_Components_for_Draw ( 1, 2 ), component_Index );

                                h ( size ( label_of_Different_Classes, 1 ) + component_Index, 1 ) = plot([0 first_Component_Point],[0 second_Component_Point],'Color', Colors ( size ( label_of_Different_Classes, 1 ) + component_Index, : ),'LineWidth', 3, 'DisplayName',sprintf ('Component: %d (%d^t^h Comp.)', component_Index, selected_Components_for_Draw ( 1, component_Index ) ));

                            end

                            if ( isempty ( axis_Labels ) == 0 )
                                xlabel( axis_Labels{1} )
                                ylabel( axis_Labels{2} )

                            end
                                            
                            if ( isempty ( plot_Title ) == 0 )
                                title( [ plot_Title ' >>> DimReduced (with "selected Dimensions of Components for Draw") Raw Data '] )

                            end        
                            hold off;
                            legend(h, 'Location','best')
                        
                        % Output     
                            figure;
                            matrix_of_Mapped_DataPoints =[];
                            for class_Index = 1 : size ( label_of_Different_Classes, 1 )
                                matrix_of_Mapped_DataPoints = [ matrix_of_Mapped_DataPoints; [vertical_Structure_of_Raw_Seperated_Mapped_DataPoints_to_PCA_Space_for_all_Classes( class_Index, 1 ). mapped_DataPoint_for_a_Single_Class] ];
                                
                            end
                            
                            for class_Index = 1 : size ( label_of_Different_Classes, 1 )
                                current_Class_Indices = [ indices_of_Different_Classes( class_Index, 1 ).indices ];                                                     

                                X = matrix_of_Mapped_DataPoints ( current_Class_Indices, selected_Dimensions_of_Components_for_Draw ( 1, 1 ) );
                                Y = matrix_of_Mapped_DataPoints ( current_Class_Indices, selected_Dimensions_of_Components_for_Draw ( 1, 2 ) );           
                                h ( class_Index, 1 ) = plot( X, Y, 'o', 'Color', Colors ( class_Index, : ),  'MarkerSize', 10, 'DisplayName',sprintf ('Class: %d', class_Index ) );
                                hold on

                            end

                            for component_Index = 1 : size ( principal_Component_Coordinations_for_Draw, 2 )
                                first_Component_Point  = principal_Component_Coordinations_for_Draw ( selected_Dimensions_of_Components_for_Draw ( 1, 1 ), component_Index );
                                second_Component_Point = principal_Component_Coordinations_for_Draw ( selected_Dimensions_of_Components_for_Draw ( 1, 2 ), component_Index );

                                h ( size ( label_of_Different_Classes, 1 ) + component_Index, 1 ) = plot([0 first_Component_Point],[0 second_Component_Point],'Color', Colors ( size ( label_of_Different_Classes, 1 ) + component_Index, : ),'LineWidth', 3, 'DisplayName',sprintf ('Component: %d (%d^t^h Comp.)', component_Index, selected_Components_for_Draw ( 1, component_Index ) ));

                            end

                            if ( isempty ( axis_Labels ) == 0 )

                                xlabel( axis_Labels{1} )
                                ylabel( axis_Labels{2} )

                            end
                            
                            if ( isempty ( plot_Title ) == 0 )

                                title( [ plot_Title ' >>> DimReduced (with "selected Dimensions of Components for Draw") Mapped Data '] )

                            end        
                            hold off;
                            legend(h, 'Location','best')                                                    
                     
                    elseif   ( size ( selected_Dimensions_of_Components_for_Draw, 2 ) == 3 )
                        
                        % Input
                            for class_Index = 1 : size ( label_of_Different_Classes, 1 )
                                current_Class_Indices = [ indices_of_Different_Classes( class_Index, 1 ).indices ];                                                     
                                X = matrix_of_DataPoints ( current_Class_Indices, selected_Dimensions_of_Components_for_Draw ( 1, 1 ) );
                                Y = matrix_of_DataPoints ( current_Class_Indices, selected_Dimensions_of_Components_for_Draw ( 1, 2 ) );                          
                                Z = matrix_of_DataPoints ( current_Class_Indices, selected_Dimensions_of_Components_for_Draw ( 1, 3 ) );              
                                h ( class_Index, 1 ) = plot3( X, Y, Z, 'o', 'Color', Colors ( class_Index, : ),  'MarkerSize', 10, 'DisplayName',sprintf ('Class: %d', class_Index ) );
                                hold on

                            end

                            for component_Index = 1 : size ( principal_Component_Coordinations_for_Draw, 2 )
                                first_Component_Point  = principal_Component_Coordinations_for_Draw ( selected_Dimensions_of_Components_for_Draw ( 1, 1 ), component_Index );
                                second_Component_Point = principal_Component_Coordinations_for_Draw ( selected_Dimensions_of_Components_for_Draw ( 1, 2 ), component_Index );
                                third_Component_Point  = principal_Component_Coordinations_for_Draw ( selected_Dimensions_of_Components_for_Draw ( 1, 3 ), component_Index );

                                h ( size ( label_of_Different_Classes, 1 ) + component_Index, 1 ) = plot3([0 first_Component_Point], [0 second_Component_Point], [0 third_Component_Point],'Color', Colors ( size ( label_of_Different_Classes, 1 ) + component_Index, : ),'LineWidth', 3, 'DisplayName',sprintf ('Component: %d (%d^t^h Comp.)', component_Index, selected_Components_for_Draw ( 1, component_Index ) ));

                            end

                            if ( isempty ( axis_Labels ) == 0 )

                                xlabel( axis_Labels{1} )
                                ylabel( axis_Labels{2} )
                                zlabel( axis_Labels{3} )

                            end
                            
                            if ( isempty ( plot_Title ) == 0 )
                                title( [ plot_Title ' >>> DimReduced (with "selected Dimensions of Components for Draw") Raw Data '] )

                            end        
                            hold off;
                            legend(h, 'Location','best')        
                            
                        % Output     
                            figure;
                            matrix_of_Mapped_DataPoints =[];
                            for class_Index = 1 : size ( label_of_Different_Classes, 1 )
                                matrix_of_Mapped_DataPoints = [ matrix_of_Mapped_DataPoints; [vertical_Structure_of_Raw_Seperated_Mapped_DataPoints_to_PCA_Space_for_all_Classes( class_Index, 1 ). mapped_DataPoint_for_a_Single_Class] ];
                                
                            end
                            
                            for class_Index = 1 : size ( label_of_Different_Classes, 1 )
                                current_Class_Indices = [ indices_of_Different_Classes( class_Index, 1 ).indices ];                                                     

                                X = matrix_of_Mapped_DataPoints ( current_Class_Indices, selected_Dimensions_of_Components_for_Draw ( 1, 1 ) );
                                Y = matrix_of_Mapped_DataPoints ( current_Class_Indices, selected_Dimensions_of_Components_for_Draw ( 1, 2 ) );
                                Z = matrix_of_Mapped_DataPoints ( current_Class_Indices, selected_Dimensions_of_Components_for_Draw ( 1, 3 ) );
                                h ( class_Index, 1 ) = plot3( X, Y, Z, 'o', 'Color', Colors ( class_Index, : ),  'MarkerSize', 10, 'DisplayName',sprintf ('Class: %d', class_Index ) );
                                hold on

                            end

                            for component_Index = 1 : size ( principal_Component_Coordinations_for_Draw, 2 )
                                first_Component_Point  = principal_Component_Coordinations_for_Draw ( selected_Dimensions_of_Components_for_Draw ( 1, 1 ), component_Index );
                                second_Component_Point = principal_Component_Coordinations_for_Draw ( selected_Dimensions_of_Components_for_Draw ( 1, 2 ), component_Index );
                                third_Component_Point  = principal_Component_Coordinations_for_Draw ( selected_Dimensions_of_Components_for_Draw ( 1, 3 ), component_Index );

                                h ( size ( label_of_Different_Classes, 1 ) + component_Index, 1 ) = plot3([0 first_Component_Point],[0 second_Component_Point], [0 third_Component_Point],'Color', Colors ( size ( label_of_Different_Classes, 1 ) + component_Index, : ),'LineWidth', 3, 'DisplayName',sprintf ('Component: %d (%d^t^h Comp.)', component_Index, selected_Components_for_Draw ( 1, component_Index ) ));

                            end

                            if ( isempty ( axis_Labels ) == 0 )

                                xlabel( axis_Labels{1} )
                                ylabel( axis_Labels{2} )
                                zlabel( axis_Labels{3} )

                            end
                            
                            if ( isempty ( plot_Title ) == 0 )

                                title( [ plot_Title ' >>> DimReduced (with "selected Dimensions of Components for Draw") Mapped Data '] )

                            end        
                            hold off;
                            legend(h, 'Location','best')                                

                    end

                    
                    

                else
                    fprintf ( 'The Plot for Data-Points with more than 3 Selected Dimensions can not be shown ... !!!\n' );

                end



            end
            
            
            
            
            

   
