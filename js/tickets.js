$(document).ready(function() {
    if($('#listTickets').length) {
        var ticketData = $('#listTickets').DataTable({
            "processing": true,
            "serverSide": true,
            "order": [],
            "ajax": {
                url: "ticket_action.php",
                type: "POST",
                data: {
                    action: 'listTicket'
                },
                dataType: "json"
            },
            "columnDefs": [{
                "targets": [7, 8, 9, 10],
                "orderable": false,
            }],
            "paging": true,
            "lengthChange": true,
            "searching": true,
            "ordering": true,
            "info": true,
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

        // AJAX request to ticket_action.php to save ticket details with action createTicket
        $(document).on('submit', '#ticketForm', function(event) {
            event.preventDefault();
            $('#save').attr('disabled', 'disabled');
            var formData = $(this).serialize();
            $.ajax({
                url: "ticket_action.php",
                method: "POST",
                data: formData,
                success: function(data) {
                    $('#ticketForm')[0].reset();
                    $('#ticketModal').modal('hide');
                    $('#save').attr('disabled', false);
                    ticketData.ajax.reload();
                }
            });
        });

        $(document).on('click', '.update', function() {
            var ticketId = $(this).attr("id");
            var action = 'getTicketDetails';
            $.ajax({
                url: 'ticket_action.php',
                method: "POST",
                data: {
                    ticketId: ticketId,
                    action: action
                },
                dataType: "json",
                success: function(data) {
                    $('#ticketModal').modal('show');
                    $('#ticketId').val(data.id);
                    $('#name').val(data.requestor_name);
                    $('#subject').val(data.title);
                    $('#message').val(data.init_msg);
                    if (data.gender == '0') {
                        $('#open').prop("checked", true);
                    } else if (data.gender == '1') {
                        $('#close').prop("checked", true);
                    }
                    $('.modal-title').html("<i class='fa fa-plus'></i> Edit Ticket");
                    $('#action').val('updateTicket');
                    $('#save').val('Save Ticket');
                }
            });
        });

        $(document).on('click', '.delete', function() {
            var ticketId = $(this).attr("id");
            var action = "closeTicket";
            if (confirm("Are you sure you want to close this ticket?")) {
                $.ajax({
                    url: "ticket_action.php",
                    method: "POST",
                    data: {
                        ticketId: ticketId,
                        action: action
                    },
                    success: function(data) {
                        ticketData.ajax.reload();
                    }
                });
            } else {
                return false;
            }
        });
    }

    $('#createTicket').click(function() {
        $('#ticketModal').modal('show');
        $('#ticketForm')[0].reset();
        $('.modal-title').html("<i class='fa fa-plus'></i> Create Ticket");
        $('#action').val('createTicket');
        $('#save').val('Save Ticket');
    });

    $(document).on('submit', '#ticketReply', function(event) {
        event.preventDefault();
        $('#reply').attr('disabled', 'disabled');
        var formData = $(this).serialize();
        $.ajax({
            url: "ticket_action.php",
            method: "POST",
            data: formData,
            success: function(data) {
                console.log("Response from server: ", data);
                $('#ticketReply')[0].reset();
                $('#reply').attr('disabled', false);
                location.reload();
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error("Error: ", textStatus, errorThrown);
            }
        });
    });
});
