function output = Persistent_Variable_Saver ( input_Variable, strategy )

    persistent saving_variable;

    if   (  strcmp ( strategy, 'Writing' ) == 1 )

        if      ( isempty ( saving_variable ) == 1 )
            saving_variable = input_Variable;

        elseif ( isempty ( saving_variable ) == 0 )
            saving_variable = saving_variable + input_Variable;

        end

            output = [];                

    elseif (  strcmp ( strategy, 'Reading' ) == 1 )
         output = saving_variable;

    elseif (  strcmp ( strategy, 'Clearing' ) == 1 )
         output = [];     

    end