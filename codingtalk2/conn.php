<?php

$conn = new mysqli("localhost", "root", "", "db_codingtalk2");

if($conn){
} else{
    echo "Koneksi tidak terhubung";
    exit();
}



?>