<?php 
	/* Attempt MySQL server connection. Assuming you are running MySQL server with default setting (user 'root' with no password) */ 
	header('Location: /?q=node/6');
	$link = mysqli_connect("localhost", "testuser", "testpassword", "LWC"); // Check connection
	if($link === false){
		die("ERROR: Could not connect. " . mysqli_connect_error());
	}
	// Escape user inputs for security
	$CounselorID = mysqli_real_escape_string($link, $_POST['CounselorID']);
	$FirstName = mysqli_real_escape_string($link, $_POST['FirstName']); 
	$LastName = mysqli_real_escape_string($link, $_POST['LastName']);
	$Address = mysqli_real_escape_string($link, $_POST['Address']);
	$City = mysqli_real_escape_string($link, $_POST['City']);
	$State = mysqli_real_escape_string($link, $_POST['State']);
	$Zip = mysqli_real_escape_string($link, $_POST['Zip']);
	$Phone = mysqli_real_escape_string($link, $_POST['Phone']);
	$Email = mysqli_real_escape_string($link, $_POST['Email']);
	// attempt insert query execution
	$sql = "INSERT INTO Counselor (CounselorID, LastName, FirstName, Address, City, State, Zip, Phone, Email) VALUES ('$CounselorID', '$LastName', '$FirstName', '$Address', '$City', '$State', '$Zip', '$Phone', '$Email')";
	if(mysqli_query($link, $sql)){
		echo "Records added successfully.";
		} else{
		echo "ERROR: Unable to execute $sql. " . mysqli_error($link);
	}
	// close connection
	mysqli_close($link);
?>