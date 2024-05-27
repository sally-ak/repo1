<?php

class Tickets extends Database {  
    private $ticketTable = 'hd_tickets';
	private $ticketRepliesTable = 'hd_ticket_replies';
	private $departmentsTable = 'hd_departments';

	private $dbConnect = false;

	public function __construct(){		
        $this->dbConnect = $this->dbConnect();
    } 

 	// Methode showTickets() which return ticket details and JSON data, to display tickets in table 
	public function showTickets($start, $length) {
		$sqlWhere = '';
		//check if user is not admin
		if (!isset($_SESSION["admin"])) {
			$sqlWhere .= " WHERE t.user = '" . $_SESSION["userid"] . "' ";
			//If a search value is provided, appends "and" to the SQL query.
			if (!empty($_POST["search"]["value"])) {
				$sqlWhere .= " and ";
			}
			//Checks if the user is an admin and if a search value is provided.	
		} else if (isset($_SESSION["admin"]) && !empty($_POST["search"]["value"])) {
			$sqlWhere .= " WHERE ";
		}
		$time = new time;
		//select ticket details from the database tables  			 
		$sqlQuery = "SELECT t.id, t.uniqid, t.title, t.init_msg as message, t.date, t.last_reply, t.resolved, u.name as creater, d.name as department, u.user_type, t.user, t.user_read, t.admin_read
				FROM hd_tickets t 
				LEFT JOIN hd_users u ON t.user = u.id 
				LEFT JOIN hd_departments d ON t.department = d.id ";
		$allRowsSql = $sqlQuery;
		$sqlQuery .= " $sqlWhere ";
		//append search conditions to the SQL query
		if (!empty($_POST["search"]["value"])) {
			$sqlQuery .= ' (uniqid LIKE "%' . $_POST["search"]["value"] . '%" ';
			$sqlQuery .= ' OR title LIKE "%' . $_POST["search"]["value"] . '%" ';
			$sqlQuery .= ' OR resolved LIKE "%' . $_POST["search"]["value"] . '%" ';
			$sqlQuery .= ' OR last_reply LIKE "%' . $_POST["search"]["value"] . '%") ';
		}
		//append order conditions to the SQL query
		if (!empty($_POST["order"])) {
			$sqlQuery .= 'ORDER BY ' . $_POST['order']['0']['column'] . ' ' . $_POST['order']['0']['dir'] . ' ';
		} else {
			$sqlQuery .= 'ORDER BY t.id DESC ';
		}
		$allSqlFiltered = $sqlQuery;
		//Modify your SQL query to include pagination
		$sqlQuery .= ' LIMIT ' . $start . ', ' . $length;
	
		//Executes the SQL query using the database connection.
		$result = mysqli_query($this->dbConnect, $sqlQuery);
		$allResult = mysqli_query($this->dbConnect, $allRowsSql);
		$allFilteredResult = mysqli_query($this->dbConnect, $allSqlFiltered);

		//Counts the number of rows returned by the SQL query.
		$numRows = mysqli_num_rows($result);
		$allRowsNum = mysqli_num_rows($allResult);
		$allFilteredRowsNum = mysqli_num_rows($allFilteredResult);
		
		$ticketData = array();
		//Iterates over each row returned by the SQL query.
		while ($ticket = mysqli_fetch_assoc($result)) {
			$ticketRows = array();
			$status = '';
			if ($ticket['resolved'] == 0) {
				$status = '<span class="label label-success">Open</span>';
			} else if ($ticket['resolved'] == 1) {
				$status = '<span class="label label-danger">Closed</span>';
			}
			$title = $ticket['title'];
			if ((isset($_SESSION["admin"]) && !$ticket['admin_read'] && $ticket['last_reply'] != $_SESSION["userid"]) || (!isset($_SESSION["admin"]) && !$ticket['user_read'] && $ticket['last_reply'] != $ticket['user'])) {
				$title = $this->getRepliedTitle($ticket['title']);
			}
			$disbaled = '';
			if (!isset($_SESSION["admin"])) {
				$disbaled = 'disabled';
			}
			$ticketRows[] = $ticket['id'];
			$ticketRows[] = $ticket['uniqid'];
			$ticketRows[] = $title;
			$ticketRows[] = $ticket['department'];
			$ticketRows[] = $ticket['creater'];
			$ticketRows[] = $time->ago($ticket['date']);
			$ticketRows[] = $status;
			$ticketRows[] = '<a href="view_ticket.php?id=' . $ticket["uniqid"] . '" class="btn btn-success btn-xs update">View Ticket</a>';
			$ticketRows[] = '<button type="button" name="update" id="' . $ticket["id"] . '" class="btn btn-warning btn-xs update" ' . $disbaled . '>Edit</button>';
			$ticketRows[] = '<button type="button" name="delete" id="' . $ticket["id"] . '" class="btn btn-danger btn-xs delete"  ' . $disbaled . '>Close</button>';
			$ticketData[] = $ticketRows;
		}
		// Array containing information for DataTables plugin
		$output = array(
			"draw" => intval($_POST["draw"]),
			"recordsTotal" => $allRowsNum,
			"recordsFiltered" => $allFilteredRowsNum,
			"data" => $ticketData
		);
		//Encodes the array to JSON and sends to client-side for processing by DataTables plugin.
		echo json_encode($output);
	}
	
	
	// Method to modify ticket title if it has been answered
 	public function getRepliedTitle($title) {
		$title = $title.'<span class="answered"> answered </span>';
		return $title; 		
	}  

