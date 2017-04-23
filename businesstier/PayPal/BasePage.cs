using System.Web.UI;
using System;
using com.paypal.soap.api;
using BusinessTier;
using BusinessTier.PayPal;

namespace BusinessTier.PayPal
{

    // TODO:  This should be refactored and/or removed.

    [Serializable]
	public class BasePage : Page
	{
		public AbstractResponseType PayPalResponse
		{
			get
			{
				return (AbstractResponseType) this.Session[Constants.RESPONSE_SESSION_KEY];
			}
			set
			{
				this.Session[Constants.RESPONSE_SESSION_KEY] = value;
			}
		}

		protected bool IsTransactionSuccessful
		{
			get
			{
				return Util.IsSuccessfull(this.PayPalResponse.Ack);
			}
		}

		protected string TransactionID
		{
			get
			{
				return this.Request.QueryString.Get(Constants.TRANSACTIONID_PARAM);
			}
		}

		public PaymentActionCodeType PaymentAction
		{
			get
			{
				if (this.Session[Constants.PAYMENTACTIONTYPE_SESSION_KEY] == null)
				{
					this.PaymentAction = PaymentActionCodeType.Sale;
				}
				return (PaymentActionCodeType)this.Session[Constants.PAYMENTACTIONTYPE_SESSION_KEY];
			}
			set
			{
				Session[Constants.PAYMENTACTIONTYPE_SESSION_KEY] = value;
			}
		}
	}
}
