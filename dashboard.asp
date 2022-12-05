<!--#include file="connection.asp"-->
<!-- #include file='updateHrdlog.asp' -->

<% 


'get data karyawan aktiF
    set kryaktif_cmd =server.createobject("ADODB.Command")
    kryaktif_cmd.ActiveConnection = MM_cargo_STRING'

    kryaktif_cmd.commandText = "SELECT COUNT(Kry_AktifYN) AS totalkry FROM HRD_M_Karyawan WHERE kry_AktifYN='Y' "
    set kryaktif = kryaktif_cmd.execute

'get data karyawan resign
    set krynonaktif_cmd =server.createobject("ADODB.Command")
    krynonaktif_cmd.ActiveConnection = MM_cargo_STRING

    krynonaktif_cmd.commandText="SELECT COUNT(kry_AktifYN) AS tkrynonaktif FROM HRD_M_Karyawan WHERE kry_AktifYN='Y' AND YEAR(Kry_TglKeluar)=YEAR('"&Now&"')"
    ' response.write krynonaktif_cmd.commandText
    set krynonaktif = krynonaktif_cmd.execute

'get data karyawan baru
    set krybarumasuk_cmd =server.createobject("ADODB.Command")
    krybarumasuk_cmd.ActiveConnection = MM_cargo_STRING'

    krybarumasuk_cmd.commandText = "SELECT COUNT(Kry_TglMasuk) AS totalkrybaru FROM HRD_M_Karyawan WHERE Kry_TglMasuk IS NOT NULL AND Kry_TglMasuk != '' AND Kry_TglMasuk >= '"&Year(now)&"'"
    set krybaru = krybarumasuk_cmd.execute
	
	
set karyawan_cmd = Server.CreateObject("ADODB.Command")
karyawan_cmd.activeConnection = mm_cargo_string
set mutasi_cmd = Server.CreateObject("ADODB.Command")
mutasi_cmd.activeConnection = mm_cargo_string

set updateMutasi = Server.CreateObject("ADODB.Command")
updateMutasi.activeConnection = mm_cargo_string

mutasi_cmd.commandText = "SELECT * FROM HRD_T_Mutasi WHERE (Mut_ExecutedYN = 'N' OR Mut_ExecutedYN = '') AND Mut_Tanggal <= '" & Month(now()) &"/"& day(now()) &"/"& Year(now()) &"' AND Mut_AktifYN = 'Y' ORDER BY Mut_Tanggal DESC"
' Response.Write mutasi_cmd.commandText & "<br>"
set mutasi = mutasi_cmd.execute

do while not mutasi.eof
    karyawan_cmd.commandText = "UPDATE HRD_M_Karyawan SET Kry_AgenID = '"& mutasi("Mut_TujAgenID") &"', Kry_DDBID = '"& mutasi("Mut_TujDDBID") &"', Kry_JabCode = '"& mutasi("Mut_TujJabCode") &"', Kry_JJID = '"& mutasi("Mut_TujJJID") &"' WHERE Kry_Nip = '"& mutasi("Mut_Nip") &"'"
    ' Response.Write karyawan.commandText & "<br>"
    karyawan_cmd.execute
    
    updateMutasi.commandText = "UPDATE HRD_T_MUTASI SET Mut_ExecutedYN = 'Y' WHERE Mut_ID = '"& mutasi("Mut_ID") &"'"
    updateMutasi.execute 

    ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
    browser = Request.ServerVariables("http_user_agent")
    dateTime = now()
    eventt = "AUTO EXECUTE"
    key = mutasi("Mut_ID")
    url = ""

    keterangan = "UPDATE MUTASI NOMOR "& mutasi("Mut_ID") & " UNTUK NIP KARYAWAN "& mutasi("Mut_Nip")
    call updateLog(eventt,url,key,"SYSTEM",session("server-id"),dateTime,ip,browser,keterangan) 
mutasi.movenext
loop  

%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="<%= url %>/hrd/css/bootstrap.min.css" rel="stylesheet">
     <link rel="preconnect" href="https://fonts.gstatic.com">
     <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300&family=Poppins:wght@900&display=swap" rel="stylesheet">
     <link rel="preconnect" href="https://fonts.gstatic.com">
     <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300&family=Poppins:wght@200&display=swap" rel="stylesheet">
     <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
     <link rel="stylesheet" href="https://www.w3schools.com/lib/w3-colors-2021.css">
     <script src="https://kit.fontawesome.com/12b382af44.js" crossorigin="anonymous"></script>
    <!-- landing html baru -->
    <link rel="stylesheet" href="<%= url %>/layout/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%= url %>/layout/font-awesome/less/icons.less">
    <!-- mycss -->
    <link rel="stylesheet" type="text/css" href="<%= url %>/css/style.css" >
    <!--sweetalert -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="db.css">
    <!-- Essential JS 2 Calendar's dependent material theme -->
    <link href="https://cdn.syncfusion.com/ej2/ej2-base/styles/material.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.syncfusion.com/ej2/ej2-buttons/styles/material.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.syncfusion.com/ej2/ej2-calendars/styles/material.css"rel="stylesheet"type="text/css"/>
    <!-- Fontawesome CSS -->
    
    <!-- Essential JS 2 all script -->
    <!-- <script src="https://cdn.syncfusion.com/ej2/dist/ej2.min.js" type="text/javascript"></script> -->

    <!-- Essential JS 2 Calendar's dependent scripts -->
    <script src="https://cdn.syncfusion.com/ej2/ej2-base/dist/global/ej2-base.min.js"type="text/javascript"></script>
    <script src="https://cdn.syncfusion.com/ej2/ej2-inputs/dist/global/ej2-inputs.min.js"type="text/javascript"></script>
    <script src="https://cdn.syncfusion.com/ej2/ej2-buttons/dist/global/ej2-buttons.min.js"type="text/javascript"></script>
    <script src="https://cdn.syncfusion.com/ej2/ej2-lists/dist/global/ej2-lists.min.js"type="text/javascript"></script>
    <script src="https://cdn.syncfusion.com/ej2/ej2-popups/dist/global/ej2-popups.min.js"type="text/javascript"></script>
    <script src="https://cdn.syncfusion.com/ej2/ej2-calendars/dist/global/ej2-calendars.min.js"type="text/javascript"></script>
    

    <title>DASHBOARD</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js" type="text/javascript"></script>
    <script>
        $('.menu').click (function(){
        $(this).toggleClass('open');
        });
    </script>
    
