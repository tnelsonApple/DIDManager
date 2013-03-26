<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserAdmin.aspx.cs" Inherits="DIDManager.UserAdmin" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Manage Users</h2>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    <table>
        <tr>
            <td>
                <asp:ListBox ID="lbUsers" runat="server" DataSourceID="SqlDataSource1" AutoPostBack="true" 
                    DataTextField="username" DataValueField="username" Height="302px" 
                    Width="159px" onselectedindexchanged="ListBox1_SelectedIndexChanged"></asp:ListBox>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
                    SelectCommand="SELECT [username] FROM [tblUsers] ORDER BY [username]"></asp:SqlDataSource>
            </td>
            <td valign="top">
                <table>
                    <tr>
                        <td>Username:</td>
                        <td><asp:TextBox ID="txtDisplayUsername" runat="server" Enabled="false"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>DID Admin:</td>
                        <td><asp:CheckBox ID="cbDisplayDIDAdmin" runat="server" Enabled="false" /></td>
                    </tr>
                    <tr>
                        <td>User Admin:</td>
                        <td><asp:CheckBox ID="cbDisplayUserAdmin" runat="server" Enabled="false" /></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Button ID="btnAdd" runat="server" Text="Add" onclick="btnAdd_Click" />&nbsp;<asp:Button runat="server" ID="btnPopupModalPlaceholder"  style="display:none" />
                            <asp:Button ID="btnEdit" runat="server" Text="Edit" Enabled="false" 
                                onclick="btnEdit_Click" />&nbsp;
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" Enabled="false" 
                                onclick="btnDelete_Click" />
                            <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" 
                                TargetControlID="btnDelete" ConfirmText="Are you sure you want to delete this user?">
                            </asp:ConfirmButtonExtender>
                        </td>
                    </tr>
                </table>
                
            </td>
        </tr>
    </table>

    <asp:ModalPopupExtender ID="mpeAddEditUser" 
            runat="server"
            TargetControlID="btnPopupModalPlaceholder"
            PopupControlID="pnlModalPopUp"
            BackgroundCssClass="modalBackground"
            CancelControlID="btnAddEditCancel">
    </asp:ModalPopupExtender>
    <asp:Panel runat="Server" ID="pnlModalPopUp" BorderStyle="Solid" CssClass="modalPopup">
        <asp:HiddenField ID="hfAddOrEdit" runat="server" />
        <table>
            <tr>
                <td>Username:</td>
                <td><asp:TextBox ID="txtUsername" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>DID Admin:</td>
                <td><asp:CheckBox ID="cbDIDAdmin" runat="server" /></td>
            </tr>
            <tr>
                <td>User Admin:</td>
                <td><asp:CheckBox ID="cbUserAdmin" runat="server" /></td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Button ID="btnAddEditSave" runat="server" Text="Save" 
                        onclick="btnAddEditSave_Click" />&nbsp;
                    <asp:Button ID="btnAddEditCancel" runat="server" Text="Cancel"/>
                </td>
            </tr>
        </table>
    
    </asp:Panel>

    </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
