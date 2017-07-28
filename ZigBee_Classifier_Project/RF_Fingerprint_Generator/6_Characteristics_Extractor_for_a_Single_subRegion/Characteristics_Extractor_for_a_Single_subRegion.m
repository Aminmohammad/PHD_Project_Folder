function vertical_Structure_of_Selected_Characteristics_for_a_Single_subRegion = Characteristics_Extractor_for_a_Single_subRegion (    horizontal_Vector_of_Single_sub_Region, ... used in:  'selected_Characteristic_Function'                                                                                                                                                             ,                                  ...  used in: 'selected_Characteristic_Function'
                                                                                                                                       vertical_Cell_of_Characteristics_Names  ... used here
                                                                                                                                                         )

    %% Section 1: Initial Parameter Extraction
        % Level 1: Management of Input
            vertical_Cell_of_Characteristics_Names = Converter_to_Horizontal_or_Vertical_Vector( vertical_Cell_of_Characteristics_Names, 'Vertical', 'Chasacteristics Extractor for a Single sub-Region' );                
          
    %% Section 2: Calling Selected Characteristics
        for vertical_Cell_of_Characteristics_Names_Index = 1 : size ( vertical_Cell_of_Characteristics_Names, 1 )            
            selected_Characteristic_Function             = str2func ( vertical_Cell_of_Characteristics_Names{ vertical_Cell_of_Characteristics_Names_Index, 1 } );
            selected_Characteristic_Value                = selected_Characteristic_Function( horizontal_Vector_of_Single_sub_Region );  % selected_Characteristic_Function: like ( Amplitude, Phase, Frequency ) 

            vertical_Structure_of_Selected_Characteristics_for_a_Single_subRegion ( vertical_Cell_of_Characteristics_Names_Index, 1 ) . element_Name  = char ( vertical_Cell_of_Characteristics_Names ( vertical_Cell_of_Characteristics_Names_Index, 1 ) ); %#ok<*AGROW>
            vertical_Structure_of_Selected_Characteristics_for_a_Single_subRegion ( vertical_Cell_of_Characteristics_Names_Index, 1 ) . element_Value = selected_Characteristic_Value;            

        end

end