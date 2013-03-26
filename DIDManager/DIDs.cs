using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Configuration;
using System.Data.SqlClient;

namespace DIDManager
{
    public class DIDs
    {
        public Int64 _phoneNum { get; set; }
        public string _type { get; set; }
        public string _siteCode { get; set; }
        public int _carrierID { get; set; }
        public Int64 _accountNum { get; set; }
        public Int64 _billingNum { get; set; }
        public string _accountName { get; set; }

        public bool checkIfExists(Int64 phoneNum)
        {
            bool exists = false;

            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            sqlConn.Open();

            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.Connection = sqlConn;
            sqlCmd.CommandText = "SELECT phoneNum FROM tblDIDs WHERE phoneNum = @phoneNum";

            SqlParameter p1 = new SqlParameter("@phoneNum", phoneNum);

            sqlCmd.Parameters.Add(p1);

            SqlDataReader myReader = sqlCmd.ExecuteReader();

            if (myReader.HasRows)
            {
                exists = true;
            }

            myReader.Close();

            sqlConn.Close();
            sqlConn.Dispose();

            return exists;
        }

        public void insertOne(Int64 phoneNum, string type, string siteCode, int carrierID)
        {
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            sqlConn.Open();

            string query = "INSERT INTO tblDIDs(phoneNum, type, siteCode, carrierID, accountNum, billingNum, accountName) ";
            query += "VALUES(@phoneNum, @type, @siteCode, @carrierID, 0, 0, '')";

            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.Connection = sqlConn;
            sqlCmd.CommandText = query;

            SqlParameter p1 = new SqlParameter("@phoneNum", phoneNum);
            SqlParameter p2 = new SqlParameter("@type", type);
            SqlParameter p3 = new SqlParameter("@siteCode", siteCode);
            SqlParameter p4 = new SqlParameter("@carrierID", carrierID);

            sqlCmd.Parameters.Add(p1);
            sqlCmd.Parameters.Add(p2);
            sqlCmd.Parameters.Add(p3);
            sqlCmd.Parameters.Add(p4);

            sqlCmd.ExecuteNonQuery();

            sqlConn.Close();
            sqlConn.Dispose();
        }

        public void insertBlock(string type, string siteCode, int carrierID, int areaCode, int prefix, int blockBegin, int blockEnd)
        {
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            sqlConn.Open();

            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.Connection = sqlConn;
            sqlCmd.CommandType = System.Data.CommandType.StoredProcedure;
            sqlCmd.CommandText = "spInsertDIDBlock";

            SqlParameter p1 = new SqlParameter("@type", type);
            SqlParameter p2 = new SqlParameter("@siteCode", siteCode);
            SqlParameter p3 = new SqlParameter("@carrierID", carrierID);
            SqlParameter p4 = new SqlParameter("@areaCode", areaCode);
            SqlParameter p5 = new SqlParameter("@prefix", prefix);
            SqlParameter p6 = new SqlParameter("@blockBegin", blockBegin);
            SqlParameter p7 = new SqlParameter("@blockEnd", blockEnd);

            sqlCmd.Parameters.Add(p1);
            sqlCmd.Parameters.Add(p2);
            sqlCmd.Parameters.Add(p3);
            sqlCmd.Parameters.Add(p4);
            sqlCmd.Parameters.Add(p5);
            sqlCmd.Parameters.Add(p6);
            sqlCmd.Parameters.Add(p7);

            sqlCmd.ExecuteNonQuery();

            sqlConn.Close();
            sqlConn.Dispose();
        }

        public void assign(Int64 phoneNum, Int64 accountNum, Int64 billingNum, string accountName)
        {
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            sqlConn.Open();

            string query = "UPDATE tblDIDs SET accountNum = @accountNum, billingNum = @billingNum, accountName = @accountName ";
            query += "WHERE phoneNum = @phoneNum";

            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.Connection = sqlConn;
            sqlCmd.CommandText = query;

            SqlParameter p1 = new SqlParameter("@accountNum", accountNum);
            SqlParameter p2 = new SqlParameter("@billingNum", billingNum);
            SqlParameter p3 = new SqlParameter("@accountName", accountName);
            SqlParameter p4 = new SqlParameter("@phoneNum", phoneNum);

            sqlCmd.Parameters.Add(p1);
            sqlCmd.Parameters.Add(p2);
            sqlCmd.Parameters.Add(p3);
            sqlCmd.Parameters.Add(p4);

            sqlCmd.ExecuteNonQuery();

            sqlConn.Close();
            sqlConn.Dispose();
        }

        public void unassign(Int64 phoneNum)
        {
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            sqlConn.Open();

            string query = "UPDATE tblDIDs SET accountNum = 0, billingNum = 0, accountName = '' ";
            query += "WHERE phoneNum = @phoneNum";

            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.Connection = sqlConn;
            sqlCmd.CommandText = query;

            SqlParameter p1 = new SqlParameter("@phoneNum", phoneNum);

            sqlCmd.Parameters.Add(p1);

            sqlCmd.ExecuteNonQuery();

            sqlConn.Close();
            sqlConn.Dispose();
        }

        public void deleteDIDs(string didList)
        {
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            sqlConn.Open();

            string query = "DELETE FROM tblDIDs ";
            query += "WHERE phoneNum IN(" + didList + ")";

            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.Connection = sqlConn;
            sqlCmd.CommandText = query;

            sqlCmd.ExecuteNonQuery();

            sqlConn.Close();
            sqlConn.Dispose();
        }
    }
}