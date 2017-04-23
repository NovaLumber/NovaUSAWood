using System;
using System.Web;
using com.paypal.sdk.services;
using com.paypal.soap.api;
using com.paypal.sdk.profiles;

namespace PaypalLibrary
{
    /// <summary>
    /// Summary description for PayPalAPI.
    /// </summary>

    [Serializable]
    public class PayPalAPI
    {
        private readonly CallerServices caller;
        MassPayRequestType pp_request = new MassPayRequestType();
        MassPayRequestItemType MassItemReq = new MassPayRequestItemType();

        public PayPalAPI()
        {
            caller = new CallerServices();
            //caller.APIProfile = SetProfile.SessionProfile;
            //caller.APIProfile = (IAPIProfile)HttpContext.Current.Session[Constants.PROFILE_KEY];
            //SetProfile.SetDefaultProfile();
            caller.APIProfile = (IAPIProfile)SetProfile.DefaultProfile;

        }

        public TransactionSearchResponseType TransactionSearch(DateTime startDate, DateTime endDate, string transactionId)
        {
            // Create the request object
            TransactionSearchRequestType concreteRequest = new TransactionSearchRequestType();

            concreteRequest.StartDate = startDate;
            concreteRequest.EndDate = endDate.AddHours(23).AddMinutes(59).AddSeconds(59);
            concreteRequest.EndDateSpecified = true;
            concreteRequest.TransactionID = transactionId;

            return (TransactionSearchResponseType)caller.Call("TransactionSearch", concreteRequest);
        }

        public GetTransactionDetailsResponseType GetTransactionDetails(string trxID)
        {
            // Create the request object
            GetTransactionDetailsRequestType concreteRequest = new GetTransactionDetailsRequestType();

            concreteRequest.TransactionID = trxID;
            return (GetTransactionDetailsResponseType)caller.Call("GetTransactionDetails", concreteRequest);
        }

        public RefundTransactionResponseType RefundTransaction(string trxID, string refundType, string amount)
        {
            // Create the request object
            RefundTransactionRequestType concreteRequest = new RefundTransactionRequestType();
            concreteRequest.TransactionID = trxID;
            switch (refundType)
            {
                case "Full":
                    concreteRequest.RefundType = RefundType.Full;
                    concreteRequest.RefundTypeSpecified = true;
                    break;
                case "Partial":
                    concreteRequest.RefundType = RefundType.Partial;
                    concreteRequest.RefundTypeSpecified = true;
                    concreteRequest.Amount = new BasicAmountType();

                    concreteRequest.Amount.currencyID = CurrencyCodeType.USD;
                    concreteRequest.Amount.Value = amount;
                    break;
            }
            return (RefundTransactionResponseType)caller.Call("RefundTransaction", concreteRequest);
        }

