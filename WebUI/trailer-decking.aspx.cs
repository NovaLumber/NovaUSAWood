using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace WebUI
{
    public partial class trailer_decking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Trailer Decking | Apitong Shiplap Truck Decks | Keruing, Angelim Pedra Flooring | Nova USA",
                "Wholesaler of Apitong, Angelim, Keruing, Purpleheart, Hardwood Trailer Flooring, Shiplap Decking, Laminated Truck Floors, Wood Trailer Components.",
                "Wholesaler, Apitong, Angelim, Keruing, Purpleheart, Hardwood, Trailer Flooring, Shiplap Decking, Laminated Truck Floors, Wood Trailer Components. certified, green, fsc");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "trailer");
            }

        }
    }
}
