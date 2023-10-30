﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IDS.Web.UI.Report.GLReport
{
    public partial class wfRptIncomeStat_ActualVsBudget : System.Web.UI.Page
    {
        CrystalDecisions.CrystalReports.Engine.ReportDocument rpt = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
        IDS.ReportHelper.CrystalHelper rptHelper = new IDS.ReportHelper.CrystalHelper();

        string Branchhhh = "";

        static double BUMNLimit = 10000000; // Limit transaksi BUMN WAPU
        static string kodeAkun = "411211";
        static string jenisSetoran = "900";
        static string FP = "030";

        protected void Page_Init(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FillBranch();
                Code_Afcgen();
            }
            else
            {
                FillBranch();
                //Code_Afcgen();
            }

            try
            {
                string menuCodeEncrypted = Request.QueryString["rpt"];

                if (string.IsNullOrWhiteSpace(menuCodeEncrypted))
                    Response.Redirect("~/Error/Error403");

                string menuCodeDecrypted = IDS.Tool.UrlEncryption.DecryptParam(menuCodeEncrypted);

                int groupAccess = IDS.Web.UI.Models.GroupAccessLevel.GetGroupAccessLevelByMenuCode(Session[Tool.GlobalVariable.SESSION_USER_GROUP_CODE] as string, menuCodeDecrypted);

                if (groupAccess <= 0)
                    Response.Redirect("~/Error/Error403");
                switch (menuCodeDecrypted)
                {
                    case "0301022200000000": //Void Invoice List
                        string judul_ = "Income Statement Actual Vs Budget";
                        this.Page.Title = judul_;
                        this.txtJudul.InnerHtml = judul_;
                        var code_ = Request.Params["ctl00$ContentPlaceHolder1$cboXCode"];
                        var from_ = Request.Params["ctl00$ContentPlaceHolder1$cboXYearFrom"];
                        var to_ = Request.Params["ctl00$ContentPlaceHolder1$cboXYear"];
                        var branch_ = Request.Params["ctl00$ContentPlaceHolder1$cbobranchcode"];

                        rpt.Load(Server.MapPath(@"~/Report/GLReport/CR/Income_StatementActualVsBudget.rpt"));

                        //rpt.SetParameterValue("@pCode", "P1");
                        //rpt.SetParameterValue("@PeriodFrom", "201501");
                        //rpt.SetParameterValue("@PeriodTo", "202001");
                        //rpt.SetParameterValue("@pBranch", "DTN");

                        // CODE
                        if (string.IsNullOrEmpty(code_))
                        {
                            rpt.SetParameterValue("@pCode", "P1");
                        }
                        else
                        {
                            rpt.SetParameterValue("@pCode", code_.ToString());
                        }

                        // FROM
                        if (string.IsNullOrEmpty(from_))
                        {
                            rpt.SetParameterValue("@PeriodFrom", System.DateTime.Now.ToString("yyyyMM"));
                        }
                        else
                        {
                            rpt.SetParameterValue("@PeriodFrom", System.Convert.ToDateTime(from_).ToString("yyyyMM"));
                        }

                        //TO
                        if (string.IsNullOrEmpty(to_))
                        {
                            rpt.SetParameterValue("@PeriodTo", System.DateTime.Now.ToString("yyyyMM"));
                            rpt.DataDefinition.FormulaFields["mn"].Text = "\"" + System.DateTime.Today.ToString("MMM yyyy") + "\"";
                            rpt.DataDefinition.FormulaFields["PrevYears"].Text = "\"" + System.DateTime.Today.ToString("yyyy") + "\"";
                        }
                        else
                        {
                            rpt.SetParameterValue("@PeriodTo", System.Convert.ToDateTime(to_).ToString("yyyyMM"));
                            rpt.DataDefinition.FormulaFields["mn"].Text = "\"" + System.Convert.ToDateTime(to_).ToString("MMM yyyy") + "\"";
                            rpt.DataDefinition.FormulaFields["PrevYears"].Text = "\"" + System.Convert.ToDateTime(to_).ToString("yyyy") + "\"";
                        }

                        //Branch
                        if (string.IsNullOrEmpty(branch_))
                        {
                            rpt.SetParameterValue("@pBranch", Session[IDS.Tool.GlobalVariable.SESSION_USER_BRANCH_CODE].ToString());
                        }
                        else
                        {
                            rpt.SetParameterValue("@pBranch", branch_.ToString());
                        }
                        // rpt.DataDefinition.FormulaFields["PrevYears"].Text = string.IsNullOrEmpty(to_) ? System.DateTime.Now.ToString("yyyyMM") : System.Convert.ToDateTime(to_).ToString("yyyyMM");
                        break;
                    default:
                        break;
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/Error/Error403");
            }
            rptHelper.SetDefaultFormulaField(rpt);
            rptHelper.SetLogOn(rpt);
            CRViewer.EnableDatabaseLogonPrompt = true;
            CRViewer.ReportSource = rpt;
            CRViewer.DataBind();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CRViewer.ToolPanelView = CrystalDecisions.Web.ToolPanelViewType.None;

                cboXYear.Text = System.DateTime.Now.ToString("MMM yyyy");
                cboXYearFrom.Text = System.DateTime.Now.ToString("MMM yyyy");
            }
            else
            {
                //FillBranch();
                //Code_Afcgen();
                //Branchhhh = Request.Params["ctl00$ContentPlaceHolder1$cbobranchcode"].ToString();
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
        }

        public static bool IsvalidDatetime(string datetime)
        {
            bool valid_ = false;
            try
            {
                System.Convert.ToDateTime(datetime);
                valid_ = true;
            }
            catch
            {
                valid_ = false;
            }
            return valid_;
        }

        protected void btnPreview_Click(object sender, EventArgs e)
        {

            CRViewer.ReportSource = rpt;
        }

        private void CreateMsgBox(string msg)
        {
            System.Text.StringBuilder b = new System.Text.StringBuilder();
            b.AppendLine("alert('" + msg + "');");
            string script = b.ToString();
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
        }

        private void FillBranch()
        {
            cbobranchcode.DataSource = Convert.ToBoolean(Session[IDS.Tool.GlobalVariable.SESSION_USER_BRANCH_HO_STATUS]) == true ? IDS.GeneralTable.Branch.GetBranchForDatasource() : IDS.GeneralTable.Branch.GetBranchForDatasource(Session[IDS.Tool.GlobalVariable.SESSION_USER_BRANCH_CODE].ToString());
            cbobranchcode.DataTextField = "Text";
            cbobranchcode.DataValueField = "Value";
            cbobranchcode.DataBind();
            cbobranchcode.SelectedValue = Session[IDS.Tool.GlobalVariable.SESSION_USER_BRANCH_CODE].ToString();
        }
        private void Code_Afcgen()
        {
            cboXCode.DataSource = IDS.GLTable.RptGen.GetRptGenForDatasource();
            cboXCode.DataTextField = "Text";
            cboXCode.DataValueField = "Value";
            cboXCode.DataBind();
        }

        static string ToJSON(object obj)
        {
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            return serializer.Serialize(obj);
        }

    }
}