﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IDS.Web.UI.Report.FixedAsset
{
    public partial class wfFARepMonthlyGroup : System.Web.UI.Page
    {
        CrystalDecisions.CrystalReports.Engine.ReportDocument rpt = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
        IDS.ReportHelper.CrystalHelper rptHelper = new IDS.ReportHelper.CrystalHelper();

        protected void Page_Init(object sender, EventArgs e)
        {

            this.Page.Title = "Monthly Depreciation Report by Group";
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
            string fullDate = "";
            if (string.IsNullOrEmpty(cboMontYear.Text))
                fullDate = System.DateTime.Now.ToString("yyyyMM");
            else
            {
                DateTime datePeriod = System.Convert.ToDateTime(cboMontYear.Text);
                fullDate = datePeriod.ToString("yyyyMM");
            }
            System.DateTime expenddt = System.DateTime.ParseExact(fullDate, "yyyyMM", System.Globalization.DateTimeFormatInfo.InvariantInfo);
            string hasil = expenddt.ToString("MM") + "/01/" + expenddt.Year;

            CrystalDecisions.CrystalReports.Engine.ReportDocument rpt = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
            IDS.ReportHelper.CrystalHelper rptHelper = new IDS.ReportHelper.CrystalHelper();
            string oYear = cboMontYear.Text;
            rpt.Load(Server.MapPath(@"~/Report/FixedAsset/CR/rptFAMonthlybyGroup.rpt"));
            rpt.SetParameterValue("@Branch", cboBranch.Text);
            rpt.SetParameterValue("@Period", Convert.ToDateTime(hasil));
            rptHelper.SetDefaultFormulaField(rpt);
            rptHelper.SetLogOn(rpt);
            CRViewer.EnableDatabaseLogonPrompt = true;
            CRViewer.ReportSource = rpt;

        }

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