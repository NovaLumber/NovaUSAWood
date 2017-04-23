using System;
using System.Collections.Generic;
using System.Text;

//TODO:  Destroy this class when possible.

namespace BusinessTier.Products
{
    //TODO:  Remove this STRUCT
    [Serializable]
    public struct SelectedFilter
    {
        public SelectedFilter(int filterId, int entryId)
        {
            FilterId = filterId;
            EntryId = entryId;
        }
        public int FilterId;
        public int EntryId;
    }
    
    public class LegacyFilter
    {

    }
}
