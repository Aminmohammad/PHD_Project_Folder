classdef post_FeatureGeneration_Processor_Manager
    
    properties
        list_of_Inputs;
        selected_postFeatureGeneration_Function;
        
        postProcessed_DataBank;
        saving_Address;
        
    end
    
    methods
        
        function obj = post_FeatureGeneration_Processor_Manager ( input_Structure )
            extracted_Field_Names = fieldnames ( input_Structure );
             for index = 1 : size ( extracted_Field_Names, 1 )
                 
                 if ( strcmp ( extracted_Field_Names{index}, 'selected_postFeatureGeneration_Method' ) )
                    obj.selected_postFeatureGeneration_Function = str2func ( input_Structure.(extracted_Field_Names{index}) );
                     
                 else                                          
                     obj.list_of_Inputs = [ obj.list_of_Inputs {extracted_Field_Names{index} [input_Structure.(extracted_Field_Names{index})]} ];
                     
                 end
             end

        end
        
        function output_from_postProc = function_Caller ( obj )
            index                = find(strcmp ( (obj.list_of_Inputs), 'Saving_Address') );
            temp_Inputs          = obj.list_of_Inputs;
            temp_Saving_Address  = temp_Inputs (1, index + 1 );
            obj.list_of_Inputs   = [ temp_Inputs(1, 1 : index - 1 ) temp_Inputs(1, index + 2 : end ) ];
            output_from_postProc = obj.selected_postFeatureGeneration_Function ( obj.list_of_Inputs{:} );
            
            obj.postProcessed_DataBank = output_from_postProc;
            obj.saving_Address         = temp_Saving_Address;
            obj.postProcessed_DataBank_Saver ();

        end
        
        function postProcessed_DataBank_Saver ( obj )
            index                = find(strcmp ( (obj.list_of_Inputs), 'selected_Indices_of_Devices_for_postProcessing') );
            temp_Inputs          = obj.list_of_Inputs;
            temp_Selected_Indices_of_Devices_for_postProcessing = temp_Inputs (1, index + 1 );
            output_from_postProc = obj.postProcessed_DataBank;
            temp_Address = obj.saving_Address;
            selected_Indices_of_Devices_for_postProcessing_String = sprintf('%d_', temp_Selected_Indices_of_Devices_for_postProcessing{:});

            save( [ temp_Address{:} '\postProcessed_DataBank__Devices_' selected_Indices_of_Devices_for_postProcessing_String(1, 1:end - 1) '.mat' ] ,'output_from_postProc' );

        end
        
        
    end
    
end

