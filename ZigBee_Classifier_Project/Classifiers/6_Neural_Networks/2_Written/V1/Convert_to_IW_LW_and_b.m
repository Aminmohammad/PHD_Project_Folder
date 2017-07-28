function output = Convert_to_IW_LW_and_b ( input_Chromosome,   ...
                                           weight_Specific_Structure )

    input_Weight_IndexSaving_Structure       = weight_Specific_Structure . input_Weight_IndexSaving_Structure;
    hiddenLayer_Weight_IndexSaving_Structure = weight_Specific_Structure . hiddenLayer_Weight_IndexSaving_Structure;
    bias_Weight_IndexSaving_Structure        = weight_Specific_Structure . bias_Weight_IndexSaving_Structure;

    size_Cell = weight_Specific_Structure.size_Cell;

    for input_Weight_Index = 1 : size ( input_Weight_IndexSaving_Structure, 1 )
                
        number_of_Rows      = input_Weight_IndexSaving_Structure ( input_Weight_Index, 1 ) . number_of_Rows;
        number_of_Columns   = input_Weight_IndexSaving_Structure ( input_Weight_Index, 1 ) . number_of_Columns;
        input_Row_Index     = input_Weight_IndexSaving_Structure ( input_Weight_Index, 1 ) . rowNum_in_Vertical_Cell_of_Input_Weights;

        vector_of_Lengths ( 1, input_Weight_Index )   = number_of_Rows * number_of_Columns;

        if ( input_Weight_Index == 1 )                
            temp_Vector = input_Chromosome ( 1, 1 : vector_of_Lengths ( 1, input_Weight_Index ) );               

        else
            temp_Vector = input_Chromosome ( 1, sum ( vector_of_Lengths ( 1, 1 : input_Weight_Index - 1 ) ) + 1          :          sum ( vector_of_Lengths ( 1, 1 : input_Weight_Index ) )       )  ;

        end

        input_Weight_Cell ( input_Row_Index, 1 ) = {reshape(temp_Vector', number_of_Columns, number_of_Rows)'};

        
    end

    if ( size ( input_Weight_Cell, 1 ) < size_Cell . size_of_Original_InputWeight_Cell_from_Net )
        input_Weight_Cell = [ input_Weight_Cell; cell( size_Cell . size_of_Original_InputWeight_Cell_from_Net - size ( input_Weight_Cell, 1 ),1) ];
    end

    for hiddenLayer_Weight_Index = 1 : size ( hiddenLayer_Weight_IndexSaving_Structure, 1 )
               
       number_of_Rows      = hiddenLayer_Weight_IndexSaving_Structure ( hiddenLayer_Weight_Index, 1 ) . number_of_Rows;
       number_of_Columns   = hiddenLayer_Weight_IndexSaving_Structure ( hiddenLayer_Weight_Index, 1 ) . number_of_Columns;
       input_Row_Index     = hiddenLayer_Weight_IndexSaving_Structure ( hiddenLayer_Weight_Index, 1 ) . rowNum_in_Vertical_Cell_of_hiddenLayer_Weights;
       input_Column_Index  = hiddenLayer_Weight_IndexSaving_Structure ( hiddenLayer_Weight_Index, 1 ) . colNum_in_Vertical_Cell_of_hiddenLayer_Weights;

       vector_of_Lengths ( 1, input_Weight_Index + hiddenLayer_Weight_Index )   = number_of_Rows * number_of_Columns;

       start_Index = sum ( vector_of_Lengths ( 1, 1 : input_Weight_Index + hiddenLayer_Weight_Index - 1 ) ) + 1;
       end_Index   = sum ( vector_of_Lengths ( 1, 1 : input_Weight_Index + hiddenLayer_Weight_Index ) );
       temp_Vector = input_Chromosome ( 1, start_Index : end_Index );

       hiddenLayer_Weight_Cell ( input_Row_Index, input_Column_Index ) = {reshape(temp_Vector', number_of_Columns, number_of_Rows)'};

        
   end

   if ( size ( hiddenLayer_Weight_Cell, 2 ) < size_Cell . size_of_Original_HiddenLayerWeight_Cell_from_Net )
       hiddenLayer_Weight_Cell = [ hiddenLayer_Weight_Cell cell( size ( hiddenLayer_Weight_Cell, 1 ), size_Cell . size_of_Original_HiddenLayerWeight_Cell_from_Net - size ( hiddenLayer_Weight_Cell, 2 )) ];
   end

   for bias_Weight_Index = 1 : size ( bias_Weight_IndexSaving_Structure, 1 )
               
       number_of_Rows     = bias_Weight_IndexSaving_Structure ( bias_Weight_Index, 1 ) . number_of_Rows;        number_of_Columns  = bias_Weight_IndexSaving_Structure ( bias_Weight_Index, 1 ) . number_of_Columns;
       bias_Row_Index     = bias_Weight_IndexSaving_Structure ( bias_Weight_Index, 1 ) . rowNum_in_Vertical_Cell_of_Bias_Weights;

       vector_of_Lengths ( 1, input_Weight_Index + hiddenLayer_Weight_Index + bias_Weight_Index )   = number_of_Rows * number_of_Columns;

       start_Index = sum ( vector_of_Lengths ( 1, 1 : input_Weight_Index + hiddenLayer_Weight_Index + bias_Weight_Index - 1 ) ) + 1;
       end_Index   = sum ( vector_of_Lengths ( 1, 1 : input_Weight_Index + hiddenLayer_Weight_Index + bias_Weight_Index ) );
       temp_Vector = input_Chromosome ( 1, start_Index : end_Index );
       
       bias_Weight_Cell ( bias_Row_Index, 1 ) = {reshape(temp_Vector', number_of_Columns, number_of_Rows)'}; %#ok<*AGROW>
        
   end

    if ( size ( bias_Weight_Cell, 1 ) < size_Cell . size_of_Original_BiasWeight_Cell_from_Net )
        bias_Weight_Cell = [ bias_Weight_Cell; cell( size_Cell . size_of_Original_BiasWeight_Cell_from_Net - size ( bias_Weight_Cell, 1 ), 1) ];
    end

    output. input_Weight_Cell       = input_Weight_Cell;
    output. hiddenLayer_Weight_Cell = hiddenLayer_Weight_Cell;
    output. bias_Weight_Cell        = bias_Weight_Cell; 
    
end
    