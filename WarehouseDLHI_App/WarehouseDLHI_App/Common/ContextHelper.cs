using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WarehouseDLHI_App.Common
{
    public static class ContextHelper
    {
        public const string DEVICE_NAME = "Device_Name";

        // ===== PATH
        public const string REPLACE_CONTENT_KEY = "{{PC-NAME}}";
        public const string REV_PO_PATH_KEY = "PO_App_Path";
        public const string REV_MPR_PATH_KEY = "MPR_App_Path";
        public const string FINAL_PROJECT_PATH_KEY = "FinalProject_Path";
        public const string EXCEL_TESTING_PATH_KEY = "Excel_Path";
        public const string BACKUP_FOLDER_PAHT_KEY = "Backup_Folder_Path";


        // ===== SHEET NAME
        public const string MPR_UPDATE_SHEET_NAME = "MPRUpdate";
        public const string PO_SHEET_NAME = "POform";
        public const string RIR_SHEET_NAME = "RIRForm";
        public const string FINAL_SHEET_NAME = "Main";
    }
}
