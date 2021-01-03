<?php
    require "connect_oracle.php";
    session_start();
    if(ISSET($_GET['action']))
    {
        if($_GET['action'] = 'checkout')
        {
            if(isset($_SESSION['cart_items']))
            {
                $result = oci_parse($conn, 'SELECT MAX(NR_COMANDA) FROM COMENZI');
                oci_execute($result);
                while ($row = oci_fetch_array($result, OCI_ASSOC+OCI_RETURN_NULLS)) {
                    $comanda_urm = $row['MAX(NR_COMANDA)'];
                }
                $comanda_urm ++;
                echo $comanda_urm;
                foreach($_SESSION['cart_items'] as $item)
                {
                    $result = oci_parse($conn, 'INSERT INTO COMENZI VALUES(:v1,:v2,:v3,:v4,:v5)');
                    oci_bind_by_name($result,':v1',$comanda_urm);
                    oci_bind_by_name($result,':v2',$_SESSION['userid']);
                    oci_bind_by_name($result,':v3',$item['code']);
                    $cantitate = 1;
                    $livrat = 0;
                    oci_bind_by_name($result,':v4',$cantitate);
                    oci_bind_by_name($result,':v5',$livrat);
                    oci_execute($result);
                }

                unset($_SESSION['cart_items']);
                header("Location: ../cart.php?checkout=succes");
                exit();
                
            }
            else
                echo 'Nu aveti produse';
        }
    }
?>