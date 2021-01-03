<?php
session_start();
require "connect_oracle.php";
if (isset($_GET['action'])) {
    if ($_GET['action'] = 'add') {
        $code = $_GET['code'];
        $result = oci_parse($conn, "SELECT * FROM PRODUSE WHERE COD_PRODUS = $code");
        oci_execute($result);
        while ($row = oci_fetch_array($result, OCI_ASSOC + OCI_RETURN_NULLS)) {
            $itemArray = array($code=>array('denumire'=>$row['DENUMIRE'], 
                        'code'=>$code, 
                        'autor'=>$row['AUTOR'],
                        'editura'=>$row['EDITURA'],
                        'gen'=>$row['GEN'],
                        'pret'=>$row['PRET']));
        }
        if (isset($_SESSION['cart_items'])) {
            $_SESSION['cart_items'] = array_merge($_SESSION['cart_items'], $itemArray);
        }
        else
        {
            $_SESSION['cart_items'] = $itemArray;
        }
    }
    header("Location: ../products.php?add=success");
    exit();
}
?>
