<?php
	$servername = "localhost";
	$username = "testuser";
	$password = "testpassword";
	$dbname = "LWC";
	
	// Create connection
	$conn = new mysqli($servername, $username, $password, $dbname);
	// Check connection
	if ($conn->connect_error) 
	{
		die("Connection failed: " . $conn->connect_error);
	} 			
	
	$sql = "SELECT * FROM CounselingLog ORDER BY Date DESC, SessionStart ASC";
	
	$result = $conn->query($sql);
	echo "<html>";
	echo "<head>";
	echo "</head>";
	echo "<body>";
	echo "<form action='/LWC/deleteSessions.php' method='post'>";
	echo"<div id='allSessions' style='display:block;'>";
	echo "<table>";
	echo "<tr><th>Select Session</th><th>Session ID</th><th>Room Number</th><th>Counselor ID</th><th>Counselor</th><th>Client ID</th><th>Session Start Time</th><th>Session End Time</th><th>Date</th><th>Session Duration</th></tr>";
	
	if ($result->num_rows > 0) 
	{
		// output data of each row
		while($row = $result->fetch_assoc()) 
		{    
			$CounselorID = $row['CounselorID'];
			$sql1 = "SELECT FirstName,LastName FROM Counselor WHERE CounselorID=$CounselorID";
			$result1 = mysqli_query($conn, $sql1);
			$Counselor = mysqli_fetch_assoc($result1);
			//$result1 = $conn->query($sql1);
			//$result1="hi";
			echo "<tr>
			<td>
			<input type='radio' name='sessionID' value='" . $row["sessionID"]. "'>
			</td>
			<td>
			" . $row["sessionID"]. "
			</td>
			<td>
			". $row["Room"]. "
			</td>
			<td>
			". $row["CounselorID"]. "
			</td>
			<td>
			" . $Counselor["FirstName"] . " " .$Counselor["LastName"] ."
			</td>
			<td>
			". $row["ClientID"]. "
			</td>
			<td>
			". $row["SessionStart"]. "
			</td>
			<td>
			". $row["SessionEnd"]. "
			</td>
			<td>
			". $row["Date"]. "
			</td>
			<td>
			". $row["Duration"]. "
			</td>
			</tr>";
		}
		echo "</table>";
		echo"</div>";
	} 
	else 
	{
		echo "0 results";
	}
?>
   	
<input type='submit' value='DELETE' />
<form action='/LWC/sortSessions.php' method='post'>	
	
</body>
</html>
<?php
	$conn->close();
?>			