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
if($_POST['id'])
{
 $id=$_POST['id'];
 
 $stmt = $DB_con->prepare("SELECT DISTINCT city  FROM cities_extended WHERE state_code=:id ORDER BY city ASC");
 $stmt->execute(array(':id' => $id));
 ?><option selected="selected">Select City :</option><?php
 while($row=$stmt->fetch(PDO::FETCH_ASSOC))
 {
  ?>
  <option value="<?php echo $row['city']; ?>"><?php echo $row['city']; ?></option>
  <?php
 }
}
?>
