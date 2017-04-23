<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="deck-calculator.aspx.cs" Inherits="WebUI.deck_calculator" Title="Untitled Page" %>

<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:DeckingNavigation id="DeckingNavigation1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
<div id="mainWithSideBar">  
<h1>Decking Calculator</h1>

    <div id="calculator">
    
        <div id="calculator-instructions">
            <h3>Calculator Instructions</h3>
            <ol>
                <li>Enter length and width in feet.</li>
                <li>Boards will run length-wise in each section.</li>
                <li>We add 5% more material for trim loss.</li>
                <li>Material is generally supplied in even lengths only, multiples of 2', from 8' to 20'.</li>
                <li>When entering deck dimensions, please round up to next even length in feet; example 9'2" should be entered as 10'.</li>
                <li>For diagonal installations, please add 15% for trim loss.</li>
                <li>Choose material size:<br />
                1x4 or 1x6 for 16" joist spacing;<br />
                5/4x4 or 5/4x6 for 24" joist spacing;<br />
                2x4 or 2x6 for heavy duty or commercial applications.</li>
                <li>Material required for each section in SF, LF and BF will be listed.</li>
                <li>Close to ground applications (24" or less) should use 4" width material.</li>
                <li>Install all materials in accordance with manufacturer's instructions.</li>
                <li>Calculations assume 1/8" spacing edge to edge between boards. 4" wide material is calculated at 3-5/8" and 6" at 5-5/8" net coverage.</li>
            </ol>
        </div> <!-- end calculator-instructions -->

        <div id="calculator-input">
            <h3>Section A</h3>
            <p>
            Width: <asp:TextBox width="80px" runat="server" ID="widthA"/>
            Length: <asp:TextBox width="80px" runat="server" ID="lengthA"/>
            </p>

            <h3>Section B</h3>
            <p>
            Width: <asp:TextBox width="80px" runat="server" ID="widthB"/>
            Length: <asp:TextBox width="80px" runat="server" ID="lengthB"/>
            </p>

            <h3>Section C</h3>
            <p>
            Width: <asp:TextBox width="80px" runat="server" ID="widthC"/>
            Length: <asp:TextBox width="80px" runat="server" ID="lengthC"/>
            </p>

            <h3>Material</h3>
            <p>
                <asp:RadioButtonList RepeatColumns="3" style="width:200px;" ID="material" runat="server">
                    <asp:listitem Selected="true" Text="1x6" Value="0" />
                    <asp:listitem Text="1x4" Value="1" />
                    <asp:listitem Text="5/4x6" Value="2" />
                    <asp:listitem Text="5/4x4" Value="3" />
                    <asp:listitem Text="2x6" Value="4" />
                    <asp:listitem Text="2x4" Value="5" />
                </asp:RadioButtonList>
            </p>
        
            <asp:Button style="font-weight:bold; margin-top:15px; margin-left:10px;" ID="calculate" OnClick="calculate_Click" runat="server" Text="Calculate" />
            
        </div> <!-- end calculator-input -->
        
        <div id="calculator-output">
        
            <h3>Material List</h3>

            <p><asp:Label runat="server" ID="SectionAResult" style="" /></p>
            <p><asp:Label runat="server" ID="SectionBResult" style="" /></p>
            <p><asp:Label runat="server" ID="SectionCResult" style="" /></p>
            <p><asp:Label runat="server" ID="TotalResult" style="" /></p>            
        
        </div> <!-- end calculator-input -->
        
    </div> <!-- end calculator -->
    
<div class="clearfix"></div>
</div><!-- end mainWithSideBar -->
</asp:Content>  