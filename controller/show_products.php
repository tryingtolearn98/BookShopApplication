<?php

/*Numarul de produse pe pagina*/
$result_per_page = 16;

$result = oci_parse($conn, "SELECT COUNT(*) FROM PRODUSE");
oci_execute($result);
while ($row = oci_fetch_array($result, OCI_ASSOC + OCI_RETURN_NULLS)) {
    $number_of_results = $row['COUNT(*)'];
}

$number_of_pages = ceil($number_of_results/$result_per_page);

if(!isset($_GET['page'])){
    $page = 1;
}else{
    $page = $_GET['page'];
}
$this_page_first_result = ($page)*$result_per_page - 15;
$result = oci_parse($conn, "select * from produse WHERE COD_PRODUS >= $this_page_first_result AND COD_PRODUS <= $this_page_first_result+15 ORDER BY COD_PRODUS ");
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
                <form method="post" action="controller/add_to_cart.php?action=add&code=<?php echo $row['COD_PRODUS'] ?>">
                    <div class="product-overlay">
                        <div class="overlay-content">
                            <h2><?php echo "Autor: " . $row['AUTOR']; ?></h2>
                            <h2><?php echo "Editura: " . $row['EDITURA']; ?></h2>
                            <h2><?php echo "Gen: " . $row['GEN']; ?></h2>
                            <h2><?php echo "Pret: " . $row['PRET'] . " LEI"; ?></h2>
                            <p><?php echo "Titlu: " . $row['DENUMIRE']; ?></p>
                            <button type = "submit" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</button>
                        </div>
                    </div>
                </form>
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
<nav aria-label="Page navigation example">
<nav aria-label="Page navigation example">
<ul class="pagination">
<?php
    if(!isset($_GET['page'])){
        $page = 1;
    }else{
        $page = $_GET['page']-1;
    }
    echo '<li class="page-item"><a class="page-link"  href="products.php?page=' . $page . '">' . 'Previous</a></li>';
    for($page = 1 ; $page <= 25 ; $page++)
    {
        echo '<li class="page-item"><a class="page-link" 
        href="products.php?page=' . $page . '">' . $page . '</a></li>';
    }
    echo '<li class="page-item"><a class="page-link" href="products.php?page=' . $number_of_pages  . '">' . '...</a></li>';
    if(!isset($_GET['page'])){
        $page = 2;
    }else{
        $page = $_GET['page']+1;
    }
    if(isset($_GET['page']))
    {
        IF($_GET['page']+1 > 62500)
            $page = $_GET['page']-1;
    }
    echo '<li class="page-item"><a class="page-link"  href="products.php?page=' . $page . '">' . 'Next</a></li>';
?>

</ul>
</nav>
<br>