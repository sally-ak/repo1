$(document).ready(function() {
        var dataTable = $('#listTickets').DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                url: "ticket_action.php",
                type: "POST",
                data: function(d) {
                    d.action = 'showTickets';
                    d.start = d.start || 0;
                    d.length = d.length || 10;
                }
            },
            "columns": [
                { "data": "id" },
                { "data": "uniqid" },
                { "data": "title" },
                { "data": "department" },
                { "data": "creater" },
                { "data": "requestor_name" },  //  New column for requestor name
                { "data": "date" },
                { "data": "status" },
                { "data": "view" },
                { "data": "edit" },
                { "data": "delete" }
            ]
        });
    

    $(document).on('submit','#ticketReply', function(event){
        event.preventDefault();
        $('#reply').attr('disabled','disabled');
        var formData = $(this).serialize();
        $.ajax({
            url:"ticket_action.php",
            method:"POST",
            data:formData,
            success:function(data){                
                $('#ticketReply')[0].reset();
                $('#reply').attr('disabled', false);
                location.reload();
            }
        })
    });     
    
    $('#createTicket').click(function(){
        $('#ticketModal').modal('show');
        $('#ticketForm')[0].reset();
        $('.modal-title').html("<i class='fa fa-plus'></i> Create Ticket");
        $('#action').val('createTicket');
        $('#save').val('Save Ticket');
    }); 

	
/* 		var empDataTable = $('#listTickets').DataTable({
			'processing': true,
			'serverSide': true,
			'serverMethod': 'post',
			'ajax': {
				'url':'Tickets.php'
			},
			pageLength: 5,
			'columns': [
				{ data: 'id' },
				{ data: 'uniqid' },
				{ data: 'user' },
				{ data: 'title' },
				{ data: 'department' },
			]
		}); */
	
	//
    if($('#listTickets').length) {
        var ticketData = $('#listTickets').DataTable({
            "processing": true,
			'serverMethod': 'post',
            "serverSide": true, // Enable server-side processing
            "order": [],
            "ajax": {
                url: "ticket_action.php",
                type: "POST",
                data: { action: 'listTicket' },
                dataType: "json"
            },
            "columnDefs": [
                {
                    "targets": [6, 7, 8, 9, 10],
                    "orderable": false,
                },
            ],
            "paging": true, // Enable pagination
            "lengthChange": true, // Enable the 'Show X entries' dropdown
            "searching": true, // Enable search box
            "ordering": true, // Enable column sorting
            "info": true, // Show 'Showing X to Y of Z entries' information
            "language": {
                "lengthMenu": "Show _MENU_ entries",
                "zeroRecords": "No matching records found",
                "info": "Showing _START_ to _END_ of _TOTAL_ entries",
                "infoEmpty": "Showing 0 to 0 of 0 entries",
                "infoFiltered": "(filtered from _MAX_ total entries)",
                "search": "Search:",
                "paginate": {
                    "first": "First",
                    "last": "Last",
                    "next": "Next",
                    "previous": "Previous"
                }
            }
        });         

        //ajax request to ticket_action.php to save ticket details with action createTicket
        $(document).on('submit','#ticketForm', function(event){
            event.preventDefault();
            $('#save').attr('disabled','disabled');
            var formData = $(this).serialize();
            $.ajax({
                url:"ticket_action.php",
                method:"POST",
                data:formData,
                success:function(data){                
                    $('#ticketForm')[0].reset();
                    $('#ticketModal').modal('hide');                
                    $('#save').attr('disabled', false);
                    ticketData.ajax.reload();
                }
            })
        });         

        $(document).on('click', '.update', function(){
            var ticketId = $(this).attr("id");
            var action = 'getTicketDetails';
            $.ajax({
                url:'ticket_action.php',
                method:"POST",
                data:{ticketId:ticketId, action:action},
                dataType:"json",
                success:function(data){
                    $('#ticketModal').modal('show');
                    $('#ticketId').val(data.id);
                    $('#name').val(data.requestor_name);
                    $('#subject').val(data.title);
                    $('#message').val(data.init_msg);
                    if(data.gender == '0') {
                        $('#open').prop("checked", true);
                    } else if(data.gender == '1') {
                        $('#close').prop("checked", true);
                    }
                    $('.modal-title').html("<i class='fa fa-plus'></i> Edit Ticket");
                    $('#action').val('updateTicket');
                    $('#save').val('Save Ticket');
                }
            })
        });         

        $(document).on('click', '.delete', function(){
            var ticketId = $(this).attr("id");        
            var action = "closeTicket";
            if(confirm("Are you sure you want to close this ticket?")) {
                $.ajax({
                    url:"ticket_action.php",
                    method:"POST",
                    data:{ticketId:ticketId, action:action},
                    success:function(data) {                    
                        ticketData.ajax.reload();
                    }
                })
            } else {
                return false;
            }
        }); 
    }
});
