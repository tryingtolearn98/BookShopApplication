<?php
require "header.php"
?>

<section id="cart_items">
    <div class="container">
        <div class="breadcrumbs">
            <ol class="breadcrumb">
                <li><a href="mainpage.php">Home</a></li>
                <li class="active">Wishlist</li>
            </ol>
        </div>
        <div class="table-responsive cart_info">
            <table class="table table-condensed">
                <thead>
                    <tr class="cart_menu">
                        <td class="image">Product</td>
                        <td class="description"></td>
                        <td class="price">Unit Price</td>
                        <td class="quantity">Stock Status</td>
                        <td class="total">Add to cart</td>
                        <td></td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="cart_product">
                            <a href=""><img src="images/productr.png" alt=""></a>
                        </td>
                        <td class="cart_description">
                            <h4><a href="">Book I</a></h4>
                            <p>Autor:</p>
                            <p>Editura:</p>
                            <p>Gen:</p>
                        </td>
                        <td class="cart_price">
                            <p>10Lei</p>
                        </td>
                        <td class="cart_stock">
                            <p>In stock!</p>
                        </td>
                        <td class="cart_order_button">
                            <a href="mainpage.php" class="btn btn-success">Add to cart</a>
                        </td>
                        <td class="cart_delete">
                            <a class="cart_quantity_delete" href=""><i class="fa fa-times"></i></a>
                        </td>
                    </tr>

                    <tr>
                        <td class="cart_product">
                            <a href=""><img src="images/productr.png" alt=""></a>
                        </td>
                        <td class="cart_description">
                            <h4><a href="">Book II</a></h4>
                            <p>Autor:</p>
                            <p>Editura:</p>
                            <p>Gen:</p>
                        </td>
                        <td class="cart_price">
                            <p>10Lei</p>
                        </td>
                        <td class="cart_stock">
                            <p>In stock!</p>
                        </td>
                        <td class="cart_order_button">
                            <a href="mainpage.php" class="btn btn-success">Add to cart</a>
                        </td>
                        <td class="cart_delete">
                            <a class="cart_quantity_delete" href=""><i class="fa fa-times"></i></a>
                        </td>
                    </tr>

                    <tr>
                        <td class="cart_product">
                            <a href=""><img src="images/productr.png" alt=""></a>
                        </td>
                        <td class="cart_description">
                            <h4><a href="">Book II</a></h4>
                            <p>Autor:</p>
                            <p>Editura:</p>
                            <p>Gen:</p>
                        </td>
                        <td class="cart_price">
                            <p>10Lei</p>
                        </td>
                        <td class="cart_stock">
                            <p>Out stock!</p>
                        </td>
                        <td class="cart_order_button">
                            <a href="mainpage.php" class="btn btn-success">Add to cart</a>
                        </td>
                        <td class="cart_delete">
                            <a class="cart_quantity_delete" href=""><i class="fa fa-times"></i></a>
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