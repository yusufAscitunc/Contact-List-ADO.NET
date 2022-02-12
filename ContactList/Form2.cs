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
    public partial class formContacts : Form
    {
        public formContacts()
        {
            InitializeComponent();
        }

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connection"].ConnectionString);
        private void formContacts_Load(object sender, EventArgs e)
        {
            ContactList();
        }

        private void ClearFields()
        {
            tbName.Text = "";
            tbSurname.Text = "";
            tbMobile.Text = "";
            tbEmail.Text = "";
            rtbAddress.Text = "";
        }
        private void ContactList()
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM Contacts", con);

            DataTable data = new DataTable();
            adapter.Fill(data);

            dgwContacts.DataSource = data;
            dgwContacts.Columns["ContactID"].Visible = false;
        }

        private void btnRegister_Click(object sender, EventArgs e)
        {
            if (tbName.Text != null && tbSurname.Text != null && tbMobile.Text != null)
            {
                SqlCommand sql = new SqlCommand("AddContact", con);

                sql.CommandType = CommandType.StoredProcedure;

                sql.Parameters.AddWithValue("@Name", tbName.Text);
                sql.Parameters.AddWithValue("@Surname", tbSurname.Text);
                sql.Parameters.AddWithValue("@MobileNumber", tbMobile.Text);
                sql.Parameters.AddWithValue("@Email", tbEmail.Text);
                sql.Parameters.AddWithValue("@Address", rtbAddress.Text);

                MessageBox.Show("New Contact is Registred");

                con.Open();
                sql.ExecuteNonQuery();
                con.Close();
                ClearFields();
                ContactList();
            }
            else MessageBox.Show("Please enter value to all empty fields");

        }


        private void btnDelete_Click(object sender, EventArgs e)
        {
            if (dgwContacts.CurrentRow != null)
            {
                SqlCommand sql = new SqlCommand("DeleteContact", con);
                sql.CommandType = CommandType.StoredProcedure;
                sql.Parameters.AddWithValue("@ID", dgwContacts.CurrentRow.Cells["ContactID"].Value);

                MessageBox.Show("Record deleted");

                con.Open();
                sql.BeginExecuteNonQuery();
                con.Close();
                ContactList();

            }

        }

        private void dgwContacts_RowHeaderMouseClick(object sender, DataGridViewCellMouseEventArgs e)
        {

            if (dgwContacts.SelectedRows.Count > 0)
            {
                string _name = dgwContacts.SelectedRows[0].Cells[1].Value + string.Empty;
                string _surname = dgwContacts.SelectedRows[0].Cells[2].Value + string.Empty;
                string _mobile = dgwContacts.SelectedRows[0].Cells[3].Value + string.Empty;
                string _email = dgwContacts.SelectedRows[0].Cells[4].Value + string.Empty;
                string _address = dgwContacts.SelectedRows[0].Cells[5].Value + string.Empty;

                tbName.Text = _name;
                tbSurname.Text = _surname;
                tbMobile.Text = _mobile;
                tbEmail.Text = _email;
                rtbAddress.Text = _address;
            }
           
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            if (tbName.Text != null && tbSurname.Text != null && tbMobile.Text != null)
            {
                SqlCommand sql = new SqlCommand("UpdateContacts", con);

                sql.CommandType = CommandType.StoredProcedure;

                sql.Parameters.AddWithValue("@ID", dgwContacts.CurrentRow.Cells["ContactID"].Value);
                sql.Parameters.AddWithValue("@Name", tbName.Text);
                sql.Parameters.AddWithValue("@Surname", tbSurname.Text);
                sql.Parameters.AddWithValue("@MobileNumber", tbMobile.Text);
                sql.Parameters.AddWithValue("@Email", tbEmail.Text);
                sql.Parameters.AddWithValue("@Address", rtbAddress.Text);

                MessageBox.Show("Contact is Updated");

                con.Open();
                sql.ExecuteNonQuery();
                con.Close();
                ClearFields();
                ContactList();
            }
            else MessageBox.Show("Please enter value to all empty fields");
        }
    }
}
