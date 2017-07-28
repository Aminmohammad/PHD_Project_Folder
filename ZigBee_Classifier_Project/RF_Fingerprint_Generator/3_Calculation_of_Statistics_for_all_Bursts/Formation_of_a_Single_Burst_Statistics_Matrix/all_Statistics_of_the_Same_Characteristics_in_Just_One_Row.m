function [ matrix_of_Selected_Statistics_for_a_Single_Burst, vertical_Cell_of_Names_of_Covered_Fields_for_a_Single_Burst_in_Order ] = all_Statistics_of_the_Same_Characteristics_in_Just_One_Row ( input_Structure )


    %% Section 0: Extraction of Initial Paramters
        vertical_Cell_of_Characteristics_Names                       = input_Structure.vertical_Cell_of_Characteristics_Names;
        vertical_Structure_of_Selected_Statistics_for_a_Single_Burst = input_Structure.vertical_Structure_of_Selected_Statistics_for_a_Single_Burst;
        
                  % vertical_Structure_of_Selected_Statistics_for_a_Single_Burst (Structure):                                                                                                                                                                                                                                                              
                        %  ---------------------------------------------------------------------------------------------------------------------------------
                        %  |     | Amplitude_Element  (Field):                               Amplitude_Element                        (Vector)             |
                        %  |     | Phase_Element      (Field):                                   Amplitude                            (Vector)             |
                        %  |     | Frequency_Element  (Field):                                 Phase_Element                          (Vector)             |
                        %  |     |                                                                                                                         |
                        %  |     | Skewness_of_Amplitude_Element (Field):               Skewness_of_Amplitude_Element                 (Scalar)             |
                        %  |     | Skewness_of_Phase_Element     (Field):                 Skewness_of_Phase_Element                   (Scalar)             |
                        %  |     | Skewness_of_Frequency_Element (Field):               Skewness_of_Frequency_Element                 (Scalar)             |
                        %  |     |                                                                                                                         |
                        %  |     | Variance_of_Amplitude_Element (Field):               Variance_of_Amplitude_Element                 (Scalar)             |
                        %  |  1  | Variance_of_Phase_Element     (Field):                 Variance_of_Phase_Element                   (Scalar)             |
                        %  |     | Variance_of_Frequency_Element (Field):               Variance_of_Frequency_Element                 (Scalar)             |
                        %  |     |                                                                                                                         |
                        %  |     | Kurtosis_of_Amplitude_Element (Field):               Kurtosis_of_Amplitude_Element                 (Scalar)             |
                        %  |     | Kurtosis_of_Phase_Element     (Field):                 Kurtosis_of_Phase_Element                   (Scalar)             |
                        %  |     | Kurtosis_of_Frequency_Element (Field):               Kurtosis_of_Frequency_Element                 (Scalar)             |
                        %  |     |                                                                                                                         |
                        %  |     | Mean_of_Amplitude_Element     (Field):                 Mean_of_Amplitude_Element                   (Scalar)             |
                        %  |     | Mean_of_Phase_Element         (Field):                   Mean_of_Phase_Element                     (Scalar)             |
                        %  |     | Mean_of_Frequency_Element     (Field):                 Mean_of_Frequency_Element                   (Scalar)             |                                
                        %  ---------------------------------------------------------------------------------------------------------------------------------
                        %                         .                                                   .                                  .                 |
                        %                         .                                                   .                                  .                 |
                        %                         .                                                   .                                  .                 |
                        %  ---------------------------------------------------------------------------------------------------------------------------------
                        %  |     | Amplitude_Element  (Field):                               Amplitude_Element                        (Vector)             |
                        %  |     | Phase_Element      (Field):                                   Amplitude                            (Vector)             |
                        %  |     | Frequency_Element  (Field):                                 Phase_Element                          (Vector)             |
                        %  |     |                                                                                                                         |
                        %  |     | Skewness_of_Amplitude_Element (Field):               Skewness_of_Amplitude_Element                 (Scalar)             |
                        %  |     | Skewness_of_Phase_Element     (Field):                 Skewness_of_Phase_Element                   (Scalar)             |
                        %  |     | Skewness_of_Frequency_Element (Field):               Skewness_of_Frequency_Element                 (Scalar)             |
                        %  |     |                                                                                                                         |
                        %  |     | Variance_of_Amplitude_Element (Field):               Variance_of_Amplitude_Element                 (Scalar)             |
                        %  | 33  | Variance_of_Phase_Element     (Field):                 Variance_of_Phase_Element                   (Scalar)             |
                        %  |     | Variance_of_Frequency_Element (Field):               Variance_of_Frequency_Element                 (Scalar)             |
                        %  |     |                                                                                                                         |
                        %  |     | Kurtosis_of_Amplitude_Element (Field):               Kurtosis_of_Amplitude_Element                 (Scalar)             |
                        %  |     | Kurtosis_of_Phase_Element     (Field):                 Kurtosis_of_Phase_Element                   (Scalar)             |
                        %  |     | Kurtosis_of_Frequency_Element (Field):               Kurtosis_of_Frequency_Element                 (Scalar)             |
                        %  |     |                                                                                                                         |
                        %  |     | Mean_of_Amplitude_Element     (Field):                 Mean_of_Amplitude_Element                   (Scalar)             |
                        %  |     | Mean_of_Phase_Element         (Field):                   Mean_of_Phase_Element                     (Scalar)             |
                        %  |     | Mean_of_Frequency_Element     (Field):                 Mean_of_Frequency_Element                   (Scalar)             |                                
                        %-----------------------------------------------------------------------------------------------------------------------------------
                                          
    %% Section 1: Extraction of Initial Paramters                
        % Level 1: Extraction of fields in a Single Burst
             fields = fieldnames (vertical_Structure_of_Selected_Statistics_for_a_Single_Burst);
                % fields (Cell):
                %   'Amplitude_Element'
                %   'Phase_Element'
                %   'Frequency_Element'
                %
                %   'Skewness_of_Amplitude_Element'
                %   'Skewness_of_Phase_Element'
                %   'Skewness_of_Frequency_Element'
                %
                %   'Variance_of_Amplitude_Element'
                %   'Variance_of_Phase_Element'
                %   'Variance_of_Frequency_Element'
                %
                %   'Kurtosis_of_Amplitude_Element'
                %   'Kurtosis_of_Phase_Element'
                %   'Kurtosis_of_Frequency_Element'
                %
                %   'Mean_of_Amplitude_Element'
                %   'Mean_of_Phase_Element'
                %   'Mean_of_Frequency_Element'




        % Level 2: Now we want to form the following matrix (matrix_of_Selected_Statistics_for_a_Single_Burst):
                    %              ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                    % Amplitude:   | Skewness_of_Amplitude_Element_1       Variance_of_Amplitude_Element_1        Kurtosis_of_Amplitude_Element_1        Mean_of_Amplitude_Element_1        ...        Skewness_of_Amplitude_Element_33       Variance_of_Amplitude_Element_33        Kurtosis_of_Amplitude_Element_33        Mean_of_Amplitude_Element_33 |        
                    % Phase:       | Skewness_of_Phase_Element_1           Variance_of_Phase_Element_1            Kurtosis_of_Phase_Element_1            Mean_of_Phase_Element_1            ...        Skewness_of_Phase_Element_33           Variance_of_Phase_Element_33            Kurtosis_of_Phase_Element_33            Mean_of_Phase_Element_33     |                         
                    % Frequency:   | Skewness_of_Frequency_Element_1       Variance_of_Frequency_Element_1        Kurtosis_of_Frequency_Element_1        Mean_of_Frequency_Element_1        ...        Skewness_of_Frequency_Element_33       Variance_of_Frequency_Element_33        Kurtosis_of_Frequency_Element_33        Mean_of_Frequency_Element_33 |        
                    %              ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                    
             matrix_of_Selected_Statistics_for_a_Single_Burst = [];
             vertical_Cell_of_Names_of_Covered_Fields_for_a_Single_Burst_in_Order = [];
             for subRegion_Index = 1 : size ( vertical_Structure_of_Selected_Statistics_for_a_Single_Burst, 1 )
                 current_subRegion = vertical_Structure_of_Selected_Statistics_for_a_Single_Burst ( subRegion_Index, 1 );

                 row_Index = 1;
                 temp_Matrix_of_Selected_Statistics_for_a_Single_Burst = [];
                 for field_Index = 1 : size ( fields, 1 )
                    current_Field                    = char ( fields ( field_Index, 1 ) );
                    index_of_an_Exact_Word_in_a_Cell = Search_an_Exact_Word_in_a_Cell ( vertical_Cell_of_Characteristics_Names, current_Field );

                    if ( isempty ( index_of_an_Exact_Word_in_a_Cell ) == 1 ) 

                        indices = strfind ( current_Field, '_' );
                        common_Parts_of_Current_Field = current_Field( 1, indices (1, 2 ) : end );

                        index_of_a_Part_in_the_Cell   = Search_a_Part_in_a_Cell ( fields, common_Parts_of_Current_Field );

                        index_of_a_Part_in_the_Cell   = index_of_a_Part_in_the_Cell (:);

                        for column_Index  =  1 : size ( index_of_a_Part_in_the_Cell, 1 )
                            name_of_Field = char ( fields ( index_of_a_Part_in_the_Cell ( column_Index, 1 ), 1 ) );
                            temp_Matrix_of_Selected_Statistics_for_a_Single_Burst ( row_Index, column_Index ) = vertical_Structure_of_Selected_Statistics_for_a_Single_Burst ( subRegion_Index, 1 ). (name_of_Field);
                            temp_Name_of_Covered_Fields_in_Order ( row_Index, column_Index ) = { name_of_Field };
                            
                        end

                        if ( size ( temp_Matrix_of_Selected_Statistics_for_a_Single_Burst, 1 ) == numel ( vertical_Cell_of_Characteristics_Names ) )                                
                            matrix_of_Selected_Statistics_for_a_Single_Burst                     = [ matrix_of_Selected_Statistics_for_a_Single_Burst, temp_Matrix_of_Selected_Statistics_for_a_Single_Burst ];
                            vertical_Cell_of_Names_of_Covered_Fields_for_a_Single_Burst_in_Order = [ vertical_Cell_of_Names_of_Covered_Fields_for_a_Single_Burst_in_Order, temp_Name_of_Covered_Fields_in_Order ];
                            break;

                        end

                        row_Index = row_Index + 1;

                    end

                 end
             end
             
                                 % matrix_of_Selected_Statistics_for_a_Single_Burst (Matrix)
                                    %              ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                    % Amplitude:   | Skewness_of_Amplitude_Element_1       Variance_of_Amplitude_Element_1        Kurtosis_of_Amplitude_Element_1        Mean_of_Amplitude_Element_1        ...        Skewness_of_Amplitude_Element_33       Variance_of_Amplitude_Element_33        Kurtosis_of_Amplitude_Element_33        Mean_of_Amplitude_Element_33 |        
                                    % Phase:       | Skewness_of_Phase_Element_1           Variance_of_Phase_Element_1            Kurtosis_of_Phase_Element_1            Mean_of_Phase_Element_1            ...        Skewness_of_Phase_Element_33           Variance_of_Phase_Element_33            Kurtosis_of_Phase_Element_33            Mean_of_Phase_Element_33     |                         
                                    % Frequency:   | Skewness_of_Frequency_Element_1       Variance_of_Frequency_Element_1        Kurtosis_of_Frequency_Element_1        Mean_of_Frequency_Element_1        ...        Skewness_of_Frequency_Element_33       Variance_of_Frequency_Element_33        Kurtosis_of_Frequency_Element_33        Mean_of_Frequency_Element_33 |        
                                    %              ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                    
                                    %              |                                                                    subRegion_1                                                                     |   ...    |                                                                        subRegion_33                                                                   |                                                                                                                                                                                  
                                    %              ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                    
                                    
