<?php
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
$link = mysqli_connect('localhost', 'androidh_jan', 'Abc12345', "androidh_jan");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$name = $_GET['name'];
		$user = $_GET['user'];
		$password = $_GET['password'];
		$phone = $_GET['phone'];
		$email = $_GET['email'];
		$shed = $_GET['shed'];
		$avatar = $_GET['avatar'];
							
		$sql = "INSERT INTO `user_ung`(`id`, `name`, `user`, `password`, `phone`, `email`, `shed`, `avatar`) VALUES (Null,'$name','$user','$password','$phone','$email','$shed','$avatar')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Qur Doctor";
   
}
	mysqli_close($link);
?>