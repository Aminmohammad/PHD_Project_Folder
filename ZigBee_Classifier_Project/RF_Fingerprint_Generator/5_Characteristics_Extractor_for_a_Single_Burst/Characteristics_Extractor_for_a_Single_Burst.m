function [ vertical_Structure_of_Selected_Characteristics_for_a_Single_Burst, horizontal_Vector_of_Lengths_of_all_subRegions ] = Characteristics_Extractor_for_a_Single_Burst ( vertical_Cell_of_Characteristics_Names,             ...
                                                                                                                                                                                 vertical_Structure_of_single_Burst)                 ... used in: 'selected_Characteristic_Function'                                                                                                                                                              
% Output:                                                                                                                                          
    % vertical_Structure_of_Selected_Characteristics_for_a_Single_Burst (Structure)
    %  ----------------------------------------------------------------------------------------------------------------------------
    %  |     |                                                           | element_Name  (Field):    Amplitude_Element  (String)  |               
    %  |     |                                                           | element_Value (Field):    Amplitude_Value    (Vector)  |               
    %  |     |                                                           ----------------------------------------------------------
    %  |     |                                                           | element_Name  (Field):    Phase_Element      (String)  |               
    %  |  1  |   Characteristics_of_a_Single_subRegion (Field):   | element_Value (Field):    Phase_Value        (Vector)  |               
    %  |     |                                                           ----------------------------------------------------------
    %  |     |                                                           | element_Name  (Field):    Frequency_Element  (String)  |               
    %  |     |                                                           | element_Value (Field):    Frequency_Value    (Vector)  |               
    %  ----------------------------------------------------------------------------------------------------------------------------
    %  |  .  |                         .                                 .                                         .              |               
    %  |  .  |                         .                                 .                                         .              |                             
    %  |  .  |                         .                                 .                                         .              |               
    %  ----------------------------------------------------------------------------------------------------------------------------
    %  |     |                                                           | element_Name  (Field):    Amplitude_Element  (String)  |               
    %  |     |                                                           | element_Value (Field):    Amplitude_Value    (Vector)  |               
    %  |     |                                                           ----------------------------------------------------------
    %  |     |                                                           | element_Name  (Field):    Phase_Element      (String)  |               
    %  | 33  |   Characteristics_of_a_Single_subRegion (Field):   | element_Value (Field):    Phase_Value        (Vector)  |               
    %  |     |                                                           ----------------------------------------------------------
    %  |     |                                                           | element_Name  (Field):    Frequency_Element  (String)  |               
    %  |     |                                                           | element_Value (Field):    Frequency_Value    (Vector)  |               
    %  ----------------------------------------------------------------------------------------------------------------------------                            
                            
                            
    %% Section 0: Preliminaries
        % Level 1: Management of Input
            vertical_Cell_of_Characteristics_Names = Converter_to_Horizontal_or_Vertical_Vector ( vertical_Cell_of_Characteristics_Names, 'Vertical', 'Chasacteristics Extractor for a Single Burst' ); 
            vertical_Structure_of_single_Burst     = Converter_to_Horizontal_or_Vertical_Vector ( vertical_Structure_of_single_Burst,            'Vertical', 'Chasacteristics Extractor for a Single Burst' ); 

    %% Section 1: Calling Selected Characteristics
        for subRegion_Index = 1 : size ( vertical_Structure_of_single_Burst, 1 )            
            current_SubRegion = [vertical_Structure_of_single_Burst( subRegion_Index, 1 ).a_Single_subRegion];
            calculated_Characteristics_for_Current_subRegion = Characteristics_Extractor_for_a_Single_subRegion ( current_SubRegion, vertical_Cell_of_Characteristics_Names );
                            % calculated_Characteristics_for_Current_subRegion (Structure)
                            %            ----------------------------------------------------------
                            %            | element_Name  (Field):    Amplitude_Element  (String)  |               
                            %            | element_Value (Field):    Amplitude_Value    (Vector)  |               
                            %            ----------------------------------------------------------
                            %            | element_Name  (Field):    Phase_Element      (String)  |               
                            %            | element_Value (Field):    Phase_Value        (Vector)  |               
                            %            ----------------------------------------------------------
                            %            | element_Name  (Field):    Frequency_Element  (String)  |               
                            %            | element_Value (Field):    Frequency_Value    (Vector)  |               
                            %            ----------------------------------------------------------
            vertical_Structure_of_Selected_Characteristics_for_a_Single_Burst ( 1, subRegion_Index ).Characteristics_of_a_Single_subRegion = calculated_Characteristics_for_Current_subRegion;            
            
            horizontal_Vector_of_Lengths_of_all_subRegions ( 1, subRegion_Index ) = size ( current_SubRegion, 1 );
            
        end

end