using System;
using System.Collections.Generic;
using System.Text;
using System.Diagnostics;
using System.IO;

namespace Utility
{
    public class ErrorLogger
    {

        private const string PATH = @"c:\logs\";
        private const string FILE_NAME_PREFIX = "WOODMONSTERS_ERROR_LOG_";
        private const string ERROR_SOURCE = "WoodMonsters";
        #region Constructors

        public ErrorLogger()
        {
            // Plain Jane Constructor
        }

        public ErrorLogger(String Source, Exception Ex, bool Silent)
        {
            // Constructor with Loggging Action
            LogError(Source, Ex, Silent);
        }

        #endregion

        #region Public Methods

        public void LogError(String Source, Exception Ex, bool Silent)
        {
            try
            {
                // Write to a text file
                WriteToFile(Source, Ex.Message.ToString());

                // Write to Windows Event Log
                //WriteToEventLog(Source, Ex.Message.ToString());

                // TODO:  Change logging to create DB Record Entry

                // After error has been logged, throw the error anyway.
                if (!Silent)
                {
                    throw Ex;
                }

            }
            catch
            {
                throw;
            }
        }

        #endregion

        #region Private Methods

        private void WriteToFile(string Source, string Message)
        {
            try
            {
                // Due to the date function, there should be a new error log file per day.
                string fileName = PATH + FILE_NAME_PREFIX + DateTime.Now.Month.ToString() + "." + DateTime.Now.Day.ToString() + "." + DateTime.Now.Year.ToString() + ".txt";

                if(!Directory.Exists(PATH))
                {
                    //MKDIR
                    Directory.CreateDirectory(PATH);
                }

                string currentDateTime = DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToShortTimeString();

                // Write Error to flat file, append if file exists.
                using (StreamWriter sw = new StreamWriter(fileName, true))
                {
                    sw.WriteLine(" ");
                    sw.WriteLine("Date Time: " + currentDateTime);
                    sw.WriteLine("Source:  WoodMonsters ASP.NET Application:  " + Source);
                    sw.WriteLine("Message:  " + Message);
                }
            }
            catch
            {
                throw;
            }
        }

        private void WriteToEventLog(string Source, string Message)
        {
            try
            {
                // If this occurs, the first error will be lost as the error source is created.
                if (!EventLog.SourceExists(ERROR_SOURCE))
                {
                    //An event log source should not be created and immediately used.
                    //There is a latency time to enable the source, it should be created
                    //prior to executing the application that uses the source.
                    //Execute this sample a second time to use the new source.
                    EventLog.CreateEventSource(ERROR_SOURCE, "Application");
                    return;
                }

                // Create an EventLog instance and assign its source.
                EventLog myLog = new EventLog();
                myLog.Source = ERROR_SOURCE;

                // Write an informational entry to the event log.    
                myLog.WriteEntry(Message, EventLogEntryType.Error);



                //EventLog.WriteEntry("WoodMonsters ASP.NET Application: " + Source, Source + ": " + Message, EventLogEntryType.Error);

                //EventLog.WriteEntry(ERROR_SOURCE, Source + ": " + Message, EventLogEntryType.Error);
            }
            catch (Exception Ex)
            {
                Debug.WriteLine("Err: " + Ex.Message.ToString());
                throw;
            }
        }

        #endregion

    }
}
