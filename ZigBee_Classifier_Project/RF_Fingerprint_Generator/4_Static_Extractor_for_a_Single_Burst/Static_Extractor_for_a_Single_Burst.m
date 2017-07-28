function [ vertical_Structure_of_Selected_Statistics_for_a_Single_Burst, should_we_Omit_the_Whole_Single_Burst, horizontal_Vector_of_Lengths_of_all_subRegions_for_a_Single_Burst ] = Static_Extractor_for_a_Single_Burst (  vertical_Structure_of_a_Single_Burst,      ...
                                                                                                                                                                                                                             vertical_Cell_of_Characteristics_Names,    ...
                                                                                                                                                                                                                             vertical_Cell_of_Statistics_Names ) 
                                                                                                         
%% Input:
    % structure_of_Selected_Characteristics_for_a_Single_Burst (Structure)
        %  ----------------------------------------------------------------------------------------------------------------------------
        %  |     |                                                    | element_Name  (Field):    Amplitude_Element  (String)  |               
        %  |     |                                                    | element_Value (Field):    Amplitude_Value    (Vector)  |               
        %  |     |                                                    ----------------------------------------------------------
        %  |     |                                                    | element_Name  (Field):    Phase_Element      (String)  |               
        %  |  1  |   Characteristics_of_a_Single_subRegion (Field):   | element_Value (Field):    Phase_Value        (Vector)  |               
        %  |     |                                                    ----------------------------------------------------------
        %  |     |                                                    | element_Name  (Field):    Frequency_Element  (String)  |               
        %  |     |                                                    | element_Value (Field):    Frequency_Value    (Vector)  |               
        %  ----------------------------------------------------------------------------------------------------------------------------
        %  |  .  |                         .                          .                                         .              |               
        %  |  .  |                         .                          .                                         .              |                             
        %  |  .  |                         .                          .                                         .              |               
        %  ----------------------------------------------------------------------------------------------------------------------------
        %  |     |                                                    | element_Name  (Field):    Amplitude_Element  (String)  |               
        %  |     |                                                    | element_Value (Field):    Amplitude_Value    (Vector)  |               
        %  |     |                                                     ----------------------------------------------------------
        %  |     |                                                    | element_Name  (Field):    Phase_Element      (String)  |               
        %  | 33  |   Characteristics_of_a_Single_subRegion (Field):   | element_Value (Field):    Phase_Value        (Vector)  |               
        %  |     |                                                    ----------------------------------------------------------
        %  |     |                                                    | element_Name  (Field):    Frequency_Element  (String)  |               
        %  |     |                                                    | element_Value (Field):    Frequency_Value    (Vector)  |               
        %  ----------------------------------------------------------------------------------------------------------------------------                            

