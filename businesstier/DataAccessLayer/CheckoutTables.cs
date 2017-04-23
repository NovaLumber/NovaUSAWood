using System;
using System.Text;

namespace BusinessTier.DataAccessLayer
{


    partial class CheckoutTables
    {
        partial class AddressDataTable
        {
        }

        [Serializable]
        partial class AddressRow
        {
            public override string ToString()
            {
                StringBuilder sb = new StringBuilder();
                if (!this.Iscust_addr_1Null()) sb.Append(cust_addr_1 + " ");
                if (!this.Iscust_addr_2Null()) sb.Append(cust_addr_2 + " ");
                if (!this.Iscust_cityNull()) sb.Append(cust_city + " ");
                if (!this.Iscust_stateNull()) sb.Append(cust_state + " ");
                if (!this.Iscust_zipNull()) sb.Append(cust_zip + " ");

                return sb.ToString();
            }


            public string TextString
            {
                get { return this.ToString(); }
            }

            public override bool Equals(object obj)
            {
                return this.cust_addr_id.Equals(((AddressRow)obj).cust_addr_id);
            }
        }
    }
}
