function [ vertical_Structure_of_Selected_nonOutlier_DataPoints_for_all_Classes, vertical_Structure_of_Selected_Outlier_DataPoints_for_all_Class ] = FaradarsV1_outlierDet_PreProc ( varargin )

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
            inputSet.CaseSensitive=false;
            inputSet.addParameter('selected_Classification_Method_Name', []);    
            inputSet.addParameter('matrix_of_DataPoints', []);
            inputSet.addParameter('classLabels_from_DataSet', []);
            inputSet.addParameter('decision_Alpha', 1);
            inputSet.addParameter('draw_or_Not', 1);
            inputSet.addParameter('selected_Dimensions_for_Draw', [ 1 2 ]);
            inputSet.addParameter('axis_Labels', '');
            inputSet.addParameter('plot_Title', '');

            inputSet.parse(varargin{:});

            selected_Classification_Method_Name                                                      = inputSet.Results.selected_Classification_Method_Name;
            matrix_of_DataPoints                                                                     = inputSet.Results.matrix_of_DataPoints;
            classLabels_from_DataSet                                                                 = inputSet.Results.classLabels_from_DataSet;
            decision_Alpha                                                                           = inputSet.Results.decision_Alpha;
            selected_Dimensions_for_Draw                                                             = inputSet.Results.selected_Dimensions_for_Draw;
            do_you_Want_to_Draw_nonOutlier_and_Outlier_DataPoints_in_a_two_or_three_Dimensional_Plot = inputSet.Results.draw_or_Not;
            axis_Labels                                                                              = inputSet.Results.axis_Labels;
            plot_Title                                                                               = inputSet.Results.plot_Title;
            
            if        ( isempty( selected_Classification_Method_Name ) == 1 )        
                error ( 'You should Enter the "selected Classification Method Name" for "Outlier Detection".' );

            elseif    ( isempty( matrix_of_DataPoints ) == 1 )        
                error ( 'You should Enter the "matrix of DataPoints" for "Outlier Detection" in "%s" Method.', selected_Classification_Method_Name );

            elseif    ( isempty( classLabels_from_DataSet ) == 1 )        
                error ( 'You should Enter the "classLabels from DataBank" for "Outlier Detection" in "%s" Method.', selected_Classification_Method_Name );

            end  
            
        % Level 2: Converting the 'classLabels_from_DataSet' to 'Horizontal Vactors'
            classLabels_from_DataSet = classLabels_from_DataSet ( : )';
               
        % Level 3: Converting the 'selected_Dimensions_for_Draw' to 'Horizontal Vactors'
            selected_Dimensions_for_Draw = selected_Dimensions_for_Draw ( : )';

        % Level 3: Seperation of DataPoints based on ClassLabels
            different_Labels = unique ( classLabels_from_DataSet );
            number_of_Classes = size ( different_Labels, 2 );
            for index = 1 : number_of_Classes
                selected_Logical_Indices_of_Columns_for_Current_Class = ( classLabels_from_DataSet == different_Labels ( 1, index ) );
                vertical_Structure_of_Seperated_Classes ( index, 1 ). dataPoints = matrix_of_DataPoints ( :, selected_Logical_Indices_of_Columns_for_Current_Class );
                
            end

            
        % Level 4: Centerizing each class by reducing the mean of 
                   % DataPoints from class
                   
                   for class_Index = 1 : size ( vertical_Structure_of_Seperated_Classes, 1 )
                        current_Class_of_DataPoints = [ vertical_Structure_of_Seperated_Classes( class_Index, 1 ). dataPoints ];
                    
                        % Stge 1: claculating the mean of dimenstions ( rows )
                            mean_Vertical_Vector = mean ( current_Class_of_DataPoints, 2 );
                            
                        % Stge 2: reducing the mean of dimenstions ( rows )
                            current_Class_of_DataPoints = current_Class_of_DataPoints - repmat ( mean_Vertical_Vector, 1, size ( current_Class_of_DataPoints, 2 ) );
                            
                        % Stge 3: Assigning the 'centerized matrix of DataPoints' to the 'vertical_Structure_of_Centerized_Classes'
                            vertical_Structure_of_Centerized_Classes   ( class_Index, 1 ). dataPoints = current_Class_of_DataPoints;
                    
                        % Stge 4: Assigning the 'non-centerized matrix of DataPoints' to the 'vertical_Structure_of_nonCenterized_Classes'
                            vertical_Structure_of_nonCenterized_Classes( class_Index, 1 ). dataPoints = current_Class_of_DataPoints + repmat ( mean_Vertical_Vector, 1, size ( current_Class_of_DataPoints, 2 ) );
                    
                            
                   end

        % Level 5: Calculating the 'Covariance Structure for all classes' && 
                                 % 'T^2 Criterion Structure for all Classes'
                covariance_Structure_of_all_DataPoints_in_all_Classes = struct ( 'covariance_Matrix_for_a_Single_Class', [] );
                covariance_Structure_of_all_DataPoints_in_all_Classes = repmat( covariance_Structure_of_all_DataPoints_in_all_Classes, size ( vertical_Structure_of_Seperated_Classes, 1 ), 1 );
                for class_Index = 1 : size ( vertical_Structure_of_Seperated_Classes, 1 )
                        current_Class_of_DataPoints = [ vertical_Structure_of_Centerized_Classes( class_Index, 1 ). dataPoints ];
                    
                        % Stge 1: claculating the Covariance Matrix for all DataPoints ( Columns ) in a Single Class
                            for dataPoint_Index = 1 : size ( current_Class_of_DataPoints, 2)
                                
                                current_Point = current_Class_of_DataPoints ( :, dataPoint_Index );

                                covariance_Matrix_of_Current_DataPoint = current_Point * current_Point';
                                
                                covariance_Structure_of_all_DataPoints_in_Current_Class ( 1, dataPoint_Index ).covariance_Matrix_of_Current_DataPoint = covariance_Matrix_of_Current_DataPoint;
                                
                            end
                            
                        % Stge 2: claculating the Covariance Structure for all classes
                            for dataPoint_Index = 1 : size ( covariance_Structure_of_all_DataPoints_in_Current_Class, 2 )
                                covariance_Matrix_of_Current_DataPoint =  [covariance_Structure_of_all_DataPoints_in_Current_Class( 1, dataPoint_Index ).covariance_Matrix_of_Current_DataPoint ];

                                if ( dataPoint_Index == 1 )
                                    covariance_Structure_of_all_DataPoints_in_all_Classes ( class_Index, 1 ).covariance_Matrix_for_a_Single_Class = covariance_Matrix_of_Current_DataPoint;
                                        
                                else
                                    covariance_Structure_of_all_DataPoints_in_all_Classes ( class_Index, 1 ).covariance_Matrix_for_a_Single_Class = [ covariance_Structure_of_all_DataPoints_in_all_Classes( class_Index, 1 ).covariance_Matrix_for_a_Single_Class ]  ...
                                                                                                                                            +         covariance_Matrix_of_Current_DataPoint;
                                    
                                end
                                                                                                                                        
                                
                            end
                            covariance_Structure_of_all_DataPoints_in_all_Classes ( class_Index, 1 ).covariance_Matrix_for_a_Single_Class = [ covariance_Structure_of_all_DataPoints_in_all_Classes( class_Index, 1 ).covariance_Matrix_for_a_Single_Class ]      ...
                                                                                                                                            / (size ( covariance_Structure_of_all_DataPoints_in_Current_Class, 2 ) - 1 );                               
                        % Stge 3: claculating the T^2 Criterion Matrix for a Single Class                                                           
                            for dataPoint_Index = 1 : size ( covariance_Structure_of_all_DataPoints_in_Current_Class, 2 )
                                
                                current_Point = current_Class_of_DataPoints ( :, dataPoint_Index );
                                covariance_Matrix_of_Current_Class =  [ covariance_Structure_of_all_DataPoints_in_all_Classes( class_Index, 1 ).covariance_Matrix_for_a_Single_Class ];
                                T_Structure_of_all_DataPoints_in_current_Class ( 1, dataPoint_Index ).T_Matrix_for_a_Single_Class = current_Point' * inv( covariance_Matrix_of_Current_Class ) * current_Point;
                                
                            end  
                            
                        % Stge 4: claculating the T^2 Criterion Structure for all Classes                                                   
                            T_Structure_of_all_DataPoints_in_all_Classes( class_Index, 1 ).T_Matrix_for_a_Single_Class = [T_Structure_of_all_DataPoints_in_current_Class.T_Matrix_for_a_Single_Class];
                            
                        % Stge 5: Selecting the Outlier DataPoints for all classes
                            indices_of_Selected_nonOutlier_DataPoints_for_Currrent_Class = [T_Structure_of_all_DataPoints_in_all_Classes( class_Index, 1 ).T_Matrix_for_a_Single_Class] <= decision_Alpha;
                            all_DataPoints_in_Current_Class = [ vertical_Structure_of_nonCenterized_Classes( class_Index, 1 ). dataPoints ];

                            vertical_Structure_of_Selected_nonOutlier_DataPoints_for_all_Classes( class_Index, 1 ).nonOutlier_DataPoints_Matrix_for_a_Single_Class = all_DataPoints_in_Current_Class( :, indices_of_Selected_nonOutlier_DataPoints_for_Currrent_Class);
                            vertical_Structure_of_Selected_nonOutlier_DataPoints_for_all_Classes( class_Index, 1 ).nonOutlier_Labels_Vector_for_a_Single_Class     = classLabels_from_DataSet       ( :, indices_of_Selected_nonOutlier_DataPoints_for_Currrent_Class);

                            vertical_Structure_of_Selected_Outlier_DataPoints_for_all_Class( class_Index, 1 ).outlier_DataPoints_Matrix_for_a_Single_Class = all_DataPoints_in_Current_Class( :, ~indices_of_Selected_nonOutlier_DataPoints_for_Currrent_Class);
                            vertical_Structure_of_Selected_Outlier_DataPoints_for_all_Class( class_Index, 1 ).outlier_Labels_Vector_for_a_Single_Class     = classLabels_from_DataSet       ( :, ~indices_of_Selected_nonOutlier_DataPoints_for_Currrent_Class);

                end


        % Level 6: Plot           
            if ( do_you_Want_to_Draw_nonOutlier_and_Outlier_DataPoints_in_a_two_or_three_Dimensional_Plot )
                Colors=hsv(size ( vertical_Structure_of_Selected_Outlier_DataPoints_for_all_Class, 1 ));

                if   ( size ( selected_Dimensions_for_Draw, 2 ) <= 3 )
                    figure;

                    for class_Index = 1 : size ( vertical_Structure_of_Selected_Outlier_DataPoints_for_all_Class, 1 )
                        legend_Labels ( 1, class_Index ) = { sprintf( 'Class: %d', class_Index ) };

                        nonOutlier_DataPoints_for_Currrent_Class = [ vertical_Structure_of_Selected_nonOutlier_DataPoints_for_all_Classes( class_Index, 1 ).nonOutlier_DataPoints_Matrix_for_a_Single_Class ];

                        outlier_DataPoints_for_Currrent_Class    = [ vertical_Structure_of_Selected_Outlier_DataPoints_for_all_Class( class_Index, 1 ).outlier_DataPoints_Matrix_for_a_Single_Class ];

                        nonOutlier_DataPoints_for_Currrent_Class = nonOutlier_DataPoints_for_Currrent_Class ( selected_Dimensions_for_Draw, : );

                        outlier_DataPoints_for_Currrent_Class    = outlier_DataPoints_for_Currrent_Class    ( selected_Dimensions_for_Draw, : );

                        if   ( size ( selected_Dimensions_for_Draw, 2 ) == 2 )

                            X = nonOutlier_DataPoints_for_Currrent_Class ( 1, : );
                            Y = nonOutlier_DataPoints_for_Currrent_Class ( 2, : );

                            h(class_Index) = plot( X, Y, 'o', 'Color', Colors ( class_Index, : ),  'MarkerSize', 10, 'DisplayName',sprintf ('Class: %d', class_Index ));            
                            hold on

                            X = outlier_DataPoints_for_Currrent_Class ( 1, : );
                            Y = outlier_DataPoints_for_Currrent_Class ( 2, : );                
                            plot( X, Y, 'o', 'Color', Colors ( class_Index, : ),  'MarkerSize', 10 );

                            plot( X, Y, 'x', 'Color', Colors ( class_Index, : ),  'MarkerSize', 10 );

                            if ( isempty ( axis_Labels ) == 0 )

                                xlabel( axis_Labels{1} )
                                ylabel( axis_Labels{2} )

                            end


                        elseif ( size ( selected_Dimensions_for_Draw, 2 ) == 3 ) 

                            X = nonOutlier_DataPoints_for_Currrent_Class ( 1, : );
                            Y = nonOutlier_DataPoints_for_Currrent_Class ( 2, : );
                            Z = nonOutlier_DataPoints_for_Currrent_Class ( 3, : );

                            h(class_Index) = plot3( X, Y, Z, 'o', 'Color', Colors ( class_Index, : ),  'MarkerSize', 10);            
                            hold on

                            X = outlier_DataPoints_for_Currrent_Class ( 1, : );
                            Y = outlier_DataPoints_for_Currrent_Class ( 2, : ); 
                            Z = outlier_DataPoints_for_Currrent_Class ( 3, : ); 
                            plot3( X, Y, Z, 'o', 'Color', Colors ( class_Index, : ),  'MarkerSize', 10);

                            plot3( X, Y, Z, 'x', 'Color', Colors ( class_Index, : ),  'MarkerSize', 10);

                             if ( isempty ( axis_Labels ) == 0 )

                                xlabel( axis_Labels{1} )
                                ylabel( axis_Labels{2} )
                                zlabel( axis_Labels{3} )

                             end

                        end

                    end


                    if ( isempty ( plot_Title ) == 0 )

                        title( plot_Title )

                    end        
                        hold off;
                        legend(h(1:3), 'Location','best')
                    

                else
                    fprintf ( 'The Plot for Data-Points with more than 3 Selected Dimensions can not be shown ... !!!\n' );

                end



            end

  
end
