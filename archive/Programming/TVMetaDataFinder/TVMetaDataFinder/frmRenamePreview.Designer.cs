namespace TVMetaDataFinder
{
    partial class frmRenamePreview
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

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.renameListBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.btnAll = new System.Windows.Forms.Button();
            this.btnTog = new System.Windows.Forms.Button();
            this.Show = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.OldFileName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.NewFileName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Rename = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.renameListBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // button1
            // 
            this.button1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.button1.DialogResult = System.Windows.Forms.DialogResult.OK;
            this.button1.Location = new System.Drawing.Point(404, 306);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 0;
            this.button1.Text = "OK";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.button2.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.button2.Location = new System.Drawing.Point(486, 306);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(75, 23);
            this.button2.TabIndex = 1;
            this.button2.Text = "Cancel";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // dataGridView1
            // 
            this.dataGridView1.AllowUserToAddRows = false;
            dataGridViewCellStyle3.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            this.dataGridView1.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle3;
            this.dataGridView1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.dataGridView1.AutoGenerateColumns = false;
            this.dataGridView1.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Show,
            this.OldFileName,
            this.NewFileName,
            this.Rename});
            this.dataGridView1.DataSource = this.renameListBindingSource;
            this.dataGridView1.Location = new System.Drawing.Point(12, 42);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.Size = new System.Drawing.Size(542, 258);
            this.dataGridView1.TabIndex = 2;
            // 
            // renameListBindingSource
            // 
            this.renameListBindingSource.DataSource = typeof(TVMetaDataFinder.RenameList);
            // 
            // btnAll
            // 
            this.btnAll.Location = new System.Drawing.Point(398, 13);
            this.btnAll.Name = "btnAll";
            this.btnAll.Size = new System.Drawing.Size(75, 23);
            this.btnAll.TabIndex = 4;
            this.btnAll.Text = "Select Al";
            this.btnAll.UseVisualStyleBackColor = true;
            this.btnAll.Click += new System.EventHandler(this.btnAll_Click);
            // 
            // btnTog
            // 
            this.btnTog.Location = new System.Drawing.Point(479, 12);
            this.btnTog.Name = "btnTog";
            this.btnTog.Size = new System.Drawing.Size(75, 23);
            this.btnTog.TabIndex = 5;
            this.btnTog.Text = "Toggle";
            this.btnTog.UseVisualStyleBackColor = true;
            this.btnTog.Click += new System.EventHandler(this.btnTog_Click);
            // 
            // Show
            // 
            this.Show.DataPropertyName = "Show";
            this.Show.HeaderText = "Show";
            this.Show.Name = "Show";
            this.Show.ReadOnly = true;
            // 
            // OldFileName
            // 
            this.OldFileName.DataPropertyName = "OldFileName";
            this.OldFileName.HeaderText = "OldFileName";
            this.OldFileName.Name = "OldFileName";
            this.OldFileName.ReadOnly = true;
            // 
            // NewFileName
            // 
            this.NewFileName.DataPropertyName = "NewFileName";
            this.NewFileName.HeaderText = "NewFileName";
            this.NewFileName.Name = "NewFileName";
            // 
            // Rename
            // 
            this.Rename.DataPropertyName = "Rename";
            this.Rename.HeaderText = "Rename";
            this.Rename.Name = "Rename";
            // 
            // frmRenamePreview
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(566, 341);
            this.Controls.Add(this.btnTog);
            this.Controls.Add(this.btnAll);
            this.Controls.Add(this.dataGridView1);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Name = "frmRenamePreview";
            this.Text = "Rename Preview";
            this.Load += new System.EventHandler(this.frmRenamePreview_Load);
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.frmRenamePreview_FormClosing);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.renameListBindingSource)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.BindingSource renameListBindingSource;
        private System.Windows.Forms.Button btnAll;
        private System.Windows.Forms.Button btnTog;
        private System.Windows.Forms.DataGridViewTextBoxColumn Show;
        private System.Windows.Forms.DataGridViewTextBoxColumn OldFileName;
        private System.Windows.Forms.DataGridViewTextBoxColumn NewFileName;
        private System.Windows.Forms.DataGridViewCheckBoxColumn Rename;
    }
}