<style>
    #headnya{
        flex: 0 0 100%;
        max-width: 100%;
        position: static;
        background-color:#EFF0F4;
        margin-top:-8px;
        height:53px;
    }
    body {
    font-family: "Lato", sans-serif;
    }
    .sidebar {
    height: 100%;
    width: -50px !important;
    position: fixed;
    z-index: 1;
    top: 0;
    left: 0;
    background-color: rgba(0, 0, 0, 0.87);
    overflow-x: hidden;
    transition: 0.5s;
    padding-top: 10px;
    }
    .sidebar a {
    text-decoration: none;
    font-size:15px;
    color: #9a9a9a;
    transition: 0.3s;
    padding:8px 20px 10px;
    }
    .sidebar a:hover {
    color: white;
    }
    .sidebar .closebtn {
    position: absolute;
    top: 0;
    right: 25px;
    font-size: 36px;
    margin-left: 80px;
    }
    .openbtn {
    font-size: 12px;
    cursor: pointer;
    background-color: transparent;
    color: #7272cf;
    padding: 2px 15px;
    border: none;
    margin-right:20rem;
    margin-left:-21px;
    }
    .openbtn:hover {
    background-color: none ;
    }
    #mySidebar{
        width:4rem;
    }
    #main {
    transition: margin-left .5s;
    padding: 16px;
    margin-left: 55px;
    }
    .ico{
    max-width:29px;
    margin-top:4px;
    margin-Left:-6px;
    position :absolute;
    }
    .input#ckbox:hover{
        background-color: white ;
    }
    #menu1{
        display:none;
    }
    input#ckbox {
                width: 30px;
                height: 30px;
                cursor: pointer;
                color:black;
                -webkit-appearance: none;
                -moz-appearance: none;
                appearance: none;
                border: none;
                position: relative;
                left: 12px;
                top: 1px;
                background-color:transparent;
            }

    /*untuk input */
    .card-header{
        background-color:#0015a7;
        color:white;
        text-align:center;
    } 
    .card-body{
        padding:2.25px;
        font-size:25px;
        text-align :center;
        color:#6a6d88;
        margin-top:7px;
    }
    .card-footer{
        background-color:black;
        color:white;
    }
    #hasil7{
            background-color: transparent;
            border: none;
            color:blue;
            box-shadow: none;
        }
    #total{
        font-size:xx-large;
        text-align:center;
        margin-left:-4px;
        margin-top:16px;
        background-color:transparent;
        border:none;
        box-shadow:none;
    }
    #cardb{
        background-color: #B9C8E4;
        text-align:center;
    }
    #stts{
        margin-top:10px;
        
    }
    #cardb:hover{
        -ms-transform: scale(0.9); /* IE 9 */
        -webkit-transform: scale(0.9); /* Safari 3-8 */
        transform: scale(0.9); 
    }

    .card-bodyp{
        margin-left:30px;
        margin-top:6px;
    }

    @media screen and (min-width:200px){
        /* chart pie  */
        #myChart{
        display:fixed;
        width:100%;
    }
    }

    /* css Calender */
    /* On smaller screens, where height is less than 450px, change the style of the sidenav (less padding and a smaller font size) */
    @media screen and (max-height: 1200px) {
    .sidebar {padding-top: 15px;}
    .sidebar a {font-size: 15px;margin-left:5px;}
    }
    @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@100;200;300;400;500;600;700&display=swap');
    :root {
        --calendar-bg-color: #101725;
        --calendar-font-color: #FFF;
        --weekdays-border-bottom-color: ;
        --calendar-date-hover-color: #505050;
        --calendar-current-date-color: linear-gradient(to bottom, rgba(0, 0, 0, 0.87), #2196f3);
        --calendar-today-color: linear-gradient(to bottom, rgba(0, 0, 0, 0.87), #2196f3);
        --calendar-today-innerborder-color: transparent;
        --calendar-nextprev-bg-color: transparent;
        --next-prev-arrow-color : #FFF;
        --calendar-border-radius: 12px;
        --calendar-prevnext-date-color: #484848
    }

    * {
        padding: 0;
        margin: 0;
    }
    .calendar {
        font-family: 'IBM Plex Sans', sans-serif;
        position: relative;
        max-width: 300; /*change as per your design need */
        min-width: 200px;
        background: var(--calendar-bg-color);
        color: var(--calendar-font-color);
        margin: 20px auto;
        box-sizing: border-box;
        overflow: hidden;
        font-weight: normal;
        border-radius: var(--calendar-border-radius);
        display:fixed;
    }
    .calendar-inner {
        padding: -3px 10px;
    }
    .calendar .calendar-inner .calendar-body {
        display: grid;
        grid-template-columns: repeat(7, 1fr);
        text-align: center;
        font-size:10px;
    }
    .calendar .calendar-inner .calendar-body div {
        padding: 0px;
        min-height: 22px;
        line-height: 30px;
        border: 1px solid transparent;
        margin: -15px -1px 0px;
    }
    .calendar .calendar-inner .calendar-body div:nth-child(-n+7) {
        border: 1px solid transparent;
        /* border-bottom: 1px solid var(--weekdays-border-bottom-color); */
        margin-top:0px;
    }
    .calendar .calendar-inner .calendar-body div:nth-child(-n+7):hover {
        border: 1px solid transparent;
        /* border-bottom: 1px solid var(--weekdays-border-bottom-color);*/
    }
    .calendar .calendar-inner .calendar-body div>a {
        color: var(--calendar-font-color);
        text-decoration: none;
        display: flex;
        justify-content: center;
    }
    .calendar .calendar-inner .calendar-body div:hover {
        border: 1px solid var(--calendar-date-hover-color);
        border-radius: 4px;
    }
    .calendar .calendar-inner .calendar-body div.empty-dates:hover {
        border: 1px solid transparent;
    }
    .calendar .calendar-inner .calendar-controls {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
    }
    .calendar .calendar-inner .calendar-today-date {
        display: grid;
        text-align: center;
        cursor: pointer;
        margin: 0px 0px;
        background: var(--calendar-current-date-color);
        padding: 4px 0px;
        border-radius: 10px;
        width: 80%;
        margin: auto;
        margin-top:-13px;
        font-size:9px;
    }
    .calendar .calendar-inner .calendar-controls .calendar-year-month {
        display: flex;
        min-width: 100px;
        justify-content: space-evenly;
        align-items: center;
        margin-top:-2px;
    }
    .calendar .calendar-inner .calendar-controls .calendar-next {
        text-align: right;
    }
    .calendar .calendar-inner .calendar-controls .calendar-year-month .calendar-year-label,
    .calendar .calendar-inner .calendar-controls .calendar-year-month .calendar-month-label {
        font-weight: 200;
        font-size: 12;
    }
    .calendar .calendar-inner .calendar-body .calendar-today {
        background: var(--calendar-today-color);
        border-radius: 50px;
        
    }
    .calendar .calendar-inner .calendar-body .calendar-today:hover {
        border: 1px solid transparent;
    }
    .calendar .calendar-inner .calendar-body .calendar-today a {
        outline: 2px solid var(--calendar-today-innerborder-color);
    }
    .calendar .calendar-inner .calendar-controls .calendar-next a,
    .calendar .calendar-inner .calendar-controls .calendar-prev a {
        color: var(--calendar-font-color);
        font-family: arial, consolas, sans-serif;
        font-size: 11px;
        text-decoration: none;
        padding: 4px 12px;
        display: inline-block;
        background: var(--calendar-nextprev-bg-color);
        margin: 10px 0 10px 0;
    }
    .calendar .calendar-inner .calendar-controls .calendar-next a svg,
    .calendar .calendar-inner .calendar-controls .calendar-prev a svg {
        height: 15px;
        width: 15px;
    }
    .calendar .calendar-inner .calendar-controls .calendar-next a svg path,
    .calendar .calendar-inner .calendar-controls .calendar-prev a svg path{
        fill: var(--next-prev-arrow-color);
    }
    .calendar .calendar-inner .calendar-body .prev-dates,
    .calendar .calendar-inner .calendar-body .next-dates {
        color: var(--calendar-prevnext-date-color);
    }
    .calendar .calendar-inner .calendar-body .prev-dates:hover,
    .calendar .calendar-inner .calendar-body .next-dates:hover {
    border: 1px solid transparent;
    pointer-events: none;
    }

    /* scss scroll */
    /* width */
    ::-webkit-scrollbar {
    width: 4px;
    }
    /* Track */
    ::-webkit-scrollbar-track {
    background: #f1f1f1; 
    }
    /* Handle */
    ::-webkit-scrollbar-thumb {
    background: #a4abb7; 
    }

    /* Handle on hover */
    ::-webkit-scrollbar-thumb:hover {
    background: #555; 
}
@media screen and (min-width: 1200px) {
    #hay{
        position:absolute;
    }
    .logout{
        position:absolute;
    }
}

/* Full-width input fields */
input[type=text], input[type=password] {
  width: 100%;
  padding: 5px 4px;
  margin: -3px 0;
  display: inline-block;
  border: 1px solid #ccc;
  box-sizing: border-box;
}

/* Set a style for all buttons */
/* Extra styles for the cancel button */
.cancelbtn {
  width: auto;
  padding: 10px 18px;
  background-color: #f44336;
}

/* Center the image and position the close button */
.imgcontainer {
  text-align: center;
  margin: 24px 0 12px 0;
  position: relative;
}

img.avatar {
  width: 40%;
  border-radius: 50%;
}

.container {
  padding: 10px;
}

span.psw {
  float: right;
  padding-top: 16px;
}

/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
  padding-top: 60px;
}

