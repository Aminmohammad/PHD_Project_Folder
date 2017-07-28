% This function is used in: 'Start_Training.m'
function classification_Parameters_Structure = Classification_ParamStruct_Producer_or_Updater_Manager ( strategy, varargin )

    %% Section 1: Extraction of Essential Parameters
        if ( strcmp ( strategy, 'general_Parameters' ) == 1 )
            inputSet = inputParser();
            inputSet.CaseSensitive = false; 
            inputSet.KeepUnmatched = true; 
            inputSet.addParameter( 'Saving_Address', [] );
            inputSet.addParameter( 'selected_Saving_Extension', []);
            inputSet.addParameter( 'selected_Dimensions_for_Draw', [ 1 2 ]);
            inputSet.addParameter( 'training_Percentage', []);
            inputSet.addParameter( 'validation_Percentage', []);
            inputSet.addParameter( 'test_Percentage', []);
            inputSet.addParameter( 'selected_Model_Address_for_Application', []);
            inputSet.addParameter( 'number_of_Devices_in_the_Original_DataBank', []);
            inputSet.addParameter( 'do_You_Want_the_Training_or_Test_be_Based_on_Special_Devices', []);
            inputSet.addParameter( 'selected_Devices_for_Training', []);
            inputSet.addParameter( 'selected_Devices_for_Validation', []);
            inputSet.addParameter( 'selected_Devices_for_Test', []);

            inputSet.parse( varargin{:} );

            classification_Parameters_Structure.Saving_Address                                                     = inputSet.Results.Saving_Address;
            classification_Parameters_Structure.selected_Saving_Extension                                          = inputSet.Results.selected_Saving_Extension;
            classification_Parameters_Structure.selected_Dimensions_for_Draw                                       = inputSet.Results.selected_Dimensions_for_Draw;
            classification_Parameters_Structure.training_Percentage                                                = inputSet.Results.training_Percentage;
            classification_Parameters_Structure.validation_Percentage                                              = inputSet.Results.validation_Percentage;
            classification_Parameters_Structure.test_Percentage                                                    = inputSet.Results.test_Percentage;
            classification_Parameters_Structure.selected_Model_Address_for_Application                             = inputSet.Results.selected_Model_Address_for_Application;
            classification_Parameters_Structure.number_of_Devices_in_the_Original_DataBank                         = inputSet.Results.number_of_Devices_in_the_Original_DataBank;
            classification_Parameters_Structure.do_You_Want_the_Training_or_Test_be_Based_on_Special_Devices       = inputSet.Results.do_You_Want_the_Training_or_Test_be_Based_on_Special_Devices;
            classification_Parameters_Structure.selected_Devices_for_Training                                      = inputSet.Results.selected_Devices_for_Training;
            classification_Parameters_Structure.selected_Devices_for_Validation                                    = inputSet.Results.selected_Devices_for_Validation;
            classification_Parameters_Structure.selected_Devices_for_Test                                          = inputSet.Results.selected_Devices_for_Test;

        elseif ( strcmp ( strategy, 'special_Parameters' ) == 1 )     
   
            index_of_String   = strcmp ( varargin, 'selected_Classification_Methods' );
            index_of_nonZeros = find (index_of_String ~= 0);
            index_of_String_1 = zeros ( 1, size ( index_of_String, 2 ));
            index_of_String_1(1, index_of_nonZeros : index_of_nonZeros + 1) = 1;
            varargin_1 = varargin ( 1, index_of_String_1 == 1 );

            temp_1 = varargin_1( 1, 2);
            selected_Classification_Methods = char ( temp_1 {:} );
            
            index_of_String   = strcmp ( varargin, 'permutation' );
            index_of_nonZeros = find (index_of_String ~= 0);
            index_of_String_2 (1, index_of_nonZeros : index_of_nonZeros + 1) = 1;

            varargin_2 = varargin ( 1, index_of_String_2 == 1 );

            temp_2 = varargin_2( 1, 2);
            permutation = cell2mat (temp_2);
            
            varargin_2 = varargin ( 1, index_of_String_2 == 1 );
          
            classification_Parameters_Structure.selected_Classification_Method = strtrim( char ( selected_Classification_Methods ( permutation, : ) ) );

            varargin_3 = varargin ( 1, ~( index_of_String_1 + index_of_String_2 ) );

            selected_Classification_Function_Parameter_Updater = str2func ( [ [classification_Parameters_Structure.selected_Classification_Method] '_Special_Parameter_Updater' ] );
            classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification = selected_Classification_Function_Parameter_Updater ( varargin_3{:} );
                        
        end
end

    
    