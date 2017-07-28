function output = Weight_Specific_Structure_Extractor_for_GA ( net, inputs, targets )

% input:
%                  DataPoints
%                  _        _
%                 |          |
%     Dimensions: |          |
%                 |          |
%                 |_        _|

% output:
%                  DataPoints
%                  _        _
%                 |_        _|
%
    vertical_Cell_of_Input_Weights      = net.IW;
    matrix_Cell_of_Hidden_Layer_Weights = net.LW;
    vertical_Cell_of_Layer_Biases       = net.b;

    size_of_Original_InputWeight_Cell_from_Net       = size ( net.IW, 1 );
    size_of_Original_HiddenLayerWeight_Cell_from_Net = size ( net.LW, 2 );
    size_of_Original_BiasWeight_Cell_from_Net        = size ( net.b, 1 );

    raw_Chromosome_Horizontal_Vector = [];

    number_of_nonEmpty_Weights = 1;
    for input_Row_Index = 1 : size ( vertical_Cell_of_Input_Weights, 1 )
        current_Input_Weights = vertical_Cell_of_Input_Weights{ input_Row_Index, 1 };

        if ( size ( current_Input_Weights, 1 ) ~= 0 )                    
            number_of_Rows = size ( current_Input_Weights, 1 );
            if ( size ( current_Input_Weights, 2 ) == 0 )
                number_of_Columns = size ( inputs, 1 );
                
            else 
                number_of_Columns = size ( current_Input_Weights, 2 );

            end

            raw_Chromosome_Horizontal_Vector = [ raw_Chromosome_Horizontal_Vector, ones( 1, number_of_Rows * number_of_Columns ) ]; %#ok<*AGROW>

            input_Weight_IndexSaving_Structure ( number_of_nonEmpty_Weights, 1 ) . number_of_Rows    = number_of_Rows;
            input_Weight_IndexSaving_Structure ( number_of_nonEmpty_Weights, 1 ) . number_of_Columns = number_of_Columns;
            input_Weight_IndexSaving_Structure ( number_of_nonEmpty_Weights, 1 ) . rowNum_in_Vertical_Cell_of_Input_Weights = input_Row_Index;
            number_of_nonEmpty_Weights = number_of_nonEmpty_Weights + 1;

        end

    end    

    number_of_nonEmpty_Weights = 1;
    for hidden_Layer_Row_Index = 1 : size ( matrix_Cell_of_Hidden_Layer_Weights, 1 )

        for hidden_Layer_Column_Index = 1 : size ( matrix_Cell_of_Hidden_Layer_Weights, 2 )
            current_Hidden_Layer_Weights = matrix_Cell_of_Hidden_Layer_Weights{ hidden_Layer_Row_Index, hidden_Layer_Column_Index };

            if ( size ( current_Hidden_Layer_Weights, 2 ) ~= 0 )
                number_of_Columns = size ( current_Hidden_Layer_Weights, 2 );
                
                if ( size ( current_Hidden_Layer_Weights, 1 ) == 0 )
                    number_of_Rows = size ( targets, 1 );
                    
                else
                    number_of_Rows = size ( current_Hidden_Layer_Weights, 1 );

                end

                raw_Chromosome_Horizontal_Vector = [ raw_Chromosome_Horizontal_Vector, ones( 1, number_of_Rows * number_of_Columns ) ];

                hiddenLayer_Weight_IndexSaving_Structure ( number_of_nonEmpty_Weights, 1 ) . number_of_Rows    = number_of_Rows;
                hiddenLayer_Weight_IndexSaving_Structure ( number_of_nonEmpty_Weights, 1 ) . number_of_Columns = number_of_Columns;
                hiddenLayer_Weight_IndexSaving_Structure ( number_of_nonEmpty_Weights, 1 ) . rowNum_in_Vertical_Cell_of_hiddenLayer_Weights = hidden_Layer_Row_Index;
                hiddenLayer_Weight_IndexSaving_Structure ( number_of_nonEmpty_Weights, 1 ) . colNum_in_Vertical_Cell_of_hiddenLayer_Weights = hidden_Layer_Column_Index;
                number_of_nonEmpty_Weights = number_of_nonEmpty_Weights + 1;

            end
        end

    end

    number_of_nonEmpty_Weights = 1;
    for bias_Row_Index = 1 : size ( vertical_Cell_of_Layer_Biases, 1 )
        current_Bias_Weights = vertical_Cell_of_Layer_Biases{ bias_Row_Index, 1 };

        if ( size ( current_Bias_Weights, 1 ) ~= 0 )
            number_of_Rows = size ( current_Bias_Weights, 1 );
            if ( size ( current_Bias_Weights, 2 ) == 0 )
                number_of_Columns = size ( targets, 1 );

            else                
                number_of_Columns = size ( current_Bias_Weights, 2 );

            end 

            raw_Chromosome_Horizontal_Vector = [ raw_Chromosome_Horizontal_Vector, ones( 1, number_of_Rows * number_of_Columns ) ];

            bias_Weight_IndexSaving_Structure ( number_of_nonEmpty_Weights, 1 ) . number_of_Rows    = number_of_Rows;
            bias_Weight_IndexSaving_Structure ( number_of_nonEmpty_Weights, 1 ) . number_of_Columns = number_of_Columns;
            bias_Weight_IndexSaving_Structure ( number_of_nonEmpty_Weights, 1 ) . rowNum_in_Vertical_Cell_of_Bias_Weights = bias_Row_Index;
            number_of_nonEmpty_Weights = number_of_nonEmpty_Weights + 1;

        end

    end

    output . raw_Chromosome_Horizontal_Vector = raw_Chromosome_Horizontal_Vector;
    
    output . input_Weight_IndexSaving_Structure       = input_Weight_IndexSaving_Structure;
    output . hiddenLayer_Weight_IndexSaving_Structure = hiddenLayer_Weight_IndexSaving_Structure;
    output . bias_Weight_IndexSaving_Structure        = bias_Weight_IndexSaving_Structure;

    size_Cell . size_of_Original_InputWeight_Cell_from_Net       = size_of_Original_InputWeight_Cell_from_Net;
    size_Cell . size_of_Original_HiddenLayerWeight_Cell_from_Net = size_of_Original_HiddenLayerWeight_Cell_from_Net;
    size_Cell . size_of_Original_BiasWeight_Cell_from_Net        = size_of_Original_BiasWeight_Cell_from_Net;

    output. size_Cell = size_Cell;
    