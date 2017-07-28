function [ matrix_of_Selected_Statistics_for_a_Single_Burst, vertical_Cell_of_Names_of_Covered_Fields_for_a_Single_Burst_in_Order ] = each_Statistics_of_Characteristics_in_Seperate_Rows ( input_Structure )


    %% Section 0: Extraction of Initial Paramters
        vertical_Cell_of_Statistics_Names                      = input_Structure.vertical_Cell_of_Statistics_Names;
               
    %% Section 1: Claculation of 'temp_Matrix_of_Selected_Statistics_for_a_Single_Burst'      
         [ temp_Matrix_of_Selected_Statistics_for_a_Single_Burst, temp_Vertical_Cell_of_Names_of_Covered_Fields_for_a_Single_Burst_in_Order ] = all_Statistics_of_the_Same_Characteristics_in_Just_One_Row ( input_Structure );

             % temp_Matrix_of_Selected_Statistics_for_a_Single_Burst (Matrix)
                %              ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % Amplitude:   | Skewness_of_Amplitude_Element_1       Variance_of_Amplitude_Element_1        Kurtosis_of_Amplitude_Element_1        Mean_of_Amplitude_Element_1        ...        Skewness_of_Amplitude_Element_33       Variance_of_Amplitude_Element_33        Kurtosis_of_Amplitude_Element_33        Mean_of_Amplitude_Element_33 |        
                % Phase:       | Skewness_of_Phase_Element_1           Variance_of_Phase_Element_1            Kurtosis_of_Phase_Element_1            Mean_of_Phase_Element_1            ...        Skewness_of_Phase_Element_33           Variance_of_Phase_Element_33            Kurtosis_of_Phase_Element_33            Mean_of_Phase_Element_33     |                         
                % Frequency:   | Skewness_of_Frequency_Element_1       Variance_of_Frequency_Element_1        Kurtosis_of_Frequency_Element_1        Mean_of_Frequency_Element_1        ...        Skewness_of_Frequency_Element_33       Variance_of_Frequency_Element_33        Kurtosis_of_Frequency_Element_33        Mean_of_Frequency_Element_33 |        
                %              ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                    
                %              |                                                                    subRegion_1                                                                     |   ...    |                                                                        subRegion_33                                                                   |                                                                                                                                                                                  
                %              ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                    

    %% Section 2: Claculation of 'matrix_of_Selected_Statistics_for_a_Single_Burst' 
        vertical_Cell_of_Statistics_Names_Size = numel ( vertical_Cell_of_Statistics_Names );
        for row_Index = 1 : size ( temp_Matrix_of_Selected_Statistics_for_a_Single_Burst, 1 )
            for col_Index = 1 : vertical_Cell_of_Statistics_Names_Size : size ( temp_Matrix_of_Selected_Statistics_for_a_Single_Burst, 2 )
                
                row_Start    = ( row_Index - 1  ) * vertical_Cell_of_Statistics_Names_Size + 1;
                row_end      = ( row_Index ) * vertical_Cell_of_Statistics_Names_Size;
                column_Index = floor ( col_Index/vertical_Cell_of_Statistics_Names_Size ) + 1;
                matrix_of_Selected_Statistics_for_a_Single_Burst        ( row_Start : row_end, column_Index ) = temp_Matrix_of_Selected_Statistics_for_a_Single_Burst   ( row_Index, col_Index : col_Index + vertical_Cell_of_Statistics_Names_Size - 1 );
                vertical_Cell_of_Names_of_Covered_Fields_for_a_Single_Burst_in_Order ( row_Start : row_end, column_Index ) = temp_Vertical_Cell_of_Names_of_Covered_Fields_for_a_Single_Burst_in_Order ( row_Index, col_Index : col_Index + vertical_Cell_of_Statistics_Names_Size - 1 );
                
            end
        end

        % matrix_of_Selected_Statistics_for_a_Single_Burst (Matrix)
                %-------------------------------------------------------------------------------------------------------
                %              | Skewness_of_Amplitude_Element_1           ...        Skewness_of_Amplitude_Element_33 |        
                % Amplitude:   | Variance_of_Amplitude_Element_1           ...        Variance_of_Amplitude_Element_33 |
                %              | Kurtosis_of_Amplitude_Element_1           ...        Kurtosis_of_Amplitude_Element_33 |
                %              | Mean_of_Amplitude_Element_1               ...        Mean_of_Amplitude_Element_33     |
                %--------------|                                                                                       |
                %              | Skewness_of_Phase_Element_1               ...        Skewness_of_Phase_Element_33     |                                                       
                % Phase:       | Variance_of_Phase_Element_1               ...        Variance_of_Phase_Element_33     |
                %              | Kurtosis_of_Phase_Element_1               ...        Kurtosis_of_Phase_Element_33     |
                %              | Mean_of_Phase_Element_1                   ...        Mean_of_Phase_Element_33         |
                %--------------|                                                                                       |
                %              | Skewness_of_Frequency_Element_1           ...        Skewness_of_Frequency_Element_33 |                      
                % Frequency:   | Variance_of_Frequency_Element_1           ...        Variance_of_Frequency_Element_33 |
                %              | Kurtosis_of_Frequency_Element_1           ...        Kurtosis_of_Frequency_Element_33 |
                %              | Mean_of_Frequency_Element_1               ...        Mean_of_Frequency_Element_33     |
                %-------------------------------------------------------------------------------------------------------
                %              |         subRegion_1                   |   ...    |            subRegion_33            |                                                                                                                                                                                  
                %-------------------------------------------------------------------------------------------------------
                
                
%                 for_show = ['  -------------------------------------------------------------------------------------------------------',                   ...
%                             '                | Skewness_of_Amplitude_Element_1           ...        Skewness_of_Amplitude_Element_33 |',                    ...      
%                             '   Amplitude:   | Variance_of_Amplitude_Element_1           ...        Variance_of_Amplitude_Element_33 |',                    ...
%                             '                | Kurtosis_of_Amplitude_Element_1           ...        Kurtosis_of_Amplitude_Element_33 |',                    ...
%                             '                | Mean_of_Amplitude_Element_1               ...        Mean_of_Amplitude_Element_33     |',                    ...
%                             '  --------------|                                                                                       |',                    ...
%                             '                | Skewness_of_Phase_Element_1               ...        Skewness_of_Phase_Element_33     |',                    ...                                                       
%                             '   Phase:       | Variance_of_Phase_Element_1               ...        Variance_of_Phase_Element_33     |',                    ...
%                             '                | Kurtosis_of_Phase_Element_1               ...        Kurtosis_of_Phase_Element_33     |',                    ...
%                             '                | Mean_of_Phase_Element_1                   ...        Mean_of_Phase_Element_33         |',                    ...
%                             '  --------------|                                                                                       |',                    ...
%                             '                | Skewness_of_Frequency_Element_1           ...        Skewness_of_Frequency_Element_33 |',                    ...                      
%                             '   Frequency:   | Variance_of_Frequency_Element_1           ...        Variance_of_Frequency_Element_33 |',                    ...
%                             '                | Kurtosis_of_Frequency_Element_1           ...        Kurtosis_of_Frequency_Element_33 |',                    ...
%                             '                | Mean_of_Frequency_Element_1               ...        Mean_of_Frequency_Element_33     |',                    ...
%                             '  -------------------------------------------------------------------------------------------------------',                    ...
%                             '                |         subRegion_1                   |   ...    |            subRegion_33            |',                    ...                                                                                                                                                                                  
%                             '  -------------------------------------------------------------------------------------------------------'                     ...
%                             ];
%                         
%                 disp (for_show);
        
end