        public DoDirectPaymentResponseType DoDirectPayment(string paymentAmount, string buyerLastName, string buyerFirstName,
            string buyerAddress1, string buyerAddress2, string buyerCity, string buyerState, string buyerZipCode,
            string creditCardType, string creditCardNumber, string CVV2, int expMonth, int expYear, PaymentActionCodeType paymentAction
            )
        {
            // Create the request object
            DoDirectPaymentRequestType pp_Request = new DoDirectPaymentRequestType();

            // Create the request details object
            pp_Request.DoDirectPaymentRequestDetails = new DoDirectPaymentRequestDetailsType();

            pp_Request.DoDirectPaymentRequestDetails.IPAddress = "10.244.43.106";
            pp_Request.DoDirectPaymentRequestDetails.MerchantSessionId = "1X911810264059026";
            pp_Request.DoDirectPaymentRequestDetails.PaymentAction = paymentAction;

            pp_Request.DoDirectPaymentRequestDetails.CreditCard = new CreditCardDetailsType();

            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CreditCardNumber = creditCardNumber;
            
            switch (creditCardType)
            {
                case "Visa":
                    pp_Request.DoDirectPaymentRequestDetails.CreditCard.CreditCardType = CreditCardTypeType.Visa;
                    break;
                case "MasterCard":
                    pp_Request.DoDirectPaymentRequestDetails.CreditCard.CreditCardType = CreditCardTypeType.MasterCard;
                    break;
                case "Discover":
                    pp_Request.DoDirectPaymentRequestDetails.CreditCard.CreditCardType = CreditCardTypeType.Discover;
                    break;
                case "Amex":
                    pp_Request.DoDirectPaymentRequestDetails.CreditCard.CreditCardType = CreditCardTypeType.Amex;
                    break;
            }

            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CVV2 = CVV2;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.ExpMonth = expMonth;
            // Test
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.ExpMonthSpecified = true;

            pp_Request.DoDirectPaymentRequestDetails.CreditCard.ExpYear = expYear;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.ExpYearSpecified = true;

            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner = new PayerInfoType();
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.Payer = "";
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.PayerID = "";
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.PayerStatus = PayPalUserStatusCodeType.unverified;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.PayerCountry = CountryCodeType.US;

            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.Address = new AddressType();
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.Address.Street1 = buyerAddress1;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.Address.Street2 = buyerAddress2;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.Address.CityName = buyerCity;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.Address.StateOrProvince = buyerState;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.Address.PostalCode = buyerZipCode;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.Address.CountryName = "USA";
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.Address.Country = CountryCodeType.US;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.Address.CountrySpecified = true;

            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.PayerName = new PersonNameType();
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.PayerName.FirstName = buyerFirstName;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.PayerName.LastName = buyerLastName;
            pp_Request.DoDirectPaymentRequestDetails.PaymentDetails = new PaymentDetailsType();
            pp_Request.DoDirectPaymentRequestDetails.PaymentDetails.OrderTotal = new BasicAmountType();
            // NOTE: The only currency supported by the Direct Payment API at this time is US dollars (USD).

            pp_Request.DoDirectPaymentRequestDetails.PaymentDetails.OrderTotal.currencyID = CurrencyCodeType.USD;
            pp_Request.DoDirectPaymentRequestDetails.PaymentDetails.OrderTotal.Value = paymentAmount;
            return (DoDirectPaymentResponseType)caller.Call("DoDirectPayment", pp_Request);
        }
        //Erich Keane: added to keep the last 2 params in this class
        public SetExpressCheckoutResponseType SetExpressCheckout(string paymentAmount, string returnURL, string cancelURL)
        {
            return SetExpressCheckout(paymentAmount, returnURL, cancelURL, PaymentActionCodeType.Sale, CurrencyCodeType.USD);
        }
        public SetExpressCheckoutResponseType SetExpressCheckout(string paymentAmount, string returnURL, string cancelURL, PaymentActionCodeType paymentAction, CurrencyCodeType currencyCodeType)
        {
            // Create the request object
            SetExpressCheckoutRequestType pp_request = new SetExpressCheckoutRequestType();

            // Create the request details object
            pp_request.SetExpressCheckoutRequestDetails = new SetExpressCheckoutRequestDetailsType();
            pp_request.SetExpressCheckoutRequestDetails.PaymentAction = paymentAction;
            pp_request.SetExpressCheckoutRequestDetails.PaymentActionSpecified = true;

            pp_request.SetExpressCheckoutRequestDetails.OrderTotal = new BasicAmountType();

            pp_request.SetExpressCheckoutRequestDetails.OrderTotal.currencyID = currencyCodeType;
            pp_request.SetExpressCheckoutRequestDetails.OrderTotal.Value = paymentAmount;

            pp_request.SetExpressCheckoutRequestDetails.CancelURL = cancelURL;
            pp_request.SetExpressCheckoutRequestDetails.ReturnURL = returnURL;

            return (SetExpressCheckoutResponseType)caller.Call("SetExpressCheckout", pp_request);
        }


        public GetExpressCheckoutDetailsResponseType GetExpressCheckoutDetails(string token)
        {
            // Create the request object
            GetExpressCheckoutDetailsRequestType pp_request = new GetExpressCheckoutDetailsRequestType();

            pp_request.Token = token;

            return (GetExpressCheckoutDetailsResponseType)caller.Call("GetExpressCheckoutDetails", pp_request);
        }

