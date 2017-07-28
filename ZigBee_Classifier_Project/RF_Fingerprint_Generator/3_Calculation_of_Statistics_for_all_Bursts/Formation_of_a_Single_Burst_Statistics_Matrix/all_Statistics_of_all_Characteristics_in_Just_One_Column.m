function [ matrix_of_Selected_Statistics_for_a_Single_Burst, vertical_Cell_of_Names_of_Covered_Fields_for_a_Single_Burst_in_Order ] = all_Statistics_of_all_Characteristics_in_Just_One_Column ( input_Structure )


    %% Section 0: Extraction of Initial Paramters

    %% Section 1: Claculation of 'temp_Matrix_of_Selected_Statistics_for_a_Single_Burst'      
         [ temp_Matrix_of_Selected_Statistics_for_a_Single_Burst, temp_Vertical_Cell_of_Names_of_Covered_Fields_for_a_Single_Burst_in_Order ]  = all_Statistics_of_the_Same_Characteristics_in_Just_One_Row ( input_Structure );

             % temp_Matrix_of_Selected_Statistics_for_a_Single_Burst (Matrix)
                %              ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % Amplitude:   | Skewness_of_Amplitude_Element_1       Variance_of_Amplitude_Element_1        Kurtosis_of_Amplitude_Element_1        Mean_of_Amplitude_Element_1        ...        Skewness_of_Amplitude_Element_33       Variance_of_Amplitude_Element_33        Kurtosis_of_Amplitude_Element_33        Mean_of_Amplitude_Element_33 |        
                % Phase:       | Skewness_of_Phase_Element_1           Variance_of_Phase_Element_1            Kurtosis_of_Phase_Element_1            Mean_of_Phase_Element_1            ...        Skewness_of_Phase_Element_33           Variance_of_Phase_Element_33            Kurtosis_of_Phase_Element_33            Mean_of_Phase_Element_33     |                         
                % Frequency:   | Skewness_of_Frequency_Element_1       Variance_of_Frequency_Element_1        Kurtosis_of_Frequency_Element_1        Mean_of_Frequency_Element_1        ...        Skewness_of_Frequency_Element_33       Variance_of_Frequency_Element_33        Kurtosis_of_Frequency_Element_33        Mean_of_Frequency_Element_33 |        
                %              ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                    
                %              |                                                                    subRegion_1                                                                     |   ...    |                                                                        subRegion_33                                                                   |                                                                                                                                                                                  
                %              ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                    

    %% Section 2: Calculation of 'matrix_of_Selected_Statistics_for_a_Single_Burst' 
        matrix_of_Selected_Statistics_for_a_Single_Burst = [];
        vertical_Cell_of_Names_of_Covered_Fields_for_a_Single_Burst_in_Order = [];
        for row_Index = 1 : size ( temp_Matrix_of_Selected_Statistics_for_a_Single_Burst, 1 )                                            
                matrix_of_Selected_Statistics_for_a_Single_Burst   = [ matrix_of_Selected_Statistics_for_a_Single_Burst; temp_Matrix_of_Selected_Statistics_for_a_Single_Burst( row_Index, : )' ];                
                vertical_Cell_of_Names_of_Covered_Fields_for_a_Single_Burst_in_Order  = [ vertical_Cell_of_Names_of_Covered_Fields_for_a_Single_Burst_in_Order;                  temp_Vertical_Cell_of_Names_of_Covered_Fields_for_a_Single_Burst_in_Order( row_Index, : )' ];
                
        end

        % matrix_of_Selected_Statistics_for_a_Single_Burst (Matrix)
                %----------------------------------------------------------------------
                %              |                 |  Skewness_of_Amplitude_Element_1   |        
                %              |                 |  Variance_of_Amplitude_Element_1   |
                %              |  sub-Region 1:  |  Kurtosis_of_Amplitude_Element_1   |
                %              |                 |  Mean_of_Amplitude_Element_1       |
                %              |-----------------|                                    |
                % Amplitude:   |        .        |             .                      |                
                %              |        .        |             .                      |
                %              |        .        |             .                      | 
                %              |-----------------|  Skewness_of_Amplitude_Element_33  | 
                %              |                 |  Variance_of_Amplitude_Element_33  | 
                %              |  sub-Region 33: |  Kurtosis_of_Amplitude_Element_33  | 
                %              |                 |  Mean_of_Amplitude_Element_33      |                 
                %--------------|-----------------|                                    |             
                %              |                 |  Skewness_of_Phase_Element_1       |                                                             
                %              |  sub-Region 1:  |  Variance_of_Phase_Element_1       |       
                %              |                 |  Kurtosis_of_Phase_Element_1       |      
                %              |                 |  Mean_of_Phase_Element_1           |      
                %              |-----------------|                                    |
                %    Phase:    |        .        |             .                      |               
                %              |        .        |             .                      | 
                %              |        .        |             .                      | 
                %              |-----------------|  Skewness_of_Phase_Element_33      | 
                %              |                 |  Variance_of_Phase_Element_33      | 
                %              |  sub-Region 33: |  Kurtosis_of_Phase_Element_33      | 
                %              |                 |  Mean_of_Phase_Element_33          |                
                %--------------|-----------------|                                    |                                                   |
                %              |                 |  Skewness_of_Frequency_Element_1   |                      
                %              |  sub-Region 1:  |  Variance_of_Frequency_Element_1   |
                %              |                 |  Kurtosis_of_Frequency_Element_1   |
                %              |                 |  Mean_of_Frequency_Element_1       |
                %              |-----------------|                                    |
                %  Frequency:  |        .        |             .                      |               
                %              |        .        |             .                      |
                %              |        .        |             .                      |
                %              |-----------------|  Skewness_of_Frequency_Element_33  | 
                %              |                 |  Variance_of_Frequency_Element_33  | 
                %              |  sub-Region 33: |  Kurtosis_of_Frequency_Element_33  | 
                %              |                 |  Mean_of_Frequency_Element_33      |                  
                %----------------------------------------------------------------------
                
                
        % vertical_Cell_of_Names_of_Covered_Fields_for_a_Single_Burst_in_Order (Matrix)
                %------------------------------------------------------------------------
                %              |                 |  'Skewness_of_Amplitude_Element_1'   |        
                %              |                 |  'Variance_of_Amplitude_Element_1'   |
                %              |  sub-Region 1:  |  'Kurtosis_of_Amplitude_Element_1'   |
                %              |                 |  'Mean_of_Amplitude_Element_1'       |
                %              |-----------------|                                      |
                % Amplitude:   |        .        |             .                        |                
                %              |        .        |             .                        |
                %              |        .        |             .                        | 
                %              |-----------------|  'Skewness_of_Amplitude_Element_33'  | 
                %              |                 |  'Variance_of_Amplitude_Element_33'  | 
                %              |  sub-Region 33: |  'Kurtosis_of_Amplitude_Element_33'  | 
                %              |                 |  'Mean_of_Amplitude_Element_33'      |                 
                %--------------|-----------------|                                      |  
                %              |                 |  'Skewness_of_Phase_Element_1'       |                                                             
                %              |  sub-Region 1:  |  'Variance_of_Phase_Element_1'       |       
                %              |                 |  'Kurtosis_of_Phase_Element_1'       |      
                %              |                 |  'Mean_of_Phase_Element_1'           |      
                %              |-----------------|                                      |
                %    Phase:    |        .        |             .                        |               
                %              |        .        |             .                        | 
                %              |        .        |             .                        | 
                %              |-----------------|  'Skewness_of_Phase_Element_33'      | 
                %              |                 |  'Variance_of_Phase_Element_33'      | 
                %              |  sub-Region 33: |  'Kurtosis_of_Phase_Element_33'      | 
                %              |                 |  'Mean_of_Phase_Element_33'          |                
                %--------------|-----------------|                                      |                                                   |
                %              |                 |  'Skewness_of_Frequency_Element_1'   |                      
                %              |  sub-Region 1:  |  'Variance_of_Frequency_Element_1'   |
                %              |                 |  'Kurtosis_of_Frequency_Element_1'   |
                %              |                 |  'Mean_of_Frequency_Element_1'       |
                %              |-----------------|                                      |
                %  Frequency:  |        .        |             .                        |               
                %              |        .        |             .                        |
                %              |        .        |             .                        |
                %              |-----------------|  'Skewness_of_Frequency_Element_33'  | 
                %              |                 |  'Variance_of_Frequency_Element_33'  | 
                %              |  sub-Region 33: |  'Kurtosis_of_Frequency_Element_33'  | 
                %              |                 |  'Mean_of_Frequency_Element_33'      |                  
                %-------------------------------------------------------------------------------------------------------
                
                
                
end

