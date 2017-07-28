function Deleting_the_Saved_Output_Folders_from_Results ( cell_of_Address_of_Output_Folders_from_Results_Folder )

    cell_of_Address_of_Output_Folders_from_Results_Folder = cell_of_Address_of_Output_Folders_from_Results_Folder (:);
    
    for index = 1 : size ( cell_of_Address_of_Output_Folders_from_Results_Folder, 1 )
        address_of_Current_Folder = char ( cell_of_Address_of_Output_Folders_from_Results_Folder ( index, 1 ) );
        
        rmdir ( address_of_Current_Folder )
        
    end

end