using Krypton.Toolkit;
using Revise_MPR_Form;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Diagnostics;
using System.Configuration;
using WarehouseDLHI_App.Common;
using WarehouseDLHI_App.MPR_GUI;
using WarehouseDLHI_App.PO_GUI;
using WarehouseDLHI_BLL;

namespace WarehouseDLHI_App.MainGUI
{
    public partial class fmrMain : KryptonForm
    {
        private DashboardBLL _dsBLL = new DashboardBLL();

        public fmrMain()
        {
            InitializeComponent();
        }

        private async void fmrMain_Load(object sender, EventArgs e)
        {
            await LoadDashboard(92, "DV-FT-25G7-OGL-MPR-001");
        }

        private async Task LoadDashboard(int mprId, string mprNo)
        {
            try
            {
                DataTable dt = await _dsBLL.GetMPRVsPOComparison_BLL(mprId, mprNo);
                dgvDashboard.DataSource = dt;

                // Cấu hình giao diện Grid
                dgvDashboard.Columns["Detail_ID"].Visible = false;
                dgvDashboard.Columns["MPR_ID"].Visible = false;
                dgvDashboard.Columns["MPR_Detail_ID"].Visible = false;
                dgvDashboard.Columns["Item_No"].Visible = false;

                dgvDashboard.Columns["MPR_Qty"].HeaderText = "Số lượng yêu cầu";
                dgvDashboard.Columns["PO_Qty"].HeaderText = "Số lượng đã đặt";
                dgvDashboard.Columns["Balance"].HeaderText = "Còn lại";
                dgvDashboard.Columns["PONo"].HeaderText = "Số đơn hàng (PO)";
            }
            catch (Exception ex)
            {
                KryptonMessageBox.Show("Lỗi hiển thị đối soát: " + ex.Message);
            }
        }

        private void btnReviseMPR_Click(object sender, EventArgs e)
        {

        }

        private void btnMakeMPR_Click(object sender, EventArgs e)
        {

        }

        private void btnMPRManagement_Click(object sender, EventArgs e)
        {
            ucMPRMangement ucMPRMangement = new ucMPRMangement();
            pnMain.Controls.Add(ucMPRMangement);
            ucMPRMangement.Dock = DockStyle.Fill;
            ucMPRMangement.BringToFront();
        }

        private void btnPOManagement_Click(object sender, EventArgs e)
        {
            ucPOManagement ucPOManagement = new ucPOManagement();
            pnMain.Controls.Add(ucPOManagement);
            ucPOManagement.Dock = DockStyle.Fill;
            ucPOManagement.BringToFront();
        }

        private void dgvDashboard_RowPostPaint(object sender, DataGridViewRowPostPaintEventArgs e)
        {
            Common.CommonForm.RenderNumbering(sender, e);
        }

        //private async void btnSaveImport_Click(object sender, EventArgs e)
        //{
        //    // Gom dữ liệu Master
        //    var importHeader = new ProjectImportTransDTO
        //    {
        //        Project_ID = 1, // Lấy từ ComboBox Project
        //        Project_Code = 123,
        //        Import_No = txtImportNo.Text,
        //        Emp_ID = 10,
        //        Emp_Name = "Nguyen Van A",
        //        Details = new List<ProjectImportDetailDTO>()
        //    };

        //    // Gom dữ liệu Detail từ DataGridView
        //    foreach (DataGridViewRow row in dgvImportDetails.Rows)
        //    {
        //        if (row.IsNewRow) continue;
        //        importHeader.Details.Add(new ProjectImportDetailDTO
        //        {
        //            Product_ID = Convert.ToInt32(row.Cells["colProductID"].Value),
        //            Import_Qty = Convert.ToDecimal(row.Cells["colQty"].Value),
        //            Unit = row.Cells["colUnit"].Value.ToString(),
        //            Time = 1,
        //            Note = row.Cells["colNote"].Value?.ToString()
        //        });
        //    }

        //    // Gọi tầng BUS/DAL để thực thi
        //    bool success = await _dal.InsertProjectImport_Async(importHeader);
        //    if (success)
        //    {
        //        KryptonMessageBox.Show("Nhập kho và cập nhật tồn kho thành công!");
        //    }
        //}


    }
}
