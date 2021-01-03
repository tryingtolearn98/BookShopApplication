<?php
    
    $result = oci_parse($conn, "SELECT * FROM (SELECT p.denumire,p.pret,p.autor,p.editura,p.gen,p.cod_produs FROM produse p JOIN comenzi c ON c.cod_produs = p.cod_produs GROUP BY p.denumire,p.pret,p.autor,p.editura,p.gen,p.cod_produs ORDER BY COUNT(*) DESC) WHERE ROWNUM <= 10");
    oci_execute($result);
    while ($row = oci_fetch_array($result, OCI_ASSOC + OCI_RETURN_NULLS)) {

        ?>
        <div class="col-sm-3">
        <div class="product-image-wrapper">
            <div class="single-products">
                <div class="productinfo text-center">
                    <img src="images/product.png" alt="book image" height="230px" />
                    <h2><?php echo $row['PRET'] . " LEI"; ?></h2>
                    <p><?php echo $row['DENUMIRE']; ?></p>
                    <a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
                </div>
                <div class="product-overlay">
                    <div class="overlay-content">
                        <h2><?php echo "Autor: " . $row['AUTOR']; ?></h2>
                        <h2><?php echo "Editura: " . $row['EDITURA']; ?></h2>
                        <h2><?php echo "Gen: " . $row['GEN']; ?></h2>
                        <h2><?php echo "Pret: " . $row['PRET'] . " LEI"; ?></h2>
                        <p><?php echo "Titlu: " . $row['DENUMIRE']; ?></p>
                        <a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
                    </div>
                </div>
            </div>
            <div class="choose">
                <ul class="nav nav-pills nav-justified">
                    <li><a href="#"><i class="fa fa-plus-square"></i>Add to wishlist</a></li>
                </ul>
            </div>
        </div>
        </div>
    <?php
    }
    ?>
    
