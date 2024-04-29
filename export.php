<?php 

include_once("database.php");
$sqlQuery = "SELECT name, gender, age, skills, address, designation FROM developers LIMIT 10";
$resultSet = mysqli_query($conn, $sqlQuery) or die("database error:". mysqli_error($conn));
$developersData = array();
while( $developer = mysqli_fetch_assoc($resultSet) ) {
	$developersData[] = $developer;
}	

?>