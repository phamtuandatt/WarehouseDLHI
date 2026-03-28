using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WarehouseDLHI_DAL;

namespace WarehouseDLHI_BLL
{
    public class DashboardBLL
    {
        private DataAccessHelperFullManagement _dal = new DataAccessHelperFullManagement();

        public async Task<DataTable> GetMPRVsPOComparison_BLL(int mprId, string mprNo)
        {
            // 1. Lấy dữ liệu từ DAL (Hàm GetComparisonData_Async đã viết ở bước trước)
            DataTable dt = await _dal.GetComparisonData_Async(mprId, mprNo);

            // 2. Thêm cột tính toán chênh lệch (Balance) nếu chưa có
            if (!dt.Columns.Contains("Balance"))
            {
                dt.Columns.Add("Balance", typeof(decimal));
            }

            // 3. Tính toán logic: Balance = MPR Qty - PO Qty
            foreach (DataRow row in dt.Rows)
            {
                decimal mprQty = row["MPR_Qty"] != DBNull.Value ? Convert.ToDecimal(row["MPR_Qty"]) : 0;
                decimal poQty = row["PO_Qty"] != DBNull.Value ? Convert.ToDecimal(row["PO_Qty"]) : 0;

                row["Balance"] = mprQty - poQty;
            }

            return dt;
        }
    }
}