/* Modal Content/Box */
.modal-content {
  background-color: #fefefe;
  margin: 10% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
  border: 1px solid #888;
  width: 16%; /* Could be more or less, depending on screen size */
}

/* The Close Button (x) */
.close {
  position: absolute;
  right: 12px;
  top: -15px;
  color: #000;
  font-size: 35px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: red;
  cursor: pointer;
}

/* Add Zoom Animation */
.animate {
  -webkit-animation: animatezoom 0.6s;
  animation: animatezoom 0.6s
}

@-webkit-keyframes animatezoom {
  from {-webkit-transform: scale(0)} 
  to {-webkit-transform: scale(1)}
}
  
@keyframes animatezoom {
  from {transform: scale(0)} 
  to {transform: scale(1)}
}

/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
  span.psw {
     display: block;
     float: none;
  }
  .cancelbtn {
     width: 100%;
  }
}
/* dropbtn */
.dropbtn {
  background-color: transparent;
  color: black;
  padding: 16px;
  font-size: 16px;
  border: none;
  cursor: pointer;
}

.dropdown {
  position: relative;
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f9f9f9;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown-content a:hover {background-color: #f1f1f1}

.dropdown:hover .dropdown-content {
  display: block;
}

.dropdown:hover .dropbtn {
  background-color: transparent;
}



</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
</head>
<body onload="selisihhari()">
    <div class="header">
        <div class="row align-items-center">
            <div class="col-lg-12 col-md-2 col-sm-2 col-3" id="headnya">
                <div class="col-lg-11 col-md-2 col-sm-12 col-10  d-flex flex-row-end">
                    <img src="<%=url%>/logo/landing.png" id="imgd" width="163" height="49" class="logo-db" >
                </div>
                <div class="col-lg-11 col-md-12 col-sm-12 col-12  d-flex flex-row-reverse">
                    <span style="color:#080C13;font-size:16px;z-index:5;margin-top:-37px;margin-left:-30px;width:auto;margin-left:20px;font-weight:lighter;">Hai,  <%=session("username")%></span>
                </div>
                <!--<div class="col-lg-12 col-md-6 col-sm-4 col-12  d-flex flex-row-reverse">
                    <div class="dropdown" style="float:left;margin-top:-60px;margin-right:-12px;">
                        <button class="dropbtn"><img src="<%=url%>/logo/uset.png" style="width:85%;margin-top:4px;"></button>
                        <div class="dropdown-content" style="margin-top:-6px;margin-left:-85px;">
                            <a href="gantipassword.asp?username=<%= session("username") %>&serverid=<%= session("server-id") %>"><img src="<%=url%>/logo/cp.png" style="width:17px;">&nbsp Change password</a>
                            <a href="<%=url%>/logout.asp"><img src="<%=url%>/logo/lo.png" style="width:17px;">&nbsp Log Out</a>
                        </div>
                    </div>
                </div>-->
            </div>
        </div>
    </div>
    <!--accordion-->
    <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
        <div class="accordion-body">
            <button type="button" class="btn" name="dashboard">Dashboard</button>
            <button type="button" class="btn" name="dashboard">Master Data</button>
            <button type="button" class="btn" name="dashboard">Employee</button>
            <button type="button" class="btn" name="dashboard">Transaction</button>
            <button type="button" class="btn" name="dashboard">Payroll</button>
            <button type="button" class="btn" name="dashboard">Report</button>
            <button type="button" class="btn" name="dashboard">Periodic</button>
            <button type="button" class="btn" name="dashboard">System Log</button>
        </div>
    </div>
    <!--end accordion-->
    <div id="mySidebar" class="sidebar"  style="margin-top: 3rem;overflow-y:hidden;" >
        <div class="row mt-1 side" style=" padding:2px 20px" >
            <div class="col-9 align-items-center">
                <img src = "<%=url%>/logo/iconm.png" class="ico">
                <input class="form-check-input"  type="checkbox" onclick="cknavbar()" id="ckbox" >
            <div class="row mt  side" style=" padding:2px 20px" >
                <span class="text-center" style="font-size: 30px"><i class="fa-sharp fa-solid fa-magnifying-glass-chart fa-2xs	" onclick="openNav()" ></i></span>
            <div class="col-9 align-items-center">
                <button id="menu1" class="dropdown-btn"  onclick="window.location.href='dashboard.asp'" >Dashboard</button>
            </div>
        </div>
        <div class="row side" style=" padding:2px 20px">
            <span class="text-center" style="font-size: 30px"><i class="fa-solid fa-folder-open fa-2xs" onclick="openNav()"></i></span>
            <div class="col-9 align-items-center">
                <button id="menu9" class="dropdown-btn" style="display:none;">Master Data</button>
                <div id="DropCNTT" class="DropCNTT dropdown-container" style="display:none">
                <%if session("HA1") = true OR session("HA3") = true OR session("HA4") = true OR session("HA5") = true OR session("HA6") = true OR session("HL4") = true then%>
                    <% if session("HA1") = true then %>
                    <a href="<%=url%>/index.asp" > Master Karyawan</a><br>
                    <% end if %> 
                    <% if session("HA3")=true then %>
                    <a href="<%=url%>/masterShift" > Master Shift</a><br> 
                    <% end if %> 
                    <% if session("HA4")=true then %>                                        
                        <a href="<%=url%>/divisi" > Divisi</a><br>
                    <% end if %>  
                    <% if session("HA5")=true then %>                                          
                        <a href="<%=url%>/jenjang" > Jenjang</a><br> 
                    <% end if %>
                    <% if session("HA6")=true then %>                                            
                        <a href="<%=url%>/jabatan" > Jabatan</a><br>
                    <% end if %>                                            
                    <% if session("HL4")=true then %>
                        <a href="<%=url%>/bpjs" aria-hidden="true" >  BPJS</a><br>
                    <% end if %>  
                <% else %>
                    <span class="hakakses" style="padding:20px;margin-top:50px;margin-bottom:50px;color:#304771;">Tidak Memiliki Akses</span>
                <% end if %>
                </div>
            </div>
        </div>
        <div class="row side" style=" padding:2px 20px">
                <span class="text-center" style="font-size: 30px"><i class="fa-sharp fa-solid fa-address-card fa-2xs" onclick="openNav()"></i></span>
            <div class="col-9 align-items-center">
                <button id="menu+" class="dropdown-btn" style="display:none;" >Employee </button>
                <div id="DropCNTT" class="DropCNTT dropdown-container" style="display:none">
                    <%if session("HA2") = true OR session("HL5") = true OR session("HL3") = true then%>    
                        <% if session("HA2")=true then %>
                            <a href="<%=url%>/shift_view.asp" > Shift Karyawan</a><br>
                        <% end if %>
                        <% if session("HL5") then %>
                            <a href="<%=url%>/forms" > Status Karyawan</a><br>
                        <% end if %>
                        <% if session("HL3")=true then %>
                            <a href="<%=url%>/approve" > Cuti Izin Sakit</a><br>
                        <% end if %>
                    <% else %>
                        <span class="hakakses" style="padding:20px;margin-top:50px;margin-bottom:50px;color:#304771;">Tidak Memiliki Akses</span>
                    <% end if %>
                </div>
            </div>
        </div>
        <div class="row side" style=" padding:2px 20px">
                <span class="text-center" style="font-size: 30px"><i class="fa-solid fa-comment-dollar fa-2xs" onclick="openNav()"></i></span>
            <div class="col-9 align-items-center">
                <button id="menu2" class="dropdown-btn" style="display:none;" >Transaction </button>   
                <div id="DropCNTT" class="DropCNTT dropdown-container" style="display:none;">
                    <%if session("HT1") = true OR session("HT2") = true OR session("HT3") = true OR session("HT4") = true then%>
                        <% if session("HT1")=true then %>
                            <a href="<%=url%>/transaksi/klaim">Klaim Pinjaman</a><br>
                        <% end if %>
                        <% if session("HT2")=true then %>
                            <a href="<%=url%>/transaksi/elektro">Pinjaman Elektronik</a><br>
                        <% end if %>
                        <% if session("HT3")=true then %>
                            <a href="<%=url%>/transaksi/bank">Pinjaman Bank</a><br>
                        <% end if %>
                        <% if session("HT4")=true then %>
                            <a href="<%=url%>/transaksi/personal">Pinjaman Pribadi</a><br>
                        <% end if %>
                    <% else %>
                        <span class="hakakses" style="padding:20px;margin-top:50px;margin-bottom:50px;color:#304771;">Tidak Memiliki Akses</span>
                    <% end if %>
                </div>
            </div>
        </div>
        <div class="row  side" style=" padding:2px 20px">
                <span class="text-center" style="font-size: 30px"><i class="fa-solid fa-hand-holding-dollar fa-2xs" onclick="openNav()"></i></span>
            <div class="col-9 align-items-center">
                <button  id="menu3" class="dropdown-btn" style="display:none;" aria-hidden="true" >Payroll </button>
                <div id="DropCNTT" class="DropCNTT dropdown-container"style="display:none">
                    <% if session("HL7")=true then %>    
                        <a href="<%=url%>/vpass_gajiAll.asp" aria-hidden="true" > Gaji Karyawan</a><br> 
                    <% else %>
                        <span class="hakakses" style="padding:20px;margin-top:50px;margin-bottom:50px;color:#304771;">Tidak Memiliki Akses</span>
                    <% end if %>
                </div>
            </div>          
        </div>
        <div class="row  side" style=" padding:2px 20px">
                <span class="text-center" style="font-size: 30px"><i class="fa-solid fa-chart-line fa-2xs" onclick="openNav()"></i></span>
            <div class="col-9 align-items-center">
                <button  id="menu0" class="dropdown-btn" style="display:none;" aria-hidden="true" >Report </button>
                <div id="DropCNTT" class="DropCNTT dropdown-container"style="display:none">
                    <% if session("HL2")=true OR session("HL1") = true then %>
                        <% if session("HL2")=true then %>
                            <a href="<%=url%>/lapoabsensi.asp" aria-hidden="true" > Laporan Absensi</a><br>
                        <% end if %>
                        <% if session("HL1")=true then %>
                            <a href="<%=url%>/laporan"  aria-hidden="true"> Laporan Lainnya</a><br>
                        <% end if %>
                    <% else %>
                        <span class="hakakses" style="padding:20px;margin-top:50px;margin-bottom:50px;color:#304771;">Tidak Memiliki Akses</span>
                    <% end if %>
                </div>
            </div>
        </div>
        <div class="row  side" style=" padding:2px 20px">
                <span class="text-center" style="font-size: 30px"><i class="fa-sharp fa-solid fa-calendar-week fa-2xs" onclick="openNav()"></i></span>
            <div class="col-9 align-items-center">
                <button  id="menu4" class="dropdown-btn" style="display:none;" aria-hidden="true" >Periodic </button>
                <div id="DropCNTT" class="DropCNTT dropdown-container"style="display:none">
                    <% if session("HL8")=true then %>
                        <a href="<%=url%>/liburpirodik/index.asp" aria-hidden="true" > Libur Periodik</a><br>
                    <% else %>
                        <span class="hakakses" style="padding:20px;margin-top:50px;margin-bottom:50px;color:#304771;">Tidak Memiliki Akses</span>
                    <% end if %>
                </div>
            </div>
        </div>
        <div class="row  side" style=" padding:2px 20px">
            <span class="text-center" style="font-size: 30px">
            <i class="fa-solid fa-clock-rotate-left fa-2xs" onclick="openNav()"></i></span>
            <div class="col-9 align-items-center ">
                <button  id="menu5" class="dropdown-btn" style="display:none;" aria-hidden="true">System Log</button>
                <div id="DropCNTT" class="DropCNTT dropdown-container" style="display:none">
                    <% if session("HL9")=true then %>
                        <a href="<%=url%>/forms/log.asp" > Lihat Log System</a><br>
                    <% else %>
                        <span class="hakakses" style="padding:20px;margin-top:50px;margin-bottom:50px;color:#304771;">Tidak Memiliki Akses</span>
                    <% end if %>
                </div>
            </div> 
        </div>  
        <div class="row  side" style=" padding:2px 20px">
            <span class="text-center" style="font-size: 30px">
            <i class="fa-solid fa-user-gear fa-2xs" onclick="openNav()"></i></span>
            <div class="col-9 align-items-center ">
                <button  id="menuu" class="dropdown-btn" style="display:none;" aria-hidden="true">Akun</button>
                <div id="DropCNTT" class="DropCNTT dropdown-container" style="display:none">
                    <a href="gantipassword.asp?username=<%= session("username") %>&serverid=<%= session("server-id") %>" > Reset password</a><br>
                    <a href="<%=url%>/logout.asp" > Log Out</a><br>
                </div>
            </div> 
        </div>

        </div>
        </div>
    </div>
    <div id="main"  style="margin-top:2rem;">
        <div class="col-lg-12 mt-3">
            <div class="card1" style="border-color:grey;z-index:1;text-align:center;">
                <Span style="font-size:25px;text-align:center;color:#4c4c4c;">HUMAN RESOURCE DEPARTEMENT</Span>
            </div>
        </div>
        <div class="Main-Dashboard" style="overflow-y:hidden;overflow-x:hidden;">
            <div class="row">
                <div class="col-lg-9 col-md-12 col-sm-12 col-12 mt-2" >
                    <div class="row">
                        <div class="col-lg-3 col-md-6 col-sm-12 col-12  ">
                            <div class="card w3-hover-shadow" style="transform:none;">
                                <a href="#" style="text-decoration:none"><div class="card-header" style="background-color:#e3c700;">
                                        <span> Karyawan Habis Kontrak </span>
                                </div>
                                    <div class="card-body" id="scroll" style="font-size:10px;overflow-y: hidden;overflow-x:hidden;margin-left:5px;margin-right:5px;margin-top:0px;text-align:center;">
                                        <div class="row" style="font-size:9px;">
                                            <div class="col-12">
                                                <div class="row">
                                                    <div class="col-12">
                                                    <a href = "<%=url%>/tampilkanfile/habiskontraks.asp" style="text-decoration:none;">
                                                        <% server.execute("habiskontrak.asp") %>
                                                    </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    </a>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 col-sm-12 col-12  ">
                            <div class="card w3-hover-shadow">
                                <div class="card-header" style="background-color:#ff0000;">
                                        <span> Karyawan Habis Berlaku SIM </span>
                                </div>
                                    <div class="card-body" style="font-size:10px;overflow-y: hidden;overflow-x:hidden;margin-left:5px;margin-right:5px;margin-top:0px;text-align:center;">
                                        <div class="row" style="font-size:9px;">
                                            <div class="col-12">
                                                <div class="row">
                                                    <div class="col-12">
                                                    <a href = "<%=url%>/tampilkanfile/berlakusims.asp" style="text-decoration:none;">
                                                        <% server.execute("berlakusim.asp") %>
                                                    </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                            </div>
                        </div>
                        
                        <div class="col-lg-3 col-md-6 col-sm-12 col-12  ">
                            <div class="card w3-hover-shadow">
                                <div class="card-header" style="background-color:#18dd00;">
                                    <span> Ajuan Cuti Belum ACC </span>
                                </div>
                                
                                    <div class="card-body" style="font-size:10px;overflow-y: auto;overflow-x:hidden;margin-left:5px;margin-right:5px;margin-top:0px;text-align:center;">
                                        <div class="row" style="font-size:9px;">
                                            <div class="col-12">
                                                <div class="row">
                                                    <div class="col-12">
                                                    <a href = "<%=url%>/tampilkanfile/ajuancutis.asp" style="text-decoration:none;">
                                                        <% server.execute("ajuancuti.asp") %>
                                                    </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 col-sm-12 col-12  ">
                            <div class="card w3-hover-shadow">
                                <div class="card-header" style="background-color:#004283;" >
                                    <span> Karyawan Akan Resign </span>
                                </div>
                                <a href="<%=url%>/tampilkanfile/kryresign_view.asp" style="text-decoration:none;">
                                <div class="card-body" style="font-size:10px;overflow-y:auto;overflow-x:hidden;margin-left:3px;margin-right:5px;margin-top:0px;text-align:center;">
                                    <div class="row" style="font-size:9px;">
                                        <div class="col-12">
                                            <div class="row">
                                                <div class="col-12">
                                                    <% server.execute("krymauresign.asp") %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                </a>
                            </div>
                        </div> 
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12 col-12 ">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-12  ">
                            <div class="calendar" style="margin-top:3px;"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-lg-4 col-md-3 col-sm-12 col-12  ">
                    <div class="card w3-hover-shadow" style="height:7rem">
                        <div class="card-header" style="background-color:#586776;">
                            <span style="font-size:15px;"> TOTAL KARYAWAN AKTIF PERIODE  <%=YEAR(NOW())%></span>
                        </div>
                        <div class="card-body">
                            <%=kryaktif("totalkry")%> <span style="font-size:20px;">Orang</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-3 col-sm-12 col-12  ">
                    <div class="card w3-hover-shadow" style="height:7rem">
                            <div class="card-header" style="background-color:#586776;">
                                    <span style="font-size:15px;"> TOTAL KARYAWAN RESIGN PERIODE <%=YEAR(NOW())%></span>
                                </div>
                        <div class="card-body ">
                            <%=krynonaktif("tkrynonaktif") %> <span style="font-size:20px;">Orang</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-3 col-sm-12 col-12  ">
                    <div class="card w3-hover-shadow"  style="height:7rem">
                        <div class="card-header" style="background-color:#586776;">
                                    <span style="font-size:15px;"> TOTAL KARYAWAN BARU PERIODE <%=YEAR(NOW())%></span>
                                </div>
                        <div class="card-body">
                            <%= krybaru("totalkrybaru") %> <span style="font-size:20px;">Orang</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12 col-md-6 col-sm-12 col-12">
            <div class="row">
                <div class="col-lg-3 col-md-10 col-sm-12 col-12  ">
                    <div class="card  " style="height:10rem;margin-top:17px;display:block;overflow-y:hidden;overflow-x:hidden;align-item:center;margin-top:9px;">
                        <canvas id="myChart" style="padding:10px;"></canvas>
                        <% server.execute("totalkrypriawanita.asp")%>
                    </div>
                </div>
            </div>
        </div>        
    <div class="col-lg-12 col-md-12 col-sm-12 col-12 mt-4 d-flex justify-content-around">
            <footer class="footer">
                    <div class="icons">
                        <p class="company-name" style="text-align:center;margin-top:-7px;color:#bcbcbc;">
                            Copyright &copy; 2022, ALL Rights Reserved PT. DAKOTA BUANA SEMESTA </br>
                        </p>
                    </div>
            </footer>
        </div>
        
    </body>
    <script>
    // function buka tutup navbar
    function cknavbar(){
        let ncknavbar =document.getElementById("ckbox").checked;
        let tombolnav =document.getElementsByClassName("dropdown-btn").length;
            // console.log(tombolnav,ncknavbar);

        if (ncknavbar){
            document.getElementById("mySidebar").style.width = "250px";
            document.getElementById("main").style.marginLeft = "250px";
            document.getElementById("menu1").style.display = "block";
            document.getElementById("menu9").style.display = "block";
            document.getElementById("menu+").style.display = "block";
            document.getElementById("menu2").style.display = "block";
            document.getElementById("menu3").style.display = "block";
            document.getElementById("menu0").style.display = "block";
            document.getElementById("menu4").style.display = "block";
            document.getElementById("menu5").style.display = "block";
            document.getElementById("menuu").style.display = "block";



        } else{
                var blanks = document.getElementsByClassName("DropCNTT");
                for (item in blanks) {
                    if (blanks[0] === 'block') {
                        blanks[0].style.display = 'none';
                    
                    } else {
            document.getElementById("mySidebar").style.width = "4rem";
            document.getElementById("main").style.marginLeft= "60px";
            document.getElementById("menu1").style.display = "none";
            document.getElementById("menu9").style.display = "none";
            document.getElementById("menu+").style.display = "none";
            document.getElementById("menu2").style.display = "none";
            document.getElementById("menu3").style.display = "none";
            document.getElementById("menu0").style.display = "none";
            document.getElementById("menu4").style.display = "none";
            document.getElementById("menu5").style.display = "none";
            document.getElementById("menuu").style.display = "none";
            
            blanks[item].style.display = 'none';
                }
            }
        }
        
    }

    // js untuk ketika di close dropdownbuttonnya automatis ketutup
    var dropdown = document.getElementsByClassName("dropdown-btn");
    var i;

    for (i = 0; i < dropdown.length; i++) {
    dropdown[i].addEventListener("click", function() {
        this.classList.toggle("active");
        var dropdownContent = this.nextElementSibling;
        if (dropdownContent.style.display === "block") {
        dropdownContent.style.display = "none";
        } else {
        dropdownContent.style.display = "block";
        }
    });
    }

    function openNav() {
        document.getElementById("mySidebar").style.width = "250px";
        document.getElementById("main").style.marginLeft = "250px";
        document.getElementById("menu1").style.display = "block";
        document.getElementById("menu9").style.display = "block";
        document.getElementById("menu+").style.display = "block";
        document.getElementById("menu2").style.display = "block";
        document.getElementById("menu3").style.display = "block";
        document.getElementById("menu0").style.display = "block";
        document.getElementById("menu4").style.display = "block";
        document.getElementById("menu5").style.display = "block";
        document.getElementById("menuu").style.display = "block";
    }

    function closeNav() {
        document.getElementById("mySidebar").style.width = "4rem";
        document.getElementById("main").style.marginLeft= "60px";
        document.getElementById("menu1").style.display = "none";
        document.getElementById("menu9").style.display = "none";
        document.getElementById("menu+").style.display = "none";
        document.getElementById("menu2").style.display = "none";
        document.getElementById("menu3").style.display = "none";
        document.getElementById("menu0").style.display = "none";
        document.getElementById("menu4").style.display = "none";
        document.getElementById("menu5").style.display = "none";
        document.getElementById("menuu").style.display = "none";

    }

    // Chart Pie
    var a = document.getElementById("pria").value;
    var b = document.getElementById("wanita").value;
    console.log(a);
    var xValues = ["Pria", "Wanita"];
    var yValues = [a,b];
    var barColors = [
    "#226FD8",
    "#FB2824",

    ];

    new Chart("myChart", {
    type: "pie",
    data: {
        labels: xValues,
        datasets: [{
        backgroundColor: barColors,
        data: yValues
        }]
    },
    options: {
        title: {
        display: true,
        text: "Total Karyawan Pria Dan Wanita"
        }
    }
    });
    

    // Function Calender
    function CalendarControl() {
    const calendar = new Date();
    const calendarControl = {
        localDate: new Date(),
        prevMonthLastDate: null,
        calWeekDays: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
        calMonthName: [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec"
        ],
        daysInMonth: function (month, year) {
        return new Date(year, month, 0).getDate();
        },
        firstDay: function () {
        return new Date(calendar.getFullYear(), calendar.getMonth(), 1);
        },
        lastDay: function () {
        return new Date(calendar.getFullYear(), calendar.getMonth() + 1, 0);
        },
        firstDayNumber: function () {
        return calendarControl.firstDay().getDay() + 1;
        },
        lastDayNumber: function () {
        return calendarControl.lastDay().getDay() + 1;
        },
        getPreviousMonthLastDate: function () {
        let lastDate = new Date(
            calendar.getFullYear(),
            calendar.getMonth(),
            0
        ).getDate();
        return lastDate;
        },
        navigateToPreviousMonth: function () {
        calendar.setMonth(calendar.getMonth() - 1);
        calendarControl.attachEventsOnNextPrev();
        },
        navigateToNextMonth: function () {
        calendar.setMonth(calendar.getMonth() + 1);
        calendarControl.attachEventsOnNextPrev();
        },
        navigateToCurrentMonth: function () {
        let currentMonth = calendarControl.localDate.getMonth();
        let currentYear = calendarControl.localDate.getFullYear();
        calendar.setMonth(currentMonth);
        calendar.setYear(currentYear);
        calendarControl.attachEventsOnNextPrev();
        },
        displayYear: function () {
        let yearLabel = document.querySelector(".calendar .calendar-year-label");
        yearLabel.innerHTML = calendar.getFullYear();
        },
        displayMonth: function () {
        let monthLabel = document.querySelector(
            ".calendar .calendar-month-label"
        );
        monthLabel.innerHTML = calendarControl.calMonthName[calendar.getMonth()];
        },
        selectDate: function (e) {
        console.log(
            `${e.target.textContent} ${
            calendarControl.calMonthName[calendar.getMonth()]
            } ${calendar.getFullYear()}`
        );
        },
        plotSelectors: function () {
        document.querySelector(
            ".calendar"
        ).innerHTML += `<div class="calendar-inner"><div class="calendar-controls">
            <div class="calendar-prev"><a href="#"><svg xmlns="http://www.w3.org/2000/svg" width="128" height="128" viewBox="0 0 128 128"><path fill="#666" d="M88.2 3.8L35.8 56.23 28 64l7.8 7.78 52.4 52.4 9.78-7.76L45.58 64l52.4-52.4z"/></svg></a></div>
            <div class="calendar-year-month">
            <div class="calendar-month-label"></div>
            <div>-</div>
            <div class="calendar-year-label"></div>
            </div>
            <div class="calendar-next"><a href="#"><svg xmlns="http://www.w3.org/2000/svg" width="128" height="128" viewBox="0 0 128 128"><path fill="#666" d="M38.8 124.2l52.4-52.42L99 64l-7.77-7.78-52.4-52.4-9.8 7.77L81.44 64 29 116.42z"/></svg></a></div>
            </div>
            <div class="calendar-today-date">Today: 
            ${calendarControl.calWeekDays[calendarControl.localDate.getDay()]}, 
            ${calendarControl.localDate.getDate()}, 
            ${calendarControl.calMonthName[calendarControl.localDate.getMonth()]} 
            ${calendarControl.localDate.getFullYear()}
            </div>
            <div class="calendar-body"></div></div>`;
        },
        plotDayNames: function () {
        for (let i = 0; i < calendarControl.calWeekDays.length; i++) {
            document.querySelector(
            ".calendar .calendar-body"
            ).innerHTML += `<div>${calendarControl.calWeekDays[i]}</div>`;
        }
        },
        plotDates: function () {
        document.querySelector(".calendar .calendar-body").innerHTML = "";
        calendarControl.plotDayNames();
        calendarControl.displayMonth();
        calendarControl.displayYear();
        let count = 1;
        let prevDateCount = 0;

        calendarControl.prevMonthLastDate = calendarControl.getPreviousMonthLastDate();
        let prevMonthDatesArray = [];
        let calendarDays = calendarControl.daysInMonth(
            calendar.getMonth() + 1,
            calendar.getFullYear()
        );
        // dates of current month
        for (let i = 1; i < calendarDays; i++) {
            if (i < calendarControl.firstDayNumber()) {
            prevDateCount += 1;
            document.querySelector(
                ".calendar .calendar-body"
            ).innerHTML += `<div class="prev-dates"></div>`;
            prevMonthDatesArray.push(calendarControl.prevMonthLastDate--);
            } else {
            document.querySelector(
                ".calendar .calendar-body"
            ).innerHTML += `<div class="number-item" data-num=${count}><a class="dateNumber" href="#">${count++}</a></div>`;
            }
        }
        //remaining dates after month dates
        for (let j = 0; j < prevDateCount + 1; j++) {
            document.querySelector(
            ".calendar .calendar-body"
            ).innerHTML += `<div class="number-item" data-num=${count}><a class="dateNumber" href="#">${count++}</a></div>`;
        }
        calendarControl.highlightToday();
        calendarControl.plotPrevMonthDates(prevMonthDatesArray);
        calendarControl.plotNextMonthDates();
        },
        attachEvents: function () {
        let prevBtn = document.querySelector(".calendar .calendar-prev a");
        let nextBtn = document.querySelector(".calendar .calendar-next a");
        let todayDate = document.querySelector(".calendar .calendar-today-date");
        let dateNumber = document.querySelectorAll(".calendar .dateNumber");
        prevBtn.addEventListener(
            "click",
            calendarControl.navigateToPreviousMonth
        );
        nextBtn.addEventListener("click", calendarControl.navigateToNextMonth);
        todayDate.addEventListener(
            "click",
            calendarControl.navigateToCurrentMonth
        );
        for (var i = 0; i < dateNumber.length; i++) {
            dateNumber[i].addEventListener(
                "click",
                calendarControl.selectDate,
                false
            );
        }
        },
        highlightToday: function () {
        let currentMonth = calendarControl.localDate.getMonth() + 1;
        let changedMonth = calendar.getMonth() + 1;
        let currentYear = calendarControl.localDate.getFullYear();
        let changedYear = calendar.getFullYear();
        if (
            currentYear === changedYear &&
            currentMonth === changedMonth &&
            document.querySelectorAll(".number-item")
        ) {
            document
            .querySelectorAll(".number-item")
            [calendar.getDate() - 1].classList.add("calendar-today");
        }
        },
        plotPrevMonthDates: function(dates){
        dates.reverse();
        for(let i=0;i<dates.length;i++) {
            if(document.querySelectorAll(".prev-dates")) {
                document.querySelectorAll(".prev-dates")[i].textContent = dates[i];
            }
        }
        },
        plotNextMonthDates: function(){
        let childElemCount = document.querySelector('.calendar-body').childElementCount;
        //7 lines
        if(childElemCount > 42 ) {
            let diff = 49 - childElemCount;
            calendarControl.loopThroughNextDays(diff);
        }

        //6 lines
        if(childElemCount > 35 && childElemCount <= 42 ) {
        let diff = 42 - childElemCount;
        calendarControl.loopThroughNextDays(42 - childElemCount);
        }

        },
        loopThroughNextDays: function(count) {
        if(count > 0) {
            for(let i=1;i<=count;i++) {
                document.querySelector('.calendar-body').innerHTML += `<div class="next-dates">${i}</div>`;
            }
        }
        },
        attachEventsOnNextPrev: function () {
        calendarControl.plotDates();
        calendarControl.attachEvents();
        },
        init: function () {
        calendarControl.plotSelectors();
        calendarControl.plotDates();
        calendarControl.attachEvents();
        }
    };
    calendarControl.init();
    }

    const calendarControl = new CalendarControl();

</script>
<!-- Fontawesome JS -->

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</html> 
