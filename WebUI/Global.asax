<%@ Application Language="C#" %>
<%@ Import Namespace="System.Diagnostics" %>


<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        // Verify Error Handler has corrent configuration (Log directories exist, permissions to write)
        try
        {
            
            BusinessTier.Utility.ErrorHandler errHandler = new BusinessTier.Utility.ErrorHandler();
            errHandler.LogError("Global.asax, Application_Start Application Stability Test Routines", "Application Starting:  Verifying that the Error Logging Mechanism is functional.  The LOGGING IS FUNCTIONAL");
        }
        catch(Exception firstException)
        {
            string Message = firstException.Message.ToString() + " " + firstException.StackTrace.ToString();
            Exception newEx = new Exception("Application_Start: Error Logger Malfunction:  Check that Error Log Directory exists and that ASP.NET has the proper permissions (WRITE) to the Error Log Directory. " + "\nStack Trace: " + Message);
            Debug.WriteLine(firstException.Message.ToString() + " " + firstException.StackTrace.ToString());
            throw newEx;
        }

        //Test that DB connection is valid. 
        try
        {
           
            BusinessTier.DataAccessLayer.DataAccessLayer daLayer = new BusinessTier.DataAccessLayer.DataAccessLayer();
            string[] ListingOfStates = daLayer.GetStates();
        }
        catch (Exception firstException)
        {
            string Message = firstException.Message.ToString() + " " + firstException.StackTrace.ToString();
            Exception newEx = new Exception("Application_Start: Database Connection Failure:  Verify that the Web.Config file is targeting the proper server.  Verify that the proper accounts are setup in SQL Server." + "\nStack Trace: " + Message);
            Debug.WriteLine(firstException.Message.ToString() + " " + firstException.StackTrace.ToString());
            throw newEx;
        }

        // TODO:  Nice to have:  Test that State Server is working. 
        
    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown
    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs
        
        // SEE MSDN or TECHNET Article:
        // http://support.microsoft.com/kb/306355
        
        // If you do not call Server.ClearError or trap the error in the Page_Error or Application_Error event handler, 
        // the error is handled based on the settings in the <customErrors> section of the Web.config file. In the <customErrors> section, 
        // you can specify a redirect page as a default error page (defaultRedirect) or specify to a particular page based on the HTTP
        // error code that is raised. You can use this method to customize the error message that the user receives. 
        
        try
            
        {
            Exception objErr = Server.GetLastError().GetBaseException();
            
            BusinessTier.Utility.ErrorHandler errHandler = new BusinessTier.Utility.ErrorHandler();
            errHandler.LogError("WoodProductsSellingEngine", objErr);
              
            // Use ClearError in the future to add routing to specific error pages.
            //Server.ClearError();
            
            // Right now this well route to the defaultRedirect setting in the Web.Config file.
            
            // <system.web>
            //   <customErrors mode="RemoteOnly" defaultRedirect="Default.aspx" />
            
        }
        catch
        {    
            throw;
        }
    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started
        // TODO:  Code could be written here to log user data (Code that runs when a new session is started
    }

    void Session_End(object sender, EventArgs e) 
    {
        // NOTE:  We are NOT using InProc Mode.  Therefore this event is not useful.
        
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.
    }
       
</script>
