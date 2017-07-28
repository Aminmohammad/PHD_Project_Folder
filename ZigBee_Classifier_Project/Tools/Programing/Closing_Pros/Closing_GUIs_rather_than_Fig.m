function Closing_GUIs_rather_than_Fig ( output_Results )

    for index_1 = 1 : size ( output_Results, 1 )

        if ( isstruct ( output_Results ( index_1, 1 ).PM_output_Structure_from_Classification ) == 1 ) 

            temp_FieldNames = fieldnames ( output_Results ( index_1, 1 ).PM_output_Structure_from_Classification );

            figure_Index = 1;
            for index_2 = 1 : size ( temp_FieldNames, 1 )
                if ( strcmp ( char ( temp_FieldNames ( index_2, 1 ) ), 'GUI_Model_Hanlde' ) == 1 )

                    temp_ViewNet_of_all_GUI_Models      = output_Results ( index_1, 1 ).PM_output_Structure_from_Classification.GUI_Model_Hanlde;
                    temp_ViewNet_Cell_of_all_GUI_Models = temp_ViewNet_of_all_GUI_Models (:);

                    for index_3 = 1 : size ( temp_ViewNet_Cell_of_all_GUI_Models, 1 )
                        handle_of_Current_GUI_Model      = temp_ViewNet_Cell_of_all_GUI_Models ( index_3, 1 );

                        close( handle_of_Current_GUI_Model );

                    end

                end                

            end
        end

    end
    
end