classdef FingerPrint_Production_Manager
    
% Essential Inputs:    
%   input_Structure. selected_DataBank_Name = '2016-07-11_IQ_20Msps_RZUSBSTICK';
%   input_Structure. do_You_Want_to_Make_new_DataBank = 0;
%   input_Structure. vertical_Cell_of_Characteristics_Names = {'Amplitude_Element', 'Phase_Element', 'Amplitude_Element'};
%   input_Structure. vertical_Cell_of_Statistics_Names = {'Skewness', 'Variance', 'Mean'};
%   input_Structure. selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst = 'Skewness';
%   input_Structure. Vertical_Structure_of_all_Devices = [];
    
% how to call:
%   k = FingerPrint_Production_Manager (input_Structure)
%   a = k.FingerPrint_for_Multi_Devices_Caller

    properties
        list_of_Inputs;
        
    end
    
    methods
        
        function obj = FingerPrint_Production_Manager ( input_Structure )
            extracted_Filed_Names = fieldnames (input_Structure);
            
            for index = 1 : size ( extracted_Filed_Names, 1 )                      
                obj.list_of_Inputs = [ obj.list_of_Inputs {extracted_Filed_Names{index} [input_Structure.(extracted_Filed_Names{index})]} ];

            end
            
        end
        
        function vertical_Structure_of_FingerPrint_DataBank_for_all_Devices = FingerPrint_for_Multi_Devices_Caller ( obj )
                 vertical_Structure_of_FingerPrint_DataBank_for_all_Devices = FingerPrint_for_Multi_Devices ( obj.list_of_Inputs{:} );

        end
        
        
        
    end
    
end
















