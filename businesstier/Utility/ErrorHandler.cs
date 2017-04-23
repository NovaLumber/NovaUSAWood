using System;
using System.Collections.Generic;
using System.Text;
using System.Diagnostics;
using System.IO;
using BusinessTier;

namespace BusinessTier.Utility
{
    [Serializable]
    public class ErrorHandler
    {
        #region Constructors

        public ErrorHandler()
        {

        }

        public ErrorHandler(String Source, Exception Ex)
        {
            // Constructor with Loggging Action
            LogError(Source, Ex);
        }

        #endregion

        #region Methods

        // Accepts Error Object
        public void LogError(String Source, Exception Ex)
        {
            // Write to a text file
            WriteToFile(Source, Ex.Message.ToString() + "\nStack Trace:" + Ex.StackTrace.ToString());

            // THIS IS INACTIVE.  REQUIRES SERVER-SIDE SECURITY TO BE SETUP.
            // Write to Windows Event Log
            // WriteToEventLog(Source, Ex.Message.ToString() + "\nStack Trace:" + Ex.StackTrace.ToString());
        }

        // Accepts Error String
        public void LogError(String Source, String Message)
        {
            // Write to a text file
            WriteToFile(Source, Message);

            // THIS IS INACTIVE.  REQUIRES SERVER-SIDE SECURITY TO BE SETUP.
            // Write to Windows Event Log
            // WriteToEventLog(Source, Ex.Message.ToString());

        }

        private void WriteToFile(string Source, string Message)
        {
            // Due to the date function, there should be a new error log file per day.
            string fileName = Constants.ERROR_PATH + Constants.ERROR_FILE_NAME_PREFIX + DateTime.Now.Month.ToString() + "." + DateTime.Now.Day.ToString() + "." + DateTime.Now.Year.ToString() + ".txt";

            if (!Directory.Exists(Constants.ERROR_PATH))
            {
                try
                {
                    //MKDIR
                    Directory.CreateDirectory(Constants.ERROR_PATH);
                }
                catch (Exception Ex)
                {
                    // If this occurs, it is likely that the ASP.NET account does not have rights to the location.
                    // In this case, create the PATH  (usually the = "c:\logs\") directory and set the ASP.NET
                    Debug.WriteLine(Ex.Message);
                    throw Ex;
                }
            }

            string currentDateTime = DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToShortTimeString();

            // Write Error to flat file, append if file exists.
            using (StreamWriter sw = new StreamWriter(fileName, true))
            {
                sw.WriteLine(" ");
                sw.WriteLine("Date Time: " + currentDateTime);
                sw.WriteLine("Source:  " + Constants.ERROR_SOURCE + ": " + Source);
                sw.WriteLine("Message:  " + Message);
            }
        }

        private void WriteToEventLog(string Source, string Message)
        {
            // If this occurs, the first error will be lost as the error source is created.
            if (!EventLog.SourceExists(Constants.ERROR_SOURCE))
            {
                //An event log source should not be created and immediately used.
                //There is a latency time to enable the source, it should be created
                //prior to executing the application that uses the source.
                //Execute this sample a second time to use the new source.
                EventLog.CreateEventSource(Constants.ERROR_SOURCE, "Application");
                return;
            }

            // Create an EventLog instance and assign its source.
            EventLog myLog = new EventLog();
            myLog.Source = Constants.ERROR_SOURCE;

            // Write an informational entry to the event log.    
            myLog.WriteEntry(Message, EventLogEntryType.Error);
        }

        #endregion

        #region OldLegacyErrorRoutines


        // TODO  Consider movig this into the ErrorHandling Module if it is really needed.
        //private  string FindDataSetErrors(DataTable dt)
        //{
        //    StringBuilder retval = new StringBuilder();

        //    if (dt.HasErrors)
        //    {
        //        retval.Append(dt.TableName);
        //        retval.Append(":\n");

        //        foreach (DataRow dr in dt.Rows)
        //        {
        //            if (dr.HasErrors)
        //            {
        //                retval.Append("\t");
        //                retval.Append(dr.RowError);
        //                retval.Append(":");
        //                retval.Append(dr.RowError);
        //                retval.Append("\n");

        //                foreach (DataColumn dc in dr.GetColumnsInError())
        //                {
        //                    retval.Append("\t\t");
        //                    retval.Append(dc.ColumnName);
        //                    retval.Append(":");
        //                    retval.Append(dr.GetColumnError(dc));
        //                    retval.Append("\n");
        //                }
        //            }
        //        }

        //    }
        //    return retval.ToString();
        //}

        // TODO  Move this into the ErrorHandling Module
        //private  string FindDataSetErrors(DataSet ds)
        //{
        //    StringBuilder retval = new StringBuilder();
        //    foreach (DataTable dt in ds.Tables)
        //    {
        //        if (dt.HasErrors)
        //        {
        //            retval.Append(dt.TableName);
        //            retval.Append(":\n");

        //            foreach (DataRow dr in dt.Rows)
        //            {
        //                if (dr.HasErrors)
        //                {
        //                    retval.Append("\t");
        //                    retval.Append(dr.RowError);
        //                    retval.Append(":");
        //                    retval.Append(dr.RowError);
        //                    retval.Append("\n");

        //                    foreach (DataColumn dc in dr.GetColumnsInError())
        //                    {
        //                        retval.Append("\t\t");
        //                        retval.Append(dc.ColumnName);
        //                        retval.Append(":");
        //                        retval.Append(dr.GetColumnError(dc));
        //                        retval.Append("\n");
        //                    }
        //                }
        //            }
        //        }
        //    }
        //    return retval.ToString();
        //}

        #endregion

    }
}
