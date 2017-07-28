package Tools;
import matlabcontrol.*;

public class MatlabCaller {

    public static void main(String[] args)
            throws MatlabConnectionException, MatlabInvocationException
    {
        // create proxy
        MatlabProxyFactoryOptions options =
                new MatlabProxyFactoryOptions.Builder()
                        .setUsePreviouslyControlledSession(true)
                        .build();
        MatlabProxyFactory factory = new MatlabProxyFactory(options);
        MatlabProxy proxy = factory.getProxy();

        // call builtin function
        proxy.eval("disp('hello world')");
        proxy.eval("z=2");

        // call user-defined function (must be on the path)
        proxy.eval("addpath('C:\\Users\\Amin\\Desktop')");
        proxy.feval("Test");
        proxy.eval("rmpath('C:\\Users\\Amin\\Desktop')");

        // close connection
          proxy.disconnect();
           // or : proxy.exit();
    }
}
