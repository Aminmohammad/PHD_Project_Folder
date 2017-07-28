    function output = WrittenV1_Perceptron_Neural_Network_Cost_Function_Calculator (    chromosome,                ...
                                                                                        weight_Specific_Structure, ...
                                                                                        structure_of_Fixed_Variables_for_Cost_Function )
                                                                                                
    weight_Specific_Structure                = Convert_to_IW_LW_and_b ( chromosome,         ...
                                                                        weight_Specific_Structure );   
    
    network                                  = structure_of_Fixed_Variables_for_Cost_Function. net;
    network. Iw                              = weight_Specific_Structure. input_Weight_Cell;
    network. Lw                              = weight_Specific_Structure. hiddenLayer_Weight_Cell;
    network. b                               = weight_Specific_Structure. bias_Weight_Cell;
    
    dataPoints   = structure_of_Fixed_Variables_for_Cost_Function. dataPoints;
    class_Labels = structure_of_Fixed_Variables_for_Cost_Function. class_Labels;

    output_from_Net    = network ( dataPoints );

    temp_output = MS_Error(     'selected_Classification_Method_Name', 'Test',  ...    
                                'classLabels_from_Net', output_from_Net, ...
                                'classLabels_from_DataBank', class_Labels );
                            
    output.mean_Squared_error = temp_output.mean_Square_Error_Value;
    output.network            = network;
    output.output_from_Net    = output_from_Net;
    output.class_Labels       = class_Labels;
            
end