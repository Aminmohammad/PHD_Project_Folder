classdef Data_Loading_Manager
    
% Essential Inputs:    
%   input_Structure. do_You_Want_to_Make_new_DataSet = 1;
%   input_Structure. SelectedDataSetName = '2016-07-11_IQ_20Msps_RZUSBSTICK';
%   input_Structure. zero_Conversion_Threshold = .7;
    
% how to call:
%   k = Data_Loading_Manager (input_Structure)
%   a = k.DataSet_Maker_or_Loader_Caller

    properties
        list_of_Inputs;
        
    end
    
    methods
        
        function obj = Data_Loading_Manager ( input_Structure )
            extracted_Filed_Names = fieldnames (input_Structure);
            
            for index = 1 : size ( extracted_Filed_Names, 1 )                                         
                obj.list_of_Inputs = [ obj.list_of_Inputs {extracted_Filed_Names{index} [input_Structure.(extracted_Filed_Names{index})]} ];

            end
            
        end
        
        function vertical_Structure_of_all_Devices = DataSet_Maker_or_Loader_Caller ( obj )
                 vertical_Structure_of_all_Devices = DataSet_Maker_or_Loader ( obj.list_of_Inputs{:} );
            
        end
        
        
    end
    
end

