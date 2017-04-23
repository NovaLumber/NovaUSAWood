using System;
using System.Collections.Generic;
using System.Text;

// TODO: this class serves no purpose that cannot be achieved through the use of
// a validationSummary.  Either refactor so this is more useful or remove.

namespace Utility
{
    /**
     * A singleton class that compiles status messages throughout a request
     **/
    public sealed class StatusMessenger
    {
        public static readonly StatusMessenger Instance = new StatusMessenger();

        private List<String> statusMessages;
        private List<String> errorMessages;

        /**
         * constructor
         **/
        private StatusMessenger()
        {
            this.statusMessages = new List<String>();
            this.errorMessages = new List<String>();
        }

        /**
         * add an error message
         **/
        public void addErrorMessage(String msg)
        {
            this.errorMessages.Add(msg);
        }

        /**
         * add a status message
         **/
        public void addStatusMessage(String msg)
        {
            this.statusMessages.Add(msg);
        }

        public List<String> getErrorMessages()
        {
            List<String> placeholder = errorMessages;
            this.errorMessages = new List<String>();
            return placeholder;
        }

        public List<String> getStatusMessages()
        {
            List<String> placeholder = this.statusMessages;
            this.statusMessages = new List<String>();
            return placeholder;
        }
    }
}
