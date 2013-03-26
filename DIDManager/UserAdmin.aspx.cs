using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DIDManager
{
    public partial class UserAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (lbUsers.SelectedIndex != -1)
            {
                UserInfo sessionUser = (UserInfo)Session["userInfo"];
                UserInfo selectedUser = new UserInfo();

                selectedUser.populateInfo(lbUsers.SelectedValue);

                txtDisplayUsername.Text = selectedUser._username;
                cbDisplayUserAdmin.Checked = selectedUser._userAdmin;
                cbDisplayDIDAdmin.Checked = selectedUser._didAdmin;

                if (sessionUser._username != selectedUser._username)
                {
                    btnEdit.Enabled = true;
                    btnDelete.Enabled = true;
                }
                else
                {
                    btnEdit.Enabled = false;
                    btnDelete.Enabled = false;
                }
            }
            else
            {
                btnEdit.Enabled = false;
                btnDelete.Enabled = false;
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            UserInfo sessionUser = (UserInfo)Session["userInfo"];

            hfAddOrEdit.Value = "Add";
            txtUsername.Enabled = true;

            txtUsername.Text = "";
            
            cbUserAdmin.Checked = false;
            cbDIDAdmin.Checked = false;

            mpeAddEditUser.Show();
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            UserInfo sessionUser = (UserInfo)Session["userInfo"];

            hfAddOrEdit.Value = "Edit";
            txtUsername.Enabled = false;
            txtUsername.Text = txtDisplayUsername.Text;
            cbUserAdmin.Checked = cbDisplayUserAdmin.Checked;
            cbDIDAdmin.Checked = cbDisplayDIDAdmin.Checked;

            mpeAddEditUser.Show();
        }

        protected void btnAddEditSave_Click(object sender, EventArgs e)
        {
            UserInfo addEditUser = new UserInfo();

            if (hfAddOrEdit.Value == "Add")
            {
                addEditUser.addNew(txtUsername.Text, cbDIDAdmin.Checked, cbUserAdmin.Checked);
            }
            else
            {
                addEditUser.editUser(txtUsername.Text, cbDIDAdmin.Checked, cbUserAdmin.Checked);
            }

            refreshUsersList();
        }

        public void refreshUsersList()
        {
            lbUsers.DataBind();
            txtDisplayUsername.Text = "";
            cbDisplayUserAdmin.Checked = false;
            cbDisplayDIDAdmin.Checked = false;

            btnEdit.Enabled = false;
            btnDelete.Enabled = false;
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            UserInfo user = new UserInfo();

            user.deleteUser(lbUsers.SelectedValue);

            refreshUsersList();
        }
    }
}