namespace File_Renamer
{
    partial class Form1
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
            this.RemoveText = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.FromText = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.ToText = new System.Windows.Forms.TextBox();
            this.ProcessNames = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // RemoveText
            // 
            this.RemoveText.Location = new System.Drawing.Point(30, 29);
            this.RemoveText.Multiline = true;
            this.RemoveText.Name = "RemoveText";
            this.RemoveText.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.RemoveText.Size = new System.Drawing.Size(186, 365);
            this.RemoveText.TabIndex = 0;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(13, 13);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(47, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "Remove";
            // 
            // FromText
            // 
            this.FromText.Location = new System.Drawing.Point(272, 29);
            this.FromText.Multiline = true;
            this.FromText.Name = "FromText";
            this.FromText.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.FromText.Size = new System.Drawing.Size(145, 365);
            this.FromText.TabIndex = 2;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(246, 12);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(30, 13);
            this.label2.TabIndex = 3;
            this.label2.Text = "From";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(424, 12);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(20, 13);
            this.label3.TabIndex = 5;
            this.label3.Text = "To";
            // 
            // ToText
            // 
            this.ToText.Location = new System.Drawing.Point(450, 29);
            this.ToText.Multiline = true;
            this.ToText.Name = "ToText";
            this.ToText.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.ToText.Size = new System.Drawing.Size(145, 365);
            this.ToText.TabIndex = 4;
            // 
            // ProcessNames
            // 
            this.ProcessNames.Location = new System.Drawing.Point(520, 400);
            this.ProcessNames.Name = "ProcessNames";
            this.ProcessNames.Size = new System.Drawing.Size(75, 23);
            this.ProcessNames.TabIndex = 6;
            this.ProcessNames.Text = "Process";
            this.ProcessNames.UseVisualStyleBackColor = true;
            this.ProcessNames.Click += new System.EventHandler(this.ProcessNames_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(634, 431);
            this.Controls.Add(this.ProcessNames);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.ToText);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.FromText);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.RemoveText);
            this.Name = "Form1";
            this.Text = "Simple Renamer";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form1_FormClosing);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox RemoveText;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox FromText;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox ToText;
        private System.Windows.Forms.Button ProcessNames;
    }
}

