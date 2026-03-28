namespace WarehouseDLHI_App.MPR_GUI
{
    partial class ucMPRMangement
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
            this.kryptonNavigator1 = new Krypton.Navigator.KryptonNavigator();
            this.pageCommonMPR = new Krypton.Navigator.KryptonPage();
            this.pageMPRList = new Krypton.Navigator.KryptonPage();
            this.kryptonPanel1 = new Krypton.Toolkit.KryptonPanel();
            this.toolStrip1 = new System.Windows.Forms.ToolStrip();
            this.kryptonPanel2 = new Krypton.Toolkit.KryptonPanel();
            this.btnMakeMPR = new Krypton.Toolkit.KryptonButton();
            this.btnReviseMPR = new Krypton.Toolkit.KryptonButton();
            ((System.ComponentModel.ISupportInitialize)(this.kryptonNavigator1)).BeginInit();
            this.kryptonNavigator1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pageCommonMPR)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pageMPRList)).BeginInit();
            this.pageMPRList.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.kryptonPanel1)).BeginInit();
            this.kryptonPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.kryptonPanel2)).BeginInit();
            this.kryptonPanel2.SuspendLayout();
            this.SuspendLayout();
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
            this.pageCommonMPR,
            this.pageMPRList});
            this.kryptonNavigator1.SelectedIndex = 1;
            this.kryptonNavigator1.Size = new System.Drawing.Size(1414, 697);
            this.kryptonNavigator1.TabIndex = 2;
            this.kryptonNavigator1.Text = "kryptonNavigator1";
            // 
            // pageCommonMPR
            // 
            this.pageCommonMPR.AutoHiddenSlideSize = new System.Drawing.Size(200, 200);
            this.pageCommonMPR.Flags = 65534;
            this.pageCommonMPR.LastVisibleSet = true;
            this.pageCommonMPR.MinimumSize = new System.Drawing.Size(150, 50);
            this.pageCommonMPR.Name = "pageCommonMPR";
            this.pageCommonMPR.Size = new System.Drawing.Size(1412, 672);
            this.pageCommonMPR.Text = "Common";
            this.pageCommonMPR.ToolTipTitle = "Page ToolTip";
            this.pageCommonMPR.UniqueName = "e07d3c61af714b3ca4a5c6018b7ed1ce";
            // 
            // pageMPRList
            // 
            this.pageMPRList.AutoHiddenSlideSize = new System.Drawing.Size(200, 200);
            this.pageMPRList.Controls.Add(this.btnReviseMPR);
            this.pageMPRList.Controls.Add(this.btnMakeMPR);
            this.pageMPRList.Flags = 65534;
            this.pageMPRList.LastVisibleSet = true;
            this.pageMPRList.MinimumSize = new System.Drawing.Size(150, 50);
            this.pageMPRList.Name = "pageMPRList";
            this.pageMPRList.Size = new System.Drawing.Size(1412, 666);
            this.pageMPRList.Text = "MPR List";
            this.pageMPRList.ToolTipTitle = "Page ToolTip";
            this.pageMPRList.UniqueName = "7ef2b4e0f877454ea70c81e74bb548e9";
            // 
            // kryptonPanel1
            // 
            this.kryptonPanel1.Controls.Add(this.kryptonPanel2);
            this.kryptonPanel1.Controls.Add(this.toolStrip1);
            this.kryptonPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.kryptonPanel1.Location = new System.Drawing.Point(0, 0);
            this.kryptonPanel1.Name = "kryptonPanel1";
            this.kryptonPanel1.PaletteMode = Krypton.Toolkit.PaletteMode.ProfessionalSystem;
            this.kryptonPanel1.Size = new System.Drawing.Size(1414, 728);
            this.kryptonPanel1.TabIndex = 3;
            // 
            // toolStrip1
            // 
            this.toolStrip1.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.toolStrip1.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.toolStrip1.Location = new System.Drawing.Point(0, 0);
            this.toolStrip1.Name = "toolStrip1";
            this.toolStrip1.RenderMode = System.Windows.Forms.ToolStripRenderMode.System;
            this.toolStrip1.Size = new System.Drawing.Size(1414, 31);
            this.toolStrip1.TabIndex = 3;
            this.toolStrip1.Text = "toolStrip1";
            // 
            // kryptonPanel2
            // 
            this.kryptonPanel2.Controls.Add(this.kryptonNavigator1);
            this.kryptonPanel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.kryptonPanel2.Location = new System.Drawing.Point(0, 31);
            this.kryptonPanel2.Name = "kryptonPanel2";
            this.kryptonPanel2.PaletteMode = Krypton.Toolkit.PaletteMode.ProfessionalSystem;
            this.kryptonPanel2.Size = new System.Drawing.Size(1414, 697);
            this.kryptonPanel2.TabIndex = 4;
            // 
            // btnMakeMPR
            // 
            this.btnMakeMPR.Location = new System.Drawing.Point(457, 128);
            this.btnMakeMPR.Name = "btnMakeMPR";
            this.btnMakeMPR.Size = new System.Drawing.Size(215, 73);
            this.btnMakeMPR.TabIndex = 0;
            this.btnMakeMPR.Values.DropDownArrowColor = System.Drawing.Color.Empty;
            this.btnMakeMPR.Values.Text = "Make MPR";
            this.btnMakeMPR.Click += new System.EventHandler(this.btnMakeMPR_Click);
            // 
            // btnReviseMPR
            // 
            this.btnReviseMPR.Location = new System.Drawing.Point(697, 128);
            this.btnReviseMPR.Name = "btnReviseMPR";
            this.btnReviseMPR.Size = new System.Drawing.Size(215, 73);
            this.btnReviseMPR.TabIndex = 0;
            this.btnReviseMPR.Values.DropDownArrowColor = System.Drawing.Color.Empty;
            this.btnReviseMPR.Values.Text = "Revise MPR";
            this.btnReviseMPR.Click += new System.EventHandler(this.btnReviseMPR_Click);
            // 
            // ucMPRMangement
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.kryptonPanel1);
            this.Name = "ucMPRMangement";
            this.Size = new System.Drawing.Size(1414, 728);
            ((System.ComponentModel.ISupportInitialize)(this.kryptonNavigator1)).EndInit();
            this.kryptonNavigator1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pageCommonMPR)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pageMPRList)).EndInit();
            this.pageMPRList.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.kryptonPanel1)).EndInit();
            this.kryptonPanel1.ResumeLayout(false);
            this.kryptonPanel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.kryptonPanel2)).EndInit();
            this.kryptonPanel2.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private Krypton.Navigator.KryptonNavigator kryptonNavigator1;
        private Krypton.Navigator.KryptonPage pageCommonMPR;
        private Krypton.Navigator.KryptonPage pageMPRList;
        private Krypton.Toolkit.KryptonPanel kryptonPanel1;
        private Krypton.Toolkit.KryptonPanel kryptonPanel2;
        private System.Windows.Forms.ToolStrip toolStrip1;
        private Krypton.Toolkit.KryptonButton btnReviseMPR;
        private Krypton.Toolkit.KryptonButton btnMakeMPR;
    }
}
