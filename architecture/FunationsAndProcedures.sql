--FUNCTII SI PROCEDURI 

--FUNCTIE PENTRU A VERIFICA DACA UN CLIENT SE AFLA IN BAZA DE DATE(PENTRU LOGARE)
--VERIFICAM DACA CLIENTUL INTRODUCE USERNAMEUL SAU EMAILUL , SI DUPA DACA EXISTA IN BAZA DE DATE VERIFICAM
--DACA PAROLELE SE POTRIVESC.DACA SE POTRIVESC RETURNAM 1 ALTFEL RETURNAM 0.

CREATE OR REPLACE FUNCTION user_login(userinfo varchar2,pass varchar2)
RETURN INTEGER AS
  v_countuser INTEGER;
  v_checkpass INTEGER;
  v_rezultat VARCHAR2(100) := '';
BEGIN
  SELECT SUBSTR(REVERSE(userinfo),10,1) INTO v_rezultat from DUAL;
  IF v_rezultat = '@' THEN
    SELECT COUNT(*) INTO v_countuser FROM LOGININFO WHERE email = userinfo;
    IF v_countuser = 1 THEN
      SELECT COUNT(*) INTO v_checkpass FROM LOGININFO WHERE email = userinfo AND pass = parola;
      IF v_checkpass = 1 THEN
        return 1;
      ELSE
        return 0;
      END IF;
    ELSE
      return 0;
    END IF;
  ELSE
    SELECT COUNT(*) INTO v_countuser FROM LOGININFO WHERE username = userinfo;
    IF v_countuser = 1 THEN
      SELECT COUNT(*) INTO v_checkpass FROM LOGININFO WHERE username = userinfo AND pass = parola;
      IF v_checkpass = 1 THEN
        return 1;
      ELSE
        return 0;
      END IF;
    ELSE
      return 0;
    END IF;
  END IF;
END;

--FUNCTIE CARE VERIFICA DACA USERNAMEUL SI EMAILUL EXISTA IN BAZA DE DATE PENTRU INREGISTRARE
--DACA NU EXISTA RETURNAM 1 - INSEAMNA CA UTILIZATORUL SE POATE INREGISTRA CU SUCCES
--ALTFEL RETURNAM 0 - UTILIZATORUL NU SE POATE INREGISTRA (USERNAME SAU EMAIL EXISTENT)

CREATE OR REPLACE FUNCTION user_exist(usern varchar2,useremail varchar2)
RETURN INTEGER AS
 v_countuser INTEGER;
 v_countemail INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_countuser FROM LOGININFO where usern = username;
  SELECT COUNT(*) INTO v_countemail FROM LOGININFO where useremail = email;
  IF v_countuser = 1 OR v_countemail = 1 THEN
    return 0;
  ELSE
    return 1;
  END IF;
END;

--AFISEAZA VARSTA UNUI CLIENT IN FUNCTIE DE ID DAT CA PARAMETRU.
CREATE OR REPLACE FUNCTION statistici_varsta(id_client INTEGER)
RETURN INTEGER AS
  v_date INTEGER;
BEGIN
  SELECT FLOOR(MONTHS_BETWEEN(SYSDATE,DATA_NASTERE)/12) INTO v_date FROM USERSINFO WHERE id_client = idc;
  return v_date;
END;

--Afiseaza numarul clientilor dintr-o anumita tara data ca parametru.
CREATE OR REPLACE FUNCTION statistici_tara(tara_client varchar2)
RETURN INTEGER AS
  v_tara INTEGER;
begin 
select count(*) into v_tara from adresa where tara_client=tara;
return v_tara;
end;

--Afiseaza numarul clientilor dintr-un anumit judet dat ca parametru.
CREATE OR REPLACE FUNCTION statistici_judet(judet_client varchar2)
RETURN INTEGER AS
  v_tara INTEGER;
begin 
select count(*) into v_tara from adresa where judet_client=judet;
return v_tara;
end;

CREATE OR REPLACE FUNCTION statistici_oras(oras_client varchar2)
RETURN INTEGER AS
  v_tara INTEGER;
begin 
select count(*) into v_tara from adresa where oras_client=oras;
return v_tara;
end;

CREATE OR REPLACE FUNCTION statistici_gen(gen_carte varchar2)
RETURN INTEGER AS
  v_count INTEGER;
begin 
select count(*) into v_count from produse where gen_carte=gen;
return v_count;
end;