%                 for_show = [        ' Amplitude:   | Skewness_of_Amplitude_Element_1       Variance_of_Amplitude_Element_1        Kurtosis_of_Amplitude_Element_1        Mean_of_Amplitude_Element_1        ...        Skewness_of_Amplitude_Element_33       Variance_of_Amplitude_Element_33        Kurtosis_of_Amplitude_Element_33        Mean_of_Amplitude_Element_33 |',   ...        
%                                     ' Phase:       | Skewness_of_Phase_Element_1           Variance_of_Phase_Element_1            Kurtosis_of_Phase_Element_1            Mean_of_Phase_Element_1            ...        Skewness_of_Phase_Element_33           Variance_of_Phase_Element_33            Kurtosis_of_Phase_Element_33            Mean_of_Phase_Element_33     |',   ...                         
%                                     ' Frequency:   | Skewness_of_Frequency_Element_1       Variance_of_Frequency_Element_1        Kurtosis_of_Frequency_Element_1        Mean_of_Frequency_Element_1        ...        Skewness_of_Frequency_Element_33       Variance_of_Frequency_Element_33        Kurtosis_of_Frequency_Element_33        Mean_of_Frequency_Element_33 |',   ...                                            
%                                     ];
%                         
%                 disp (for_show);   

                                                                                
end