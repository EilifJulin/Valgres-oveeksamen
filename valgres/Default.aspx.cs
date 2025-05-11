using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace valgres
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetVotes();
                PopulateDropdowns(); // fyll valg og regioner
            }
        }

        public void GetVotes()
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnCms"].ConnectionString;
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand("SELECT v.valg, r.name AS region, v.vote_count FROM votes v JOIN regions r ON v.region_id = r.id", conn);
                cmd.CommandType = CommandType.Text;

                SqlDataReader reader = cmd.ExecuteReader();
                dt.Load(reader);
                reader.Close();
            }
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        private void PopulateDropdowns()
        {
            ddlValg.Items.Clear();
            ddlValg.Items.Add("Valg 1");
            ddlValg.Items.Add("Valg 2");
            ddlValg.Items.Add("Valg 3");

            ddlRegion.Items.Clear();
            ddlRegion.Items.Add("Fredrikstad");
            ddlRegion.Items.Add("Sarpsborg");
            ddlRegion.Items.Add("Skjeberg");
            ddlRegion.Items.Add("Halden");
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string selectedValg = ddlValg.SelectedValue;
            string selectedRegion = ddlRegion.SelectedValue;
            int newVoteCount;

            if (!int.TryParse(txtVotes.Text, out newVoteCount))
            {
                lblStatus.Text = "Ugyldig tall!";
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["ConnCms"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string query = @"
                    UPDATE votes
                    SET vote_count = @voteCount
                    WHERE valg = @valg AND region_id = (
                        SELECT id FROM regions WHERE name = @regionName
                    )";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@voteCount", newVoteCount);
                    cmd.Parameters.AddWithValue("@valg", selectedValg);
                    cmd.Parameters.AddWithValue("@regionName", selectedRegion);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    lblStatus.Text = rowsAffected > 0 ? "Stemmer oppdatert!" : "Ingen rad funnet.";
                }
            }

            GetVotes(); // Oppdater grid etter endring
        }
    }
}
