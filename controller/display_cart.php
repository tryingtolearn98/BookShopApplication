<?php
    if(isset($_SESSION['cart_items']))
    {
        foreach($_SESSION['cart_items'] as $item)
        {

?>
    <tr>
        <td class="cart_product">
            <a href=""><img src="images/productr.png" alt=""></a>
        </td>
        <td class="cart_description">
            <h4><a href=""><?php echo $item['denumire']; ?></a></h4>
            <p><?php echo 'Autor ' . $item['autor']?></p>
            <p><?php echo 'Editura:' . $item['editura']?></p>
            <p><?php echo 'Gen:' . $item['gen']?></p>
        </td>
        <td class="cart_price">
            <p><?php echo 'Pret:' . $item['pret'] . 'LEI'?></p>
        </td>
        <td class="cart_quantity">
            <div class="cart_quantity_button">
                <a class="cart_quantity_up" href=""> + </a>
                <input class="cart_quantity_input" type="text" name="quantity" value="1" size="2">
                <a class="cart_quantity_down" href=""> - </a>
            </div>
        </td>
        <td class="cart_total">
            <p class="cart_total_price"><?php echo 'Pret:' . $item['pret'] . 'LEI' ?></p>
        </td>
        <td class="cart_delete">
            <a class="cart_quantity_delete" href="controller/remove_to_cart.php?action=remove&code=<?php echo $item["code"]; ?>"><i class="fa fa-times"></i></a>
        </td>
    </tr>

<?php
    }
?>

<tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td class="cart_order_price">
        Total price: <b>
            <?php
                $total_price = 0 ;
                foreach($_SESSION['cart_items'] as $item)
                {
                    $total_price += $item['pret'];
                }
                echo $total_price . 'LEI';
            ?>
        </b>&nbsp;
    </td>
</tr>

<tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td class="cart_order_button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="controller/checkout.php?action=checkout" class="btn btn-success">Checkout</a>
    </td>
</tr>

<?php
   }
   else echo "Nu aveti produse in cos!";
?>