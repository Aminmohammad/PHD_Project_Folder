function horizontal_Vector_of_Amplitude = Amplitude_Element ( horizontal_Vector_of_a_Single_subRegion )

    %% Section 0: Preliminaries
        % Level 1: Management of Input
            horizontal_Vector_of_a_Single_subRegion = Converter_to_Horizontal_or_Vertical_Vector ( horizontal_Vector_of_a_Single_subRegion, 'Horizontal', 'Amplitude' );
                
    %% Section 1: Extraction of Amplitude
        horizontal_Vector_of_Amplitude = abs (horizontal_Vector_of_a_Single_subRegion);
                
end