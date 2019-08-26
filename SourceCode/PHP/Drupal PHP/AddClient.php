<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Add Client Form</title>
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
}?>
<script type="text/javascript"> 

function stopRKey(evt) { 
  var evt = (evt) ? evt : ((event) ? event : null); 
  var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null); 
  if ((evt.keyCode == 13) && (node.type=="text"))  {return false;} 
} 

document.onkeypress = stopRKey; 

</script>
<script type="text/javascript" src="jquery-1.12.3.min.js"></script>
<script type="text/javascript">
$(document).ready(function()
{
 
 $(".State").change(function()
 {
  var id=$(this).val();
  var dataString = 'id='+ id;

  $.ajax
  ({
   type: "POST",
   url: "get_city.php",
   data: dataString,
   cache: false,
   success: function(html)
   {
    $(".City").html(html);
	
   } 
  
   
   });
    
   
   
  });
   $(".City").change(function()
 {
 var id=$(this).val();
  var dataString = 'id='+ id;
  var id1=$(".State").val();
  var dataString1 = 'id1='+ id1;
  $.ajax
  ({
   type: "POST",
   url: "get_zip.php",
   data: {id: id, id1: id1},
   cache: false,
   success: function(html)
   {
    $(".Zip").html(html);
   } 
   });
   
  });
  
 
});
</script>

</head>
<body>

<form action="/LWC/insertClient.php" method="post">
    <p>
        <label for="ClientID">ID:</label>
        <input type="text" name="ClientID" id="ClientID">
    </p>
    <p>
        <label for="FirstName">First Name:</label>
        <input type="text" name="FirstName" id="FirstName">
    </p>
    <p>
        <label for="LastName">Last Name:</label>
        <input type="text" name="LastName" id="LastName">
    </p>
<p>
        <label for="Address">Address:</label>
        <input type="text" name="Address" id="Address">
    </p>
     <p>
        
		<label>State :</label> 
<select name="State" id="State" class="State">
<option selected="selected">--Select State--</option>
<?php
 $stmt = $DB_con->prepare("SELECT * FROM states");
 $stmt->execute();
 while($row=$stmt->fetch(PDO::FETCH_ASSOC))
 {
  ?>
        <option value="<?php echo $row['state_code']; ?>"><?php echo $row['state']; ?></option>
        <?php
 } 
?>


</select>

</p>
<p>
<label>City :</label> 
<select name="City" id="City" class="City">
<option selected="selected">--Select City--</option>
</select>
   
        <label>Zip :</label> <select name="Zip" id="Zip" class="Zip">
<option selected="selected">--Zip--</option>

</select>
    </p>
<p>
        <label for="Phone">Phone:</label>
        <input type="text" name="Phone" id="Phone">
    </p>
<p>
        <label for="Email">Email:</label>
        <input type="text" name="Email" id="Email">
    </p>

    <input type="submit" value="Submit">
</form>

</body>
</html>
