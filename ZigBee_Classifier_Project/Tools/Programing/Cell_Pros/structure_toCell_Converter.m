function cell_Elements = structure_toCell_Converter ( structure )

    field_names = fieldnames ( structure );
    field_names = field_names (:)';
    cell_Elements = [];
    for index = 1 : size ( field_names, 2 )
        cell_Elements = [ cell_Elements char(field_names( 1, index )), {structure.(char(field_names( 1, index )))} ];
        
    end
    
end