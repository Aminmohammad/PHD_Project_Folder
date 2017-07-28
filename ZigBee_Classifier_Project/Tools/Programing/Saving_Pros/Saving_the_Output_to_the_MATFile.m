function Saving_the_Output_to_the_MATFile ( saving_Folder_Address, file_that_Should_be_Saved, name_of_Saving_File ) %#ok<*INUSL>

    saving_Address = [ saving_Folder_Address '\' name_of_Saving_File ];
    save ( saving_Address, 'file_that_Should_be_Saved', '-v7.3' );
    
end
           