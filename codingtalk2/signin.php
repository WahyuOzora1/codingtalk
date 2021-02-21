<?php

include 'conn.php';

$email = $_POST['email'];
$password1 = md5($_POST['password1']);

$query = "SELECT * FROM tb_user WHERE email = '".$email."' AND password1 = '".$password1."'";


$result = mysqli_query($conn, $query); //do query
// $count = mysqli_num_rows($result);


if($row = $result->fetch_assoc()){
    $data = array(
        "message" => "Success", 
        "body" => $row,
    );
    echo json_encode($data);
} else {
    $data = array(
        "message" => "Failed",
        "body" => null,
    );
    echo json_encode($data);
}

?>