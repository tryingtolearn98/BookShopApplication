
<?php
    $id = $_SESSION['userid'] ; 
    $rezultat = 0;
    $result = oci_parse($conn, "BEGIN number_orders(:id,:orders);END;");
    oci_bind_by_name($result, ":id", $id);
    oci_bind_by_name($result, ":orders", $rezultat);
    oci_execute($result);
    echo $rezultat;
?>