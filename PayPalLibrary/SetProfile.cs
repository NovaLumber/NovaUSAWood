using System;
using System.ComponentModel;
using System.Web;
using com.paypal.sdk.profiles;
using log4net;

namespace PaypalLibrary
{
	/// <summary>
	/// Summary description for Constants.
	/// </summary>
    //[Serializable]

    public class SetProfile
	{
		
		/// <summary>
		/// Required designer variable.
		/// </summary
		public static readonly IAPIProfile DefaultProfile =  CreateAPIProfile(Constants.API_USERNAME, Constants.API_PASSWORD, Constants.API_SIGNATURE, "", "", Constants.CERTIFICATE, Constants.PRIVATE_KEY_PASSWORD);
		
		public static IAPIProfile CreateAPIProfile(string apiUsername, string apiPassword, string signature, string CertificateFile_Sig, string APISignature_Sig, string CertificateFile_Cer, string PrivateKeyPassword_Cer)
		{
			//IAPIProfile profile = ProfileFactory.CreateAPIProfile();
			
			if (Global.is3token==true)
			{
				IAPIProfile profile = ProfileFactory.createSignatureAPIProfile();
				profile.APIUsername = apiUsername;
				profile.APIPassword = apiPassword;
				profile.Environment = Constants.ENVIRONMENT;

				profile.Subject = string.Empty;
				profile.APISignature = signature;
				return profile;
			}
			else
			{
				IAPIProfile profile = ProfileFactory.createSSLAPIProfile();
				profile.APIUsername = apiUsername;
				profile.APIPassword = apiPassword;
				profile.Environment = Constants.ENVIRONMENT;

				profile.CertificateFile= CertificateFile_Cer;
				profile.PrivateKeyPassword=PrivateKeyPassword_Cer;
				profile.Subject =signature;
				//profile.Subject = string.Empty;
				//profile.APISignature = signature;
				return profile;
			}


			
		}
		public static void SetDefaultProfile()
		{
			SessionProfile = DefaultProfile;
		}

		public static IAPIProfile SessionProfile
		{
			get
			{
				return (IAPIProfile) HttpContext.Current.Session[Constants.PROFILE_KEY];
			}
			set
			{
				HttpContext.Current.Session[Constants.PROFILE_KEY] = value;
			}
		}
	}
	

}