CREATE OR REPLACE FUNCTION statistici_autor(autor_carte varchar2)
RETURN INTEGER AS
  v_count INTEGER;
begin 
select count(*) into v_count from produse where autor_carte=autor;
return v_count;
end;

--NUMARA CATE EDITURI SUNT IN MAGAZIN PENTRU UN ANUMIT PARAMETRU.
CREATE OR REPLACE FUNCTION statistici_editura(editura_carte varchar2)
RETURN INTEGER AS
  v_count INTEGER;
begin 
select count(*) into v_count from produse where editura_carte=editura;
return v_count;
end;

--NUMARA CATI UTILIZATORI AU UN ANUMIT GEN.
CREATE OR REPLACE FUNCTION statistici_sex(gen_pers varchar2)
RETURN INTEGER AS
  v_count INTEGER;
begin 
select count(*) into v_count from usersinfo where gen_pers=gen;
return v_count;
end;

--FUNCTIE CARE NUMARA CATI UTILIZATORI SUNT DE O ANUMITA VARSTA.
CREATE OR REPLACE FUNCTION statistici_varsta(varsta INTEGER)
RETURN INTEGER AS
  v_count INTEGER;
begin 
select count(*) into v_count from usersinfo where varsta=FLOOR(MONTHS_BETWEEN(SYSDATE,DATA_NASTERE)/12);
return v_count;
end;

--FUNCTIE CARE RETURNEAZA TITLUL CELEI MAI VANDUTE CARTI DIN MAGAZIN.
CREATE OR REPLACE FUNCTION statistici_cea_mai_vanduta
RETURN varchar2 AS
  v_titlu varchar2(50);
  v_id integer;
begin 
select * into v_id from (select cod_produs from comenzi group by cod_produs order by count(*) desc)where rownum<2;
select denumire into v_titlu from produse where v_id=cod_produs;
return v_titlu;
end;

--FUNCTIE CARE RETURNEAZA ORASUL UNDE SE AFLA CEI MAI MULTI CLIENTI.
CREATE OR REPLACE FUNCTION zone_de_cumparare_oras
RETURN varchar2 AS
  v_oras varchar2(30);
begin 
select * into v_oras from(select oras from adresa group by oras order by count(*) desc) where rownum<2;
return v_oras;
end;

CREATE OR REPLACE FUNCTION zone_de_cumparare_judet
RETURN varchar2 AS
  v_judet varchar2(30);
begin 
select * into v_judet from(select judet from adresa group by judet order by count(*) desc) where rownum<2;
return v_judet;
end;

--MEDIA DE VARSTA IN FUNCTIE DE CODUL CARTII.
CREATE OR REPLACE FUNCTION statistici_medie_varsta_cod(cod INTEGER)
RETURN varchar2 AS
  v_medie integer;
begin 
select ROUND(avg(FLOOR(MONTHS_BETWEEN(SYSDATE,DATA_NASTERE)/12))) INTO V_MEDIE FROM USERSINFO U JOIN COMENZI C ON C.IDC=U.IDC JOIN PRODUSE P ON P.COD_PRODUS=C.COD_PRODUS
WHERE cod=P.COD_PRODUS;
return v_medie;
end;

--FUNCTIE CARE RETURNEAZA MEDIA DE VARSTA A CITITORILOR IN FUNCTIE DE TITLUL CARTII DAT CA PARAMETRU.
CREATE OR REPLACE FUNCTION statistici_medie_varsta_titlu(titlu varchar2)
RETURN varchar2 AS
  v_medie integer;
begin 
select ROUND(avg(FLOOR(MONTHS_BETWEEN(SYSDATE,DATA_NASTERE)/12))) INTO V_MEDIE FROM USERSINFO U JOIN COMENZI C ON C.IDC=U.IDC JOIN PRODUSE P ON P.COD_PRODUS=C.COD_PRODUS
WHERE TITLU=P.DENUMIRE;
return v_medie;
end;

--FUNCTIE CARE RETURNEAZA MEDIA DE VARSTA A CITITORILOR IN FUNCTIE DE UN AUTOR DAT.
CREATE OR REPLACE FUNCTION statistici_medie_varsta_autor(aut varchar2)
RETURN varchar2 AS
  v_medie integer;
begin 
select ROUND(avg(FLOOR(MONTHS_BETWEEN(SYSDATE,DATA_NASTERE)/12))) INTO V_MEDIE FROM USERSINFO U JOIN COMENZI C ON C.IDC=U.IDC JOIN PRODUSE P ON P.COD_PRODUS=C.COD_PRODUS
WHERE aut=P.AUTOR;
return v_medie;
end;

