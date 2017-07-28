function FingerPrint_for_a_Single_Burst = FingerPrint_Generation_for_a_Single_Burst ( matrix_of_Selected_Statistics_for_a_Single_Burst, selected_Algorithm_for_Making_FingerPrint_of_a_Burst )

    current_Statistic_Name     = selected_Algorithm_for_Making_FingerPrint_of_a_Burst;
    current_Statistic_Function = str2func ( char ( current_Statistic_Name ) );
    
    for row_Index = 1 : size ( matrix_of_Selected_Statistics_for_a_Single_Burst, 1 )
        current_Row = matrix_of_Selected_Statistics_for_a_Single_Burst ( row_Index, : );
        FingerPrint_for_a_Single_Burst ( row_Index, 1 )  = current_Statistic_Function ( current_Row, 0 );
    end

end