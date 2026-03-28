using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WarehouseDLHI_DAL.Entities.ProjectEntity
{
    public class ProjectImportDetailEntity
    {
        public int Product_ID { get; set; }
        public decimal Import_Qty { get; set; }
        public string Unit { get; set; }
        public int Time { get; set; }
        public string Note { get; set; }
    }
}
