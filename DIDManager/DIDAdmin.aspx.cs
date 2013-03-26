using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DIDManager
{
    public partial class DIDAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            //btnAddDIDsSave.Attributes.Add("onclick", " this.disabled = true; this.value = 'Processing.  Please be Patient...'; btnAddDIDsCancel.disabled = true; btnAddDIDsSave_Click();");
        }

        protected void lbSites_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (lbSites.SelectedIndex != -1)
            {
                btnDeleteSite.Enabled = true;
            }
            else
            {
                btnDeleteSite.Enabled = false;
            }
        }

        protected void btnDeleteSite_Click(object sender, EventArgs e)
        {
            Sites delSite = new Sites();
            delSite.delete(lbSites.SelectedValue);

            lbSites.DataBind();
            lbSites.SelectedIndex = -1;
            btnDeleteSite.Enabled = false;
        }

        protected void btnAddSiteSave_Click(object sender, EventArgs e)
        {
            Sites newSite = new Sites();
            newSite.addNew(txtSiteCode.Text, txtSiteDescription.Text);

            lbSites.DataBind();
            lbSites.SelectedIndex = -1;
            btnDeleteSite.Enabled = false;

            txtSiteCode.Text = "";
            txtSiteDescription.Text = "";
        }

        protected void lbCarriers_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (lbCarriers.SelectedIndex != -1)
            {
                btnDeleteCarrier.Enabled = true;
            }
            else
            {
                btnDeleteCarrier.Enabled = false;
            }
        }

        protected void btnDeleteCarrier_Click(object sender, EventArgs e)
        {
            Carriers delCarrier = new Carriers();
            delCarrier.delete(Convert.ToInt32(lbCarriers.SelectedValue));

            lbCarriers.DataBind();
            lbCarriers.SelectedIndex = -1;
            btnDeleteCarrier.Enabled = false;

            txtCarrierName.Text = "";
        }

        protected void btnAddCarrierSave_Click(object sender, EventArgs e)
        {
            Carriers addCarrier = new Carriers();
            addCarrier.insertNew(txtCarrierName.Text);

            lbCarriers.DataBind();
            lbCarriers.SelectedIndex = -1;
            btnDeleteCarrier.Enabled = false;

            txtCarrierName.Text = "";
        }


        protected void btnDeleteDID_Click(object sender, EventArgs e)
        {
            int count = 0;
            string didList = "";
            
            foreach (int index in lbDIDs.GetSelectedIndices())
            {
                ListItem li = lbDIDs.Items[index];
                if (count == 0)
                {
                    didList = li.Value;
                }
                else
                {
                    didList += ", " + li.Value;
                }
                count++;
            }

            if (count > 0)
            {
                DIDs delDIDs = new DIDs();
                delDIDs.deleteDIDs(didList);
            }

            lbDIDs.DataBind();
            lbDIDs.SelectedIndex = -1;
        }

        protected void ddlSite_SelectedIndexChanged(object sender, EventArgs e)
        {
            lbDIDs.DataBind();
            lbDIDs.SelectedIndex = -1;
            //btnDeleteDID.Enabled = false;
        }

        protected void ddlCarrier_SelectedIndexChanged(object sender, EventArgs e)
        {
            lbDIDs.DataBind();
            lbDIDs.SelectedIndex = -1;
            //btnDeleteDID.Enabled = false;
        }

        protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            lbDIDs.DataBind();
            lbDIDs.SelectedIndex = -1;
            //btnDeleteDID.Enabled = false;
        }

        protected void btnAddDIDsSave_Click(object sender, EventArgs e)
        {
            //btnAddDIDsSave.Enabled = false;
            DIDs newDIDs = new DIDs();

            if (hfMultipleOrSingle.Value == "Multiple")
            {
                newDIDs.insertBlock(ddlAddType.SelectedValue, ddlAddSite.SelectedValue, Convert.ToInt32(ddlAddCarrier.SelectedValue), Convert.ToInt32(txtAreaCode.Text), Convert.ToInt32(txtPrefix.Text), Convert.ToInt32(txtStartBlock.Text), Convert.ToInt32(txtEndBlock.Text));
            }
            else
            {
                if (!newDIDs.checkIfExists(Convert.ToInt64(txtPhoneNum.Text)))
                {
                    newDIDs.insertOne(Convert.ToInt64(txtPhoneNum.Text), ddlAddType.SelectedValue, ddlAddSite.SelectedValue, Convert.ToInt32(ddlAddCarrier.SelectedValue));
                }
            }

            lbDIDs.DataBind();
            lbDIDs.SelectedIndex = -1;
            //btnDeleteDID.Enabled = false;
        }

        protected void btnAddMultipleDIDs_Click(object sender, EventArgs e)
        {
            //btnAddDIDsSave.Enabled = true;
            hfMultipleOrSingle.Value = "Multiple";
            divMultiple.Visible = true;
            divSingle.Visible = false;

            ddlAddSite.SelectedValue = ddlSite.SelectedValue;
            ddlAddCarrier.SelectedValue = ddlCarrier.SelectedValue;
            ddlAddType.SelectedValue = ddlType.SelectedValue;

            mpeAddDIDs.Show();
        }

        protected void btnAddSingleDID_Click(object sender, EventArgs e)
        {
            //btnAddDIDsSave.Enabled = true;
            hfMultipleOrSingle.Value = "Single";
            divMultiple.Visible = false;
            divSingle.Visible = true;

            ddlAddSite.SelectedValue = ddlSite.SelectedValue;
            ddlAddCarrier.SelectedValue = ddlCarrier.SelectedValue;
            ddlAddType.SelectedValue = ddlType.SelectedValue;

            mpeAddDIDs.Show();
        }
    }
}