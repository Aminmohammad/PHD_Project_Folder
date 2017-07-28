function output = Persistent_Variable_Saver ( input_Variable, strategy, used_Index_for_Saving_Variable )


    persistent saving_variable_1 saving_variable_2 saving_variable_3 saving_variable_4 saving_variable_5 saving_variable_6 saving_variable_7 saving_variable_8 saving_variable_9 saving_variable_10;
    %  saving_variable_1: for 'Interface.m': to set that Address of 'sub-Folders' exist in 'Adding Memory' or not.
    %  saving_variable_2: for 'ROCPlot.m': to save the Values of Training.
    %  saving_variable_3: for 'ROCPlot.m': to save the Values of Testing.
    
    if (nargin < 3)
        used_Index_for_Saving_Variable = 1;
        
    end

    if     ( used_Index_for_Saving_Variable == 1 )
            if   (  strcmp ( strategy, 'Writing' ) == 1 )

                if      ( isempty ( saving_variable_1 ) == 1 )
                    saving_variable_1 = input_Variable;

                elseif ( isempty ( saving_variable_1 ) == 0 )
                    saving_variable_1 = saving_variable_1 + input_Variable;

                end

                    output = [];                

            elseif (  strcmp ( strategy, 'Reading' ) == 1 )
                 output = saving_variable_1;

            elseif (  strcmp ( strategy, 'Clearing' ) == 1 )
                 saving_variable_1 = [];
                 output = [];     

            end
       
    elseif ( used_Index_for_Saving_Variable == 2 )
        
            if   (  strcmp ( strategy, 'Writing' ) == 1 )

                if      ( isempty ( saving_variable_2 ) == 1 )
                    saving_variable_2 = input_Variable;

                elseif ( isempty ( saving_variable_2 ) == 0 )
                    saving_variable_2 = saving_variable_2 + input_Variable;

                end

                    output = [];                

            elseif (  strcmp ( strategy, 'Reading' ) == 1 )
                 output = saving_variable_2;

            elseif (  strcmp ( strategy, 'Clearing' ) == 1 )
                saving_variable_2 = [];
                output = [];     

            end
            
    elseif ( used_Index_for_Saving_Variable == 3 )
        
            if   (  strcmp ( strategy, 'Writing' ) == 1 )

                if      ( isempty ( saving_variable_3 ) == 1 )
                    saving_variable_3 = input_Variable;

                elseif ( isempty ( saving_variable_3 ) == 0 )
                    saving_variable_3 = saving_variable_3 + input_Variable;

                end

                    output = [];                

            elseif (  strcmp ( strategy, 'Reading' ) == 1 )
                 output = saving_variable_3;

            elseif (  strcmp ( strategy, 'Clearing' ) == 1 )
                saving_variable_3 = [];
                output = [];     

            end
            
     elseif ( used_Index_for_Saving_Variable == 4 )
        
            if   (  strcmp ( strategy, 'Writing' ) == 1 )

                if      ( isempty ( saving_variable_4 ) == 1 )
                    saving_variable_4 = input_Variable;

                elseif ( isempty ( saving_variable_4 ) == 0 )
                    saving_variable_4 = saving_variable_4 + input_Variable;

                end

                    output = [];                

            elseif (  strcmp ( strategy, 'Reading' ) == 1 )
                 output = saving_variable_4;

            elseif (  strcmp ( strategy, 'Clearing' ) == 1 )
                saving_variable_4 = [];
                output = [];     

            end       
        
    elseif ( used_Index_for_Saving_Variable == 5 )
        
            if   (  strcmp ( strategy, 'Writing' ) == 1 )

                if      ( isempty ( saving_variable_5 ) == 1 )
                    saving_variable_5 = input_Variable;

                elseif ( isempty ( saving_variable_5 ) == 0 )
                    saving_variable_5 = saving_variable_5 + input_Variable;

                end

                    output = [];                

            elseif (  strcmp ( strategy, 'Reading' ) == 1 )
                 output = saving_variable_5;

            elseif (  strcmp ( strategy, 'Clearing' ) == 1 )
                saving_variable_5 = [];
                output = [];     

            end  
            
    elseif ( used_Index_for_Saving_Variable == 6 )

        if   (  strcmp ( strategy, 'Writing' ) == 1 )

            if      ( isempty ( saving_variable_6 ) == 1 )
                saving_variable_6 = input_Variable;

            elseif ( isempty ( saving_variable_6 ) == 0 )
                saving_variable_6 = saving_variable_6 + input_Variable;

            end

                output = [];                

        elseif (  strcmp ( strategy, 'Reading' ) == 1 )
             output = saving_variable_6;

        elseif (  strcmp ( strategy, 'Clearing' ) == 1 )
            saving_variable_6 = [];
            output = [];     

        end   
        
    elseif ( used_Index_for_Saving_Variable == 7 )
        
            if   (  strcmp ( strategy, 'Writing' ) == 1 )

                if      ( isempty ( saving_variable_7 ) == 1 )
                    saving_variable_7 = input_Variable;

                elseif ( isempty ( saving_variable_7 ) == 0 )
                    saving_variable_7 = saving_variable_7 + input_Variable;

                end

                    output = [];                

            elseif (  strcmp ( strategy, 'Reading' ) == 1 )
                 output = saving_variable_7;

            elseif (  strcmp ( strategy, 'Clearing' ) == 1 )
                saving_variable_7 = [];
                output = [];     

            end 
            
    elseif ( used_Index_for_Saving_Variable == 8 )

        if   (  strcmp ( strategy, 'Writing' ) == 1 )

            if      ( isempty ( saving_variable_8 ) == 1 )
                saving_variable_8 = input_Variable;

            elseif ( isempty ( saving_variable_8 ) == 0 )
                saving_variable_8 = saving_variable_8 + input_Variable;

            end

                output = [];                

        elseif (  strcmp ( strategy, 'Reading' ) == 1 )
             output = saving_variable_8;

        elseif (  strcmp ( strategy, 'Clearing' ) == 1 )
            saving_variable_8 = [];
            output = [];     

        end  
        
    elseif ( used_Index_for_Saving_Variable == 9 )

        if   (  strcmp ( strategy, 'Writing' ) == 1 )

            if      ( isempty ( saving_variable_9 ) == 1 )
                saving_variable_9 = input_Variable;

            elseif ( isempty ( saving_variable_9 ) == 0 )
                saving_variable_9 = saving_variable_9 + input_Variable;

            end

                output = [];                

        elseif (  strcmp ( strategy, 'Reading' ) == 1 )
             output = saving_variable_9;

        elseif (  strcmp ( strategy, 'Clearing' ) == 1 )
            saving_variable_9 = [];
            output = [];     

        end   
        
    elseif ( used_Index_for_Saving_Variable == 10 )
        
            if   (  strcmp ( strategy, 'Writing' ) == 1 )

                if      ( isempty ( saving_variable_10 ) == 1 )
                    saving_variable_10 = input_Variable;

                elseif ( isempty ( saving_variable_10 ) == 0 )
                    saving_variable_10 = saving_variable_10 + input_Variable;

                end

                    output = [];                

            elseif (  strcmp ( strategy, 'Reading' ) == 1 )
                 output = saving_variable_10;

            elseif (  strcmp ( strategy, 'Clearing' ) == 1 )
                saving_variable_10 = [];
                output = [];     

            end         
                        
    end
    
end