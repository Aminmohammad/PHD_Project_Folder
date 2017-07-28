function Write_to_Excell_File ( data, Address, fileName )

    xlswrite( fileName, data, 'Output', 'A1' );
    e=actxserver('excel.application');
    eW=e.Workbooks;    
    eF=eW.Open( [ pwd '\' fileName] ); % open OutputTest.xls
    eS=eF.ActiveSheet;
    
    % edit sheet
        for index = 1 : 100
            text = [ 'A' sprintf('%d', index) ':AZ' sprintf('%d', index) ];
            eS.Range(text).HorizontalAlignment = -4108;

        end

        eS.Range('A1:AZ1').EntireColumn.AutoFit;
        eS.Range('A1').EntireRow.Font.Bold=1;
        
    % Saving the Sheet    
        eF.Save;
        eF.Close; % close the file
        e.Quit; % close Excel entirely

    % Coping the file to another place  && Deleting the first file      
        copyfile( [ pwd '\' fileName], [ Address '\' fileName] )
        delete ( [ pwd '\' fileName] )
    
end