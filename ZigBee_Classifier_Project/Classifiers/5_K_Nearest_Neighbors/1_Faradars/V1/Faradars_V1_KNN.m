function Faradars_V1_KNN ( input_DataSet )

   %% Section 0 : Preliminaries
        if       ( nargin < 1 )
            error ( 'Input for the "FaradarsV1_Decision_Tree" function should be at least 1: "DataSet" and "Labels".' ) 

        end

    %% Section 1: Ematrix_of_DataPointstraction of Initial Parameters
        % Level 1: Inputs
            matrix_of_DataPoints         = input_DataSet ( 1: end - 1, : )';     % This matrimatrix_of_DataPoints is (dmatrix_of_DataPointsn)
            hosizontal_Vector_of_Labels  = input_DataSet (        end, : )';     % This Vector is (1matrix_of_DataPointsn)            


    %% KNN Classifier
        c=ClassificationKNN.fit(matrix_of_DataPoints, hosizontal_Vector_of_Labels,'NumNeighbors',5);

        disp('Resub. Loss =');
        disp(resubLoss(c));

    %% Cross-validation
        cvmodel=crossval(c);

        disp('k-Fold Loss =');
        disp(kfoldLoss(cvmodel));

end