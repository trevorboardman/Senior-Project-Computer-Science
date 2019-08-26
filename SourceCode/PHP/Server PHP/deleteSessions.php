<?php
	
	$link = mysqli_connect("localhost", "testuser", "testpassword", "LWC");
	
	if($link === false){
		die("ERROR: Could not connect. " . mysqli_connect_error());
	}
	
	$SessionID = mysqli_real_escape_string($link, $_POST['sessionID']);
	$sql =  "DELETE FROM CounselingLog WHERE sessionID='$SessionID'";
	
	
	if(mysqli_query($link, $sql)){
		
		$alert = "Session Deleted Successfully\\nSessionID: " . $SessionID;
		echo "<script type='text/javascript'>alert('".$alert."');</script>";
		
		echo "<script>setTimeout(\"location.href = '/?q=node/5';\",0);</script>";
		} else{
		echo "ERROR: Could not able to execute $sql. " . mysqli_error($link);
	}
	
	// close connection
	mysqli_close($link);
?>
