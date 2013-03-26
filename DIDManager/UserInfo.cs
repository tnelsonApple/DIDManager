using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Configuration;
using System.Data.SqlClient;

namespace DIDManager
{
    public class UserInfo
    {
        public string _username { get; set; }
        public bool _didAdmin { get; set; }
        public bool _userAdmin { get; set; }

        public void populateInfo(string username)
        {
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            sqlConn.Open();

            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.Connection = sqlConn;
            sqlCmd.CommandText = "SELECT didAdmin, userAdmin FROM tblUsers WHERE username = @username";

            SqlParameter p1 = new SqlParameter("@username", username);

            sqlCmd.Parameters.Add(p1);

            SqlDataReader myReader = sqlCmd.ExecuteReader();

            while (myReader.Read())
            {
                this._username = username;

                this._didAdmin = myReader.GetBoolean(0);
                this._userAdmin = myReader.GetBoolean(1);
            }

            myReader.Close();

            sqlConn.Close();
            sqlConn.Dispose();
        }

        public void addNew(string username, bool didAdmin, bool userAdmin)
        {
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            sqlConn.Open();

            string query = "INSERT INTO tblUsers(username, didAdmin, userAdmin) ";
            query += "VALUES(@username, @didAdmin, @userAdmin)";

            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.Connection = sqlConn;
            sqlCmd.CommandText = query;

            SqlParameter p1 = new SqlParameter("@username", username);
            SqlParameter p2 = new SqlParameter("@didAdmin", didAdmin);
            SqlParameter p3 = new SqlParameter("@userAdmin", userAdmin);

            sqlCmd.Parameters.Add(p1);
            sqlCmd.Parameters.Add(p2);
            sqlCmd.Parameters.Add(p3);

            sqlCmd.ExecuteNonQuery();

            sqlConn.Close();
            sqlConn.Dispose();
        }

        public void editUser(string username, bool didAdmin, bool userAdmin)
        {
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            sqlConn.Open();

            string query = "UPDATE tblUsers SET didAdmin = @didAdmin, userAdmin = @userAdmin WHERE username = @username";

            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.Connection = sqlConn;
            sqlCmd.CommandText = query;

            SqlParameter p1 = new SqlParameter("@username", username);
            SqlParameter p2 = new SqlParameter("@didAdmin", didAdmin);
            SqlParameter p3 = new SqlParameter("@userAdmin", userAdmin);

            sqlCmd.Parameters.Add(p1);
            sqlCmd.Parameters.Add(p2);
            sqlCmd.Parameters.Add(p3);

            sqlCmd.ExecuteNonQuery();

            sqlConn.Close();
            sqlConn.Dispose();
        }

        public void deleteUser(string username)
        {
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            sqlConn.Open();

            string query = "DELETE FROM tblUsers WHERE username = @username";

            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.Connection = sqlConn;
            sqlCmd.CommandText = query;

            SqlParameter p1 = new SqlParameter("@username", username);

            sqlCmd.Parameters.Add(p1);

            sqlCmd.ExecuteNonQuery();

            sqlConn.Close();
            sqlConn.Dispose();
        }
    }
}