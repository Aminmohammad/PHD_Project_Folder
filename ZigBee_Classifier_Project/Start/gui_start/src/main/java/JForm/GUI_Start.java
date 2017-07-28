package JForm;

import Tools.Display;
import info.clearthought.layout.TableLayout;
import info.clearthought.layout.TableLayoutConstraints;

import javax.swing.*;
import javax.swing.event.ChangeEvent;
import java.awt.*;

/**
 * @author Mohammad amin
 */
public class GUI_Start extends JFrame {
    public GUI_Start() {

        initComponents();
        Display.JFrame( this, overall_Panel, "GUI Start" );


        new Display().LookandFeel( this );
    }

    private void rb_DataSet_RawDataSelectionStateChanged(ChangeEvent e) {

        if (rb_DataSet_RawDataSelection.isSelected()){
            tf_DataSet_RawDataAddress.setEnabled(true);
            tf_DataSet_DataSetAddress.setEnabled(false);
        }
        else
        {
            tf_DataSet_RawDataAddress.setEnabled(false);
            tf_DataSet_DataSetAddress.setEnabled(true);
        }
    }

    private void rb_DataBank_NewDataBankSelectionStateChanged(ChangeEvent e) {
        if (rb_DataBank_NewDataBankSelection.isSelected()){
            tf_DataBank_DataBankAddress.setEnabled(false);
        }
        else
        {
            tf_DataBank_DataBankAddress.setEnabled(true);
        }
    }

