namespace WarehouseDLHI_App.PO_GUI
{
    partial class ucPOManagement
    {
        /// <summary> 
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.toolStrip1 = new System.Windows.Forms.ToolStrip();
            this.kryptonPanel2 = new Krypton.Toolkit.KryptonPanel();
            this.kryptonNavigator1 = new Krypton.Navigator.KryptonNavigator();
            this.pageCommonPO = new Krypton.Navigator.KryptonPage();
            this.pagePOList = new Krypton.Navigator.KryptonPage();
            this.btnRevisePO = new Krypton.Toolkit.KryptonButton();
            this.btnMakePO = new Krypton.Toolkit.KryptonButton();
            ((System.ComponentModel.ISupportInitialize)(this.kryptonPanel2)).BeginInit();
            this.kryptonPanel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.kryptonNavigator1)).BeginInit();
            this.kryptonNavigator1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pageCommonPO)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pagePOList)).BeginInit();
            this.pagePOList.SuspendLayout();
            this.SuspendLayout();
            // 
            // toolStrip1
            // 
            this.toolStrip1.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.toolStrip1.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.toolStrip1.Location = new System.Drawing.Point(0, 0);
            this.toolStrip1.Name = "toolStrip1";
            this.toolStrip1.RenderMode = System.Windows.Forms.ToolStripRenderMode.System;
            this.toolStrip1.Size = new System.Drawing.Size(1276, 25);
            this.toolStrip1.TabIndex = 0;
            this.toolStrip1.Text = "toolStrip1";
            // 
            // kryptonPanel2
            // 
            this.kryptonPanel2.Controls.Add(this.kryptonNavigator1);
            this.kryptonPanel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.kryptonPanel2.Location = new System.Drawing.Point(0, 25);
            this.kryptonPanel2.Name = "kryptonPanel2";
            this.kryptonPanel2.PaletteMode = Krypton.Toolkit.PaletteMode.ProfessionalSystem;
            this.kryptonPanel2.Size = new System.Drawing.Size(1276, 715);
            this.kryptonPanel2.TabIndex = 5;
            // 
            // kryptonNavigator1
            // 
            this.kryptonNavigator1.Button.ButtonDisplayLogic = Krypton.Navigator.ButtonDisplayLogic.None;
            this.kryptonNavigator1.Button.CloseButtonAction = Krypton.Navigator.CloseButtonAction.None;
            this.kryptonNavigator1.Button.CloseButtonDisplay = Krypton.Navigator.ButtonDisplay.Hide;
            this.kryptonNavigator1.Button.ContextButtonAction = Krypton.Navigator.ContextButtonAction.SelectPage;
            this.kryptonNavigator1.Button.ContextButtonDisplay = Krypton.Navigator.ButtonDisplay.Logic;
            this.kryptonNavigator1.Button.ContextMenuMapImage = Krypton.Navigator.MapKryptonPageImage.Small;
            this.kryptonNavigator1.Button.ContextMenuMapText = Krypton.Navigator.MapKryptonPageText.TextTitle;
            this.kryptonNavigator1.Button.NextButtonAction = Krypton.Navigator.DirectionButtonAction.ModeAppropriateAction;
            this.kryptonNavigator1.Button.NextButtonDisplay = Krypton.Navigator.ButtonDisplay.Logic;
            this.kryptonNavigator1.Button.PreviousButtonAction = Krypton.Navigator.DirectionButtonAction.ModeAppropriateAction;
            this.kryptonNavigator1.Button.PreviousButtonDisplay = Krypton.Navigator.ButtonDisplay.Logic;
            this.kryptonNavigator1.ControlKryptonFormFeatures = false;
            this.kryptonNavigator1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.kryptonNavigator1.Location = new System.Drawing.Point(0, 0);
            this.kryptonNavigator1.NavigatorMode = Krypton.Navigator.NavigatorMode.BarTabGroup;
            this.kryptonNavigator1.Owner = null;
            this.kryptonNavigator1.PageBackStyle = Krypton.Toolkit.PaletteBackStyle.PanelClient;
            this.kryptonNavigator1.Pages.AddRange(new Krypton.Navigator.KryptonPage[] {
            this.pageCommonPO,
            this.pagePOList});
            this.kryptonNavigator1.SelectedIndex = 1;
            this.kryptonNavigator1.Size = new System.Drawing.Size(1276, 715);
            this.kryptonNavigator1.TabIndex = 2;
            this.kryptonNavigator1.Text = "kryptonNavigator1";
            // 
            // pageCommonPO
            // 
            this.pageCommonPO.AutoHiddenSlideSize = new System.Drawing.Size(200, 200);
            this.pageCommonPO.Flags = 65534;
            this.pageCommonPO.LastVisibleSet = true;
            this.pageCommonPO.MinimumSize = new System.Drawing.Size(150, 50);
            this.pageCommonPO.Name = "pageCommonPO";
            this.pageCommonPO.Size = new System.Drawing.Size(1274, 684);
            this.pageCommonPO.Text = "Common";
            this.pageCommonPO.ToolTipTitle = "Page ToolTip";
            this.pageCommonPO.UniqueName = "e07d3c61af714b3ca4a5c6018b7ed1ce";
            // 
            // pagePOList
            // 
            this.pagePOList.AutoHiddenSlideSize = new System.Drawing.Size(200, 200);
            this.pagePOList.Controls.Add(this.btnRevisePO);
            this.pagePOList.Controls.Add(this.btnMakePO);
            this.pagePOList.Flags = 65534;
            this.pagePOList.LastVisibleSet = true;
            this.pagePOList.MinimumSize = new System.Drawing.Size(150, 50);
            this.pagePOList.Name = "pagePOList";
            this.pagePOList.Size = new System.Drawing.Size(1274, 684);
            this.pagePOList.Text = "PO List";
            this.pagePOList.ToolTipTitle = "Page ToolTip";
            this.pagePOList.UniqueName = "7ef2b4e0f877454ea70c81e74bb548e9";
            // 
            // btnRevisePO
            // 
            this.btnRevisePO.Location = new System.Drawing.Point(308, 33);
            this.btnRevisePO.Name = "btnRevisePO";
            this.btnRevisePO.Size = new System.Drawing.Size(215, 73);
            this.btnRevisePO.TabIndex = 1;
            this.btnRevisePO.Values.DropDownArrowColor = System.Drawing.Color.Empty;
            this.btnRevisePO.Values.Text = "Revise PO";
            this.btnRevisePO.Click += new System.EventHandler(this.btnRevisePO_Click);
            // 
            // btnMakePO
            // 
            this.btnMakePO.Location = new System.Drawing.Point(68, 33);
            this.btnMakePO.Name = "btnMakePO";
            this.btnMakePO.Size = new System.Drawing.Size(215, 73);
            this.btnMakePO.TabIndex = 2;
            this.btnMakePO.Values.DropDownArrowColor = System.Drawing.Color.Empty;
            this.btnMakePO.Values.Text = "Make PO";
            this.btnMakePO.Click += new System.EventHandler(this.btnMakePO_Click);
            // 
            // ucPOManagement
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.kryptonPanel2);
            this.Controls.Add(this.toolStrip1);
            this.Name = "ucPOManagement";
            this.Size = new System.Drawing.Size(1276, 740);
            ((System.ComponentModel.ISupportInitialize)(this.kryptonPanel2)).EndInit();
            this.kryptonPanel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.kryptonNavigator1)).EndInit();
            this.kryptonNavigator1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pageCommonPO)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pagePOList)).EndInit();
            this.pagePOList.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ToolStrip toolStrip1;
        private Krypton.Toolkit.KryptonPanel kryptonPanel2;
        private Krypton.Navigator.KryptonNavigator kryptonNavigator1;
        private Krypton.Navigator.KryptonPage pageCommonPO;
        private Krypton.Navigator.KryptonPage pagePOList;
        private Krypton.Toolkit.KryptonButton btnRevisePO;
        private Krypton.Toolkit.KryptonButton btnMakePO;
    }
}
