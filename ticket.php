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
<script src="js\jquery.dataTables.min.js"></script>
<script src="js\dataTables.bootstrap.min.js"></script>		
<link rel="stylesheet" href="css\dataTables.bootstrap.min.css" />

<script src="js\general.js"></script>
<script src="js\tickets.js"></script>
<link rel="stylesheet" href="css\style.css" />

<!-- 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />    
<link href='https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css' rel='stylesheet' type='text/css'>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
-->



<?php include('inc\container.php');?>

<!-- JS and CSS files for DataTables plugin -->

<div class="container">
    <div class="row home-sections">
        <h2>
            <div class="logo"><img src="assets\LOGO.png" alt="Logo Toyota"></div>
            Incident Management System
        </h2>
    </div>

	<?php include('menus.php'); ?>		
	</div> 
	<div class="">   		
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-10">
					<h3 class="panel-title"></h3>
				</div>
				<div class="col-md-2" align="right">
					<button type="button" name="add" id="createTicket" class="btn btn-success btn-xs">Create New Incident</button>
				</div>

				<div class="col-md-2" align="left">	
			<form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">					
				<button type="button" id="dataExport" name="dataExport" value="Export to excel" class="btn btn-success btn-xs">Export To Excel</button>
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
					<!-- <th>Department</th> -->
					<!-- <th>Name</th> -->
					<th>Department</th>
					<th>Created By</th>					
					<th>Created At</th>	
					<th>Status</th>
					<th></th>
					<th></th>
					<th></th>	
				</tr>
			</thead>
		</table>
	</div>
	<?php include('add_ticket_model.php'); ?>
</div>	
<?php include('inc\footer.php');?>