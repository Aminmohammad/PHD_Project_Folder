function methods_Names = Selected_Methods_Extractor ( method_Name, input_Cell )
    index = strcmp ( input_Cell, method_Name );
    index = find ( index == 1 );    
    methods_Names = input_Cell ( 1, index + 1 );
    methods_Names = methods_Names {:};    

end