<?php
include 'conn.php';

$username = $_POST['username'];
$email = $_POST['email'];
$password1 = md5($_POST['password1']);
$password2 = md5($_POST['password2']);


$conn->query("INSERT INTO tb_user(username, email, password1, password2) VALUES 
('".$username."','".$email."','".$password1."', '".$password2."')");


?>