    private void initComponents() {
        // JFormDesigner - Component initialization - DO NOT MODIFY  //GEN-BEGIN:initComponents
        // Generated using JFormDesigner Evaluation license - Mohammad amin
        overall_Panel = new JPanel();
        overall_TabbedPanel = new JTabbedPane();
        tab_Strategy = new JTabbedPane();
        tab_DataSet = new JTabbedPane();
        DataSet_Panel = new JPanel();
        rb_DataSet_RawDataSelection = new JRadioButton();
        jb_DataSet_RawDataAddress = new JButton();
        tf_DataSet_RawDataAddress = new JTextField();
        rb_DataSet_DataSetSelection = new JRadioButton();
        jb_DataSet_DataSetAddress = new JButton();
        tf_DataSet_DataSetAddress = new JTextField();
        tab_preProcessing = new JTabbedPane();
        tab_DataBank = new JTabbedPane();
        DataBank_Panel = new JPanel();
        rb_DataBank_NewDataBankSelection = new JRadioButton();
        rb_DataBank_DataBankSelection = new JRadioButton();
        jb_DataBank_DataBankAddress = new JButton();
        tf_DataBank_DataBankAddress = new JTextField();
        scrollPane2 = new JScrollPane();
        jl_DataBank_DataBankMethodsList = new JList();
        tab_postProcessing = new JTabbedPane();
        tab_Classification = new JTabbedPane();
        classification_Panel = new JPanel();
        scrollPane1 = new JScrollPane();
        jl_CLassification_CLassificationList = new JList();
        tab_Evaluation = new JTabbedPane();
        button_Panel = new JPanel();
        jb_Start = new JButton();

        //======== this ========
        Container contentPane = getContentPane();
        contentPane.setLayout(new GridLayout());

        //======== overall_Panel ========
        {

            // JFormDesigner evaluation mark
            overall_Panel.setBorder(new javax.swing.border.CompoundBorder(
                new javax.swing.border.TitledBorder(new javax.swing.border.EmptyBorder(0, 0, 0, 0),
                    "JFormDesigner Evaluation", javax.swing.border.TitledBorder.CENTER,
                    javax.swing.border.TitledBorder.BOTTOM, new java.awt.Font("Dialog", java.awt.Font.BOLD, 12),
                    java.awt.Color.red), overall_Panel.getBorder())); overall_Panel.addPropertyChangeListener(new java.beans.PropertyChangeListener(){public void propertyChange(java.beans.PropertyChangeEvent e){if("border".equals(e.getPropertyName()))throw new RuntimeException();}});

            overall_Panel.setLayout(new TableLayout(new double[][] {
                {1026},
                {493, TableLayout.PREFERRED}}));
            ((TableLayout)overall_Panel.getLayout()).setHGap(5);
            ((TableLayout)overall_Panel.getLayout()).setVGap(5);

            //======== overall_TabbedPanel ========
            {
                overall_TabbedPanel.setPreferredSize(new Dimension(1000, 800));
                overall_TabbedPanel.setMinimumSize(new Dimension(10, 10));
                overall_TabbedPanel.addTab("Strategy", tab_Strategy);

                //======== tab_DataSet ========
                {

                    //======== DataSet_Panel ========
                    {
                        DataSet_Panel.setMinimumSize(new Dimension(100, 2833));
                        DataSet_Panel.setPreferredSize(null);
                        DataSet_Panel.setEnabled(false);
                        DataSet_Panel.setLayout(new TableLayout(new double[][] {
                            {TableLayout.PREFERRED, TableLayout.PREFERRED, 808},
                            {TableLayout.PREFERRED, TableLayout.PREFERRED, TableLayout.PREFERRED}}));
                        ((TableLayout)DataSet_Panel.getLayout()).setHGap(3);
                        ((TableLayout)DataSet_Panel.getLayout()).setVGap(5);

                        //---- rb_DataSet_RawDataSelection ----
                        rb_DataSet_RawDataSelection.setText("Make a new Data-Set");
                        rb_DataSet_RawDataSelection.setPreferredSize(new Dimension(40, 18));
                        rb_DataSet_RawDataSelection.addChangeListener(e -> rb_DataSet_RawDataSelectionStateChanged(e));
                        DataSet_Panel.add(rb_DataSet_RawDataSelection, new TableLayoutConstraints(0, 0, 0, 0, TableLayoutConstraints.FULL, TableLayoutConstraints.FULL));

                        //---- jb_DataSet_RawDataAddress ----
                        jb_DataSet_RawDataAddress.setText("Raw Data Address");
                        jb_DataSet_RawDataAddress.setHorizontalAlignment(SwingConstants.LEFT);
                        jb_DataSet_RawDataAddress.setVerticalAlignment(SwingConstants.TOP);
                        DataSet_Panel.add(jb_DataSet_RawDataAddress, new TableLayoutConstraints(1, 0, 1, 0, TableLayoutConstraints.CENTER, TableLayoutConstraints.FULL));

                        //---- tf_DataSet_RawDataAddress ----
                        tf_DataSet_RawDataAddress.setMinimumSize(null);
                        tf_DataSet_RawDataAddress.setPreferredSize(null);
                        tf_DataSet_RawDataAddress.setMaximumSize(null);
                        tf_DataSet_RawDataAddress.setEnabled(false);
                        DataSet_Panel.add(tf_DataSet_RawDataAddress, new TableLayoutConstraints(2, 0, 2, 0, TableLayoutConstraints.FULL, TableLayoutConstraints.FULL));

                        //---- rb_DataSet_DataSetSelection ----
                        rb_DataSet_DataSetSelection.setText("Select an Exising Data-Set");
                        rb_DataSet_DataSetSelection.setSelected(true);
                        DataSet_Panel.add(rb_DataSet_DataSetSelection, new TableLayoutConstraints(0, 1, 0, 1, TableLayoutConstraints.FULL, TableLayoutConstraints.FULL));

                        //---- jb_DataSet_DataSetAddress ----
                        jb_DataSet_DataSetAddress.setText("Data-Set Address");
                        jb_DataSet_DataSetAddress.setHorizontalAlignment(SwingConstants.LEFT);
                        jb_DataSet_DataSetAddress.setVerticalAlignment(SwingConstants.TOP);
                        DataSet_Panel.add(jb_DataSet_DataSetAddress, new TableLayoutConstraints(1, 1, 1, 1, TableLayoutConstraints.FULL, TableLayoutConstraints.FULL));

                        //---- tf_DataSet_DataSetAddress ----
                        tf_DataSet_DataSetAddress.setMinimumSize(null);
                        tf_DataSet_DataSetAddress.setPreferredSize(null);
                        tf_DataSet_DataSetAddress.setMaximumSize(null);
                        DataSet_Panel.add(tf_DataSet_DataSetAddress, new TableLayoutConstraints(2, 1, 2, 1, TableLayoutConstraints.FULL, TableLayoutConstraints.FULL));
                    }
                    tab_DataSet.addTab("", DataSet_Panel);
                    tab_DataSet.setEnabledAt(0, false);
                }
                overall_TabbedPanel.addTab("DataSet", tab_DataSet);
                overall_TabbedPanel.addTab("pre-Processing", tab_preProcessing);

                //======== tab_DataBank ========
                {

                    //======== DataBank_Panel ========
                    {
                        DataBank_Panel.setMinimumSize(new Dimension(100, 2833));
                        DataBank_Panel.setPreferredSize(null);
                        DataBank_Panel.setEnabled(false);
                        DataBank_Panel.setLayout(new TableLayout(new double[][] {
                            {174, 201, 138, 481},
                            {TableLayout.PREFERRED, 62}}));
                        ((TableLayout)DataBank_Panel.getLayout()).setHGap(3);
                        ((TableLayout)DataBank_Panel.getLayout()).setVGap(5);

                        //---- rb_DataBank_NewDataBankSelection ----
                        rb_DataBank_NewDataBankSelection.setText("Make a new Data-Bank");
                        rb_DataBank_NewDataBankSelection.setPreferredSize(new Dimension(40, 18));
                        rb_DataBank_NewDataBankSelection.addChangeListener(e -> {
			rb_DataSet_RawDataSelectionStateChanged(e);
			rb_DataBank_NewDataBankSelectionStateChanged(e);
			rb_DataBank_NewDataBankSelectionStateChanged(e);
			rb_DataBank_NewDataBankSelectionStateChanged(e);
		});
                        DataBank_Panel.add(rb_DataBank_NewDataBankSelection, new TableLayoutConstraints(0, 0, 0, 0, TableLayoutConstraints.FULL, TableLayoutConstraints.FULL));

                        //---- rb_DataBank_DataBankSelection ----
                        rb_DataBank_DataBankSelection.setText("Select an Exising Data-Bank");
                        rb_DataBank_DataBankSelection.setSelected(true);
                        DataBank_Panel.add(rb_DataBank_DataBankSelection, new TableLayoutConstraints(1, 0, 1, 0, TableLayoutConstraints.FULL, TableLayoutConstraints.FULL));

                        //---- jb_DataBank_DataBankAddress ----
                        jb_DataBank_DataBankAddress.setText("Data-Set Address");
                        jb_DataBank_DataBankAddress.setHorizontalAlignment(SwingConstants.LEFT);
                        jb_DataBank_DataBankAddress.setVerticalAlignment(SwingConstants.TOP);
                        DataBank_Panel.add(jb_DataBank_DataBankAddress, new TableLayoutConstraints(2, 0, 2, 0, TableLayoutConstraints.FULL, TableLayoutConstraints.FULL));

                        //---- tf_DataBank_DataBankAddress ----
                        tf_DataBank_DataBankAddress.setMinimumSize(null);
                        tf_DataBank_DataBankAddress.setPreferredSize(null);
                        tf_DataBank_DataBankAddress.setMaximumSize(null);
                        DataBank_Panel.add(tf_DataBank_DataBankAddress, new TableLayoutConstraints(3, 0, 3, 0, TableLayoutConstraints.FULL, TableLayoutConstraints.FULL));

                        //======== scrollPane2 ========
                        {
                            scrollPane2.setViewportView(jl_DataBank_DataBankMethodsList);
                        }
                        DataBank_Panel.add(scrollPane2, new TableLayoutConstraints(1, 1, 1, 1, TableLayoutConstraints.FULL, TableLayoutConstraints.FULL));
                    }
                    tab_DataBank.addTab("", DataBank_Panel);
                    tab_DataBank.setEnabledAt(0, false);
                }
                overall_TabbedPanel.addTab("DataBank", tab_DataBank);
                overall_TabbedPanel.addTab("post-Processing", tab_postProcessing);

                //======== tab_Classification ========
                {

                    //======== classification_Panel ========
                    {
                        classification_Panel.setLayout(new TableLayout(new double[][] {
                            {TableLayout.PREFERRED, 82, TableLayout.PREFERRED, TableLayout.PREFERRED},
                            {54, TableLayout.PREFERRED, TableLayout.PREFERRED, TableLayout.PREFERRED}}));
                        ((TableLayout)classification_Panel.getLayout()).setHGap(5);
                        ((TableLayout)classification_Panel.getLayout()).setVGap(5);

                        //======== scrollPane1 ========
                        {
                            scrollPane1.setViewportView(jl_CLassification_CLassificationList);
                        }
                        classification_Panel.add(scrollPane1, new TableLayoutConstraints(1, 0, 1, 0, TableLayoutConstraints.FULL, TableLayoutConstraints.FULL));
                    }
                    tab_Classification.addTab("text", classification_Panel);
                }
                overall_TabbedPanel.addTab("Classification", tab_Classification);
                overall_TabbedPanel.addTab("Evaluation", tab_Evaluation);
            }
            overall_Panel.add(overall_TabbedPanel, new TableLayoutConstraints(0, 0, 0, 0, TableLayoutConstraints.FULL, TableLayoutConstraints.FULL));

            //======== button_Panel ========
            {
                button_Panel.setLayout(new TableLayout(new double[][] {
                    {TableLayout.FILL, TableLayout.FILL, TableLayout.FILL, TableLayout.FILL, TableLayout.FILL, TableLayout.FILL, TableLayout.FILL, TableLayout.FILL, TableLayout.FILL},
                    {42}}));

                //---- jb_Start ----
                jb_Start.setText("Start");
                button_Panel.add(jb_Start, new TableLayoutConstraints(4, 0, 4, 0, TableLayoutConstraints.FULL, TableLayoutConstraints.FULL));
            }
            overall_Panel.add(button_Panel, new TableLayoutConstraints(0, 1, 0, 1, TableLayoutConstraints.FULL, TableLayoutConstraints.FULL));
        }
        contentPane.add(overall_Panel);
        pack();
        setLocationRelativeTo(getOwner());
        // JFormDesigner - End of component initialization  //GEN-END:initComponents
    }

