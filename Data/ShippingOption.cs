using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using System.Security.Cryptography;

namespace Data
{
    [Serializable]
    public class ShippingOption
    {
        private decimal m_Cost;
        private int m_OptionId;
        private string m_Name;
        private string m_Description;

        public string Description
        {
            get { return m_Description; }
            set { m_Description = value; }
        }
        public string Name
        {
            get { return m_Name; }
            set { m_Name = value; }
        }
        public int OptionId
        {
            get { return m_OptionId; }
            set { m_OptionId = value; }
        }
        public decimal Cost
        {
            get { return m_Cost; }
            set { m_Cost = value; }
        }

        public string OutputString
        {
            get
            {
                return Name + ":  " + Description+ " "+Cost.ToString("C");
            }
        }

        public ShippingOption(int optionId,string name, string description,decimal cost)
        {
            this.OptionId = optionId;
            this.Name=name;
            this.Description = description;
            this.Cost = cost;
        }
    }
    public class ShippingOptionComparer : IComparer<ShippingOption>
    {
        #region IComparer<ShippingOption> Members

        public int Compare(ShippingOption x, ShippingOption y)
        {
            if (x == null && y == null)
                return 0;
            else if (x == null)
                return -1;
            else if (y == null)
                return 1;

            return x.Cost.CompareTo(y.Cost);
        }

        #endregion
    }
}