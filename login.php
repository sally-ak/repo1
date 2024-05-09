<?php 
include 'init.php';
if($users->isLoggedIn()) {
	header('Location: ticket.php');
}
$errorMessage = $users->login();
include('inc/header.php');
?>
<title>Incident Management System</title>
<?php include('inc/container.php');?>

<!-- <div class="login-logo"><img src="assets\LOGO.png" alt="Logo Toyota"></div>  -->

<div class="container contact">	
        <h2>
            Incident Management System
			<div class="login-logo"><img src="assets\LOGO.png" alt="Logo Toyota"></div>
			<style>
        .login-logo {
            display: inline-block; 
            vertical-align: middle; 
            margin-left: 5px; 
        }

        .login-logo img {
            max-width: 80px; 
            height: auto; 
        }
    </style> 
        </h2>
	<div class="col-md-6">                    
		<div class="panel panel-info">
			<div class="panel-heading" style="background:#00796B;color:white;">
				<div class="panel-title">
					User Login
				</div>                        
			</div> 
			<div style="padding-top:30px" class="panel-body" >
				<?php if ($errorMessage != '') { ?>
					<div id="login-alert" class="alert alert-danger col-sm-12"><?php echo $errorMessage; ?></div>                            
				<?php } ?>
				<form id="loginform" class="form-horizontal" role="form" method="POST" action="">                                    
					<div style="margin-bottom: 25px" class="input-group">
						<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
						<input type="text" class="form-control" id="email" name="email" placeholder="email" style="background:white;" required>                                        
					</div>                                
					<div style="margin-bottom: 25px" class="input-group">
						<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
						<input type="password" class="form-control" id="password" name="password"placeholder="password" required>
					</div>
					<div style="margin-top:10px" class="form-group">                               
						<div class="col-sm-12 controls">
						  <input type="submit" name="login" value="Login" class="btn btn-success">						  
						</div>						
					</div>	
					<div style="margin-top:10px" class="form-group">                               
<!-- 						<div class="col-sm-12 controls">
						Admin: salma@tdm.com<br>
						password:123	<br><br>
						User: meryem@tdm.com<br>
						password:123							
						</div>	 -->					
					</div>	
				</form>   
			</div>                     
		</div>  
	</div>
</div>	
<?php include('inc/footer.php');?>
