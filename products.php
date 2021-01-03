<?php
require "header.php";
require "controller/connect_oracle.php";
?>

<p class="subtitle fancy"><span>Products</span></p>

<div class="col-sm-12">
    <div class="features_items">
        <?php require "controller/show_products.php" ?>
    </div>
</div>
<?php
require "footer.php"
?>