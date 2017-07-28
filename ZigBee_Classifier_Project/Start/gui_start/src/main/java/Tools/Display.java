package Tools;


import javax.swing.*;
import java.awt.*;

public class Display {
    private UIManager.LookAndFeelInfo[] looks;
    private String [] lookNames;

    public static void JFrame (JFrame jf, JPanel jp, String jf_Name){
        System.out.println(jf_Name);

        Dimension DimMax = Toolkit.getDefaultToolkit().getScreenSize();
        jf.setMaximumSize(DimMax);
        jf.setExtendedState(JFrame.MAXIMIZED_BOTH);
        jf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        jf.setName( jf_Name );
        jf.setContentPane(jp);
        jf.setVisible(true);

    }

    public void LookandFeel( JFrame jf ) {
        try {
            looks = UIManager.getInstalledLookAndFeels();
            lookNames = new String [ looks.length ];
            for ( int i=0; i<looks.length;i++){
                lookNames [ i ] = looks[i].getName();
            }
            System.out.println("length is:"+looks.length);
            int index =0;
            UIManager.setLookAndFeel(looks[index].getClassName()); //Windows Look and feel

            System.out.println("This is:" + lookNames[index]);
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException | UnsupportedLookAndFeelException e) {
            e.printStackTrace();
        }

    }
}
