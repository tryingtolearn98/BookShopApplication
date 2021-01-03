<?php



if (isset($_POST['singup'])) {
    require "connect_oracle.php";
    $email = $_POST['email'];
    $name = $_POST['username'];
    $password = $_POST['password'];
    $repassword = $_POST['repassword'];
    $fname = $_POST['fname'];
    $lname = $_POST['lname'];
    $street = $_POST['street'];
    $number = $_POST['number'];
    $block = $_POST['block'];
    $city = $_POST['city'];
    $county = $_POST['county'];
    $country = $_POST['country'];
    $date = $_POST['datanastere'];
    $gen = $_POST['gen'];
    $tip = "Obisnuit";
    if (
        empty($email) || empty($name) || empty($password) || empty($repassword)
        || empty($fname) || empty($lname) || empty($street) || empty($number)
        || empty($block) || empty($city) || empty($county) || empty($country) 
        || empty($date) || empty($gen)
    ) {
        header("Location: ../singup.php?error=emptyfield");
        exit();
    } else if (!filter_var($email, FILTER_VALIDATE_EMAIL) && !preg_match("/^[a-zA-Z0-9]*$/", $name)) {
        header("Location: ../singup.php?error=invalidmailuid");
        exit();
    } else if (!empty($mail) && !filter_var($mail, FILTER_VALIDATE_EMAIL)) {
        header("Location: ../singup.php?error=invalidmail&uid=" . $name);
        exit();
    } else if (!preg_match("/^[a-zA-Z0-9_]*$/", $name)) {
        header("Location: ../singup.php?error=invaliduid&mail=" . $email);
        exit();
    } else if ($password !== $repassword) {
        header("Location: ../singup.php?error=passwordcheck&uid=" . $name . "&email=" . $email);
        exit();
    } else {
        $result = oci_parse($conn, 'begin :res := user_exist(:usern,:usere); end;');
        oci_bind_by_name($result, ":usern", $name);
        oci_bind_by_name($result, ":usere", $email);
        oci_bind_by_name($result, ':res', $res);
        oci_execute($result);

        if($res == 0) /*Nu ne putem conecta la baza de date , deoarece mail-ul sau username-ul este luat.*/
        {
            header("Location: ../singup.php?error=mailorusernametaken");
            exit();
        }
        /*Ne putem conecta la baza de date , scriem informatiile despre useri
        IDC - id-ul care il va avea userul in baza de date , username , parola , mail ,tip - Tabelul LOGININFO
        IDC - id-ul , nume , prenume ,data_nastere,gen
        IDC - id-ul , strada , bloc , numar_strada , oras , judet , tara
        */
        else if($res == 1)
        {
            $result = oci_parse($conn, "SELECT COUNT(*) FROM LOGININFO");
            oci_execute($result);
            while ($row = oci_fetch_array($result, OCI_ASSOC+OCI_RETURN_NULLS)) {
                $numberRecords =  $row['COUNT(*)'];
            }

            echo $numberRecords;
            
            $numberRecords = $numberRecords + 1;

            echo '</br>';

            echo $numberRecords;
            /*Introducem in LOGININFO*/
            $result = oci_parse($conn, "INSERT INTO LOGININFO VALUES (:v1,:v2,:v3,:v4,:v5)");
            oci_bind_by_name($result, ":v1", $numberRecords);
            oci_bind_by_name($result, ":v2", $name);
            oci_bind_by_name($result, ':v3', $password);
            oci_bind_by_name($result, ':v4', $email);
            oci_bind_by_name($result, ':v5', $tip);
            
            oci_execute($result);
            
            /*Introducem in USERSINFO*/
            $result = oci_parse($conn, "INSERT INTO USERSINFO VALUES (:v1,:v2,:v3,TO_DATE(:v4,'MM-DD-YYYY'),:v5)");
            oci_bind_by_name($result, ":v1", $numberRecords);
            oci_bind_by_name($result, ":v2", $lname);
            oci_bind_by_name($result, ':v3', $fname);
            oci_bind_by_name($result, ':v4', $date);
            oci_bind_by_name($result, ':v5', $gen);
            
            oci_execute($result);

            /*Introducem in ADRESA*/
            $result = oci_parse($conn, "INSERT INTO ADRESA VALUES (:v1,:v2,:v3,:v4,:v5,:v6,:v7)");
            oci_bind_by_name($result, ":v1", $numberRecords);
            oci_bind_by_name($result, ":v2", $street);
            oci_bind_by_name($result, ':v3', $block);
            oci_bind_by_name($result, ':v4', $number);
            oci_bind_by_name($result, ':v5', $city);
            oci_bind_by_name($result, ':v6', $county);
            oci_bind_by_name($result, ':v7', $country);

            oci_execute($result);

            header("Location: ../singup.php?singup=succes");
            exit();
        }
    }
}

?>
