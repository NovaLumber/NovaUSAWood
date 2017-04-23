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
    public partial class kiln_sticks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            /*
            masterPage.SetMetaTags(
                "Kiln Sticks | Stacking Sticks | Hardwood Kiln Stickers | Kiln Drying Sticks",
                "Kiln Sticks, Stacking Sticks, Hardwood Kiln Stickers, Specializing in Purpleheart, Angelim Pedra, Apitong, Cumaru, Massaranduba, Ipe, Tatajuba",
                "kiln sticks, stacking sticks, kiln stickers, kiln drying, hardwood, purpleheart, apitong, keruing, angelim pedra, cumaru, massranduba, ipe, tatajuba");
            */ 
             

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "lumber-yard");
            }
        }
    }
}
