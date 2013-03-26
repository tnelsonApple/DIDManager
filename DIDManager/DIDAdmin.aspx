<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DIDAdmin.aspx.cs" Inherits="DIDManager.DIDAdmin" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Manage Carriers/Sites/DIDs</h2>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
        <br />
        <asp:Accordion ID="Accordion1" runat="server" SelectedIndex="-1" 
                HeaderCssClass="accordionHeader" HeaderSelectedCssClass="accordionHeaderSelected"
                ContentCssClass="accordionContent" FadeTransitions="false" FramesPerSecond="40" 
                TransitionDuration="1" AutoSize="None" RequireOpenedPane="false" 
                SuppressHeaderPostbacks="true" Height="353px" Width="836px" >

            <Panes>
                <asp:AccordionPane ID="apSites" runat="server">
                    <Header><a href="" class="accordionLink">Add/Delete Sites</a></Header>
                    <Content>
                        <asp:ListBox ID="lbSites" Height="300px" Width="250px" runat="server" AutoPostBack="true" 
                            DataSourceID="SqlDataSource1" DataTextField="Display" OnSelectedIndexChanged="lbSites_SelectedIndexChanged" 
                            DataValueField="siteCode"></asp:ListBox>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
                            SelectCommand="SELECT [siteCode], [siteCode] + '(' + [siteDescription] + ')' as 'Display' FROM [tblSites] ORDER BY [siteCode]">
                        </asp:SqlDataSource>
                        <br />
                        <asp:Button ID="btnAddSite" runat="server" Text="Add" />&nbsp;
                        <asp:Button ID="btnDeleteSite" runat="server" Text="Delete" OnClick="btnDeleteSite_Click" Enabled="false" />
                        <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you sure you want to delete this site?" TargetControlID="btnDeleteSite">
                        </asp:ConfirmButtonExtender>
                        <asp:ModalPopupExtender ID="mpeAddSite" 
                                runat="server"
                                TargetControlID="btnAddSite"
                                PopupControlID="pnlAddSite"
                                BackgroundCssClass="modalBackground"
                                CancelControlID="btnAddSiteCancel">
                        </asp:ModalPopupExtender>
                        <asp:Panel runat="Server" ID="pnlAddSite" BorderStyle="Solid" CssClass="modalPopup">
                            <asp:HiddenField ID="hfAddOrEdit" runat="server" />
                            <table>
                                <tr>
                                    <td>Site Code:</td>
                                    <td><asp:TextBox ID="txtSiteCode" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>Site Description:</td>
                                    <td><asp:TextBox ID="txtSiteDescription" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Button ID="btnAddSiteSave" runat="server" Text="Save" 
                                            onclick="btnAddSiteSave_Click" />&nbsp;
                                        <asp:Button ID="btnAddSiteCancel" runat="server" Text="Cancel"/>
                                    </td>
                                </tr>
                            </table>
    
                        </asp:Panel>
                    </Content>
                </asp:AccordionPane>

                <asp:AccordionPane ID="apCarriers" runat="server">
                    <Header><a href="" class="accordionLink">Add/Delete Carriers</a></Header>
                    <Content>
                        <asp:ListBox ID="lbCarriers" Height="300px" Width="250px" runat="server" AutoPostBack="true" 
                            DataSourceID="SqlDataSource2" DataTextField="carrierName" OnSelectedIndexChanged="lbCarriers_SelectedIndexChanged" 
                            DataValueField="id"></asp:ListBox>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
                            SelectCommand="SELECT [id], [carrierName] FROM [tblCarriers] ORDER BY [carrierName]">
                        </asp:SqlDataSource>
                        <br />
                        <asp:Button ID="btnAddCarrier" runat="server" Text="Add" />&nbsp;
                        <asp:Button ID="btnDeleteCarrier" runat="server" Text="Delete" OnClick="btnDeleteCarrier_Click" Enabled="false" />
                        <asp:ConfirmButtonExtender ID="ConfirmButtonExtender2" runat="server" ConfirmText="Are you sure you want to delete this carrier?" TargetControlID="btnDeleteCarrier">
                        </asp:ConfirmButtonExtender>
                        <asp:ModalPopupExtender ID="ModalPopupExtender1" 
                                runat="server"
                                TargetControlID="btnAddCarrier"
                                PopupControlID="pnlAddCarrier"
                                BackgroundCssClass="modalBackground"
                                CancelControlID="btnAddCarrierCancel">
                        </asp:ModalPopupExtender>
                        <asp:Panel runat="Server" ID="pnlAddCarrier" BorderStyle="Solid" CssClass="modalPopup">
                            <table>
                                <tr>
                                    <td>Carrier Name:</td>
                                    <td><asp:TextBox ID="txtCarrierName" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Button ID="btnAddCarrierSave" runat="server" Text="Save" 
                                            onclick="btnAddCarrierSave_Click" />&nbsp;
                                        <asp:Button ID="btnAddCarrierCancel" runat="server" Text="Cancel"/>
                                    </td>
                                </tr>
                            </table>
    
                        </asp:Panel>
                    </Content>
                </asp:AccordionPane>

                <asp:AccordionPane ID="apDIDs" runat="server">
                    <Header><a href="" class="accordionLink">Add/Delete DIDs & Toll-Free #s</a></Header>
                    <Content>
                        <table>
                            <tr>
                                <td>Site:</td>
                                <td>
                                    <asp:DropDownList ID="ddlSite" runat="server" DataSourceID="SqlDataSource3" 
                                        DataTextField="Display" DataValueField="siteCode" AutoPostBack="True" 
                                        onselectedindexchanged="ddlSite_SelectedIndexChanged">
                                    </asp:DropDownList> 
                                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
                                        SelectCommand="SELECT [siteCode], [siteCode] + '(' + [siteDescription] + ')' as 'Display' FROM [tblSites] ORDER BY [siteCode]">
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                            <tr>
                                <td>Carrier:</td>
                                <td>
                                    <asp:DropDownList ID="ddlCarrier" runat="server" DataSourceID="SqlDataSource4" 
                                        DataTextField="carrierName" DataValueField="id" AutoPostBack="True" 
                                        onselectedindexchanged="ddlCarrier_SelectedIndexChanged">
                                    </asp:DropDownList> 
                                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
                                        SelectCommand="SELECT [carrierName], [id] FROM [tblCarriers] ORDER BY [carrierName]">
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                            <tr>
                                <td>Type:</td>
                                <td>
                                    <asp:DropDownList ID="ddlType" runat="server" AutoPostBack="True" 
                                        onselectedindexchanged="ddlType_SelectedIndexChanged">
                                        <asp:ListItem>DID</asp:ListItem>
                                        <asp:ListItem Value="TFN">Toll-Free</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td>
                                    <asp:ListBox ID="lbDIDs" runat="server" DataSourceID="SqlDataSource5" 
                                        DataTextField="Formatted" DataValueField="phoneNum" Height="300px" 
                                        SelectionMode="Multiple" Width="200px"></asp:ListBox>
    
                                    <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
                                        SelectCommand="SELECT [phoneNum], '(' + LEFT([phoneNum], 3) + ') ' + SUBSTRING(CONVERT(varchar(10),[phoneNum]), 4,3) + '-' + RIGHT([phoneNum],4) as 'Formatted' FROM [tblDIDs] WHERE (([carrierID] = @carrierID) AND ([siteCode] = @siteCode) AND ([type] = @type))">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="ddlCarrier" Name="carrierID" 
                                                PropertyName="SelectedValue" Type="Int32" />
                                            <asp:ControlParameter ControlID="ddlSite" Name="siteCode" 
                                                PropertyName="SelectedValue" Type="String" />
                                            <asp:ControlParameter ControlID="ddlType" Name="type" 
                                                PropertyName="SelectedValue" Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                                <td valign="top">
                                    <asp:Button runat="server" ID="btnPopupModalPlaceholder"  style="display:none" />
                                    <asp:Button ID="btnAddMultipleDIDs" runat="server" 
                                        Text="Add Block" OnClick="btnAddMultipleDIDs_Click" /><br />
                                    <asp:Button ID="btnAddSingleDID" runat="server" 
                                        Text="Add Single" OnClick="btnAddSingleDID_Click" /><br />
                                    <asp:Button ID="btnDeleteDID" runat="server" 
                                        Text="Delete Selected" onclick="btnDeleteDID_Click" />
                                    <asp:ConfirmButtonExtender ID="ConfirmButtonExtender3" runat="server" ConfirmText="Are you sure you want to delete the selected DIDs/TFNs?" TargetControlID="btnDeleteDID">
                                    </asp:ConfirmButtonExtender>
                                </td>
                            </tr>
                        </table>
                        <asp:ModalPopupExtender ID="mpeAddDIDs" 
                                runat="server"
                                TargetControlID="btnPopupModalPlaceholder"
                                PopupControlID="pnlAddDIDs"
                                BackgroundCssClass="modalBackground"
                                CancelControlID="btnAddDIDsCancel">
                        </asp:ModalPopupExtender>
                        <asp:Panel runat="Server" ID="pnlAddDIDs" BorderStyle="Solid" CssClass="modalPopup">
                            <asp:HiddenField ID="hfMultipleOrSingle" runat="server" />
                            <table>
                                <tr>
                                    <td>Site:</td>
                                    <td>
                                        <asp:DropDownList Enabled="false" ID="ddlAddSite" runat="server" DataSourceID="SqlDataSource3" 
                                        DataTextField="Display" DataValueField="siteCode">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Carrier:</td>
                                    <td>
                                        <asp:DropDownList Enabled="false" ID="ddlAddCarrier" runat="server" DataSourceID="SqlDataSource4" 
                                        DataTextField="carrierName" DataValueField="id">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Type:</td>
                                    <td>
                                        <asp:DropDownList Enabled="false" ID="ddlAddType" runat="server">
                                            <asp:ListItem>DID</asp:ListItem>
                                            <asp:ListItem Value="TFN">Toll-Free</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <div runat="server" id="divMultiple" visible="false">
                                <tr>
                                    <td>Area Code:</td>
                                    <td>
                                        <asp:TextBox ID="txtAreaCode" runat="server" Columns="3" MaxLength="3"></asp:TextBox>
                                        <asp:MaskedEditExtender Mask="999" TargetControlID="txtAreaCode" ID="MaskedEditExtender1" runat="server" PromptCharacter="#">
                                        </asp:MaskedEditExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Prefix:</td>
                                    <td>
                                        <asp:TextBox ID="txtPrefix" runat="server" Columns="3" MaxLength="3"></asp:TextBox>
                                        <asp:MaskedEditExtender Mask="999" TargetControlID="txtPrefix" ID="MaskedEditExtender2" runat="server" PromptCharacter="#">
                                        </asp:MaskedEditExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Block:</td>
                                    <td>
                                        <asp:TextBox ID="txtStartBlock" runat="server" Columns="4" MaxLength="4"></asp:TextBox> - <asp:TextBox ID="txtEndBlock" runat="server" Columns="4" MaxLength="4"></asp:TextBox>
                                        <asp:MaskedEditExtender Mask="9999" TargetControlID="txtStartBlock" ID="MaskedEditExtender3" runat="server" PromptCharacter="#">
                                        </asp:MaskedEditExtender>
                                        <asp:MaskedEditExtender Mask="9999" TargetControlID="txtEndBlock" ID="MaskedEditExtender4" runat="server" PromptCharacter="#">
                                        </asp:MaskedEditExtender>
                                     </td>
                                </tr>
                                </div>
                                <div runat="server" id="divSingle" visible="false">
                                <tr>
                                    <td>Phone #:</td>
                                    <td><asp:TextBox ID="txtPhoneNum" runat="server" Columns="15"></asp:TextBox>
                                        <asp:MaskedEditExtender TargetControlID="txtPhoneNum" ID="meePhoneNum" runat="server" Mask="(999) 999-9999">
                                        </asp:MaskedEditExtender>
                                    </td>
                                </tr>
                                </div>
                                <tr>
                                    <td colspan="2">
                                        <asp:Button ID="btnAddDIDsSave" runat="server" Text="Save" 
                                           UseSubmitBehavior="false" onclick="btnAddDIDsSave_Click" OnClientClick="this.disabled = true; this.value = 'Processing...';" />&nbsp;
                                        <asp:Button ID="btnAddDIDsCancel" runat="server" Text="Cancel"/>
                                    </td>
                                </tr>
                            </table>
    
                        </asp:Panel>
                    </Content>
                </asp:AccordionPane>

            </Panes>
        </asp:Accordion>
    
        </ContentTemplate>
    </asp:UpdatePanel>

    
    
</asp:Content>
