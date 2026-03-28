using Revise_MPR_Form;
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

namespace WarehouseDLHI_App.MPR_GUI
{
    public partial class ucMPRMangement : UserControl
    {
        private string _pcPath = ConfigurationManager.AppSettings[ContextHelper.DEVICE_NAME];

        public ucMPRMangement()
        {
            InitializeComponent();
        }

        private void btnMakeMPR_Click(object sender, EventArgs e)
        {
            string appPath = ConfigurationManager.AppSettings[ContextHelper.EXCEL_TESTING_PATH_KEY];
            CommonForm.OpenExcelAtSheet(appPath.Replace(ContextHelper.REPLACE_CONTENT_KEY, _pcPath), ContextHelper.MPR_UPDATE_SHEET_NAME);
        }

        private void btnReviseMPR_Click(object sender, EventArgs e)
        {
            frmOpenMPR frmOpenMPR = new frmOpenMPR();
            frmOpenMPR.ShowDialog();
        }
    }
}
