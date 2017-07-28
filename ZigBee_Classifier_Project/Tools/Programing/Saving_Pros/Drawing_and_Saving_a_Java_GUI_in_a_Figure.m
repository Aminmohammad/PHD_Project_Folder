function hFig = Drawing_and_Saving_a_Java_GUI_in_a_Figure ( net, Saving_Address, selected_Saving_Extension )

    %# Making the JFrame
        jframe = view(net);
        
    %# close java window
        jframe.setVisible(false);
        jframe.dispose();        

    %# create it in a MATLAB figure
        hFig = figure('Menubar','none', 'Position',[0 0 1000 1000]);
        jpanel = get(jframe,'ContentPane');
        [~,h] = javacomponent(jpanel);
        set(h, 'units','normalized', 'position',[0 0 1 1])
        set(hFig, 'PaperPositionMode', 'auto')
        saveas(hFig, [Saving_Address '.' selected_Saving_Extension])

end
