using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace TVMetaDataFinder
{
    public partial class frmRenamePreview : Form
    {

        public RenameList RenameList { get; set; }

        public frmRenamePreview()
        {
            InitializeComponent();
            
        }

        private void button2_Click(object sender, EventArgs e)
        {
        }

        private void button1_Click(object sender, EventArgs e)
        {
           
        }

        private void frmRenamePreview_Load(object sender, EventArgs e)
        {
            dataGridView1.DataSource = RenameList;
            dataGridView1.Refresh();
        }

        private void frmRenamePreview_FormClosing(object sender, FormClosingEventArgs e)
        {
        }

        private void bindingNavigatorDeleteItem_Click(object sender, EventArgs e)
        {

        }

        private void btnAll_Click(object sender, EventArgs e)
        {
            RenameList.ForEach((item) => item.Rename = true);
            dataGridView1.Refresh();
        }

        private void btnTog_Click(object sender, EventArgs e)
        {
            RenameList.ForEach((item) => item.Rename = !item.Rename);
            dataGridView1.Refresh();
        }
    }
}
