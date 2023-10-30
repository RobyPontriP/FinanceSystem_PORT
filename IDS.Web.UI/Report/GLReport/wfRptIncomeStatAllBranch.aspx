﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="wfRptIncomeStatAllBranch.aspx.cs" Inherits="IDS.Web.UI.Report.GLReport.wfRptIncomeStatAllBranch" MasterPageFile="~/Report/Template/ReportMaster.Master" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content runat="server" ContentPlaceHolderID="StyleSection">
        <link rel="stylesheet" type="text/css" href="<%=ResolveClientUrl("~/Content/Select2/css/select2.min.css")%>" />
    </asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">


    <div class="card">
        <div class="card-header">
            <h3 class="card-title" style="font-size: 12px;">Filter</h3>
            <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
            </div>
        </div>

        <div class="card-body">
            <div class="row">
                <div class="col-sm-4">
                    <div class="form-group row mb-2">
                        <asp:Label ID="Label1" runat="server" Text="Code" CssClass="control-label col-sm-3 col-form-label" Font-Bold="true"></asp:Label>
                        <div class="col-sm-4">
                            <asp:DropDownList ID="cboCode" runat="server" CssClass="form-control form-control-sm select2DDList"></asp:DropDownList>
                        </div>
                    </div>
                </div>

                <div class="col-sm-4">
                    <div class="form-group row mb-2">
                        <asp:Label ID="Label2" runat="server" Text="Period" CssClass="control-label col-sm-3 col-form-label" Font-Bold="true"></asp:Label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="txtDtpPeriod" runat="server" CssClass="form-control form-control-sm bg-white"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="col-sm-4">
                    <div class="form-group row mb-2" style="justify-content: flex-end">
                        <div class="col-sm-4">
                            <asp:Button runat="server" ID="btnPreview" Text="Preview" CausesValidation="false" ToolTip="Preview Report"
                                CssClass="form-control form-control-sm btn btn-sm btn-default" OnClick="btnPreview_Click"/>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="CRReportViewer">
        <CR:CrystalReportViewer runat="server" ID="CRViewer"
            AutoDataBind="true"
            EnableDatabaseLogonPrompt="false"
            DisplayToolbar="True"
            HasToggleGroupTreeButton="False"
            BestFitPage="False"
            ToolPanelView="None"
            ReuseParameterValuesOnRefresh="True"
            HasCrystalLogo="True"
            Width="100%" />
    </div>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="ScriptSection">
<script type="text/javascript" src="<%=ResolveClientUrl("~/Scripts/moment.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveClientUrl("~/Content/flatpickr/flatpickr.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveClientUrl("~/Content/flatpickr/id.min.js") %>"></script>
    <link rel="stylesheet" type="text/css" href="<%=ResolveClientUrl("~/Content/flatpickr/flatpickr.min.css")%>" />
    <link rel="stylesheet" type="text/css" href="<%=ResolveClientUrl("~/Content/flatpickr/plugins/monthSelect/style.css")%>" />
    <script type="text/javascript" src="<%=ResolveClientUrl("~/Content/flatpickr/plugins/monthSelect/Index.js") %>"></script>
     <script type="text/javascript" src="<%=ResolveClientUrl("~/Content/Select2/js/select2.full.min.js") %>"></script>

    <script type="text/javascript">
        const monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
        ];
        var curDate = monthNames[new Date().getMonth()] + " " + new Date().getFullYear();

        $(document).ready(function () {

            $(".select2DDList").select2({ width: "100%", theme: "classic" });

            if ($("#<%=txtDtpPeriod.ClientID %>").val() != '') {
                curDate = $("#<%=txtDtpPeriod.ClientID %>").val();
            }

            flatpickr("#<%=txtDtpPeriod.ClientID %>", {
                //shorthand: true,
                dateFormat: "M/Y",
                altFormat: "F Y",
                defaultDate: [curDate],
                static: true,
                disableMobile: true,
                plugins: [new monthSelectPlugin({
                    shorthand: true, //defaults to false
                    dateFormat: "M Y", //defaults to "F Y"
                    altFormat: "F Y"
                })],
            });

            $("#<%=txtDtpPeriod.ClientID %>").change(function () {
                curDate = $("#<%=txtDtpPeriod.ClientID %>").val();
            });
        });
    </script>
</asp:Content>



