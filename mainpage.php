<?php
require "header.php";
require "controller/connect_oracle.php";
?>


<main>
    <p class="subtitle fancy"><span>Recommended books for you</span></p>
        <div class="col-sm-12">
        <div class="features_items">
            <?php require "controller/show_recommended.php" ?>
        </div>
    </div>
</main>



<?php
require "footer.php"
?>