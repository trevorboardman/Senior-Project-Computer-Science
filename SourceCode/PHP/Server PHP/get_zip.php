<?php
$DB_host = "localhost";
$DB_user = "testuser";
$DB_pass = "testpassword";
$DB_name = "LWC";

try
{
 $DB_con = new PDO("mysql:host={$DB_host};dbname={$DB_name}",$DB_user,$DB_pass);
 $DB_con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
}
catch(PDOException $e)
{
 $e->getMessage();
}
 $id=$_POST['id'];
$id1=$_POST['id1'];
 $stmt = $DB_con->prepare("SELECT zip  FROM cities_extended WHERE city=:id AND state_code=:id1");
 
 $stmt->execute(array(':id' => $id, ':id1' => $id1));
 ?><?php
 while($row=$stmt->fetch(PDO::FETCH_ASSOC))
 {
  ?>
        <option  value="<?php echo $row['zip']; ?>"><?php echo $row['zip']; ?></option>
        <?php
 }

?>

