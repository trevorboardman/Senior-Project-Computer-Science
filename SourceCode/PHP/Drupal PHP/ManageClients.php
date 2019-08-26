<?php
$servername = "localhost";
$username = "testuser";
$password = "testpassword";
$dbname = "LWC";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

$sql = "SELECT * FROM Client";
$result = $conn->query($sql);
echo "<html>";
echo "<head>";
echo "</head>";
echo "<body>";
echo "<table>";
echo "<tr><th>ID</th><th>Name</th><th>Address</th><th>Phone</th><th>Email</th></tr>";
if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
        echo "<tr><td>" . $row["ClientID"]. "</td><td>" . $row["FirstName"]. "  " . $row["LastName"]. " </td><td>" . $row["Address"]. " ". $row["City"]. ", " . $row["State"]." " . $row["Zip"]. "</td><td>". $row["Phone"]. "</td><td>". $row["Email"]. "</td></tr>";
    }
echo "</table>";

} else {
    echo "0 results";
}
$conn->close();
?>
<button onclick="window.location='/?q=node/8'">+ Add Client</button>
</body>
</html>