--FUNCTIE CARE RETURNEAZA MEDIA DE VARSTA IN FUNCTIE DE GENUL DAT.
CREATE OR REPLACE FUNCTION statistici_medie_varsta_gen(genul varchar2)
RETURN varchar2 AS
  v_medie integer;
begin 
select ROUND(avg(FLOOR(MONTHS_BETWEEN(SYSDATE,DATA_NASTERE)/12))) INTO V_MEDIE FROM USERSINFO U JOIN COMENZI C ON C.IDC=U.IDC JOIN PRODUSE P ON P.COD_PRODUS=C.COD_PRODUS
WHERE genul=P.GEN;
return v_medie;
end;

--FUNCTIE CARE RETURNEAZA STOCUL OPTIM NECESAR PENTRU UN PRODUS IN FUNCTIE DE CANTITATEA VANDUTA.
CREATE OR REPLACE FUNCTION stoc_optim(cod integer)
RETURN varchar2 AS
  v_optim integer;
begin 
select (count(*)*4+20+500) into v_optim from comenzi where cod_produs=cod;
return v_optim;
end;

CREATE OR REPLACE TYPE var_array IS TABLE OF VARCHAR2(90);
--PROCEDURA , IN CARE O SA SALVAM UN ARRAY CU TOP-UL CELOR MAI VANDUTE CARTI DIN MAGAZIN
CREATE OR REPLACE PROCEDURE top_books (books_array IN OUT var_array) AS
i BINARY_INTEGER :=1;
CURSOR lista_carti  IS
      SELECT * FROM (SELECT p.denumire FROM produse p JOIN comenzi c ON c.cod_produs = p.cod_produs GROUP BY c.cod_produs,p.denumire ORDER BY COUNT(*) DESC) WHERE ROWNUM <= 10;
BEGIN
    FOR v_std_linie IN lista_carti LOOP     
            books_array.extend;
            books_array(i) := v_std_linie.denumire;
            i := i+1;
    END LOOP;  
END;

--FUNCTIE CARE RETURNEAZA RECOMANDARI
CREATE OR REPLACE FUNCTION recomandare(p_codc INTEGER)
RETURN varchar2 AS
   v_carte varchar2(25);
   cumparatura INTEGER;
   genul varchar2(20);
   v_id INTEGER;
   carte_inexistenta EXCEPTION;
   comanda_inexistenta exception;
   r_cod integer;
BEGIN
select * into cumparatura from (select cod_produs from comenzi where idc=p_codc) where rownum<2;
if cumparatura is null then
  raise comanda_inexistenta;
end if;
select * into genul from (select p.gen from produse p join comenzi c on c.cod_produs=p.cod_produs where p.cod_produs=cumparatura)where rownum<2;
select * into v_id from (select c.cod_produs from comenzi c join produse p on c.cod_produs=p.cod_produs where p.gen=genul and c.cod_produs!=cumparatura group by c.cod_produs order by count(*) desc)where rownum<2;
select denumire into v_carte from produse where v_id = cod_produs;
IF v_carte IS NULL THEN
  raise carte_inexistenta;
END IF;
return v_carte;
EXCEPTION
WHEN NO_DATA_FOUND THEN
return 'Nu exista';
WHEN carte_inexistenta THEN
r_cod:=dbms_random.value(1,500);
select denumire into v_carte from produse where cod_produs=r_cod;
WHEN comanda_inexistenta THEN
cumparatura:=dbms_random.value(1,500);
return v_carte;
END;

--PROCEDURA , IN CARE SALVAM CATE COMENZI ARE UN ANUMIT CLIENT
CREATE OR REPLACE PROCEDURE number_orders (id IN INTEGER, orders OUT VARCHAR2) AS
BEGIN
  SELECT COUNT(*) INTO orders FROM (SELECT COUNT(*) FROM COMENZI WHERE idc = id GROUP BY NR_COMANDA,IDC);
END;

set serveroutput on;
DECLARE
    BOOKS_ARRAY var_array := var_array(null);
    orders INTEGER := 0;
BEGIN
     TOP_BOOKS(BOOKS_ARRAY);
     number_orders(1,orders);
     DBMS_OUTPUT.PUT_LINE(orders);
END;

SELECT * FROM COMENZI;

select * from comenzi;
SELECT * FROM COMENZI WHERE IDC = 1000001;