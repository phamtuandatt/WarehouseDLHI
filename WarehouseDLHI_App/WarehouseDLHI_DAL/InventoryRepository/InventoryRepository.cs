using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WarehouseDLHI_DAL.Entities.ProjectEntity;

namespace WarehouseDLHI_DAL.InventoryRepository
{
    public class InventoryRepository
    {
        string connStr = @"";

        public async Task<bool> InsertProjectImport_Async(ProjectImportTransEntity trans)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    // 1. Chuyển List chi tiết sang DataTable (TVP)
                    DataTable dtDetails = new DataTable();
                    dtDetails.Columns.Add("product_id", typeof(int));
                    dtDetails.Columns.Add("import_qty", typeof(decimal));
                    dtDetails.Columns.Add("unit", typeof(string));
                    dtDetails.Columns.Add("time", typeof(int));
                    dtDetails.Columns.Add("note", typeof(string));

                    foreach (var item in trans.Details)
                    {
                        dtDetails.Rows.Add(item.Product_ID, item.Import_Qty, item.Unit, item.Time, item.Note);
                    }

                    // 2. Thiết lập Command gọi Procedure
                    SqlCommand cmd = new SqlCommand("sp_InsertProjectImport", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Tham số thông thường
                    cmd.Parameters.AddWithValue("@project_id", trans.Project_ID);
                    cmd.Parameters.AddWithValue("@project_code", trans.Project_Code);
                    cmd.Parameters.AddWithValue("@total_quantity", trans.Details.Sum(x => x.Import_Qty));
                    cmd.Parameters.AddWithValue("@po_no", trans.PO_No ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@import_no", trans.Import_No ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@invoice_no", trans.Invoice_No ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@note", trans.Note ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@supplier_id", trans.Supplier_ID);
                    cmd.Parameters.AddWithValue("@emp_id", trans.Emp_ID);
                    cmd.Parameters.AddWithValue("@emp_name", trans.Emp_Name);
                    cmd.Parameters.AddWithValue("@po_id", trans.PO_ID);

                    // 3. THAM SỐ ĐẶC BIỆT: Table-Valued Parameter
                    SqlParameter tvpParam = cmd.Parameters.AddWithValue("@Details", dtDetails);
                    tvpParam.SqlDbType = SqlDbType.Structured; // Khai báo đây là kiểu bảng
                    tvpParam.TypeName = "dbo.udt_ProjectImportDetail"; // Tên TYPE bạn đã tạo trong SQL

                    await conn.OpenAsync();
                    int rows = await cmd.ExecuteNonQueryAsync();
                    return rows > 0;
                }
                catch (SqlException ex)
                {
                    throw new Exception("Lỗi SQL: " + ex.Message);
                }
            }
        }
    }
}
