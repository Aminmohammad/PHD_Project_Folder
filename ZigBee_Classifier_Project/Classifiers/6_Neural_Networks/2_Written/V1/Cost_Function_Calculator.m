    function mean_Squared_error = Cost_Function_Calculator ( network, chromosome, weight_Structure, structure_of_Fixed_Variables_for_Cost_Function )

    dataPoints, class_Label
    input_Weight_IndexSaving_Structure       = weight_Structure. input_Weight_IndexSaving_Structure;
    hiddenLayer_Weight_IndexSaving_Structure = weight_Structure. hiddenLayer_Weight_IndexSaving_Structure;
    bias_Weight_IndexSaving_Structure        = weight_Structure. bias_Weight_IndexSaving_Structure;
    
    weight_Structure                         = Convert_to_IW_LW_and_b ( chromosome, input_Weight_IndexSaving_Structure, hiddenLayer_Weight_IndexSaving_Structure, bias_Weight_IndexSaving_Structure, size_Cell );

    network. Iw                              = weight_Structure. input_Weight_Cell;
    network. Lw                              = weight_Structure. hiddenLayer_Weight_Cell;
    network. b                               = weight_Structure. bias_Weight_Cell;
    
    output_from_Net = network ( dataPoints  )
    error = class_Labels - output_from_Net;
    mean_Squared_error = mean ( error .^ 2 )
            
end