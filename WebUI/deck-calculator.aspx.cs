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
    public partial class deck_calculator : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //This is the default for std pages
            UiMasterPage masterPage = (UiMasterPage)Master;
            masterPage.SetMetaTags(
                "Deck Calculator, Calculating Material for Decking from Nova",
                "Deck Calculator to calculate BF, SF, and LF amount of 1x4, 5/4x4, 2x4, 1x6, 5/4x6 or 2x6 decking material needed to cover deck area.",
                "deck, calculator, calculate, calculating, bf, sf, lf, amount, 1x4, 5/4x4, 2x4, 1x6, 5/4x6, 2x6, cover, material, decking, area");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "forest");
            }

        }

        protected void calculate_Click(object sender, EventArgs e)
        {
            //clear results
            this.SectionAResult.Text = "";
            this.SectionBResult.Text = "";
            this.SectionCResult.Text = "";
            this.TotalResult.Text = "";

            //declare variable
            double widthA = 0, widthB = 0, widthC = 0, lengthA = 0, lengthB = 0, lengthC = 0;
            double thickness, width, sf, lf, bf, sfA, lfA, bfA, sfB, lfB, bfB, sfC, lfC, bfC;

            //get values
            try{ widthA = Convert.ToDouble(this.widthA.Text); } 
            catch{ this.SectionAResult.Text = "Invalid A width"; return; }

            try { lengthA = Convert.ToDouble(this.lengthA.Text); }
            catch { this.SectionAResult.Text = "Invalid A length"; return; }

            if (this.widthB.Text != "")
            {
                try { widthB = Convert.ToDouble(this.widthB.Text); }
                catch { this.SectionBResult.Text = "Invalid B width"; return; }
            }

            if (this.lengthB.Text != "")
            {
                try { lengthB = Convert.ToDouble(this.lengthB.Text); }
                catch { this.SectionBResult.Text = "Invalid B length"; return; }
            }

            if (this.widthC.Text != "")
            {
                try { widthC = Convert.ToDouble(this.widthC.Text); }
                catch { this.SectionCResult.Text = "Invalid C width"; return; }
            }

            if (this.lengthC.Text != "")
            {
                try { lengthC = Convert.ToDouble(this.lengthC.Text); }
                catch { this.SectionCResult.Text = "Invalid C length"; return; }
            }

            switch (material.SelectedIndex)
            {
                case 0:
                    thickness = 1;
                    width = 6;
                    break;
                case 1:
                    thickness = 1;
                    width = 4;
                    break;
                case 2:
                    thickness = 1.25;
                    width = 6;
                    break;
                case 3:
                    thickness = 1.25;
                    width = 4;
                    break;
                case 4:
                    thickness = 2;
                    width = 6;
                    break;
                case 5:
                    thickness = 2;
                    width = 4;
                    break;
                default:
                    thickness = 1;
                    width = 6;
                    break;
            }


            //do calculation
            sfA = widthA * lengthA;
            sf = sfA;
            if (width == 4)
            {
                lfA = 1.05 * sfA * 12 / 3.625;
                lf = lfA;
            }
            else
            {
                lfA = 1.05 * sfA * 12 / 5.625;
                lf = lfA;
            }
            bfA = lfA * thickness * width / 12;
            bf = bfA;
            this.SectionAResult.Text = "Section A:  SF=" + sfA.ToString("N0") + "  LF=" + lfA.ToString("N0") + "  BF=" + bfA.ToString("N0");

            if (widthB > 0 && lengthB > 0)
            {
                sfB = widthB * lengthB;
                if (width == 4)
                {
                    lfB = 1.05 * sfB * 12 / 3.625;
                }
                else
                {
                    lfB = 1.05 * sfB * 12 / 5.625;
                }
                bfB = lfB * thickness * width / 12;
                lf = lf + lfB;
                sf = sf + sfB;
                bf = bf + bfB;
                this.SectionBResult.Text = "Section B:  SF=" + sfB.ToString("N0") + "  LF=" + lfB.ToString("N0") + "  BF=" + bfB.ToString("N0");
            }

            if (widthC > 0 && lengthC > 0)
            {
                sfC = widthC * lengthC;
                if (width == 4)
                {
                    lfC = 1.05 * sfC * 12 / 3.625;
                }
                else
                {
                    lfC = 1.05 * sfC * 12 / 5.625;
                }
                bfC = lfC * thickness * width / 12;
                lf = lf + lfC;
                sf = sf + sfC;
                bf = bf + bfC;
                this.SectionCResult.Text = "Section C:  SF=" + sfC.ToString("N0") + "  LF=" + lfC.ToString("N0") + "  BF=" + bfC.ToString("N0");
            }

            this.TotalResult.Text = "Total:  SF=" + sf.ToString("N0") + "  LF=" + lf.ToString("N0") + "  BF=" + bf.ToString("N0");

        }
    }
}
