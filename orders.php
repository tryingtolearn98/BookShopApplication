<?php
require "header.php"
?>

<section id="cart_items">
    <div class="container">
        <div class="breadcrumbs">
            <ol class="breadcrumb">
                <li><a href="mainpage.php">Home</a></li>
                <li class="active">Orders</li>
            </ol>
        </div>
        <div class="table-responsive cart_info">
            <table class="table table-condensed">
                <thead>
                    <tr class="cart_menu">
                        <td class="image">Orders</td>
                        <td class="description">Details</td>
                        <td class="price">Total Price</td>
                        <td class="quantity">Delivered</td>
                        <td></td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="cart_product">
                            <a href="#"><img src="images/order.png" alt=""></a>
                        </td>
                        <td class="cart_description">
                            <h4><a href="">Order-1</a></h4>
                            <p>Book-1</p>
                            <p>Book-10</p>
                        </td>
                        <td class="cart_price">
                            <p>35Lei</p>
                        </td>
                        <td class="cart_stock">
                            <p>Yes!</p>
                        </td>
                    </tr>

                    <tr>
                        <td class="cart_product">
                            <a href="#"><img src="images/order.png" alt=""></a>
                        </td>
                        <td class="cart_description">
                            <h4><a href="">Order-2</a></h4>
                            <p>Book-4</p>
                        </td>
                        <td class="cart_price">
                            <p>20Lei</p>
                        </td>
                        <td class="cart_stock">
                            <p>No!</p>
                        </td>
                    </tr>

                    <tr>
                        <td class="cart_product">
                            <a href="#"><img src="images/order.png" alt=""></a>
                        </td>
                        <td class="cart_description">
                            <h4><a href="">Order-3</a></h4>
                            <p>Book-2</p>
                            <p>Book-3</p>
                        </td>
                        <td class="cart_price">
                            <p>60Lei</p>
                        </td>
                        <td class="cart_stock">
                            <p>Yes!</p>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</section>

<?php
require "footer.php"
?>