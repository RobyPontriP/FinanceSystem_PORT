﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="wfRptTransByAccCashBasis.aspx.cs" Inherits="IDS.Web.UI.Report.GLReport.wfRptTransByAccCashBasis" MasterPageFile="~/Report/Template/ReportMaster.Master" EnableEventValidation="false" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content runat="server" ContentPlaceHolderID="StyleSection">
        <link rel="stylesheet" type="text/css" href="<%=ResolveClientUrl("~/Content/Select2/css/select2.min.css")%>" />
    <link rel="stylesheet" type="text/css" href="<%=ResolveClientUrl("~/Content/flatpickr/flatpickr.min.css")%>" />
    <link rel="stylesheet" type="text/css" href="<%=ResolveClientUrl("~/Content/flatpickr/plugins/monthSelect/style.css")%>" />
    </asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <h4>
        <asp:Label ID="lblTitle" runat="server" >Transaction Listing By Account Cash Basis Report</asp:Label>
    </h4>

    <asp:ScriptManager runat="server" ID="scr1"></asp:ScriptManager>

    <div class="card">
        <div class="card-header">
            <h3 class="card-title" style="font-size: 12px;">Filter</h3>
            <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
            </div>
        </div>

        <div class="card-body">
             <div class="row mb-1">
                  <div class="col-sm-6">
                    <div class="form-group row mb-2">
                        <asp:Label ID="Label1" runat="server" Text="Branch" CssClass="control-label col-sm-3 col-form-label" Font-Bold="true"></asp:Label>
                        <div class="col-sm-8">
                            <asp:DropDownList ID="cboBranch" runat="server" CssClass="form-control select2DDList"></asp:DropDownList>
                        </div>
                    </div>
                </div>

                  <div class="col-sm-6">
                    <div class="form-group row mb-2" style="justify-content: flex-end">
                        <div class="col-sm-4">
                            <asp:Button runat="server" ID="btnPreview" Text="Preview" CausesValidation="false" ToolTip="Preview Report"
                                CssClass="form-control form-control-sm btn btn-sm btn-default" OnClick="btnPreview_Click" />
                        </div>
                    </div>
                </div>
             </div>


            <div class="row mb-1">
                <div class="col-sm-6">
                    <div class="form-group row mb-2">
                        <asp:Label ID="Label6" runat="server" Text="ACC From" CssClass="control-label col-sm-3 col-form-label" Font-Bold="true"></asp:Label>
                        <div class="col-sm-8">
                            <asp:DropDownList ID="cboAccFrom" runat="server" CssClass="form-control select2DDList"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group row mb-2">
                        <asp:Label ID="Label7" runat="server" Text="ACC To" CssClass="control-label col-sm-3 col-form-label" Font-Bold="true"></asp:Label>
                        <div class="col-sm-8">
                            <asp:DropDownList ID="cboAccTo" runat="server" CssClass="form-control select2DDList"></asp:DropDownList>
                        </div>
                    </div>
                </div>

                <div class="col-sm-6">
                    <div class="form-group row mb-2">
                        <asp:Label ID="Label2" runat="server" Text="Date From" CssClass="control-label col-sm-3 col-form-label" Font-Bold="true"></asp:Label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtDtpFrom" runat="server" CssClass="form-control form-control-sm bg-white"></asp:TextBox>
                        </div>
                    </div>
                     <div class="form-group row mb-2">
                        <asp:Label ID="Label3" runat="server" Text="Date To" CssClass="control-label col-sm-3 col-form-label" Font-Bold="true"></asp:Label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtDtpTo" runat="server" CssClass="form-control form-control-sm bg-white"></asp:TextBox>
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
    <script type="text/javascript" src="<%=ResolveClientUrl("~/Content/Select2/js/select2.full.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveClientUrl("~/Content/flatpickr/plugins/monthSelect/Index.js") %>"></script>

    <script type="text/javascript">
        const monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
        ];

        var curDateFrom = "01-" + monthNames[new Date().getMonth()] + "-" + new Date().getFullYear();
        var curDateTo = new Date().getDate() + "-" + monthNames[new Date().getMonth()] + "-" + new Date().getFullYear();

        $(document).ready(function () {
            $(".select2DDList").select2({width:"100%",theme:"classic"});

            var cboAccFrom = $('cboAccFrom');
            var cboAccTo = $('cboAccTo');

            if ($("#<%=txtDtpFrom.ClientID %>").val() != '') {
                curDateFrom = $("#<%=txtDtpFrom.ClientID %>").val();
            }

            if ($("#<%=txtDtpTo.ClientID %>").val() != '') {
                curDateTo = $("#<%=txtDtpTo.ClientID %>").val();
            }

            flatpickr("#<%=txtDtpFrom.ClientID %>", {
                dateFormat: "d/M/Y",
                defaultDate: [curDateFrom],
                static: true,
                disableMobile: true,
            });

            flatpickr("#<%=txtDtpTo.ClientID %>", {
                dateFormat: "d/M/Y",
                defaultDate: [curDateTo],
                static: true,
                disableMobile: true,
            });

            $("#<%=txtDtpFrom.ClientID %>").change(function () {
                var dtpTo = new Date($("#<%=txtDtpTo.ClientID %>").val());
                var dtpFrom = new Date($("#<%=txtDtpFrom.ClientID %>").val());
                if (dtpTo < dtpFrom) {
                    alert('From Period cannot less then To Period');
                    $("#<%=txtDtpFrom.ClientID %>").val($("#<%=txtDtpTo.ClientID %>").val());
                    return;
                }

                curDateFrom = $("#<%=txtDtpTo.ClientID %>").val();
            });

            $("#<%=txtDtpTo.ClientID %>").change(function () {
                var dtpTo = new Date($("#<%=txtDtpTo.ClientID %>").val());
                var dtpFrom = new Date($("#<%=txtDtpFrom.ClientID %>").val());
                if (dtpTo < dtpFrom) {
                    alert('From Period cannot less then To Period');
                    $("#<%=txtDtpTo.ClientID %>").val($("#<%=txtDtpFrom.ClientID %>").val());
                    return;
                }

                curDateTo = $("#<%=txtDtpTo.ClientID %>").val();
            });

            function FillAcc() {
                $.ajax({
                    type: "POST",
                    url: "<%=new System.Web.Mvc.UrlHelper(this.Request.RequestContext).Action("GetCOAForDataSource","ChartOfAccount",new { Area="GLTable"}) %>",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (respond) {
                        $.each(respond, function (i, item) {
                            $("#<%=cboAccFrom.ClientID %>").append('<option value = "' + item.Value + '">' + item.Text + '</option>');
                            $("#<%=cboAccTo.ClientID %>").append('<option value = "' + item.Value + '">' + item.Text + '</option>');
                        });
                    },
                    error: function (xhr, test, response,aas) {
                    }
                });
            }

            $("#<%=btnPreview.ClientID %>").click(function () {
            });
        });
    </script>
</asp:Content>


