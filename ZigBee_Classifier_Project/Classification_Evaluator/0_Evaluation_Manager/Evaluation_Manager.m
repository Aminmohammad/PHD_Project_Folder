classdef Evaluation_Manager
    
    properties
        list_of_Inputs;
        selected_Evaluation_Method;
        
    end
    
    methods
        
        function obj = Evaluation_Manager ( input_Structure )
            extracted_Filed_Names = fieldnames ( input_Structure );
             for index = 1 : size ( extracted_Filed_Names, 1 )
                 
                 if ( strcmp ( extracted_Filed_Names{index}, 'selected_Evaluation_Method' ) )
                     obj.selected_Evaluation_Method = str2func ( input_Structure.(extracted_Filed_Names{index}) );
                     
                 else                                          
                     obj.list_of_Inputs = [ obj.list_of_Inputs {extracted_Filed_Names{index} [input_Structure.(extracted_Filed_Names{index})]} ];
                     
                 end
             end             
            
        end
        
        function output_from_Evaluation = function_Caller ( obj ) 
            output_from_Evaluation = obj.selected_Evaluation_Method ( obj.list_of_Inputs{:} );

        end
        
        
    end
    
end

