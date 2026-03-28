using Krypton.Toolkit;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WarehouseDLHI_App.Common
{
    public static class CommonForm
    {
        public static void OpenApp(string pathApp)
        {
            if (File.Exists(pathApp))
            {
                try
                {
                    Process.Start(pathApp);
                }
                catch (Exception ex)
                {
                    KryptonMessageBox.Show("Không thể khởi chạy PO: " + ex.Message);
                }
            }
            else
            {
                KryptonMessageBox.Show("Không tìm thấy ứng dụng PO. Vui lòng kiểm tra lại cài đặt!");
            }
        }

        public static void OpenExcelAtSheet(string filePath, string sheetName)
        {
            try
            {
                Microsoft.Office.Interop.Excel.Application excelApp = new Microsoft.Office.Interop.Excel.Application();
                excelApp.Visible = true; // Hiện Excel lên
                Microsoft.Office.Interop.Excel.Workbook workbook = excelApp.Workbooks.Open(filePath);

                // Trỏ vào Sheet theo tên
                Microsoft.Office.Interop.Excel.Worksheet worksheet = (Microsoft.Office.Interop.Excel.Worksheet)workbook.Sheets[sheetName];
                worksheet.Select();
            }
            catch (Exception ex)
            {
                KryptonMessageBox.Show("Lỗi mở Sheet: " + ex.Message);
            }
        }

        public static void AutoCompleteComboboxValidating(KryptonComboBox sender, CancelEventArgs e)
        {
            var cb = sender as KryptonComboBox;
            string typedText = cb.Text?.Trim();

            if (string.IsNullOrEmpty(typedText))
            {
                cb.SelectedIndex = 0;
                return;
            }

            bool matched = false;
            string displayMember = cb.DisplayMember;

            foreach (var item in cb.Items)
            {
                if (item is DataRowView drv)
                {
                    string value = drv[displayMember]?.ToString();

                    if (value != null && value.Equals(typedText, StringComparison.OrdinalIgnoreCase))
                    {
                        cb.SelectedItem = item;
                        matched = true;
                        break;
                    }
                }
            }

            //if (!matched &&
            //    cb.SelectedItem is DataRowView selected &&
            //    selected[displayMember]?.ToString() != typedText)
            //{
            //    cb.SelectedIndex = 0;
            //}
            if (!matched)
            {
                cb.SelectedIndex = 0;
            }
        }

        public static void RenderNumbering(object sender, DataGridViewRowPostPaintEventArgs e)
        {
            var grid = sender as DataGridView;
            var rowIdx = (e.RowIndex + 1).ToString();

            var centerFormat = new StringFormat()
            {
                // right alignment might actually make more sense for numbers
                Alignment = StringAlignment.Center,
                LineAlignment = StringAlignment.Center
            };

            var headerBounds = new Rectangle(e.RowBounds.Left, e.RowBounds.Top, grid.RowHeadersWidth, e.RowBounds.Height);
            e.Graphics.DrawString(rowIdx, new Font("Arial", 11.0f), SystemBrushes.ControlText, headerBounds, centerFormat);
        }
    }
}
