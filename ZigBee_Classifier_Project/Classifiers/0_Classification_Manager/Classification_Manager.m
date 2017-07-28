classdef Classification_Manager
    
    properties
        list_of_Inputs;
        selected_Classification_Methods;
        
    end
    
    methods
        
        function obj = Classification_Manager ( input_Structure )
            extracted_Filed_Names = fieldnames ( input_Structure );
             for index = 1 : size ( extracted_Filed_Names, 1 )
                 
                 if ( strcmp ( extracted_Filed_Names{index}, 'selected_Classification_Method' ) )
                    obj.selected_Classification_Methods = str2func ( input_Structure.(extracted_Filed_Names{index}) );
                     
                 else                                          
                     obj.list_of_Inputs = [ obj.list_of_Inputs {extracted_Filed_Names{index} [input_Structure.(extracted_Filed_Names{index})]} ];
                     
                 end
             end
            
        end
        
        function output_from_Classification = function_Caller ( obj )
            inputs_for_classifier      = Input_Provider_for_Classifier ( obj.list_of_Inputs{:} );            
            output_from_Classifier     = obj.selected_Classification_Methods ( inputs_for_classifier {:} );

            temp_Output_from_Classifier = [ output_from_Classifier, [obj.list_of_Inputs], inputs_for_classifier ];

            output_from_Classification = Output_Provider_from_Classifier ( temp_Output_from_Classifier {:} );

        end
        
        
    end
    
end

