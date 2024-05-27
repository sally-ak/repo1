<!-- check login, if not, redirect -->
<?php 
include 'init.php'; 
if(!$users->isLoggedIn()) {
	header("Location: login.php");	
}
include('inc\header.php');
$user = $users->getUserInfo();
?>

<!-- JS and CSS files for DataTables plugin -->
<title>Incident Management</title>
<script src="js/jquery.dataTables.min.js"></script>
<script src="js/dataTables.bootstrap.min.js"></script>
<link rel="stylesheet" href="css/dataTables.bootstrap.min.css" />

<script src="js/general.js"></script>
<script src="js/tickets.js"></script>
<link rel="stylesheet" href="css/style.css" />

<!--  sheetJs Library via CDN  -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.3/xlsx.full.min.js"></script>
<!--<script src="https://cdn.sheetjs.com/xlsx-0.20.2/package/dist/xlsx.full.min.js"></script>-->

<?php include('inc\container.php');?>

<!-- JS and CSS files for DataTables plugin -->
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Meta tags, title, and CSS includes -->
</head>
<body>
    <div class="container">
        <div class="row home-sections">
            <h2>
                <div class="logo"><img src="assets/LOGO.png" alt="Logo Toyota"></div>
                Incident Management System
            </h2>
        </div>

        <?php include('menus.php'); ?>        
        <div class="">          
            <div class="panel-heading">
                <div class="row">
                    <div class="col-md-10">
                        <h3 class="panel-title"></h3>
                    </div>
                    <div class="col-md-2" align="right">
                        <button type="button" name="add" id="createTicket" class="btn btn-success btn-xs">Create New Incident</button>
                    </div>

                    <div class="col-md" align="left">    
                        <form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">                    
                            <button type="button" id="exportButton" name="dataExport" value="Export to excel" class="btn btn-success btn-xs">Export To Excel</button>
                        </form>
                    </div>
                </div>
            </div>
            <table id="listTickets" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>S/N</th>
                        <th>Ticket ID</th>
                        <th>Subject</th>
                        <th>Department</th>
                        <th>Created By</th>                    
                        <th>Name</th>  
                        <th>Created At</th>  
                        <th>Status</th>
                        <th></th>
                        <th></th>
                        <th></th>    
                    </tr>
                </thead>
                <tbody>
                    <!-- Populate table rows here dynamically or statically -->
                </tbody>
            </table>
        </div>
        <?php include('add_ticket_model.php'); ?>
    </div>    
</body>
</html>

<script>
function exportTableToExcel(tableID, filename = '') {
    var tableSelect = document.getElementById(tableID);
    var columnsToExport = [0, 1, 2, 3, 4, 5, 6, 7]; // Column indexes to export (0-based)

    // Create a new table element to hold the filtered data
    var tempTable = document.createElement('table');

    // Clone the headers
    var header = tableSelect.querySelector('thead').cloneNode(true);
    var newHeaderRow = document.createElement('tr');
    columnsToExport.forEach(index => {
        newHeaderRow.appendChild(header.rows[0].cells[index].cloneNode(true));
    });
    tempTable.appendChild(newHeaderRow);

    // Clone the rows
    var rows = tableSelect.querySelector('tbody').cloneNode(true);
    Array.from(rows.rows).forEach(row => {
        var newRow = document.createElement('tr');
        columnsToExport.forEach(index => {
            newRow.appendChild(row.cells[index].cloneNode(true));
        });
        tempTable.appendChild(newRow);
    });

    // Generate worksheet from filtered table data
    var worksheet = XLSX.utils.table_to_sheet(tempTable);

    // Apply styling to the worksheet
    var range = XLSX.utils.decode_range(worksheet['!ref']);
    for (var R = range.s.r; R <= range.e.r; ++R) {
        for (var C = range.s.c; C <= range.e.c; ++C) {
            var cell_address = { c: C, r: R };
            var cell_ref = XLSX.utils.encode_cell(cell_address);
            if (!worksheet[cell_ref]) continue;

            worksheet[cell_ref].s = {
                border: {
                    top: { style: "thin" },
                    bottom: { style: "thin" },
                    left: { style: "thin" },
                    right: { style: "thin" }
                },
                alignment: { horizontal: "center", vertical: "center" }
            };

            if (R === 0) {
                worksheet[cell_ref].s.font = { bold: true, color: { rgb: "FFFFFF" } };
                worksheet[cell_ref].s.fill = { fgColor: { rgb: "4F81BD" } };
            } else {
                worksheet[cell_ref].s.fill = { fgColor: { rgb: (R % 2 === 0 ? "D9EAD3" : "FFFFFF") } };
            }
        }
    }

    // Create a new workbook and append the worksheet
    var workbook = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(workbook, worksheet, 'Tickets');

    // Convert the workbook to a Blob
    var excelBuffer = XLSX.write(workbook, { bookType: 'xlsx', type: 'array' });
    var blob = new Blob([excelBuffer], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=UTF-8' });

    // Create a download link and trigger the download
    var downloadLink = document.createElement("a");
    var url = URL.createObjectURL(blob);
    downloadLink.href = url;
    downloadLink.download = filename ? filename + '.xlsx' : 'tickets.xlsx';
    document.body.appendChild(downloadLink);
    downloadLink.click();
    document.body.removeChild(downloadLink);
}

// Event listener for export button
document.getElementById('exportButton').addEventListener('click', function() {
    exportTableToExcel('listTickets', 'tickets');
});


</script>



 <?php include('inc\footer.php');?>