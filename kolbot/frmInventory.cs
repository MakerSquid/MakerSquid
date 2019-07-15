using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace kolbot
{
	/// <summary>
	/// Summary description for inventory.
	/// </summary>
	public class frmInventory : System.Windows.Forms.Form
	{
		private System.Windows.Forms.TextBox txtInventory;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;
		private frmKolbot myParent = null;

		public frmInventory(frmKolbot myOwner)
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();
			this.myParent = myOwner;

			//
			// TODO: Add any constructor code after InitializeComponent call
			//
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if(components != null)
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.txtInventory = new System.Windows.Forms.TextBox();
			this.SuspendLayout();
			// 
			// txtInventory
			// 
			this.txtInventory.Location = new System.Drawing.Point(16, 88);
			this.txtInventory.Multiline = true;
			this.txtInventory.Name = "txtInventory";
			this.txtInventory.ScrollBars = System.Windows.Forms.ScrollBars.Both;
			this.txtInventory.Size = new System.Drawing.Size(744, 224);
			this.txtInventory.TabIndex = 0;
			this.txtInventory.Text = "txtInventory";
			// 
			// frmInventory
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(816, 485);
			this.Controls.Add(this.txtInventory);
			this.Name = "frmInventory";
			this.Text = "inventory";
			this.Load += new System.EventHandler(this.inventory_Load);
			this.ResumeLayout(false);

		}
		#endregion

		private void inventory_Load(object sender, System.EventArgs e)
		{
			//frmKolbot.
			string sPage = this.myParent.GetPage("http://www.kingdomofloathing.com/inventory.php?which=1");

			txtInventory.Text = sPage;

		}
	}
}
