<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="WebUI.contact" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <div id="mainNoSideBar">
    
        <h1>Contact Us</h1>

        <p>Our sales representatives are available to help connect you with the perfect Nova product 
        for your project. Please contact the appropriate sales representative for your location and product. 
        If the representative is not immediately available, please leave a detailed message including your 
        location and the product you are looking for, and we will get back to you as soon as possible.</p>
        <p>For general inquiries, please call 503.419.6407. <a href="tel:503-419-6407" class="button-new" title="Call Us">Call Us</a>
</p> 
       
        <div class="locationDetails">

            <h2><a name="portland">Nova Products Inc.</a></h2>
            <p>Nova Products Inc., 8082 SW Nimbus Ave, Space 6-A, Beaverton, OR 97008<br />
            Office: <a href="tel:503-419-6407">503.419.6407</a>, Fax: 216.373.4931</p>

            <div class="contactMap">
            <iframe width="<%= locationWidth%>" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" 
            src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=8082+SW+Nimbus+Ave,+Beaverton,+OR&amp;aq=&amp;ll=45.46,-122.79&amp;spn=0.021448,0.033603&amp;ie=UTF8&amp;hq=&amp;hnear=8082+SW+Nimbus+Ave,+Beaverton,+Oregon+97008&amp;t=m&amp;z=14&amp;ll=45.46,-122.79&amp;spn=0.021448,0.033603&amp;output=embed"></iframe></div>
           
            <div class="contact_info">
                <ul class="contact_name">
                    <li>John McGlocklin - Interior Flooring</li>
                    <li>Bill Christou - Eastern US Residential Decking</li>
                    <li>Manny Mueller - Kiln Sticks</li>
                    <li>Stephen Purdy - Truck Flooring, Apitong, Customs</li>
                    <li>Steve Getsiv - CEO, Western US Decking, Kiln Sticks</li>
                    <li>Robert Brown - Controller</li>
                    <li>Diane Getsiv - Accounts Payable</li>
                    <li>Joyce Gum - Accounts Receivable, Customer Service</li>
                </ul>
                
                <ul class="contact_email">
                    <li><a href="mailto:john@novausawood.com">john@novausawood.com</a></li>
                    <li><a href="mailto:bill@novausawood.com">bill@novausawood.com</a></li>
                    <li><a href="mailto:cmmueller@comcast.net">cmmueller@comcast.net</a></li>
                    <li><a href="mailto:stephen@novausawood.com">stephen@novausawood.com</a></li>
                    <li><a href="mailto:steve@novausawood.com">steve@novausawood.com</a></li>
                    <li><a href="mailto:bob.brown@novausawood.com">bob.brown@novausawood.com</a></li>
                    <li><a href="mailto:diane@novausawood.com">diane@novausawood.com</a></li>
                    <li><a href="mailto:joyce@novausawood.com">joyce@novausawood.com</a></li>
                </ul>
                <ul class="contact_phone">
                    <li>Phone: <a href="tel:504-756-8876">504.756.8876</a></li>
                    <li>Phone: <a href="tel:416-483-0351">416.483.0351</a></li>
                    <li>Phone: <a href="tel:971-409-5867">971.409.5867</a></li>  
                    <li>Phone: <a href="tel:503-419-6407">503.419.6407</a></li>  
                    <li>Phone: <a href="tel:503-473-2878">503.473.2878</a></li>
                    <li>Phone: <a href="tel:503-419-6407">503.419.6407</a></li>  
                    <li>Phone: <a href="tel:503-419-6407">503.419.6407</a></li>
                    <li>Phone: <a href="tel:503-419-6407">503.419.6407</a></li>
                </ul>
            </div> <!-- end contact_info -->

        </div> <!-- end locationDetails -->
               
        <div class="locationDetails">

            <h2><a name="curitiba">Nova Brazil Headquarters</a></h2>
            <p>Nova Forest Products SA, Rua Padre Ancheta, 2050, Sala 1201, Curitiba, Paran&aacute;, Brazil, CEP 80.730-000<br />
               Office: <a href="tel:++55-41-3245-0414">55.41.3245.0414</a></p>
            
            <div class="contactMap">
            <%--<iframe width="<%= locationWidth%>" height="350" frameborder="0" scrolling="yes" marginheight="0" marginwidth="0" 
            src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=Nova+Forest+Products+SA,+Curitiba,+Parana,+Brazil&amp;aq=&amp;sll=37.0625,-95.677068&amp;sspn=46.092115,59.941406&amp;ie=UTF8&amp;hq=Nova+Forest+Products+SA,&amp;hnear=R,+Curitiba+-+Paran%C3%A1,+80320-270,+Brazil&amp;t=m&amp;ll=-25.439554,-49.2663&amp;spn=0.054256,0.164795&amp;z=13&amp;output=embed"></iframe>--%>
            </div>

            <div class="contact_info">
                <ul class="contact_name">
                    <li>John McGlocklin - Interior Flooring</li>
                    <li>David Zugman - European Sales</li>
                    <li>Marlise Zonta - Asian Sales </li>
                </ul>
                <ul class="contact_email">
                    <li><a href="mailto:john@novausawood.com">john@novausawood.com</a></li>
                    <li><a href="mailto:dzugman@novafp.com.br">dzugman@novafp.com.br</a></li>
                    <li><a href="mailto:marlise@novafp.com.br">marlise@novafp.com.br</a></li>
                </ul>
                <ul class="contact_phone">
                    <li>Phone: <a href="tel:504-756-8876">504.756.8876</a></li>
                    <li>Phone: <a href="tel:++55-41-3245-0414">55.41.3245.0414</a></li>
                    <li>Phone: <a href="tel:++55-41-9192-1305">55.41.9192.1305</a></li>
                </ul>
            </div> <!-- end contact_info -->
            
        </div> <!-- end locationDetails -->            
            
        <div class="locationDetails">
            <p>Click to go to: <a href="#portland" >Nova Headquarters</a>, <a href="#curitiba" >Curitiba Brazil Office</a></p>
        </div> <!-- end locationDetails -->
                        
    </div><!-- end mainNoSideBar -->

<div class="clearfix"></div>

</asp:Content>  