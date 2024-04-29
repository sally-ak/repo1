<?php
include 'init.php';

if(!empty($_POST['action']) && $_POST['action'] == 'auth') {
	$users->login();
}
/*if(!empty($_POST['action']) && $_POST['action'] == 'listTicket') {
	$tickets->showTickets();
} */
if(!empty($_POST['action']) && $_POST['action'] == 'createTicket') {
	$tickets->createTicket();
}
if(!empty($_POST['action']) && $_POST['action'] == 'getTicketDetails') {
	$tickets->getTicketDetails();
}
if(!empty($_POST['action']) && $_POST['action'] == 'updateTicket') {
	$tickets->updateTicket();
}
if(!empty($_POST['action']) && $_POST['action'] == 'closeTicket') {
	$tickets->closeTicket();
}
if(!empty($_POST['action']) && $_POST['action'] == 'saveTicketReplies') {
	$tickets->saveTicketReplies();
}



if (!empty($_POST['action']) && $_POST['action'] == 'listTicket') {
    $start = isset($_POST['start']) ? intval($_POST['start']) : 0; // Starting index of the data
    $length = isset($_POST['length']) ? intval($_POST['length']) : 10; // Number of records per page

    $tickets->showTickets($start, $length);
}


?>