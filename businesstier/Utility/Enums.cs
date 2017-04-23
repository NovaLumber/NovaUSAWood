using System;
using System.Collections.Generic;
using System.Text;

namespace BusinessTier.Utility
{
    [Serializable]
    public class Enums
    {
        public enum CreateAccountErrorMessages
        {
            OtherError = -1,
            EmailTaken = -2
        }

        public enum CartStatus
        {
            New = 'N', Finalized = 'F', Submitted = 'S'
        }
    }
}
