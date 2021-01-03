<?php
    $id = $_SESSION['userid'];
    $res = "rezultat";
    $result = oci_parse($conn, 'begin :res := recomandare(:userid); end;');
    oci_bind_by_name($result, ":userid", $id);
    oci_bind_by_name($result, ":res", $res);
    oci_execute($result);

    if($res == 'Nu exista')
    {
        echo "Va trebuie sa faceti cumparaturi pentru a va recomanda o carte!";
        exit();
    }
        $result = oci_parse($conn, "SELECT * FROM (SELECT * FROM PRODUSE WHERE denumire = :v) WHERE ROWNUM < 2");
        oci_bind_by_name($result, ":v", $res);
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