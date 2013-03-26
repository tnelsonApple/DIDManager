using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Configuration;
using System.Data.SqlClient;

namespace DIDManager
{
    public class Sites
    {
        public string _siteCode { get; set; }
        public string _siteDescription { get; set; }

        public void addNew(string siteCode, string siteDescription)
        {
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            sqlConn.Open();

            string query = "INSERT INTO tblSites(siteCode, siteDescription) ";
            query += "VALUES(@siteCode, @siteDescription)";

            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.Connection = sqlConn;
            sqlCmd.CommandText = query;

            SqlParameter p1 = new SqlParameter("@siteCode", siteCode);
            SqlParameter p2 = new SqlParameter("@siteDescription", siteDescription);

            sqlCmd.Parameters.Add(p1);
            sqlCmd.Parameters.Add(p2);

            sqlCmd.ExecuteNonQuery();

            sqlConn.Close();
            sqlConn.Dispose();
        }

        public void delete(string siteCode)
        {
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            sqlConn.Open();

            string query = "DELETE FROM tblSites WHERE siteCode = @siteCode";

            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.Connection = sqlConn;
            sqlCmd.CommandText = query;

            SqlParameter p1 = new SqlParameter("@siteCode", siteCode);

            sqlCmd.Parameters.Add(p1);

            sqlCmd.ExecuteNonQuery();

            sqlConn.Close();
            sqlConn.Dispose();
        }
    }
}