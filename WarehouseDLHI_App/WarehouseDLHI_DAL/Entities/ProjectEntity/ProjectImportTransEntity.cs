using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WarehouseDLHI_DAL.Entities.ProjectEntity
{
    public class ProjectImportTransEntity
    {
        public int Project_ID { get; set; }
        public int Project_Code { get; set; }
        public string PO_No { get; set; }
        public string Import_No { get; set; }
        public string Invoice_No { get; set; }
        public string Note { get; set; }
        public int Supplier_ID { get; set; }
        public int Emp_ID { get; set; }
        public string Emp_Name { get; set; }
        public int PO_ID { get; set; }
        public List<ProjectImportDetailEntity> Details { get; set; } // Danh sách chi tiết
    }
}
