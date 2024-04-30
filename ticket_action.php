<?php
include 'init.php';

if (!empty($_POST['action'])) {
    switch ($_POST['action']) {
        case 'auth':
            $users->login();
            break;
        case 'createTicket':
            $tickets->createTicket();
            break;
        case 'getTicketDetails':
            $tickets->getTicketDetails();
            break;
        case 'updateTicket':
            $tickets->updateTicket();
            break;
        case 'closeTicket':
            $tickets->closeTicket();
            break;
        case 'saveTicketReplies':
            $tickets->saveTicketReplies();
            break;
        case 'listTicket':
            $start = isset($_POST['start']) ? intval($_POST['start']) : 0; // Starting index of the data
            $length = isset($_POST['length']) ? intval($_POST['length']) : 10; // Number of records per page

            $tickets->showTickets($start, $length);
            break;
        default:
            // Handle unknown action
            break;
    }
}
?>