    // JFormDesigner - Variables declaration - DO NOT MODIFY  //GEN-BEGIN:variables
    // Generated using JFormDesigner Evaluation license - Mohammad amin
    private JPanel overall_Panel;
    private JTabbedPane overall_TabbedPanel;
    private JTabbedPane tab_Strategy;
    private JTabbedPane tab_DataSet;
    private JPanel DataSet_Panel;
    private JRadioButton rb_DataSet_RawDataSelection;
    private JButton jb_DataSet_RawDataAddress;
    private JTextField tf_DataSet_RawDataAddress;
    private JRadioButton rb_DataSet_DataSetSelection;
    private JButton jb_DataSet_DataSetAddress;
    private JTextField tf_DataSet_DataSetAddress;
    private JTabbedPane tab_preProcessing;
    private JTabbedPane tab_DataBank;
    private JPanel DataBank_Panel;
    private JRadioButton rb_DataBank_NewDataBankSelection;
    private JRadioButton rb_DataBank_DataBankSelection;
    private JButton jb_DataBank_DataBankAddress;
    private JTextField tf_DataBank_DataBankAddress;
    private JScrollPane scrollPane2;
    private JList jl_DataBank_DataBankMethodsList;
    private JTabbedPane tab_postProcessing;
    private JTabbedPane tab_Classification;
    private JPanel classification_Panel;
    private JScrollPane scrollPane1;
    private JList jl_CLassification_CLassificationList;
    private JTabbedPane tab_Evaluation;
    private JPanel button_Panel;
    private JButton jb_Start;
    // JFormDesigner - End of variables declaration  //GEN-END:variables

}



