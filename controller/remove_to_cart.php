<?php
    session_start();
    if(isset($_GET['action']))
    {
        if($_GET['action'] == 'remove')
        {
            $contor = 0;
            foreach($_SESSION['cart_items'] as $key => $item)
            {
                if($item['code'] == $_GET['code'])
                {
                    unset($_SESSION['cart_items'][$key]);
                }
            }
            if(sizeof($_SESSION['cart_items']) == 0)
            {
                unset($_SESSION['cart_items']);
            }
        }
        header("Location: ../cart.php?remove=success");
        exit();
    }
?>