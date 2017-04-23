<%@ Page Title="" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="elemental-advantage.aspx.cs" Inherits="WebUI.elemental_advantage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:FlooringNavigation id="FlooringNavigation1" runat="server" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div id="mainWithSideBar" class="elemental">
        <img alt="elemental exotics" src="images/photo-elemental-advantage-top.jpg" />
        <div class="align-left">
            <h1>Elemental Advantage Collection</h1>
            
            <h2>Stunning looks and amazing prices - we've engineered the perfect combination of value and quality.</h2>
            
            <h3>Engineered Hardwood Flooring</h3>
            <p>The Nova Elemental Advantage line of engineered flooring is manufactured in Indonesia using only the highest quality products. 
            Our Advantage engineered flooring features internationally recognized finishes, a wide variety of legally and responsibly harvested face species, 
            and renewable plantation grown core and bottom layer woods.<br />
            <a href="contact.aspx" class="button-new" title="Contact Us">Contact Us</a>
            <a href="tel:503-419-6407" class="button-new" title="Call Us">Call Us</a>
            </p>
            
            <h3>The Hevea Core</h3>
            <p>Hevea or Rubberwood is a plantation species that yields natural latex in its harvestable lifespan. When the trees have reached an age where latex yield is no longer adequate, the trees are harvested for lumber. This process of felling and replanting occurs every 25 to 30 years.</p>
            <p>Being a hardwood species, with similar characteristics to Oak, Hevea provides greater dimensional stability and withstands external pressures, such as changes in temperature, moisture, and humidity, better than typical softwood core products.</p>
            <p>75% of each 3 layer plank composition is made up of renewable plantation species and 25% is from hardwood veneers. The bottom layer is plantation pine.</p>
            
            <h3>White Oak Wear Layers</h3>
            <p>All Elemental Advantage oak veneers come from Europe or the United States as opposed to Siberian/Russian oak used by many mills. Siberian/Russian oak will only semi-smoke due to the lack of tannin within the oak. European oak can fully smoke to a beautiful dark brown color.</p>
            <p>Additionally, European and American oak is typically more consistent in grain & color whereas Siberian/Russian oak is susceptible to increased amounts of discoloration and unsightly mineral streaks.  This is primarily due to differences in the regions and soil composition where the trees grow.</p>
            
            <h3>Environmental Responsibility</h3>
            <p>Elemental Advantage is both Lacey Act and CARB (California Air Resources Board) compliant. 
            All products in the Elemental Flooring line are produced with the utmost care for our environment. 
            From the tropical forests of South America and Southeast Asia to the deciduous forests of northern temperate regions, 
            we engage in only selective and highly sustainable harvesting practices to ensure the continued health and prosperity 
            of the forests we all rely on. The wood industry plays an important role in the preservation of the world's forests by 
            providing value and jobs in forest regions. By providing an economically viable alternative to clear cutting land for 
            agricultural use, the wood industry ensures the continued preservation of the world’s standing forests.</p>
            
        </div> <!-- end align-left -->

        <div class="align-right">
            <a href="products.aspx?FilterstoAdd=520" class="button-new">View ELEMENTAL Advantage Collection</a>
            <img style="padding-bottom:10px;" alt="elemental exotics" src="images/photo-elemental-advantage-side.jpg" />

            <span style="text-align:left;">
            <h3>Long Length Structure</h3>
            <p>All products, except for Rustic Oak, will have 84% 6’ boards and 16% 2’, 3’, & 4’ boards.  Rustic Oak will have 50% 6’ boards and 50% 2’, 3’, & 4’ boards.</p>

            <h3>Finishes</h3>
            <p>All flooring is finished with either UV urethane or oil products from world respected Klumpp Coatings. German-based Klumpp has been producing finish products since 1919.</p>

            <h3>Warranty</h3>
            <p>Elemental Advantage comes with a 25-yr residential finish warranty (does not apply to oiled products) as well as a lifetime structural warranty.</p>

            <h3>Installation</h3>
            <p>Elemental Advantage can be nailed, stapled, glued, or floated.</p>

            <h3>Other Elemental Collections</h3>
            <p>
            <a href="elemental-exotics.aspx">Elemental Exotics</a><br />
            <!--<a href="elemental-classics.aspx">Elemental Classics</a><br />-->
            <a href="elemental-heritage.aspx">Elemental Heritage</a><br />
            <a href="prefinished-flooring.aspx">Elemental Overview</a></p>
            </span>
            
        </div> <!-- end align-right -->
    <div class="clearfix"></div>
    </div><!-- end mainWithSideBar -->
</asp:Content>
