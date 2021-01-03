<?php
require "header.php";
require "controller/connect_oracle.php";
?>
<div class="container">
    <div class="row">
        <div class="col-12">
            <div class="card">

                <div class="card-body">
                    <div class="card-title mb-4">
                        <div class="d-flex justify-content-start">
                            <div class="image-container">
                                <img src="https://i0.wp.com/www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png?fit=256%2C256&quality=100&ssl=1" id="imgProfile" style="width: 150px; height: 150px" class="img-thumbnail" />
                            </div>
                            <div class="userData ml-3">
                                <h2 class="d-block" style="font-size: 1.5rem; font-weight: bold"><a href="javascript:void(0);"><?php echo $_SESSION['prenume']?></a></h2>
                                <h6 class="d-block"><a href="javascript:void(0);"><?php require "controller/number_orders.php" ?></a> Comenzi efectuate</h6>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <ul class="nav nav-tabs mb-4" id="myTab" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" id="basicInfo-tab" data-toggle="tab" href="#basicInfo" role="tab" aria-controls="basicInfo" aria-selected="true">Basic Info</a>
                                </li>
                            </ul>
                            <div class="tab-content ml-1" id="myTabContent">
                                <div class="tab-pane fade show active" id="basicInfo" role="tabpanel" aria-labelledby="basicInfo-tab">


                                    <div class="row">
                                        <div class="col-sm-3 col-md-2 col-5">
                                            <label style="font-weight:bold;">Full Name</label>
                                        </div>
                                        <div class="col-md-8 col-6">
                                            <?php echo $_SESSION['nume'] . ' ' . $_SESSION['prenume'] ?>
                                        </div>
                                    </div>
                                    <hr />

                                    <div class="row">
                                        <div class="col-sm-3 col-md-2 col-5">
                                            <label style="font-weight:bold;">Birth Date</label>
                                        </div>
                                        <div class="col-md-8 col-6">
                                            <?php echo $_SESSION['data_nastere']  ?>
                                        </div>
                                    </div>
                                    <hr />


                                    <div class="row">
                                        <div class="col-sm-3 col-md-2 col-5">
                                            <label style="font-weight:bold;">Gender</label>
                                        </div>
                                        <div class="col-md-8 col-6">
                                            <?php echo $_SESSION['gen']  ?>
                                        </div>
                                    </div>
                                    <hr />
                                    <div class="row">
                                        <div class="col-sm-3 col-md-2 col-5">
                                            <label style="font-weight:bold;">Street</label>
                                        </div>
                                        <div class="col-md-8 col-6">
                                            <?php echo $_SESSION['strada']  ?>
                                        </div>
                                    </div>
                                    <hr />
                                    <div class="row">
                                        <div class="col-sm-3 col-md-2 col-5">
                                            <label style="font-weight:bold;">Block</label>
                                        </div>
                                        <div class="col-md-8 col-6">
                                            <?php echo $_SESSION['bloc']  ?>
                                        </div>
                                    </div>
                                    <hr />
                                    <div class="row">
                                        <div class="col-sm-3 col-md-2 col-5">
                                            <label style="font-weight:bold;">Street Number</label>
                                        </div>
                                        <div class="col-md-8 col-6">
                                            <?php echo $_SESSION['numar_strada']  ?>
                                        </div>
                                    </div>
                                    <hr />
                                    <div class="row">
                                        <div class="col-sm-3 col-md-2 col-5">
                                            <label style="font-weight:bold;">City</label>
                                        </div>
                                        <div class="col-md-8 col-6">
                                            <?php echo $_SESSION['oras']  ?>
                                        </div>
                                    </div>
                                    <hr />
                                    <div class="row">
                                        <div class="col-sm-3 col-md-2 col-5">
                                            <label style="font-weight:bold;">County</label>
                                        </div>
                                        <div class="col-md-8 col-6">
                                            <?php echo $_SESSION['judet']  ?>
                                        </div>
                                    </div>
                                    <hr />
                                    <div class="row">
                                        <div class="col-sm-3 col-md-2 col-5">
                                            <label style="font-weight:bold;">Country</label>
                                        </div>
                                        <div class="col-md-8 col-6">
                                            <?php echo $_SESSION['tara']  ?>
                                        </div>
                                    </div>
                                    <hr />

                                </div>
                            </div>
                        </div>
                    </div>


                </div>

            </div>
        </div>
    </div>
</div>
<?php
require "footer.php"
?>