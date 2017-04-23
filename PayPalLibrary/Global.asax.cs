using System;
using System.ComponentModel;
using System.Web;
using com.paypal.sdk.profiles;
using log4net;

namespace PaypalLibrary 
{
	/// <summary>
	/// Summary description for Global.
	/// </summary>
	public class Global : HttpApplication
	{
		public static readonly ILog log = LogManager.GetLogger("com.paypal.sdk.samples");
		public static bool is3token=true;

		private IContainer components = null;

		/// <summary>
		/// Required designer variable.
		/// </summary>

		public Global()
		{
			InitializeComponent();
		}	

		protected void Application_Start(Object sender, EventArgs e)
		{

		}

		protected void Session_Start(Object sender, EventArgs e)
		{

		}

		public static void SetDefaultProfile()
		{

		}

		protected void Application_BeginRequest(Object sender, EventArgs e)
		{

		}

		protected void Application_EndRequest(Object sender, EventArgs e)
		{

		}

		protected void Application_AuthenticateRequest(Object sender, EventArgs e)
		{

		}

		protected void Application_Error(Object sender, EventArgs e)
		{

		}

		protected void Session_End(Object sender, EventArgs e)
		{

		}

		protected void Application_End(Object sender, EventArgs e)
		{

		}
			
		#region Web Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.components = new Container();
		}
		#endregion
	}
}

