function selected_nonOutlier_DataBank_Matrix = FaradarsV2_OutlierDet_PostProc ( varargin )

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
            inputSet.addParameter('selected_DataBank_Methods', []);
            inputSet.addParameter('selected_Type_of_FingerPrints_for_postProcessing', '');                
            inputSet.addParameter('matrix_of_DataPoints', []);
            inputSet.addParameter('classLabels_from_DataBank', []); 
            
            inputSet.addParameter('draw_or_Not', 1 );
            inputSet.addParameter('selected_Dimensions_for_Draw', [ 1 2 ] );
            inputSet.addParameter('axis_Labels', 1 );
            inputSet.addParameter('special_PlotTitle', [] );
            inputSet.addParameter('special_Structure_of_Parameters_for_postProcessing', []);  
            inputSet.addParameter('general_PlotTitle', [] );
                    
            inputSet.parse(varargin{:});

            selected_Indices_of_Devices_for_postProcessing                                           = inputSet.Results.selected_Indices_of_Devices_for_postProcessing;
            selected_DataBank_Methods                                                                = inputSet.Results.selected_DataBank_Methods;
            selected_Type_of_FingerPrints_for_postProcessing                                         = inputSet.Results.selected_Type_of_FingerPrints_for_postProcessing;
            matrix_of_DataPoints                                                                     = inputSet.Results.matrix_of_DataPoints;
            classLabels_from_DataBank                                                                = inputSet.Results.classLabels_from_DataBank;
            draw_or_Not                                                                              = inputSet.Results.draw_or_Not;
            selected_Dimensions_for_Draw                                                             = inputSet.Results.selected_Dimensions_for_Draw;
            axis_Labels                                                                              = inputSet.Results.axis_Labels;
            special_PlotTitle                                                                        = inputSet.Results.special_PlotTitle;
            special_Structure_of_Parameters_for_postProcessing                                       = inputSet.Results.special_Structure_of_Parameters_for_postProcessing;
            general_PlotTitle                                                                        = inputSet.Results.general_PlotTitle;
          
            if        ( isempty( matrix_of_DataPoints ) == 1 )        
                error ( 'You should Enter the "matrix of DataPoints" for "Outlier Detection".' );

            elseif    ( isempty( classLabels_from_DataBank ) == 1 )        
                error ( 'You should Enter the "classLabels from DataBank" for "Outlier Detection".' );
            
            end  
            
            if ( isempty ( special_Structure_of_Parameters_for_postProcessing ) == 0 && isempty ( isfield ( special_Structure_of_Parameters_for_postProcessing, 'decision_Alpha' ) ) == 0 )
                decision_Alpha   = special_Structure_of_Parameters_for_postProcessing.decision_Alpha;
                
            else 
                decision_Alpha = .07;
                
            end    
            
            if ( isempty ( special_Structure_of_Parameters_for_postProcessing ) == 0 && isempty ( isfield ( special_Structure_of_Parameters_for_postProcessing, 'do_you_Want_to_Draw_nonOutlier_and_Outlier' ) ) == 0 )
                do_you_Want_to_Draw_nonOutlier_and_Outlier_DataPoints_in_a_two_or_three_Dimensional_Plot   = special_Structure_of_Parameters_for_postProcessing.do_you_Want_to_Draw_nonOutlier_and_Outlier;
                
            else 
                do_you_Want_to_Draw_nonOutlier_and_Outlier_DataPoints_in_a_two_or_three_Dimensional_Plot = 1;
                
            end    
            
        % Level 2: Converting the 'classLabels_from_DataSet' to 'Horizontal Vactors'
            classLabels_from_DataBank    = classLabels_from_DataBank ( : )';
               
        % Level 3: Converting the 'selected_Dimensions_for_Draw' to 'Horizontal Vactors'
            selected_Dimensions_for_Draw = selected_Dimensions_for_Draw ( : )';

        % Level 4: Seperation of DataPoints based on ClassLabels
            different_Labels = unique ( classLabels_from_DataBank );
            number_of_Classes = size ( different_Labels, 2 );
            
            for class_Index = 1 : number_of_Classes
                selected_Logical_Indices_of_Columns_for_Current_Class                   = ( classLabels_from_DataBank == different_Labels ( 1, class_Index ) );
                vertical_Structure_of_Seperated_Classes ( class_Index, 1 ). dataPoints  = matrix_of_DataPoints ( :, selected_Logical_Indices_of_Columns_for_Current_Class );
                vertical_Structure_of_Seperated_Classes ( class_Index, 1 ). classLabels = classLabels_from_DataBank ( :, selected_Logical_Indices_of_Columns_for_Current_Class );
            end
            
        % Level 5: Checking if each of 'selected_Dimensions_of_Components_for_Draw'    
                %  is bigger than the number of dimensions of 'matrix_of_DataPoints'
                    if ( max ( selected_Dimensions_for_Draw ) > size ( matrix_of_DataPoints, 1 ) )
                        fprintf ( 'non of "selected Dimensions of Components for Draw" can not be bigger than "Row-Number" of "matrix_of_DataPoints" which is Dimension-Number (P).\n' )
                        fprintf ( 'Then we reduced "selected Dimensions of DataPoints for Draw" to "1:%d(p)" \n', size ( matrix_of_DataPoints, 1 ) )
                        selected_Dimensions_of_Components_for_Draw = 1 : size ( matrix_of_DataPoints, 1 );
                        
                    end
            
    %% Section  2: Calculation of outliers                    
        % Level 1: Centerizing each class by reducing the mean of 
                   % DataPoints from class                   
                   for class_Index = 1 : size ( vertical_Structure_of_Seperated_Classes, 1 )
                        current_Class_of_DataPoints = [ vertical_Structure_of_Seperated_Classes( class_Index, 1 ). dataPoints ];
                    
                        % Stge 1: claculating the mean of dimenstions ( rows )
                            mean_Vertical_Vector = mean ( current_Class_of_DataPoints, 2 );
                            
                        % Stge 2: reducing the mean of dimenstions ( rows )
                            current_Class_of_DataPoints = current_Class_of_DataPoints - repmat ( mean_Vertical_Vector, 1, size ( current_Class_of_DataPoints, 2 ) );
                            
                        % Stge 3: Assigning the 'centerized matrix of DataPoints' to the 'vertical_Structure_of_Centerized_Classes'
                            vertical_Structure_of_Centerized_Classes   ( class_Index, 1 ). dataPoints = current_Class_of_DataPoints;
                    
                        % Stge 4: Assigning the 'non-centerized matrix of DataPoints && Labels' to the 'vertical_Structure_of_nonCenterized_Classes'
                            vertical_Structure_of_nonCenterized_Classes( class_Index, 1 ). dataPoints = current_Class_of_DataPoints + repmat ( mean_Vertical_Vector, 1, size ( current_Class_of_DataPoints, 2 ) );                           
                            vertical_Structure_of_nonCenterized_Classes( class_Index, 1 ). classLabels = [ vertical_Structure_of_Seperated_Classes( class_Index, 1 ). classLabels ];
                   end

        % Level 2: Calculating the 'Covariance Structure for all classes' && 
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
                            T_Structure_of_all_DataPoints_in_current_Class =[];
                            for dataPoint_Index = 1 : size ( current_Class_of_DataPoints, 2 )
                                
                                current_Point = current_Class_of_DataPoints ( :, dataPoint_Index );
                                covariance_Matrix_of_Current_Class =  [ covariance_Structure_of_all_DataPoints_in_all_Classes( class_Index, 1 ).covariance_Matrix_for_a_Single_Class ];
                                T_Structure_of_all_DataPoints_in_current_Class ( 1, dataPoint_Index ).T_Matrix_for_a_Single_Class = current_Point' * inv( covariance_Matrix_of_Current_Class ) * current_Point;
                                
                            end 
                            
                        % Stge 4: claculating the T^2 Criterion Structure for all Classes                                                   
                            T_Structure_of_all_DataPoints_in_all_Classes( class_Index, 1 ).T_Matrix_for_a_Single_Class = [T_Structure_of_all_DataPoints_in_current_Class.T_Matrix_for_a_Single_Class];
                            
                        % Stge 5: Selecting the Outlier DataPoints for all classes
                            indices_of_Selected_nonOutlier_DataPoints_for_Currrent_Class = [ T_Structure_of_all_DataPoints_in_all_Classes( class_Index, 1 ).T_Matrix_for_a_Single_Class ] <= decision_Alpha;
                            all_DataPoints_in_Current_Class                              = [ vertical_Structure_of_nonCenterized_Classes( class_Index, 1 ) . dataPoints ];
                            all_ClassLabels_in_Current_Class                             = [ vertical_Structure_of_nonCenterized_Classes( class_Index, 1 ) . classLabels ];

                            vertical_Structure_of_Selected_nonOutlier_DataPoints_for_all_Classes( class_Index, 1 ).nonOutlier_DataPoints_Matrix_for_a_Single_Class = all_DataPoints_in_Current_Class  ( :, indices_of_Selected_nonOutlier_DataPoints_for_Currrent_Class);
                            vertical_Structure_of_Selected_nonOutlier_DataPoints_for_all_Classes( class_Index, 1 ).nonOutlier_Labels_Vector_for_a_Single_Class     = all_ClassLabels_in_Current_Class ( :, indices_of_Selected_nonOutlier_DataPoints_for_Currrent_Class);
                            
                            vertical_Structure_of_Selected_Outlier_DataPoints_for_all_Classes( class_Index, 1 ).outlier_DataPoints_Matrix_for_a_Single_Class = all_DataPoints_in_Current_Class ( :, ~indices_of_Selected_nonOutlier_DataPoints_for_Currrent_Class);
                            vertical_Structure_of_Selected_Outlier_DataPoints_for_all_Classes( class_Index, 1 ).outlier_Labels_Vector_for_a_Single_Class     = all_ClassLabels_in_Current_Class       ( :, ~indices_of_Selected_nonOutlier_DataPoints_for_Currrent_Class);

                end
                
    %% Section  3: Making the "output" Ready
        selected_nonOutlier_DataBank_Matrix = [];
        for class_Index = 1 : size ( vertical_Structure_of_Selected_nonOutlier_DataPoints_for_all_Classes, 1 )
            temp_Part_1 = [ vertical_Structure_of_Selected_nonOutlier_DataPoints_for_all_Classes( class_Index, 1 ).nonOutlier_DataPoints_Matrix_for_a_Single_Class ];
            temp_Part_2 = [ vertical_Structure_of_Selected_nonOutlier_DataPoints_for_all_Classes( class_Index, 1 ).nonOutlier_Labels_Vector_for_a_Single_Class ];
            temp_Matrix = [ temp_Part_1; temp_Part_2 ];
            selected_nonOutlier_DataBank_Matrix = [ selected_nonOutlier_DataBank_Matrix, temp_Matrix ];
            
        end

    %% Section  4: Plot            
            if ( do_you_Want_to_Draw_nonOutlier_and_Outlier_DataPoints_in_a_two_or_three_Dimensional_Plot )
                Colors=hsv(size ( vertical_Structure_of_Selected_Outlier_DataPoints_for_all_Classes, 1 ));

                if   ( size ( selected_Dimensions_for_Draw, 2 ) <= 3 )
                    figure;

                    for class_Index = 1 : size ( vertical_Structure_of_Selected_Outlier_DataPoints_for_all_Classes, 1 )
                        legend_Labels ( 1, class_Index ) = { sprintf( 'Class: %d', class_Index ) };

                        nonOutlier_DataPoints_for_Currrent_Class = [ vertical_Structure_of_Selected_nonOutlier_DataPoints_for_all_Classes( class_Index, 1 ).nonOutlier_DataPoints_Matrix_for_a_Single_Class ];

                        outlier_DataPoints_for_Currrent_Class    = [ vertical_Structure_of_Selected_Outlier_DataPoints_for_all_Classes( class_Index, 1 ).outlier_DataPoints_Matrix_for_a_Single_Class ];

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
                            title ( sprintf ('%s \n %s', general_PlotTitle, special_PlotTitle) );

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
                             
                             title ( sprintf ('%s \n %s', general_PlotTitle, special_PlotTitle) );

                        end

                    end


                    if ( isempty ( plot_Title ) == 0 )
                        minimum_T2_Distance = min ([ T_Structure_of_all_DataPoints_in_all_Classes( class_Index, 1 ).T_Matrix_for_a_Single_Class ]);
                        maximum_T2_Distance = max ([ T_Structure_of_all_DataPoints_in_all_Classes( class_Index, 1 ).T_Matrix_for_a_Single_Class ]);
                        title( [ plot_Title sprintf( '        Minimum T^2 Distance: %3.4f >> Maximum T^2 Distance: %3.4f', minimum_T2_Distance, maximum_T2_Distance ) ] );

                    end        
                        hold off;
                        legend(h(1:3), 'Location','best')
                    

                else
                    fprintf ( 'The Plot for Data-Points with more than 3 Selected Dimensions can not be shown ... !!!\n' );

                end



            end

  
end
