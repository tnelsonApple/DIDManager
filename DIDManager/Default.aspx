<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DIDManager._Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        View / Assign DIDs & Toll-Free #s
    </h2>
    <asp:Panel ID="pnlFilterParameters" runat="server" GroupingText="Filter Parameters">
        <table>
            <tr>
                <td>Site:</td>
                <td>
                    <asp:DropDownList ID="ddlSite" runat="server" DataSourceID="dsSites" 
                        DataTextField="Display" DataValueField="siteCode">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="dsSites" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
                        SelectCommand="SELECT [siteCode], [siteCode] + '(' + [siteDescription] + ')' as 'Display' FROM [tblSites] ORDER BY [siteCode]">
                    </asp:SqlDataSource>
                </td>
                <td>Carrier:</td>
                <td>
                    <asp:DropDownList ID="ddlCarrier" runat="server" AppendDataBoundItems="True" 
                        DataSourceID="dsCarriers" DataTextField="carrierName" DataValueField="id">
                        <asp:ListItem>Any</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="dsCarriers" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
                        SelectCommand="SELECT [id], [carrierName] FROM [tblCarriers] ORDER BY [carrierName]">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>Type (DID or Toll-Free):</td>
                <td>
                    <asp:DropDownList ID="ddlType" runat="server">
                        <asp:ListItem>Any</asp:ListItem>
                        <asp:ListItem>DID</asp:ListItem>
                        <asp:ListItem Value="TFN">Toll-Free</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>Phone #:</td>
                <td>
                    <asp:TextBox ID="txtPhoneNum" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Account #:</td>
                <td>
                    <asp:TextBox ID="txtAcctNum" runat="server"></asp:TextBox></td>
                <td>Account Billing #:</td>
                <td>
                    <asp:TextBox ID="txtBillingNum" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Available?</td>
                <td>
                    <asp:DropDownList ID="ddlAvailable" runat="server">
                        <asp:ListItem>Any</asp:ListItem>
                        <asp:ListItem>Yes</asp:ListItem>
                        <asp:ListItem>No</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>Account Name:</td>
                <td>
                    <asp:TextBox ID="txtAcctName" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="4" align="center">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" 
                        onclick="btnSearch_Click" /></td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnlSearchResults" runat="server" GroupingText="Results">
    
        <asp:GridView ID="gvSearchResults" runat="server" 
                AutoGenerateColumns="False" DataKeyNames="phoneNum" 
                DataSourceID="dsSearch">
            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>Assign/Unassign</HeaderTemplate>
                    <ItemTemplate>
                        <center>
                        <asp:LinkButton ID="btnAssign" OnCommand="assignUnassign_Click" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "phoneNum") %>'  CommandName='<%# Convert.ToInt64(DataBinder.Eval(Container.DataItem, "accountNum")) == 0 ? "Assign" : "Unassign" %>' runat="server"><%# Convert.ToInt64(DataBinder.Eval(Container.DataItem, "accountNum")) == 0 ? "Assign" : "Unassign" %></asp:LinkButton>
                        </center>
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:BoundField DataField="Formatted" HeaderText="Phone #" ReadOnly="True" 
            SortExpression="phoneNum" />
                <asp:BoundField DataField="type" HeaderText="Type" SortExpression="type" />
                <asp:BoundField DataField="carrierName" HeaderText="Carrier" 
            SortExpression="carrierID" />
                <asp:BoundField DataField="accountNum" HeaderText="Account #" 
            SortExpression="accountNum" />
                <asp:BoundField DataField="billingNum" HeaderText="Billing #" 
            SortExpression="billingNum" />
                <asp:BoundField DataField="accountName" HeaderText="Account Name" 
            SortExpression="accountName" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="dsSearch" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
            OnSelected="dsSearch_Selected">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlSite" Name="siteCode" 
                    PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

    </asp:Panel>

    <asp:Button runat="server" ID="btnPopupModalPlaceholder"  style="display:none" />
    <asp:ModalPopupExtender ID="mpeAssignUnassign" 
            runat="server"
            TargetControlID="btnPopupModalPlaceholder"
            PopupControlID="pnlAssignUnassign"
            BackgroundCssClass="modalBackground"
            CancelControlID="btnAssignUnassignCancel">
    </asp:ModalPopupExtender>
    <asp:Panel runat="Server" ID="pnlAssignUnassign" BorderStyle="Solid" CssClass="modalPopup">
        <asp:HiddenField ID="hfPhoneNum" runat="server" />
        <asp:HiddenField ID="hfAssignUnassign" runat="server" />
        <table>
            <tr>
                <td>Phone #:</td>
                <td><asp:Label ID="lblAssignUnassignNum" runat="server" Text=""></asp:Label></td>
            </tr>
            <div runat="server" id="divAssign" visible="false">
            <tr>
                <td>Account #:</td>
                <td>
                    <asp:TextBox ID="txtAssignAccountNum" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Billing #:</td>
                <td>
                    <asp:TextBox ID="txtAssignBillingNum" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Account Name:</td>
                <td>
                    <asp:TextBox ID="txtAssignAccountName" runat="server"></asp:TextBox></td>
            </tr>
            </div>
            <div runat="server" id="divUnassign" visible="false">
            <tr>
                <td colspan="2">
                    <asp:Label ID="Label1" runat="server" Text="Are you sure want to Unassign this DID/Toll-Free #?"></asp:Label></td>
            </tr>
            </div>
            <tr>
                <td colspan="2">
                    <asp:Button ID="btnAssignUnassignSave" runat="server" Text="Save" 
                        UseSubmitBehavior="false" 
                        OnClientClick="this.disabled = true; this.value = 'Processing...';" 
                        onclick="btnAssignUnassignSave_Click" />&nbsp;
                    <asp:Button ID="btnAssignUnassignCancel" runat="server" Text="Cancel"/>
                </td>
            </tr>
        </table>
    
    </asp:Panel>
</asp:Content>
