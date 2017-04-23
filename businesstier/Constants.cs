using System;

namespace BusinessTier
{
    [Serializable]
    public class Constants
	{

        // BusinessTier.Utility.ErrorHandler ---------------------------------------------
        public const string ERROR_PATH = @"c:\logs\";
        public const string ERROR_FILE_NAME_PREFIX = "SITE_ERROR_LOG_";
        public const string ERROR_SOURCE = "Wood Products Selling Engine";
        
        

        // BusinessTier.PayPal -----------------------------------------------------------
        
        /// Modify these values if you want to use your own profile.

		/* 
		 *                                                                         *
		 * WARNING: Do not embed plaintext credentials in your application code.   *
		 * Doing so is insecure and against best practices.                        *
		 *                                                                         *
		 * Your API credentials must be handled securely. Please consider          *
		 * encrypting them for use in any production environment, and ensure       *
		 * that only authorized individuals may view or modify them.               *
		 *                                                                         *
		 */

        // STEVE's sandbox
        //public const string API_USERNAME = "steve_1203698479_biz_api1.novausawood.com";
        //public const string API_PASSWORD = "1203698521";
        //public const string API_SIGNATURE = "AbPwEaqPnJqb8rRjI602R3cEh9VcAcR15JnPebHkkyFqKgl3kTnxIH6G";
        //public const string CERTIFICATE = "";
        //public const string PRIVATE_KEY_PASSWORD = "";
        //public const string SUBJECT = "";
        //public const string ENVIRONMENT = "sandbox";
        //public const string ECURLLOGIN = "https://api-3t.sandbox.paypal.com/2.0/";

        // ERICH's SANDBOX
        //public const string API_USERNAME = "keanee_api1.wit.edu";
        //public const string API_PASSWORD = "T5AJA3YNEK8Q9LNX";
        //public const string API_SIGNATURE = "A4a6OgI4dBBN7DZhfx3PcECd.HmAAkpLedYR7zkZD-2BQY1QGL467zh0";
        //public const string CERTIFICATE = "";
        //public const string PRIVATE_KEY_PASSWORD = "";
        //public const string SUBJECT = "";
        //public const string ENVIRONMENT = "sandbox";
        //public const string ECURLLOGIN = "https://api-3t.sandbox.paypal.com/2.0/";


        public const bool IS3TOKEN = true;

        // PRODUCTION (REAL DOLLARS!!!!!!!!!!!!!!!)

        //NW Wood Holdings LLC
        //public const string API_USERNAME = "steve.getsiv_api1.comcast.net";
        //public const string API_PASSWORD = "WDBF2ZSN52NX2HCC";
        //public const string API_SIGNATURE = "Alhupuv--kyMKE2imCXSe0hlU940AzbWmAFY84GQ1W9wR5GAfW7YF52V";

        //Nova USA Wood Products LLC
        public const string API_USERNAME = "paypal_api1.novausawood.com";
        public const string API_PASSWORD = "DVMBN35RVPV3YACS";
        public const string API_SIGNATURE = "A8S27hfXLc-dvx2HVL5wF.YGz-CmAdosz8hCojHW283o-UgeaaCL3uWG";

        //Stone Wood Outlet LLC
        //public const string API_USERNAME = "customer.service_api1.stonewoodstore.com";
        //public const string API_PASSWORD = "8DT9X6JGBS87HTBX";
        //public const string API_SIGNATURE = "AKiVMQkjDK-KFhZbznpFJ0Hm6cNxALCWOtdnH4tqB8eOeoJRyhbw8tue";

        public const string CERTIFICATE = "";
        public const string PRIVATE_KEY_PASSWORD = "";
        public const string SUBJECT = "";
        public const string ENVIRONMENT = "live";
        public const string ECURLLOGIN = "https://api-3t.paypal.com/2.0/";
        

        public const string GET_TRANSACTION_DETAILS_SESSION_KEY = "GetTransactionDetailsResponseType";
		public const string TRANSACTION_SEARCH_SESSION_KEY = "TransactionSearchResponseType";
		public const string RESPONSE_SESSION_KEY = "payPalResponse";
		public const string PROFILE_KEY = "Profile";
		public const string PAYMENTACTIONTYPE_SESSION_KEY = "PaymentActionType";


		public const string TRANSACTIONID_PARAM = "trxID";
		public const string REFUND_TYPE_PARAM = "refundType";
		public const string PAYMENT_AMOUNT_PARAM = "amount";
		public const string PAYMENT_CURRENCY_PARAM = "currency";
		public const string BUYER_LAST_NAME_PARAM = "buyerLastName";
		public const string BUYER_FIRST_NAME_PARAM = "buyerFirstName";
		public const string BUYER_ADDRESS1_PARAM = "buyerAddress1";
		public const string BUYER_ADDRESS2_PARAM = "buyerAddress2";
		public const string BUYER_CITY_PARAM = "buyerCity";
		public const string BUYER_STATE_PARAM = "buyerState";
		public const string BUYER_ZIPCODE_PARAM = "buyerZipCode";
		public const string CREDIT_CARD_TYPE_PARAM = "creditCardType";
		public const string CREDIT_CARD_NUMBER_PARAM = "creditCardNumber";
		public const string CVV2_PARAM = "cvv2";
		public const string EXP_MONTH_PARAM = "expMonth";
		public const string EXP_YEAR_PARAM = "expYear";
		public const string TOKEN_PARAM = "token";
		public const string PAYERID_PARAM = "payerID";
		public const string AUTHORIZATIONID_PARAM = "authorizationID";
		public const string PAYMENT_ACTION_PARAM = "paymentAction";
	}
}
