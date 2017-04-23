using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net.Mail;

namespace WebUI
{
    public partial class request : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Nova USA Wood Products - Exotic Hardwood Flooring and Decking",
                "Specializing in Prefinished, Unfinished Solid Hardwood, Engineered Flooring and Decking - Exotic, Brazilian Cherry, Ipe, TigerWood, Cumaru, Oak, Maple, Cherry, and Rosewood. Certified FSC Green Floor.",
                "hardwood, flooring, floor, deck, decking, prefinished, unfinished, wood, solid, engineered, exotic, cheap, discount, brazilian, cherry, chestnut, walnut, canarywood, ipe, lapacho, maple, cumaru, patagonian, tiete, rosewood, tigerwood, tarara, oak, specializing, certified, green, fsc");

        }

        protected void submit_Click(object sender, EventArgs e)
        {
            try
            {

                string from_email = "";
                from_email = this.email.Text;

                string to_email = "steve.getsiv@comcast.net";

                string body = this.message.Text;

                MailMessage message = new MailMessage(from_email, to_email, "Request Info", body);

                SmtpClient client = new SmtpClient();

                client.Host = System.Configuration.ConfigurationManager.AppSettings["SMTPServer"];
                client.EnableSsl = false;
                client.Port = 587;
                client.UseDefaultCredentials = false;

                client.Credentials = new System.Net.NetworkCredential(System.Configuration.ConfigurationManager.AppSettings["EmailFromUserName"],
                    System.Configuration.ConfigurationManager.AppSettings["EmailFromPassword"]);

                client.DeliveryMethod = SmtpDeliveryMethod.SpecifiedPickupDirectory;
                client.PickupDirectoryLocation = "C:\\inetpub\\mailroot\\Pickup";
                client.Send(message);

                Response.Redirect("success.aspx", false);

            }
            catch (Exception ex)
            {
                //if exception
                //Response.Redirect("failure.aspx", false);
                throw ex;
            }
            finally
            {
                //always
            }

            
        }
    }
}