    // Method to create a new ticket
	public function createTicket() {  
		print_r($_POST);

		if(!empty($_POST['subject']) && !empty($_POST['message']) && !empty($_POST['requestor_name'])) { 
			$date = new DateTime();
			$date = $date->getTimestamp();
			$uniqid = uniqid();                
			$message = strip_tags($_POST['subject']);
			$message = strip_tags($_POST['message']);    
			$requestorName = mysqli_real_escape_string($this->dbConnect, $_POST['requestor_name']);
			$queryInsert = "INSERT INTO ".$this->ticketTable." (uniqid, user, title, init_msg, department, date, last_reply, user_read, admin_read, resolved, requestor_name) 
			VALUES('".$uniqid."', '".$_SESSION["userid"]."', '".$_POST['subject']."', '".$message."', '".$_POST['department']."', '".$date."', '".$_SESSION["userid"]."', 0, 0, '".$_POST['status']."', '".$requestorName."')";			
			mysqli_query($this->dbConnect, $queryInsert);			
			echo 'success ' . $uniqid;
		} else {
			echo '<div class="alert error">Please fill in all of the fields.</div>';
		}
	}
	
	//ticket_action.php	// Method to get details of a specific ticket
	public function getTicketDetails(){
		if($_POST['ticketId']) {	
			$sqlQuery = "
				SELECT * FROM ".$this->ticketTable." 
				WHERE id = '".$_POST["ticketId"]."'";
			$result = mysqli_query($this->dbConnect, $sqlQuery);	
			$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
			echo json_encode($row);
		}
	} 
	
	//ticket_action.php	// Method to update details of a ticket
	public function updateTicket() {
		if($_POST['ticketId']) {	
			$updateQuery = "UPDATE ".$this->ticketTable." 
			SET title = '".$_POST["subject"]."', department = '".$_POST["department"]."', init_msg = '".$_POST["message"]."', resolved = '".$_POST["status"]."'
			WHERE id ='".$_POST["ticketId"]."'";
			$isUpdated = mysqli_query($this->dbConnect, $updateQuery);		
		}	
	}	
		//ticket_action.php	// Method to mark a ticket as resolved or closed	
	public function closeTicket(){
		if($_POST["ticketId"]) {
			$sqlDelete = "UPDATE ".$this->ticketTable." 
				SET resolved = '1'
				WHERE id = '".$_POST["ticketId"]."'";		
			mysqli_query($this->dbConnect, $sqlDelete);		
		}
	}	
	 // Method to retrieve department list for dropdown
	public function getDepartments() {       
		$sqlQuery = "SELECT * FROM ".$this->departmentsTable;
		$result = mysqli_query($this->dbConnect, $sqlQuery);
		while($department = mysqli_fetch_assoc($result) ) {       
            echo '<option value="' . $department['id'] . '">' . $department['name']  . '</option>';           
        }
    }	
	
	// Method to get detailed information about a ticket
    public function ticketInfo($id) {  		
		$sqlQuery = "SELECT t.id, t.uniqid, t.title, t.user, t.init_msg as message, t.date, t.last_reply, t.resolved, u.name as creater, d.name as department 
			FROM ".$this->ticketTable." t 
			LEFT JOIN hd_users u ON t.user = u.id 
			LEFT JOIN hd_departments d ON t.department = d.id 
			WHERE t.uniqid = '".$id."'";	
		$result = mysqli_query($this->dbConnect, $sqlQuery);
        $tickets = mysqli_fetch_assoc($result);
        return $tickets;        
    } 
	//ticket_action.php	// Method to save a reply message to a ticket
	public function saveTicketReplies () {
		if($_POST['message']) {
			$date = new DateTime();
			$date = $date->getTimestamp();
			$queryInsert = "INSERT INTO ".$this->ticketRepliesTable." (user, text, ticket_id, date) 
				VALUES('".$_SESSION["userid"]."', '".$_POST['message']."', '".$_POST['ticketId']."', '".$date."')";
			mysqli_query($this->dbConnect, $queryInsert);				
			$updateTicket = "UPDATE ".$this->ticketTable." 
				SET last_reply = '".$_SESSION["userid"]."', user_read = '0', admin_read = '0' 
				WHERE id = '".$_POST['ticketId']."'";				
			mysqli_query($this->dbConnect, $updateTicket);
		} 
	}
	// Method to get replies associated with a ticket	
	public function getTicketReplies($id) {  		
		$sqlQuery = "SELECT r.id, r.text as message, r.date, u.name as creater, d.name as department, u.user_type  
			FROM ".$this->ticketRepliesTable." r
			LEFT JOIN ".$this->ticketTable." t ON r.ticket_id = t.id
			LEFT JOIN hd_users u ON r.user = u.id 
			LEFT JOIN hd_departments d ON t.department = d.id 
			WHERE r.ticket_id = '".$id."'";	
		$result = mysqli_query($this->dbConnect, $sqlQuery);
       	$data= array();
		while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
			$data[]=$row;            
		}
        return $data;
    }
	
	// Method to update read status of a ticket 
	public function updateTicketReadStatus($ticketId) {
		$updateField = '';
		if(isset($_SESSION["admin"])) {
			$updateField = "admin_read = '1'";
		} else {
			$updateField = "user_read = '1'";
		}
		$updateTicket = "UPDATE ".$this->ticketTable." 
			SET $updateField
			WHERE id = '".$ticketId."'";				
		mysqli_query($this->dbConnect, $updateTicket);
	}
}