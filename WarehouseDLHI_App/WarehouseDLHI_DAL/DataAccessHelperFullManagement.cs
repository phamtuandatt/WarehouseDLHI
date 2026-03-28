using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

namespace WarehouseDLHI_DAL
{
    public class DataAccessHelperFullManagement
    {
        //public string connStr = @"Server=dlhivietnam.database.windows.net;Database=MPR_Management;User ID=DLHI_Admin;Password=Hoangquyen@1905;TrustServerCertificate=True;";
        //public string connStr = @"Server=DESKTOP-KD2BPDJ;Database=SQLTesting_V1;User ID=sa;Password=Aa123456@;TrustServerCertificate=True;";

        public string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;

        // Chuỗi kết nối mới cho máy trạm (Client)
        // Sử dụng SQL Server Authentication (User/Pass) để ổn định hơn trong mạng LAN

        public async Task<DataTable> GetComparisonData_Async(int mprId, string mprNo)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("sp_GetMPRVsPOComparison", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Truyền tham số từ giao diện vào
                    cmd.Parameters.AddWithValue("@MPR_ID", mprId);
                    cmd.Parameters.AddWithValue("@MPR_No", mprNo);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    await conn.OpenAsync();
                    da.Fill(dt);
                    return dt;
                }
                catch (Exception ex)
                {
                    throw new Exception("Lỗi đối soát MPR-PO: " + ex.Message);
                }
            }
        }
    }
}
