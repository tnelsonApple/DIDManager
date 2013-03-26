using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DIDManager
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string temp = "";
            temp = "temp";

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            refreshSearchResults();
        }

        protected void refreshSearchResults()
        {
            dsSearch.SelectParameters.Clear();
            string query = "SELECT [phoneNum], '(' + LEFT([phoneNum], 3) + ') ' + SUBSTRING(CONVERT(varchar(10),[phoneNum]), 4,3) + '-' + RIGHT([phoneNum],4) as 'Formatted', [type], [carrierName], [accountNum], [billingNum], [accountName] FROM [tblDIDs] INNER JOIN tblCarriers ON tblDIDs.carrierID = tblCarriers.id WHERE siteCode = @siteCode";
            dsSearch.SelectParameters.Add(new Parameter("siteCode", System.Data.DbType.String, ddlSite.SelectedValue));

            if (ddlCarrier.SelectedValue != "Any")
            {
                query += " AND carrierID = @carrierID";
                dsSearch.SelectParameters.Add(new Parameter("carrierID", System.Data.DbType.Int32, ddlCarrier.SelectedValue));
            }

            if (ddlType.SelectedValue != "Any")
            {
                query += " AND type = @type";
                dsSearch.SelectParameters.Add(new Parameter("type", System.Data.DbType.String, ddlType.SelectedValue));
            }

            if (txtPhoneNum.Text != "")
            {
                query += " AND CONVERT(VARCHAR(10), phoneNum) LIKE '%' + @phoneNum + '%'";
                dsSearch.SelectParameters.Add(new Parameter("phoneNum", System.Data.DbType.String, txtPhoneNum.Text));
            }

            if (txtAcctNum.Text != "")
            {
                query += " AND CONVERT(VARCHAR(20), accountNum) LIKE '%' + @accountNum + '%' AND accountNum != 0";
                dsSearch.SelectParameters.Add(new Parameter("accountNum", System.Data.DbType.String, txtAcctNum.Text));
            }

            if (txtBillingNum.Text != "")
            {
                query += " AND CONVERT(VARCHAR(20), billingNum) LIKE '%' + @billingNum + '%' AND billingNum != 0";
                dsSearch.SelectParameters.Add(new Parameter("billingNum", System.Data.DbType.String, txtBillingNum.Text));
            }

            if (txtAcctName.Text != "")
            {
                query += " AND CONVERT(VARCHAR(20), accountName) LIKE '%' + @accountName + '%'";
                dsSearch.SelectParameters.Add(new Parameter("accountName", System.Data.DbType.String, txtAcctName.Text));
            }

            if (ddlAvailable.SelectedValue != "Any")
            {
                if (ddlAvailable.SelectedValue == "Yes")
                {
                    query += " AND accountNum = 0";
                }
                else
                {
                    query += " AND accountNum != 0";
                }
            }

            query += " ORDER BY [phoneNum]";

            dsSearch.SelectCommand = query;
        }

        protected void dsSearch_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            pnlSearchResults.GroupingText = e.AffectedRows.ToString() + " Results";
        }

        protected void assignUnassign_Click(object sender, CommandEventArgs e)
        {
            string phoneNum = e.CommandArgument.ToString();
            string assignUnassign = e.CommandName.ToString();

            hfPhoneNum.Value = phoneNum;
            hfAssignUnassign.Value = assignUnassign;

            lblAssignUnassignNum.Text = phoneNum;

            if (assignUnassign == "Assign")
            {
                divAssign.Visible = true;
                divUnassign.Visible = false;
            }
            else
            {
                divAssign.Visible = false;
                divUnassign.Visible = true;
            }

            mpeAssignUnassign.Show();
        }

        protected void btnAssignUnassignSave_Click(object sender, EventArgs e)
        {
            DIDs updateDID = new DIDs();

            if (hfAssignUnassign.Value == "Assign")
            {
                updateDID.assign(Convert.ToInt64(hfPhoneNum.Value), Convert.ToInt64(txtAssignAccountNum.Text), Convert.ToInt64(txtAssignBillingNum.Text), txtAssignAccountName.Text);
            }
            else
            {
                updateDID.unassign(Convert.ToInt64(hfPhoneNum.Value));
            }

            txtAssignAccountName.Text = "";
            txtAssignAccountNum.Text = "";
            txtAssignBillingNum.Text = "";

            refreshSearchResults();
        }
    }
}
