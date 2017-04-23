using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;

namespace BusinessTier.Utility
{
    [Serializable]
    public class DataScrubber
    {
        public Regex GenerateEmailRegEx()
        {
            // Email scrub regex
            Regex theRegEx = new Regex(@"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$", RegexOptions.IgnoreCase);
            return theRegEx;
        }

        public string CleanPhoneNumber(string input)
        {
            string retval = "";

            foreach (char c in input)
            {
                if (c >= '0' && c <= '9')
                {
                    retval += c;
                }
            }
            return retval;
        }
        
        public string CleanEmail()
        {
            throw new System.NotImplementedException();
        }

        public string CleanByRegEx()
        {
            throw new System.NotImplementedException();
        }
    }
}