%% Output:                            
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
        %  | 1   | Variance_of_Phase_Element     (Field):                 Variance_of_Phase_Element                   (Scalar)             |
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

                      
    %% Section 1: Initial Parameter Extraction  
        % Level 1: pre-Definition of 'should_we_Omit_the_Whole_Burst' and 'vertical_Structure_of_Selected_Statistics_for_a_Single_Burst'
            should_we_Omit_the_Whole_Single_Burst = 0;
            vertical_Structure_of_Selected_Statistics_for_a_Single_Burst = [];
            
        % Level 2: Extraction of 'structure_of_Selected_Characteristics_for_a_Single_Burst'
            [ structure_of_Selected_Characteristics_for_a_Single_Burst, horizontal_Vector_of_Lengths_of_all_subRegions_for_a_Single_Burst ] = Characteristics_Extractor_for_a_Single_Burst ( vertical_Cell_of_Characteristics_Names,   ... 
                                                                                                                                                                                             vertical_Structure_of_a_Single_Burst );
                                                                 
                            % structure_of_Selected_Characteristics_for_a_Single_Burst (Structure)
                            %  ----------------------------------------------------------------------------------------------------------------------------
                            %  |     |                                                    | element_Name  (Field):    Amplitude_Element  (String)  |               
                            %  |     |                                                    | element_Value (Field):    Amplitude_Value    (Vector)  |               
                            %  |     |                                                    ----------------------------------------------------------
                            %  |     |                                                    | element_Name  (Field):    Phase_Element      (String)  |               
                            %  |  1  |   Characteristics_of_a_Single_subRegion (Field):   | element_Value (Field):    Phase_Value        (Vector)  |               
                            %  |     |                                                    ----------------------------------------------------------
                            %  |     |                                                    | element_Name  (Field):    Frequency_Element  (String)  |               
                            %  |     |                                                    | element_Value (Field):    Frequency_Value    (Vector)  |               
                            %  ----------------------------------------------------------------------------------------------------------------------------
                            %  |  .  |                         .                          .                                         .              |               
                            %  |  .  |                         .                          .                                         .              |                             
                            %  |  .  |                         .                          .                                         .              |               
                            %  ----------------------------------------------------------------------------------------------------------------------------
                            %  |     |                                                    | element_Name  (Field):    Amplitude_Element  (String)  |               
                            %  |     |                                                    | element_Value (Field):    Amplitude_Value    (Vector)  |               
                            %  |     |                                                    ----------------------------------------------------------
                            %  |     |                                                    | element_Name  (Field):    Phase_Element      (String)  |               
                            %  | 33  |   Characteristics_of_a_Single_subRegion (Field):   | element_Value (Field):    Phase_Value        (Vector)  |               
                            %  |     |                                                    ----------------------------------------------------------
                            %  |     |                                                    | element_Name  (Field):    Frequency_Element  (String)  |               
                            %  |     |                                                    | element_Value (Field):    Frequency_Value    (Vector)  |               
                            %  ----------------------------------------------------------------------------------------------------------------------------                            
                            
        % Level 3: Converting 'structure_of_Selected_Characteristics_for_a_Single_Burst' to Vertical Case 
            structure_of_Selected_Characteristics_for_a_Single_Burst = Converter_to_Horizontal_or_Vertical_Vector( structure_of_Selected_Characteristics_for_a_Single_Burst, 'Vertical', 'vertical_Structure_of_a_Single_Burst' );                

        % Level 4: Converting 'vertical_Cell_of_Characteristics_Names' to Vertical Case 
            vertical_Cell_of_Characteristics_Names                   = Converter_to_Horizontal_or_Vertical_Vector( vertical_Cell_of_Characteristics_Names, 'Vertical', 'vertical_Structure_of_a_Single_Burst' );                
          
        % Level 5: Converting 'vertical_Cell_of_Statistics_Names' to Vertical Case             
            vertical_Cell_of_Statistics_Names                        = Converter_to_Horizontal_or_Vertical_Vector( vertical_Cell_of_Statistics_Names,             'Vertical', 'vertical_Structure_of_a_Single_Burst' );                
 
    %% Section 2: Calling Selected 'Characteristics' for selected 'sub Region'        
        for index = 1 : size ( vertical_Cell_of_Statistics_Names, 1 )
            current_Statistic_Name     = vertical_Cell_of_Statistics_Names { index, 1 };
            current_Statistic_Function = str2func ( current_Statistic_Name );

            for subRegion_Index = 1 : size ( structure_of_Selected_Characteristics_for_a_Single_Burst, 1 )
                
                vertical_Structure_of_Selected_Characteristics_for_a_Single_subRegion = structure_of_Selected_Characteristics_for_a_Single_Burst ( subRegion_Index, 1 ). Characteristics_of_a_Single_subRegion;                
                    % vertical_Structure_of_Selected_Characteristics_for_a_Single_subRegion (Structure)
                    %  ----------------------------------------------------------
                    %  | element_Name  (Field):    Amplitude_Element  (String)  |               
                    %  | element_Value (Field):    Amplitude_Value    (Vector)  |               
                    %  ----------------------------------------------------------
                    %  | element_Name  (Field):    Phase_Element      (String)  |               
                    %  | element_Value (Field):    Phase_Value        (Vector)  |               
                    %  ----------------------------------------------------------
                    %  | element_Name  (Field):    Frequency_Element  (String)  |               
                    %  | element_Value (Field):    Frequency_Value    (Vector)  |               
                    %  ----------------------------------------------------------

                number_of_Characteristics = size ( vertical_Structure_of_Selected_Characteristics_for_a_Single_subRegion, 1 );
                for Characteristic_Index = 1 : number_of_Characteristics
                    
                    current_Characteristic_Name_for_this_subRegion  = vertical_Structure_of_Selected_Characteristics_for_a_Single_subRegion (Characteristic_Index, 1 ).element_Name;
                    characteristic_Value_for_Current_subRegion      = [vertical_Structure_of_Selected_Characteristics_for_a_Single_subRegion(Characteristic_Index, 1 ).element_Value];
                        % current_Characteristic_Name_for_this_subRegion (String): 'Amplitude_Element', 'Phase_Element', or 'Frequency_Element'
                        % characteristic_Value_for_Current_subRegion     (Vector): Amplitude/ Phase/ Frequency of current subRegion    
                        
                        % In this section, we try to eliminate the subregions with the length = 2. Since, in this section, 
                        % the 'frequency_Element' for each subregion will have length of 0, and will make error in the next parts.
                        % on th other hand, if a subregion has the length of 0, since all subregions (except the last one) in the burst are of the same length,
                        % then, that whole Burst should be omitted, completely.                        
                            if ( size ( characteristic_Value_for_Current_subRegion, 2 ) == 1)
                                should_we_Omit_the_Whole_Single_Burst = 1;
                                return;
                                
                            end
                            
                    % In this part, we try to calculate the ('Skewness', 'Variance', 'Kurtosis', or 'Mean') Scalar 
                    % of ('Amplitude', 'Phase', or 'Frequency') for current sub-Region                        
                        the_name_of_Current_Statitic = sprintf ( '%s_of_%s', current_Statistic_Name, current_Characteristic_Name_for_this_subRegion );
                        % the_name_of_Current_Statitic (String):    (Selected Statistics)_of_(Selected_Characteristic)
                        %                                              ex.: 'Skewness_of_Amplitude_Element' 
 
                        value_of_Current_Statistic_for_a_Single_subRegion = current_Statistic_Function ( characteristic_Value_for_Current_subRegion, 0 );                 
                            % value_of_Current_Statistic_for_a_Single_subRegion (Scalar): ('Skewness', 'Variance', 'Kurtosis', or 'Mean') of ('Amplitude', 'Phase', or 'Frequency') for current sub-Region
                                                   
                    temp_Structure = struct ( 'element_Name', the_name_of_Current_Statitic, 'element_Value', value_of_Current_Statistic_for_a_Single_subRegion );
                            % temp_Structure (Structure)
                            %            --------------------------------------------------------------------------------------------------
                            %            | element_Name  (Field):    (Selected Statistics)_of_(Selected_Characteristic)  (String)  | 
                            %            |                            ex.: 'Skewness_of_Amplitude_Element'                                |
                            %            |                                                                                                |
                            %            | element_Value (Field):    Skewness/Kurtosis/Variance/Mean                            (Scalar)  |               
                            %            --------------------------------------------------------------------------------------------------
                           
                    vertical_Structure_of_Selected_Characteristics_for_a_Single_subRegion = [ vertical_Structure_of_Selected_Characteristics_for_a_Single_subRegion; temp_Structure ];
                    
                end  
                          % vertical_Structure_of_Selected_Characteristics_for_a_Single_subRegion (Structure)
                                    %            --------------------------------------------------------------------------------------------------
                                    %            | element_Name  (Field):           Amplitude_Element                        (String)             | 
                                    %            | element_Value (Field):               Amplitude                            (Vector)             |               
                                    %            --------------------------------------------------------------------------------------------------
                                    %            | element_Name  (Field):             Phase_Element                          (String)             | 
                                    %            | element_Value (Field):               Amplitude                            (Vector)             |               
                                    %            --------------------------------------------------------------------------------------------------
                                    %            | element_Name  (Field):           Frequency_Element                        (String)             | 
                                    %            | element_Value (Field):               Amplitude                            (Vector)             |               
                                    %            --------------------------------------------------------------------------------------------------
                                    %            | element_Name  (Field): (Selected Statistics)_of_Amplitude_Element         (String)             |
                                    %            |                           ex.: 'Skewness_of_Amplitude_Element'                                 |
                                    %            |                                                                                                |
                                    %            | element_Value (Field): (Selected Statistics)_of_Amplitude_Element         (Scalar)             |               
                                    %            --------------------------------------------------------------------------------------------------
                                    %            | element_Name  (Field): (Selected Statistics)_of_Phase_Element             (String)             |
                                    %            |                           ex.: 'Skewness_of_Phase_Element'                                     |
                                    %            |                                                                                                |
                                    %            | element_Value (Field): (Selected Statistics)_of_Phase_Element             (Scalar)             |               
                                    %            --------------------------------------------------------------------------------------------------
                                    %            | element_Name  (Field): (Selected Statistics)_of_Frequency_Element         (String)             |
                                    %            |                           ex.: 'Skewness_of_Frequency_Element'                                 |
                                    %            |                                                                                                |
                                    %            | element_Value (Field): (Selected Statistics)_of_Frequency_Element         (Scalar)             |                 
                                    %            --------------------------------------------------------------------------------------------------                                    

                temp_Str_of_Selected_Characteristics_for_a_Single_Burst ( subRegion_Index, index ).Characteristics_of_a_Single_subRegion = vertical_Structure_of_Selected_Characteristics_for_a_Single_subRegion;
                
            end
                        
        end
        
                        % temp_Str_of_Selected_Characteristics_for_a_Single_Burst (Structure)                            
                                %  -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                %  |     |                                                    | element_Name  (Field):           Amplitude_Element                        (String)             | element_Name  (Field):           Amplitude_Element                        (String)             | element_Name  (Field):           Amplitude_Element                        (String)             | element_Name  (Field):           Amplitude_Element                        (String)             | 
                                %  |     |                                                    | element_Value (Field):               Amplitude                            (Vector)             | element_Value (Field):               Amplitude                            (Vector)             | element_Value (Field):               Amplitude                            (Vector)             | element_Value (Field):               Amplitude                            (Vector)             |               
                                %  |     |                                                    -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                %  |     |                                                    | element_Name  (Field):             Phase_Element                          (String)             | element_Name  (Field):             Phase_Element                          (String)             | element_Name  (Field):             Phase_Element                          (String)             | element_Name  (Field):             Phase_Element                          (String)             | 
                                %  |     |                                                    | element_Value (Field):               Amplitude                            (Vector)             | element_Value (Field):               Amplitude                            (Vector)             | element_Value (Field):               Amplitude                            (Vector)             | element_Value (Field):               Amplitude                            (Vector)             |               
                                %  |     |                                                    -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                %  |     |                                                    | element_Name  (Field):           Frequency_Element                        (String)             | element_Name  (Field):           Frequency_Element                        (String)             | element_Name  (Field):           Frequency_Element                        (String)             | element_Name  (Field):           Frequency_Element                        (String)             | 
                                %  |     |                                                    | element_Value (Field):               Amplitude                            (Vector)             | element_Value (Field):               Amplitude                            (Vector)             | element_Value (Field):               Amplitude                            (Vector)             | element_Value (Field):               Amplitude                            (Vector)             |               
                                %  |  1  |   Characteristics_of_a_Single_subRegion (Field):   -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                %  |     |                                                    | element_Name  (Field):       Skewness_of_Amplitude_Element                (String)             | element_Name  (Field):       Variance_of_Amplitude_Element                (String)             | element_Name  (Field):       Kurtosis_of_Amplitude_Element                (String)             | element_Name  (Field):       Mean_of_Amplitude_Element                (String)                 |
                                %  |     |                                                    | element_Value (Field):       Skewness_of_Amplitude_Element                (Scalar)             | element_Value (Field):       Variance_of_Amplitude_Element                (Scalar)             | element_Value (Field):       Kurtosis_of_Amplitude_Element                (Scalar)             | element_Value (Field):       Mean_of_Amplitude_Element                (Scalar)                 |               
                                %  |     |                                                    ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                %  |     |                                                    | element_Name  (Field):         Skewness_of_Phase_Element                  (String)             | element_Name  (Field):         Variance_of_Phase_Element                  (String)             | element_Name  (Field):         Kurtosis_of_Phase_Element                  (String)             | element_Name  (Field):         Mean_of_Phase_Element                  (String)                 |
                                %  |     |                                                    | element_Value (Field):         Skewness_of_Phase_Element                  (Scalar)             | element_Value (Field):         Variance_of_Phase_Element                  (Scalar)             | element_Value (Field):         Kurtosis_of_Phase_Element                  (Scalar)             | element_Value (Field):         Mean_of_Phase_Element                  (Scalar)                 |              
                                %  |     |                                                    -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                %  |     |                                                    | element_Name  (Field):       Skewness_of_Frequency_Element                (String)             | element_Name  (Field):       Variance_of_Frequency_Element                (String)             | element_Name  (Field):       Kurtosis_of_Frequency_Element                (String)             | element_Name  (Field):       Mean_of_Frequency_Element                (String)                 |
                                %  |     |                                                    | element_Value (Field):       Skewness_of_Frequency_Element                (Scalar)             | element_Value (Field):       Variance_of_Frequency_Element                (Scalar)             | element_Value (Field):       Kurtosis_of_Frequency_Element                (Scalar)             | element_Value (Field):       Mean_of_Frequency_Element                (Scalar)                 |             
                                %-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                                                                                                              
                                %  |  .  |                         .                          .                                         .                                         .                                         .                                         .                                         .                                         .                                         .                                         .                                         .         |                                             |               
                                %  |  .  |                         .                          .                                         .                                         .                                         .                                         .                                         .                                         .                                         .                                         .                                         .         |
                                %  |  .  |                         .                          .                                         .                                         .                                         .                                         .                                         .                                         .                                         .                                         .                                         .         |
                                %  -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                %  |     |                                                    | element_Name  (Field):           Amplitude_Element                        (String)             | element_Name  (Field):           Amplitude_Element                        (String)             | element_Name  (Field):           Amplitude_Element                        (String)             | element_Name  (Field):           Amplitude_Element                        (String)             | 
                                %  |     |                                                    | element_Value (Field):               Amplitude                            (Vector)             | element_Value (Field):               Amplitude                            (Vector)             | element_Value (Field):               Amplitude                            (Vector)             | element_Value (Field):               Amplitude                            (Vector)             |               
                                %  |     |                                                    -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                %  |     |                                                    | element_Name  (Field):             Phase_Element                          (String)             | element_Name  (Field):             Phase_Element                          (String)             | element_Name  (Field):             Phase_Element                          (String)             | element_Name  (Field):             Phase_Element                          (String)             | 
                                %  |     |                                                    | element_Value (Field):               Amplitude                            (Vector)             | element_Value (Field):               Amplitude                            (Vector)             | element_Value (Field):               Amplitude                            (Vector)             | element_Value (Field):               Amplitude                            (Vector)             |               
                                %  |     |                                                    -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                %  |     |                                                    | element_Name  (Field):           Frequency_Element                        (String)             | element_Name  (Field):           Frequency_Element                        (String)             | element_Name  (Field):           Frequency_Element                        (String)             | element_Name  (Field):           Frequency_Element                        (String)             | 
                                %  |     |                                                    | element_Value (Field):               Amplitude                            (Vector)             | element_Value (Field):               Amplitude                            (Vector)             | element_Value (Field):               Amplitude                            (Vector)             | element_Value (Field):               Amplitude                            (Vector)             |               
                                %  | 33  |   Characteristics_of_a_Single_subRegion (Field):   -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                %  |     |                                                    | element_Name  (Field):       Skewness_of_Amplitude_Element                (String)             | element_Name  (Field):       Variance_of_Amplitude_Element                (String)             | element_Name  (Field):       Kurtosis_of_Amplitude_Element                (String)             | element_Name  (Field):       Mean_of_Amplitude_Element                (String)                 |
                                %  |     |                                                    | element_Value (Field):       Skewness_of_Amplitude_Element                (Scalar)             | element_Value (Field):       Variance_of_Amplitude_Element                (Scalar)             | element_Value (Field):       Kurtosis_of_Amplitude_Element                (Scalar)             | element_Value (Field):       Mean_of_Amplitude_Element                (Scalar)                 |               
                                %  |     |                                                    ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                %  |     |                                                    | element_Name  (Field):         Skewness_of_Phase_Element                  (String)             | element_Name  (Field):         Variance_of_Phase_Element                  (String)             | element_Name  (Field):         Kurtosis_of_Phase_Element                  (String)             | element_Name  (Field):         Mean_of_Phase_Element                  (String)                 |
                                %  |     |                                                    | element_Value (Field):         Skewness_of_Phase_Element                  (Scalar)             | element_Value (Field):         Variance_of_Phase_Element                  (Scalar)             | element_Value (Field):         Kurtosis_of_Phase_Element                  (Scalar)             | element_Value (Field):         Mean_of_Phase_Element                  (Scalar)                 |              
                                %  |     |                                                    -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                %  |     |                                                    | element_Name  (Field):       Skewness_of_Frequency_Element                (String)             | element_Name  (Field):       Variance_of_Frequency_Element                (String)             | element_Name  (Field):       Kurtosis_of_Frequency_Element                (String)             | element_Name  (Field):       Mean_of_Frequency_Element                (String)                 |
                                %  |     |                                                    | element_Value (Field):       Skewness_of_Frequency_Element                (Scalar)             | element_Value (Field):       Variance_of_Frequency_Element                (Scalar)             | element_Value (Field):       Kurtosis_of_Frequency_Element                (Scalar)             | element_Value (Field):       Mean_of_Frequency_Element                (Scalar)                 |             
                                %-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
                            
    %% Section 3: Concatenating all 'Statistics' related to each 'subRegion' to each Other
        for row_Index = 1 : size ( temp_Str_of_Selected_Characteristics_for_a_Single_Burst, 1 )

            for column_Index = 1 : size ( temp_Str_of_Selected_Characteristics_for_a_Single_Burst, 2 )
                temp_1 = temp_Str_of_Selected_Characteristics_for_a_Single_Burst( row_Index, column_Index ).Characteristics_of_a_Single_subRegion;

                            % temp_1 (Structure)
                                    %            --------------------------------------------------------------------------------------------------
                                    %            | element_Name  (Field):           Amplitude_Element                        (String)             | 
                                    %            | element_Value (Field):               Amplitude                            (Vector)             |               
                                    %            --------------------------------------------------------------------------------------------------
                                    %            | element_Name  (Field):             Phase_Element                          (String)             | 
                                    %            | element_Value (Field):               Amplitude                            (Vector)             |               
                                    %            --------------------------------------------------------------------------------------------------
                                    %            | element_Name  (Field):           Frequency_Element                        (String)             | 
                                    %            | element_Value (Field):               Amplitude                            (Vector)             |               
                                    %            --------------------------------------------------------------------------------------------------
                                    %            | element_Name  (Field): (Selected Statistics)_of_Amplitude_Element         (String)             |
                                    %            |                           ex.: 'Skewness_of_Amplitude_Element'                                 |
                                    %            |                                                                                                |
                                    %            | element_Value (Field): (Selected Statistics)_of_Amplitude_Element         (Scalar)             |               
                                    %            --------------------------------------------------------------------------------------------------
                                    %            | element_Name  (Field): (Selected Statistics)_of_Phase_Element             (String)             |
                                    %            |                           ex.: 'Skewness_of_Phase_Element'                                     |
                                    %            |                                                                                                |
                                    %            | element_Value (Field): (Selected Statistics)_of_Phase_Element             (Scalar)             |               
                                    %            --------------------------------------------------------------------------------------------------
                                    %            | element_Name  (Field): (Selected Statistics)_of_Frequency_Element         (String)             |
                                    %            |                           ex.: 'Skewness_of_Frequency_Element'                                 |
                                    %            |                                                                                                |
                                    %            | element_Value (Field): (Selected Statistics)_of_Frequency_Element         (Scalar)             |                 
                                    %            --------------------------------------------------------------------------------------------------                                    

                for index = 1 : size ( temp_1, 1 )
                    vertical_Structure_of_Selected_Statistics_for_a_Single_Burst ( row_Index, 1 ). (temp_1(index, 1).element_Name) = temp_1(index, 1).element_Value;

                end

            end

        end
                         % vertical_Structure_of_Selected_Statistics_for_a_Single_Burst (Structure)                            
                            %  ---------------------------------------------------------------------------------------------------------------------------------
                            %  |     | Amplitude_Element  (Field):                               Amplitude_Element                        (Vector)             |
                            %  |     | Phase_Element      (Field):                                   Amplitude                            (Vector)             |
                            %  |     | Frequency_Element  (Field):                                 Phase_Element                          (Vector)             |
                            %  |     |                                                                                                                         |
                            %  |     | Skewness_of_Amplitude_Element (Field):               Skewness_of_Amplitude_Element                 (Scalar)             |
                            %  |     | Skewness_of_Phase_Element     (Field):                 Skewness_of_Phase_Element                   (Scalar)             |
                            %  |     | Skewness_of_Frequency_Element (Field):               Skewness_of_Frequency_Element                 (Scalar)             |
                            %  |  1  |                                                                                                                         |
                            %  |     | Variance_of_Amplitude_Element (Field):               Variance_of_Amplitude_Element                 (Scalar)             |
                            %  |     | Variance_of_Phase_Element     (Field):                 Variance_of_Phase_Element                   (Scalar)             |
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
                            %  | 33  |                                                                                                                         |
                            %  |     | Variance_of_Amplitude_Element (Field):               Variance_of_Amplitude_Element                 (Scalar)             |
                            %  |     | Variance_of_Phase_Element     (Field):                 Variance_of_Phase_Element                   (Scalar)             |
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
                            
end