using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ContactList
{
    public partial class frmLogin : Form
    {
        public frmLogin()
        {
            InitializeComponent();
        }

        
        private void btnLogin_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString);
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT Username, Password FROM UserList WHERE Username='" + tbUsername.Text + "' AND Password='" + tbPassword.Text + "'", con);
            

            DataTable data = new DataTable();
            adapter.Fill(data);


            if (data.Rows.Count > 0)
            {
                formContacts contacts = new formContacts();
                this.Hide();
                contacts.Visible = true;
                MessageBox.Show("Login Successful");
                con.Close();
            }
            else MessageBox.Show("Invalid Username or Password");

            con.Close();

        }
    }
}
