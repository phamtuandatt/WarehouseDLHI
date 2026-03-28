using Revise_PO_Form;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WarehouseDLHI_App.Common;

namespace WarehouseDLHI_App.PO_GUI
{
    public partial class ucPOManagement : UserControl
    {
        private string _pcPath = ConfigurationManager.AppSettings[ContextHelper.DEVICE_NAME];

        public ucPOManagement()
        {
            InitializeComponent();
        }

        private void btnMakePO_Click(object sender, EventArgs e)
        {
            string appPath = ConfigurationManager.AppSettings[ContextHelper.EXCEL_TESTING_PATH_KEY];
            Common.CommonForm.OpenExcelAtSheet(appPath.Replace(ContextHelper.REPLACE_CONTENT_KEY, _pcPath), ContextHelper.PO_SHEET_NAME);
        }

        private void btnRevisePO_Click(object sender, EventArgs e)
        {
            //string appPath = ConfigurationManager.AppSettings[ContextHelper.REV_PO_PATH_KEY];
            //Common.CommonForm.OpenApp(appPath.Replace(ContextHelper.REPLACE_CONTENT_KEY, _pcPath));
            frmOpenPO frmOpenPO = new frmOpenPO();
            frmOpenPO.ShowDialog();
        }
    }
}
