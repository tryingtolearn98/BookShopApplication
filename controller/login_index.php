<?php

    if (isset($_POST['login'])) {
        require "connect_oracle.php";
        $username = $_POST['username'];
        $password = $_POST['password'];
        if(empty($username) || empty($password))
        {
            header("Location: ../index.php?error=emptyfields");
            exit();
        }else{
            $result = oci_parse($conn, 'begin :res := user_login(:useri,:userp); end;');
            oci_bind_by_name($result, ":useri", $username);
            oci_bind_by_name($result, ":userp", $password);
            oci_bind_by_name($result, ':res', $res);
            oci_execute($result);
            
           /*Daca $res este 0 inseamna ca userul nu se poate loga in aplicatie numa / parola incorecte
           altfel el se poate loga $res = 1*/
           if($res == 0)
           {
                header("Location: ../index.php?error=wrongpasswordoruser");
                exit();
           }else if($res == 1)
           {
                session_start();
                $result = oci_parse($conn, "SELECT idc FROM LOGININFO WHERE username = :v");
                oci_bind_by_name($result, ":v", $username);
                oci_execute($result);
                while ($row = oci_fetch_array($result, OCI_ASSOC+OCI_RETURN_NULLS)) {
                    $idc =  $row['IDC'];
                }

                /*Cautam datele despre user sa le adaugam in sesiune*/
                $result = oci_parse($conn,"SELECT * from USERSINFO where idc = :v");
                oci_bind_by_name($result, ":v", $idc);
                oci_execute($result);
                while ($row = oci_fetch_array($result, OCI_ASSOC+OCI_RETURN_NULLS)) {
                    $nume =  $row['NUME'];
                    $prenume = $row['PRENUME'];
                    $data_nastere = $row['DATA_NASTERE'];
                    $gen = $row['GEN'];
                }

                $result = oci_parse($conn,"SELECT * from ADRESA where idc = :v");
                oci_bind_by_name($result, ":v", $idc);
                oci_execute($result);
                while ($row = oci_fetch_array($result, OCI_ASSOC+OCI_RETURN_NULLS)) {
                    $strada =  $row['STRADA'];
                    $bloc = $row['BLOC'];
                    $numbar_strada = $row['NUMAR_STRADA'];
                    $oras = $row['ORAS'];
                    $judet = $row['JUDET'];
                    $tara = $row['TARA'];
                }
               
                $_SESSION['userid'] = $idc;
                $_SESSION['nume'] = $nume;
                $_SESSION['prenume'] = $prenume;
                $_SESSION['data_nastere'] = $data_nastere;
                $_SESSION['gen'] = $gen;
                $_SESSION['strada'] = $strada;
                $_SESSION['bloc'] = $bloc;
                $_SESSION['numar_strada'] = $numbar_strada;
                $_SESSION['oras'] = $oras;
                $_SESSION['judet'] = $judet;
                $_SESSION['tara'] = $tara;
                header("Location: ../mainpage.php");
                exit(); 
                
           }
        }
    }

?>