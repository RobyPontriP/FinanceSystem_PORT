﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="wfRptReceiveSSP.aspx.cs" Inherits="IDS.Web.UI.Report.Sales.wfRptReceiveSSP" MasterPageFile="~/Report/Template/ReportMaster.Master"  %>
<%@Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" 
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content runat="server" ContentPlaceHolderID="StyleSection">
    <link rel="stylesheet" type="text/css" href="<%=ResolveClientUrl("~/Content/Select2/css/select2.min.css")%>" />
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
 
    <section class="content">
    <div class="container-fluid">
        <div class="row">
            <section class="col-lg-12 p-0 connectedSortable">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">
                          <b>SSP Collection</b>
                        </h3>
                    </div>

   

                    <div class="card-body">
                        <div class="tab-content p-0">
                            <div class="row mb-1">
                                <section class="col-lg-12 connectedSortable">
                                    <div class="card">
                                        <div class="card-header ui-sortable-handle" style="cursor: move;">
                                            <h3 class="card-title">
                                               Filter
                                            </h3>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
                                            </div>
                                        </div>

                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <div class="form-group row">
                                                        <label for="cboBranch" class="col-form-label col-form-label-sm col-sm-4">Branch</label>
                                                        <div class="col-sm-7">
                                                           <asp:DropDownList AutoPostBack="false"  ID="cboBranch" runat="server" CssClass="form-control form-control-sm pl-15"></asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-5">
                                                    <div class="form-group row">
                                                        <label for="cboCustomer" class="col-form-label col-form-label-sm col-sm-4">Customer</label>
                                                        <div class="col-sm-7">
                                                            <asp:DropDownList ID="cboCustomer" runat="server" CssClass="form-control form-control-sm select2DDList"></asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                                 <%--<div class="col-sm-3">
                                                    <div class="form-group row mb-1">
                                                          <label for="cboDate" class="col-form-label col-form-label-sm col-sm-3">Date</label>
                                                        <div class="col-sm-8">
                                                             <asp:TextBox ID="cboDate" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>--%>
                                                      <div class="col-sm-3">
                                                    <div class="form-group row">
                                                        <div class="col-sm-8">
                                                             <asp:Button ID="btnExe" runat="server" CssClass="form-control form-control-sm float-right" Width="100px" Text="Print Preview" OnClick="btnPreview_Click"></asp:Button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col-sm-3 ml-4">
                                                    <div class="form-group row mb-1">
                                                          <label for="cboDate" class="col-form-label col-form-label-sm col-sm-3">Date</label>
                                                        <div class="col-sm-8">
                                                             <asp:TextBox ID="cboDate" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>

                                        <%--    <div class="col-sm-9">
                                                <asp:Button ID="btnExe" runat="server" CssClass="form-control form-control-sm float-right" Width="100px" Text="Print Preview" OnClick="btnPreview_Click"></asp:Button>
                                            </div>--%>
                                        </div>
                                    </div>
                                </section>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

											  
																																													  
				  

        </div>
    </div>
</section>
   
  

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
        $(".select2DDList").select2({
            width:"100%",
            theme:"classic"
        });
        $(document).ready(function () {
            flatpickr("#<%=cboDate.ClientID %>", {
                dateFormat: "d/M/Y",
                altFormat: "F Y",
                static: true
            });

        });
    </script>
</asp:Content>




<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="wfRptReceiveSSP.aspx.cs" Inherits="IDS.Web.UI.Report.Sales.wfRptReceiveSSP" MasterPageFile="~/Report/Template/ReportMaster.Master"  %>
<%@Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" 
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content runat="server" ContentPlaceHolderID="StyleSection">
    <link rel="stylesheet" type="text/css" href="<%=ResolveClientUrl("~/Content/Select2/css/select2.min.css")%>" />
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    
    <div class="col-sm-8 col-md-6 col-8">
        <h5>SSP Collection</h5>
    </div>

   

    <div class="card">
    <div class="card-header">
        <h3 class="card-title" style="font-size: 12px;"><b>Filter</b></h3>
        <div class="card-tools">
            <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
        </div>
    </div>

    <div class="card-body">
        <div class="row mb-0">
            <div class="form-group row col-sm-3">
                <label for="cboBranch" class="col-form-label col-form-label-sm col-sm-3">Branch</label>
                <div class="col-sm-9">
                    <asp:DropDownList AutoPostBack="false"  ID="cboBranch" runat="server" CssClass="form-control form-control-sm pl-15"></asp:DropDownList>
                </div>
            </div>

            <div class="form-group row col-sm-3">
                <label for="cboCustomer" class="col-form-label col-form-label-sm col-sm-4">Customer</label>
                <div class="col-sm-8">
                    <asp:DropDownList ID="cboCustomer" runat="server" CssClass="form-control form-control-sm select2DDList"></asp:DropDownList>
                </div>
            </div>

             <div class="form-group row col-sm-2">
                <label for="cboDate" class="col-form-label col-form-label-sm col-sm-3">Date</label>
                <div class="col-sm-8">
                    <asp:TextBox ID="cboDate" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                </div>
            </div>

            <div class="col-sm-4 float-right">
                <asp:Button ID="btnExe" runat="server" CssClass="form-control form-control-sm float-right" Width="100px" Text="Print Preview" OnClick="btnPreview_Click"></asp:Button>
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
        $(".select2DDList").select2();
        $(document).ready(function () {
            flatpickr("#<%=cboDate.ClientID %>", {
                dateFormat: "d/M/Y",
                altFormat: "F Y",
                static: true
            });

        });
    </script>
</asp:Content>

--%>
