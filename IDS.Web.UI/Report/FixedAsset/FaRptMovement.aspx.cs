﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IDS.Web.UI.Report.FixedAsset
{
    public partial class FaRptMovement : System.Web.UI.Page
    {
        CrystalDecisions.CrystalReports.Engine.ReportDocument rpt = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
        IDS.ReportHelper.CrystalHelper rptHelper = new IDS.ReportHelper.CrystalHelper();

        protected void Page_Init(object sender, EventArgs e)
        {

            this.Page.Title = "Detailed Acquisition and Sold Fixed Assets";
            if (!IsPostBack)
            {
                FillBranch();
                Refresh();
            }
            else
            {
                FillBranch();
                Refresh();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CRViewer.ToolPanelView = CrystalDecisions.Web.ToolPanelViewType.None;
            }
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            if (rpt != null)
            {
                rpt.Close();
                rpt.Dispose();
            }

            if (CRViewer != null)
                CRViewer.Dispose();

            GC.Collect();
        }// Page_Unload

        protected void btnPreview_Click(object sender, EventArgs e)
        {
            Refresh();
        }

        private void Refresh()
        {
            string bef_FromYear = "";
            if (string.IsNullOrEmpty(cboFromYear.Text))
            {
                bef_FromYear = System.DateTime.Now.ToString("yyyyMM");
            }
            else {
                DateTime datePeriod = System.Convert.ToDateTime(cboFromYear.Text);
                bef_FromYear = datePeriod.ToString("yyyyMM");
            }
            System.DateTime expenddt = System.DateTime.ParseExact(bef_FromYear, "yyyyMM", System.Globalization.DateTimeFormatInfo.InvariantInfo);
            string From_month = expenddt.ToString("MM"); //+ "/01/" + expenddt.Year;
            string From_year = expenddt.ToString("yyyy");

            string bef_ToYear = "";
            if (string.IsNullOrEmpty(cboToYear.Text))
            {
                bef_ToYear = System.DateTime.Now.ToString("yyyyMM");
            }
            else
            {
                DateTime datePeriod = System.Convert.ToDateTime(cboToYear.Text);
                bef_ToYear = datePeriod.ToString("yyyyMM");
            }
            System.DateTime expenddt1 = System.DateTime.ParseExact(bef_ToYear, "yyyyMM", System.Globalization.DateTimeFormatInfo.InvariantInfo);
            string To_month = expenddt1.ToString("MM"); //+ "/01/" + expenddt.Year;
            string To_year = expenddt1.ToString("yyyy");

            rpt.Load(Server.MapPath(@"~/Report/FixedAsset/CR/RptFAMovement.rpt"));
            rpt.DataDefinition.FormulaFields["Period"].Text = "\"" + expenddt.ToString("MMMM") + " " + From_year + " - " + expenddt1.ToString("MMMM") + " " + To_year + "\"";
            rpt.SetParameterValue("@Year", To_year);
            rpt.SetParameterValue("@Month",To_month);
            rpt.SetParameterValue("@YearFrom", From_year);
            rpt.SetParameterValue("@MonthFrom", From_month);
            rpt.SetParameterValue("@Branch", cboBranch.Text);
            rptHelper.SetDefaultFormulaField(rpt);
            rptHelper.SetLogOn(rpt);
            CRViewer.EnableDatabaseLogonPrompt = true;
            CRViewer.ReportSource = rpt;

        }//Refresh

        private void FillBranch()
        {
            cboBranch.DataSource = Convert.ToBoolean(Session[IDS.Tool.GlobalVariable.SESSION_USER_BRANCH_HO_STATUS]) == true ? IDS.GeneralTable.Branch.GetBranchForDatasource() : IDS.GeneralTable.Branch.GetBranchForDatasource(Session[IDS.Tool.GlobalVariable.SESSION_USER_BRANCH_CODE].ToString());
            cboBranch.DataTextField = "Text";
            cboBranch.DataValueField = "Value";
            cboBranch.DataBind();
            cboBranch.SelectedValue = Session[IDS.Tool.GlobalVariable.SESSION_USER_BRANCH_CODE].ToString();
        }

    }
}