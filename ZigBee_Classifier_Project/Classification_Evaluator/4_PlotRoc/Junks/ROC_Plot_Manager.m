classdef ROC_Plot_Manager
    
    properties
        list_of_Inputs_for_Training;
        list_of_Inputs_for_Testing;
        type_of_Data;
        
    end
    
    methods
        
        function obj = ROC_Plot_Manager ( input_Structure )
            extracted_Filed_Names = fieldnames ( input_Structure );
            obj.type_of_Data   =  input_Structure.type_of_Data;
             for index = 1 : size ( extracted_Filed_Names, 1 )
                 if ( strcmp ( extracted_Filed_Names{index}, 'type_of_Data' ) == 0 )                                  
                     obj.(['list_of_Inputs_for_'  obj.type_of_Data]).(extracted_Filed_Names{index}) = [input_Structure.(extracted_Filed_Names{index})];
                     
                 end
             end
                   
        end
        
        function output_from_ROC_Plot = function_Caller ( obj )
%             
            obj.list_of_Inputs_for_Training
            
            output_from_ROC_Plot = 7;
%             inputs_for_classifier     = Input_Provider_for_Classifier ( obj.list_of_Inputs{:} );            
%             output_from_ROC_Plot      = obj.selected_Classification_Methods ( inputs_for_classifier {:} );

        end
        
        
    end
    
end

