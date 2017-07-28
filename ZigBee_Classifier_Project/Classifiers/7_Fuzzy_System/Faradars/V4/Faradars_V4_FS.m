function Faradars_V4_FS ( input_DataSet, train_Proability )

   %% Section 0 : Preliminaries
        if       ( nargin < 1 )
            error ( 'Input for the "FaradarsV4_FS" function should be at least 1: "DataSet" and "Labels".' ) 

        end

    %% Section 1: Ematrix_of_DataPointstraction of Initial Parameters
        % Level 1: Inputs
            matrix_of_DataPoints         = input_DataSet ( 1, : );     % This matrimatrix_of_DataPoints is (dmatrix_of_DataPointsn)
            horizontal_Vector_of_Labels  = input_DataSet (  end, : );     % This Vector is (1matrix_of_DataPointsn)            



        matrix_of_DataPoints      = matrix_of_DataPoints';
        vertical_Vector_of_Labels = horizontal_Vector_of_Labels';
    	number_of_Elements_for_Training = floor ( train_Proability * size ( matrix_of_DataPoints, 1 ) );
        train_Indices = randperm ( size (matrix_of_DataPoints, 1 ), number_of_Elements_for_Training );

        temp_Indices = ones ( 1, size ( matrix_of_DataPoints, 1 ) );
        temp_Indices ( train_Indices ) = 0;
        test_Indices = logical ( temp_Indices );

        TrainInputs = matrix_of_DataPoints( train_Indices, 1: end - 1 );
        TrainTargets = vertical_Vector_of_Labels( train_Indices, end );
        TrainData=[TrainInputs TrainTargets];
        
        TestInputs = matrix_of_DataPoints( test_Indices,  1: end - 1 );
        TestTargets = vertical_Vector_of_Labels( test_Indices, end );
            
        
        TestData =[TestInputs TestTargets];
            
            
            
            
            
%         TrainInputs = matrix_of_DataPoints;
%         TrainTargets = hosizontal_Vector_of_Labels;
%         TrainData=[TrainInputs TrainTargets];
% 
%         xmin = min ( TrainInputs );
%         xmax = max ( TrainInputs );
% 
%         xx=linspace(xmin,xmax,1000)';
%         yy=f(xx);
% 
%         TestInputs=xx;
%         TestTargets=yy;
%         TestData=[TestInputs TestTargets];


    %% Design ANFIS
        Option{1}='Grid Part. (genfis1)';
        Option{2}='Sub. Clustering (genfis2)';
        Option{3}='FCM (genfis3)';

        ANSWER=questdlg('Select FIS Generation Approach:',...
                        'Select GENFIS',...
                        Option{1},Option{2},Option{3},...
                        Option{3});

        switch ANSWER
            case Option{1}
                Prompt={'Number of MFs','Input MF Type:','Output MF Type:'};
                Title='Enter genfis1 parameters';
                DefaultValues={'5','gaussmf','linear'};

                PARAMS=inputdlg(Prompt,Title,1,DefaultValues);

                nMFs=str2num(PARAMS{1}); %#ok
                InputMF=PARAMS{2};
                OutputMF=PARAMS{3};

                fis=genfis1(TrainData,nMFs,InputMF,OutputMF);

            case Option{2}
                Prompt={'Influence Radius:'};
                Title='Enter genfis2 parameters';
                DefaultValues={'0.2'};

                PARAMS=inputdlg(Prompt,Title,1,DefaultValues);

                Radius=str2num(PARAMS{1}); %#ok

                fis=genfis2(TrainInputs,TrainTargets,Radius);

            case Option{3}
                Prompt={'Number fo Clusters:',...
                        'Partition Matrix Exponent:',...
                        'Maximum Number of Iterations:',...
                        'Minimum Improvemnet:'};
                Title='Enter genfis3 parameters';
                DefaultValues={'10','2','100','1e-5'};

                PARAMS=inputdlg(Prompt,Title,1,DefaultValues);

                nCluster=str2num(PARAMS{1}); %#ok
                Exponent=str2num(PARAMS{2}); %#ok
                MaxIt=str2num(PARAMS{3}); %#ok
                MinImprovment=str2num(PARAMS{4}); %#ok
                DisplayInfo=1;
                FCMOptions=[Exponent MaxIt MinImprovment DisplayInfo];

                fis=genfis3(TrainInputs,TrainTargets,'sugeno',nCluster,FCMOptions);
        end

        Prompt={'Maximum Number of Epochs:',...
                'Error Goal:',...
                'Initial Step Size:',...
                'Step Size Decrease Rate:',...
                'Step Size Increase Rate:'};
        Title='Enter genfis3 parameters';
        DefaultValues={'100','0','0.01','0.9','1.1'};

        PARAMS=inputdlg(Prompt,Title,1,DefaultValues);


        MaxEpoch=str2num(PARAMS{1});                %#ok
        ErrorGoal=str2num(PARAMS{2});               %#ok
        InitialStepSize=str2num(PARAMS{3});         %#ok
        StepSizeDecreaseRate=str2num(PARAMS{4});    %#ok
        StepSizeIncreaseRate=str2num(PARAMS{5});    %#ok
        TrainOptions=[MaxEpoch ...
                      ErrorGoal ...
                      InitialStepSize ...
                      StepSizeDecreaseRate ...
                      StepSizeIncreaseRate];

        DisplayInfo=true;
        DisplayError=true;
        DisplayStepSize=true;
        DisplayFinalResult=true;
        DisplayOptions=[DisplayInfo ...
                        DisplayError ...
                        DisplayStepSize ...
                        DisplayFinalResult];

        OptimizationMethod=1;
        % 0: Backpropagation
        % 1: Hybrid

        fis=anfis(TrainData,fis,TrainOptions,DisplayOptions,[],OptimizationMethod);


    %% Apply ANFIS to Train Data
        TrainOutputs=evalfis(TrainInputs,fis);

        TrainErrors=TrainTargets-TrainOutputs;
        TrainMSE=mean(TrainErrors(:).^2);
        TrainRMSE=sqrt(TrainMSE);
        TrainErrorMean=mean(TrainErrors);
        TrainErrorSTD=std(TrainErrors);

        figure;
        PlotResults(TrainTargets,TrainOutputs,'Train Data');

        figure;
        plotregression(TrainTargets,TrainOutputs,'Train Data');
        set(gcf,'Toolbar','figure');

    %% Apply ANFIS to Test Data
        TestOutputs=evalfis(TestInputs,fis);

        TestErrors=TestTargets-TestOutputs;
        TestMSE=mean(TestErrors(:).^2);
        TestRMSE=sqrt(TestMSE);
        TestErrorMean=mean(TestErrors);
        TestErrorSTD=std(TestErrors);

        figure;
        PlotResults(TestTargets,TestOutputs,'Test Data');

        figure;
        plotregression(TestTargets,TestOutputs,'Test Data');
        set(gcf,'Toolbar','figure');