        public DoExpressCheckoutPaymentResponseType DoExpressCheckoutPayment(string token, string payerID, string paymentAmount, PaymentActionCodeType paymentAction, CurrencyCodeType currencyCodeType)
        {
            // Create the request object
            DoExpressCheckoutPaymentRequestType pp_request = new DoExpressCheckoutPaymentRequestType();

            // Create the request details object
            pp_request.DoExpressCheckoutPaymentRequestDetails = new DoExpressCheckoutPaymentRequestDetailsType();
            pp_request.DoExpressCheckoutPaymentRequestDetails.Token = token;
            pp_request.DoExpressCheckoutPaymentRequestDetails.PayerID = payerID;
            pp_request.DoExpressCheckoutPaymentRequestDetails.PaymentAction = paymentAction;

            pp_request.DoExpressCheckoutPaymentRequestDetails.PaymentDetails = new PaymentDetailsType();

            pp_request.DoExpressCheckoutPaymentRequestDetails.PaymentDetails.OrderTotal = new BasicAmountType();

            pp_request.DoExpressCheckoutPaymentRequestDetails.PaymentDetails.OrderTotal.currencyID = currencyCodeType;
            pp_request.DoExpressCheckoutPaymentRequestDetails.PaymentDetails.OrderTotal.Value = paymentAmount;
            return (DoExpressCheckoutPaymentResponseType)caller.Call("DoExpressCheckoutPayment", pp_request);
        }

        public DoVoidResponseType DoVoid(string authorizationId, string note)
        {
            DoVoidRequestType pp_request = new DoVoidRequestType();
            pp_request.AuthorizationID = authorizationId;
            pp_request.Note = note;
            return (DoVoidResponseType)caller.Call("DoVoid", pp_request);
        }

        public DoCaptureResponseType DoCapture(string authorizationId, string note, string value, CurrencyCodeType currencyId, string invoiceId)
        {
            DoCaptureRequestType pp_request = new DoCaptureRequestType();
            pp_request.AuthorizationID = authorizationId;
            pp_request.Note = note;
            pp_request.Amount = new BasicAmountType();
            pp_request.Amount.Value = value;
            pp_request.Amount.currencyID = currencyId;
            pp_request.InvoiceID = invoiceId;
            return (DoCaptureResponseType)caller.Call("DoCapture", pp_request);
        }

        public DoAuthorizationResponseType DoAuthorization(string orderId, string value, CurrencyCodeType currencyId)
        {
            DoAuthorizationRequestType pp_request = new DoAuthorizationRequestType();
            pp_request.TransactionID = orderId;
            pp_request.Amount = new BasicAmountType();
            pp_request.Amount.Value = value;
            pp_request.Amount.currencyID = currencyId;
            return (DoAuthorizationResponseType)caller.Call("DoAuthorization", pp_request);
        }
        public DoReauthorizationResponseType DoReAuthorization(string authorizationId, string value, CurrencyCodeType currencyId)
        {
            DoReauthorizationRequestType pp_request = new DoReauthorizationRequestType();
            pp_request.AuthorizationID = authorizationId;
            pp_request.Amount = new BasicAmountType();
            pp_request.Amount.Value = value;
            pp_request.Amount.currencyID = currencyId;
            return (DoReauthorizationResponseType)caller.Call("DoReauthorization", pp_request);
        }
        public MassPayResponseType MassPay(string EmailSubject, ReceiverInfoCodeType receiverType, string[] ReceiverEmail, string[] value, string[] UniqueId, string[] note, CurrencyCodeType[] currencyId, int Count)
        {

            pp_request.MassPayItem = new MassPayRequestItemType[Count];
            for (int i = 0; i < Count; i++)
            {

                pp_request.MassPayItem[i] = new MassPayRequestItemType();

                pp_request.MassPayItem[i].ReceiverEmail = ReceiverEmail[i];
                pp_request.MassPayItem[i].Amount = new BasicAmountType();
                pp_request.MassPayItem[i].Amount.Value = value[i];
                pp_request.MassPayItem[i].Amount.currencyID = currencyId[i];
                pp_request.MassPayItem[i].UniqueId = UniqueId[i];
                pp_request.MassPayItem[i].Note = note[i];

            }

            pp_request.EmailSubject = EmailSubject;
            pp_request.ReceiverType = receiverType;
            return (MassPayResponseType)caller.Call("MassPay", pp_request);

        }

    }
}
