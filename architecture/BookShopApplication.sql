--CREEARE TABELE + CONSTRANGERI
DROP TABLE ADRESA CASCADE CONSTRAINTS
/
DROP TABLE COMENTARII CASCADE CONSTRAINTS
/
DROP TABLE COMENZI CASCADE CONSTRAINTS
/
DROP TABLE LOGININFO CASCADE CONSTRAINTS
/
DROP TABLE PRODUSE CASCADE CONSTRAINTS
/
DROP TABLE COS CASCADE CONSTRAINTS
/
DROP TABLE STOC CASCADE CONSTRAINTS
/
DROP TABLE USERSINFO CASCADE CONSTRAINTS

/

DROP TABLE FAVORITE CASCADE CONSTRAINTS

/


CREATE TABLE LOGININFO (
IDC INT NOT NULL PRIMARY KEY,
Username VARCHAR2(35) NOT NULL UNIQUE,
Parola VARCHAR2(40) NOT NULL,
email VARCHAR2(45) NOT NULL UNIQUE,
TIP VARCHAR2(15) NOT NULL
)

/

CREATE TABLE USERSINFO(
IDC INT NOT NULL PRIMARY KEY,
Nume VARCHAR2(30) NOT NULL,
Prenume VARCHAR2(30) NOT NULL,
Data_Nastere DATE,
Gen VARCHAR2(3),
CONSTRAINT fk_USERSINFO_IDC FOREIGN KEY (IDC) REFERENCES LOGININFO(IDC)
)

/

CREATE TABLE Adresa(
IDC INT NOT NULL PRIMARY KEY,
Strada VARCHAR2(30) NOT NULL,
Bloc VARCHAR2(10) ,
Numar_Strada VARCHAR2(10) NOT NULL,
Oras VARCHAR2(20) NOT NULL,
Judet VARCHAR2(20) NOT NULL,
Tara VARCHAR2(20) NOT NULL,
CONSTRAINT fk_Adresa_IDC FOREIGN KEY (IDC) REFERENCES USERSINFO(IDC)
)

/

CREATE TABLE Produse(
COD_PRODUS INT NOT NULL PRIMARY KEY,
Denumire VARCHAR2(50) NOT NULL,
Autor VARCHAR2(30) NOT NULL,
Editura VARCHAR2(30) NOT NULL,
Gen VARCHAR2(25) NOT NULL,
Pret NUMBER(6,2) NOT NULL
)

/

CREATE TABLE Stoc(
COD_PRODUS INT NOT NULL PRIMARY KEY,
Cantitate INT NOT NULL,
CONSTRAINT fk_Stoc_COD_PRODUS FOREIGN KEY (COD_PRODUS) REFERENCES Produse(COD_PRODUS)
)

/

CREATE TABLE Comenzi(
NR_COMANDA INT NOT NULL PRIMARY KEY,
IDC INT NOT NULL ,
COD_PRODUS INT NOT NULL ,
CANTITATE INT NOT NULL,
LIVRAT VARCHAR2(2) NOT NULL,
CONSTRAINT fk_Comenzi_COD_PRODUS FOREIGN KEY (COD_PRODUS) REFERENCES Produse(COD_PRODUS),
CONSTRAINT fk_Comenzi_IDC FOREIGN KEY (IDC) REFERENCES LOGININFO(IDC)
)

/

CREATE TABLE Cos(
IDC INT NOT NULL ,
COD_PRODUS INT NOT NULL,
Cantitate INT NOT NULL,
PRIMARY KEY (IDC,COD_PRODUS),
CONSTRAINT fk_Cos_COD_PRODUS FOREIGN KEY (COD_PRODUS) REFERENCES Produse(COD_PRODUS),
CONSTRAINT fk_Cos_IDC FOREIGN KEY (IDC) REFERENCES LOGININFO(IDC)
)

/

CREATE TABLE Favorite(
IDC INT NOT NULL,
COD_PRODUS INT NOT NULL,
PRIMARY KEY (IDC,COD_PRODUS),
CONSTRAINT fk_Favorite_COD_PRODUS FOREIGN KEY (COD_PRODUS) REFERENCES Produse(COD_PRODUS),
CONSTRAINT fk_Favorite_IDC FOREIGN KEY (IDC) REFERENCES LOGININFO(IDC)
)

/

CREATE TABLE Comentarii(
ID_Com INT NOT NULL PRIMARY KEY,
COD_PRODUS INT NOT NULL,
Comentariu VARCHAR2(350),
CONSTRAINT fk_Comentarii_COD_PRODUS FOREIGN KEY (COD_PRODUS) REFERENCES Produse(COD_PRODUS)
)

/

-- POPULARE TABELE

SET SERVEROUTPUT ON;
DECLARE
  TYPE varr IS VARRAY(1000) OF varchar2(255);
  lista_denumire varr:=varr('Do Androids Dream of Electric Sheep? ','To Kill','Midnight in the Garden','Where the Wild'
  , 'One Hundred Years' , 'A Heartbreaking Work' , 'The Elephant Tree' , 'Another Bullshit' , 'A Wrinkle' , 'Neverwhere' 
  , 'The Grapes of Wrath' , 'When You Are Engulfed', 'Brave New World' , 'The Catcher in the Rye' , 'The Zombie Room'
  , 'Trainspotting' , 'Factotum' , 'Invisible Monsters' , 'Lunar Park' , 'The Wasp Factory' , 'As I Lay Dying' , 'Fuck This Book' 
  , 'Mistress Suffragette' , 'Less Than Zero' , 'The Bell Jar' , 'Pale Fire' , 'Things Fall Apart' , 'Crash' , 'The Sluts' 
  , 'The Idiot' , 'Water for Elephants' , 'The Book Thief' , 'Jesus son' , 'Vanity Fair' , 'Clown Girl' , 'High-Rise' , 'Heart of Darkness'
  , 'Ham on Ray' , 'Novel with Cocaine' , 'The Fall' , 'Nigger' , 'Ubik' , 'Money' , 'The Trial' , 'The Road' , 'East of Eden'
  , 'Heart of a Dog' , 'Queer' , 'Cars' , 'Toys' , 'Footbal' , 'Plays' , 'Games' , 'Jokes' , 'Glue' , 'Node' , 'NodeJS' 
  , 'Learn JavaScript' , 'Queen' , 'My Love' , 'Cartoons' , 'Joshua' , 'Coconut 2013' , 'King and Queen' , 'Costa Rica' , 'Champions League 2008'
  , 'Mercle' , 'Cojombo' , 'Zenga 250' , 'Here we go' , 'Learn exercise' , 'Go to the gym' , 'Strict diet' , 'Invisible man' , 'Girls Power'
  , 'How are you?' , 'I love you' , 'Be rich' , 'Stay loyal' , 'Swimming Studies' , 'Learn to Swim' , 'Night Games' , 'Thank you Janet' 
  , 'White Girls' , 'Sheila' , 'My Year of Meats' , 'Taming the Beast' , 'Wonder' , 'Bad Behavior');
  
  lista_genuri varr := varr('Actiune' , 'Groaza' , 'Politist' , 'Dragoste' , 'Mister' , 'Aventura' , 'Fantezie' , 'Comedie' 
  , 'Drama' , 'Crima' , 'Biografie','Fictiune');
  
  lista_autori varr := varr('William Shakespeare','Emily Dickinson','Arthur Conan Doyle','Leo Tolstoy','Edgar Allan Poe','Robert Ervin Howard','Rabindranath Tagore','Rudyard Kipling','Seneca Vasile',
      'John Donne','Sarah Williams','Oscar Wilde','Catullus Caesar','Alfred Tennyson','William Blake','Charles Dickens','John Keats','Theodor Herzl','Percy Bysshe Shelley',
      'Ernest Hemingway','Barack Obama',' Anton Chekhov','Henry Wadsworth Longfellow','Arthur Schopenhauer',
      'Jacob De Haas','George Gordon Byron','Jack London','Robert Frost','Abraham Lincoln','O. Henry',' Ovid'
      ,'Robert Louis Stevenson','John Masefield','James Joyce','Clark Ashton Smith','Aristotle','William Wordsworth','Jane Austen',' Niccolo Machiavelli'
      ,' Lewis Carroll',' Robert Burns','Edgar Rice Burroughs','Plato','John Milton','Ralph Waldo Emerson','Margaret Thatcher'
      ,'Sylvie Avigdor','Marcus Tullius Cicero','Banjo Paterson','Woodrow Wilson','Walt Whitman',
      'Theodore Roosevelt','Agatha Christie','Ambrose Bierce','Nikola Tesla','Franz Kafka','Neagoe Basarab','Miron Costin','Dosoftei','Ion Neculce','Dimitrie Cantemir',
      'Ion Budai-Deleanu','Dinicu Golescu','Anton Pann','Ion Heliade-Rãdulescu','Costache Negruzzi','Grigore Alexandrescu','Nicolae Filimon','Vasile Alecsandri',
      'Petre Ispirescu','Alexandru Odobescu','Alecu Russo','Bogdan Petriceicu-Hasdeu','Ion Creangã','Ioan Slavici',
      'Mihai Eminescu','Ion Luca Caragiale','Alexandru Macedonski','Barbu Delavrancea','Duiliu Zamfirescu',
      'Alexandru Davila','Constantin Stere','George Co?buc','Nicolae Iorga','Hortensia Papadat-Bengescu','Emil Gârleanu','Gala Galaction','Mihail Sadoveanu','Tudor Arghezi','George Bacovia',
      'Ion Minulescu','Octavian Goga','Ion Agârbiceanu','George Ciprian','Panait Istrati','Liviu Rebreanu','Vasile Voiculescu','Mihail Sorbul','Mateiu I. Caragiale','Ion Al. Brãtescu-Voine?ti',
      'George Topârceanu','Alexandru Kiritescu','Victor Eftimiu','Ion Pillat','Adrian Maniu',
      'Cezar Petrescu','Ion Marin Sadoveanu','Urmuz','Gib I. Mihãescu','Camil Petrescu','Lucian Blaga',
      'Ion Barbu','Ion Vinea','Tristan Tzara','Ionel Teodoreanu','Benjamin Fundoianu');
  
  
  
  lista_edituri varr := varr('AB-ART','ABRAMS','ACUMA','AGNOS','AIDA','AIUS','AMETIST','ARES','ARGONAUT','ARHITEXT','ASTRA'
  ,'AQUILA 93','ASTRO','ATMAN','ANA','ANDREAS','NICOLAS','MISCOL','ATMAN','ATU','CONU','MERES','MOJOS','ADEVAR','ALIAS','ALTIP'
  , 'ALCOR' ,'ADENIUM');
  
  v_autori VARCHAR2(255);
  v_edituri VARCHAR2(255);
  v_denumire VARCHAR2(255);
  v_genuri VARCHAR2(255);
  v_pret NUMBER(6,2);
  v_count INT;

  --DATE PENTRU A POPULA TABELUL USERSINFO
  
	lista_nume varr := varr('Morrison','Bennett','Brady','Coleman','Ford','Rios','Poole','Walters','Guerrero','Flores','Lee','Miller',
      'Francis','French','Martin','Sherman','Graham','Garner','Maxwell','Estrada','Morales','Owen','Lawson','Benson','Hammond','Greene',
      'Lamb','Castro','Perkins','Hughes','Barnes','Mckenzie','Watts','Anderson','Gregory','Alvarez','Yates','Fowler','Wilkins','Warren',
      'Burns','Boone','Goodwin','Porter','Wheeler','Brock','Howard','Barton','Zimmerman','Hodges','Massey','Norton','Gibson','Strickland',
      'Bell','Robinson','Graves','Craig','Howell','Hunt','Malone','Richards','Murphy','Nash','West','Lloyd','Paul','Fuller','Holloway',
      'Goodman','Ryan','Reeves','Cole','Parker','Cohen','Ingram','Scott','Byrd','Hart','Casey','Franklin','Morgan','Mclaughlin','Lyons',
      'Montgomery','Stephens','Glover','Roberts','Erickson','Allison','Ramos','Holland','Hawkins','Williamson','Edwards','Mccoy','Swanson',
      'Delgado','Ellis','Collins','Boyd','Myers','Nichols','Wood','Rice','Wolfe','Stokes','Ortiz','Haynes','Mccormick','Norman','Knight',
      'Patton','Gomez','Chandler','Henry','Tucker','Kennedy','Day','Gray','Banks','Allen','Clark','Reed','Oliver','Price','Simon','Fox',
      'Copeland','Harrington','Brooks','Ruiz','Taylor','Griffith','Jordan','Ballard','Clarke','Kelley','Waters','Russell','Luna','Becker',
      'Nguyen','Norris','Munoz','Wilson','Todd','Olson','George','Rivera','Williams','White','Torres','Brewer','Mendoza','Alexander','Joseph',
      'Mason','Webster','Higgins','Barnett','Harrison','Bailey','Underwood','Robertson','Watkins','Stone','Quinn','Hicks','Holt','Burgess','Hoffman','Adams',
      'Stevens','Chavez','Wilkerson','Bryan','Sandoval','Greer','Soto','Walsh','Wagner','Vega',
      'Schmidt','Figueroa','Thornton','Diaz','Hamilton','Peters','Sims','Duncan','Rhodes','Carter',
      'Alvarado','Powell','Burton','Osborne','Blake','Palmer','Moore','Dawson','Henderson','Lowe','Peterson',
      'Sanders','Shelton','Lopez','Mckinney','Ferguson','Pierce','Neal','Abbott','Keller','Silva','Stewart','Griffin',
      'Lynch','Bush','Nelson','Townsend','Butler','Webb','Spencer','Mack','Frazier','Gutierrez','Moody','Carroll','Bowman',
      'Little','Guzman','Martinez','Larson','Clayton','Perez','Colon','Daniel','Adkins','Turner','Smith','Tate','Mccarthy',
      'Douglas','Riley','Mills','Briggs','Collier','Perry','Murray','Mullins','Vasquez','Wright','Pearson','Cooper','Lewis','Foster',
      'Mann','Santiago','Santos','Cain','Rodgers','Lambert','Fitzgerald','Hudson','Fletcher','Jennings','Schultz','Bowen','Schwartz',
      'Rose','Hopkins','Doyle','Carr','Saunders','Meyer','Cruz','Roy','Baker','Simpson','Valdez','Newton','Caldwell','Parks','Obrien',
      'Johnson','Weaver','Steele','Thomas','Fisher','Walker','Johnston','Grant','Watson','Reid','Gill','Carson','Simmons','Barrett',
      'Holmes','Wells','Mcdonald','Garza','Cook','Bridges','Cox','Leonard','Klein','Lawrence','Rowe','Quinnteles','Aguilar','Willis',
      'Harmon','Long','Davis','Summers','Davidson','Baldwin','Harper','Patrick','Sanchez','Gonzalez','Lindsey','Miles','Wise','Roberson',
      'Bass','Mcgee','Powers','Richardson','Nunez','Hogan','Gordon','Singleton','Harvey','Wade','Welch','Kelly','Houston','Sutton','Love',
      'Bradley','Jimenez','Floyd','Ortega','Black','Ball','Crawford','Bowers','Hernandez','Tran','Brown','Armstrong','Gilbert','Cummings',
      'Snyder','Hayes','Padilla','Dixon','Hampton','Mathis','Medina','Jenkins','Hill','Jacobs','King','Jefferson','Conner','Chapman','Terry',
      'Christensen','Maldonado','Stanley','Gardner','Fields','Ward','Hunter','Ross','Cannon','Sharp','Manning','Newman','Mitchell','Morris','Morton','Hansen','Ramsey','Garcia','Moss','Vargas','Hale','Wallace','Dennis','Fernandez','Thompson','Huff','Park','Walton','Kim','Chambers');
	lista_prenume_fete varr := varr('Bonnie','Louise','Janet','Anna','Jane','Ruth','Ashley','Tina','Joyce',
     'Stephanie','Laura','Virginia','Alice','Margaret','Lori','Sharon','Anne','Emily','Andrea','Elizabeth','Sarah',
     'Rebecca','Ann','Brenda','Jessica','Paula','Jennifer','Diana','Cheryl','Lois','Teresa','Susan','Evelyn','Karen',
     'Wanda','Gloria','Carol','Nicole','Phyllis','Martha','Carolyn','Denise','Heather','Theresa','Marie','Sara','Doris',
     'Cynthia','Joan','Sandra','Kathryn','Julie','Mildred','Jacqueline','Donna','Rose','Dorothy','Debra','Rachel','Diane',
     'Irene','Helen','Jean','Lillian','Patricia','Norma','Kelly','Janice','Frances','Annie','Christine','Michelle','Beverly',
     'Catherine','Melissa','Judith','Lisa','Pamela','Tammy','Kathy','Deborah','Linda','Judy','Kathleen','Angela','Christina',
     'Katherine','Marilyn','Shirley','Maria','Ruby','Mary','Kimberly','Barbara','Nancy','Betty','Amy','Julia','Amanda');
	lista_prenume_baieti varr := varr('Alonzo','Lorenzo','Tommy','Levi','Dustin','Angelo','Matthew','Johnny',
    'Andres','Jeffrey','Samuel','Alberto','Leland','Wallace','Loren','Gustavo','Virgil','Dale','Jaime','Gerard','Carlos',
    'Jason','Roy','Harvey','Willard','Rick','Stuart','Cody','Eduardo','Gerardo','Curtis','Aubrey','Sammy','Gene','Toby','Winston',
    'Tony','Charlie','Wm','Joseph','Marty','Johnnie','Earl','Brad','Jonathan','Rex','Cornelius','Eddie','Cesar','Keith','Louis','Micheal',
    'Nicholas','Dwight','Dave','Rodolfo','Warren','Raymond','Shannon','Emmett','George','Moses','Preston','Guillermo','Andrew','Ignacio',
    'Leslie','Ian','Kirk','Amos','Bert','Ronnie','Timmy','Manuel','Tim','Gregory','Mario','Earnest','Luis','Lawrence','Eric','Miguel','Rudy',
    'Albert','Wayne','Colin','Larry','Israel','Salvador','Jorge','Thomas','Alton','Pat','Malcolm','Randolph','Nicolas','Marshall','Francis','Tyrone','Lewis');
  
  lista_tip varr := varr('Administrator','Obisnuit');
  
  v_mail VARCHAR2(150);
	v_parola VARCHAR2(32);
	v_nume VARCHAR2(20);
	v_prenume VARCHAR2(30);
	v_prenume1 VARCHAR2(30);
	v_prenume2 VARCHAR2(30);
  v_number INT;
  v_user VARCHAR2(150);
  v_found INT;
  v_tip VARCHAR2(15);
  v_gen VARCHAR2(3);
  v_data_nastere date;  

  BEGIN

  DBMS_OUTPUT.PUT_LINE('Inserarea a 500 produse...');
  
  --PRODUSE 500 DE CARTI--
      FOR v_i IN 1..500 LOOP
            v_count := 0;
            LOOP
            v_denumire := lista_denumire(TRUNC(DBMS_RANDOM.VALUE(0,lista_denumire.count))+1);
            v_autori := lista_autori(TRUNC(DBMS_RANDOM.VALUE(0,lista_autori.count))+1);
            SELECT COUNT(*) INTO v_count FROM Produse WHERE autor = v_autori AND denumire = v_denumire;
            EXIT WHEN v_count = 0;
            END LOOP;
            
            v_pret := TRUNC(DBMS_RANDOM.VALUE(0,80)) + 5;
            v_edituri := lista_edituri(TRUNC(DBMS_RANDOM.VALUE(0,lista_edituri.count))+1);
            v_genuri := lista_genuri(TRUNC(DBMS_RANDOM.VALUE(0,lista_genuri.count))+1);
            
            insert into Produse values(v_i,v_denumire,v_autori,v_edituri,v_genuri,v_pret);
     END LOOP;
      DBMS_OUTPUT.PUT_LINE('500 de produse inserate.');   
      
      --FINISH POPULARE PRODUSE
      
      --POPULARE LOGININFO/USERSINFO , 1MILION ELEMENTE.
      FOR v_i IN 1..1000000 LOOP
            v_nume := lista_nume(TRUNC(DBMS_RANDOM.VALUE(0,lista_nume.count))+1);
            IF (DBMS_RANDOM.VALUE(0,100)<50) THEN   
                  v_gen := 'F';
                  v_prenume1 := lista_prenume_fete(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume_fete.count))+1);
                  v_prenume := v_prenume1;
                  IF (DBMS_RANDOM.VALUE(0,100) < 50) THEN
                      LOOP
                          v_prenume2 := lista_prenume_fete(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume_fete.count))+1);
                          EXIT WHEN v_prenume1<>v_prenume2;
                      END LOOP;
                  v_prenume := v_prenume1 || ' ' || v_prenume2;
                  END IF;
                  
            ELSE
                    v_gen := 'M';
                    v_prenume1 := lista_prenume_baieti(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume_baieti.count))+1);
                    v_prenume := v_prenume1;
                    IF (DBMS_RANDOM.VALUE(0,100)<50) THEN
                      LOOP
                        v_prenume2 := lista_prenume_baieti(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume_baieti.count))+1);
                        exit when v_prenume1<>v_prenume2;
                      END LOOP;  
                      v_prenume := v_prenume1 || ' ' || v_prenume2;
                    END IF;
              
             END IF;
        
              v_parola := DBMS_RANDOM.STRING('x', DBMS_RANDOM.VALUE(6,32));
              
              v_mail := LOWER(v_nume ||'_'|| v_prenume1);
              v_number := TRUNC(DBMS_RANDOM.VALUE(0,10000));
              LOOP         
                  SELECT count(*) INTO v_found FROM LOGININFO WHERE email = v_mail || v_number || '@gmail.com' OR email = v_mail || v_number || '@yahoo.com';
                  EXIT WHEN v_found=0;
                  v_number := TRUNC(DBMS_RANDOM.VALUE(0,10000));
              END LOOP;    
              v_mail := v_mail || v_number;
              v_user := v_mail;
              v_data_nastere := TO_DATE('01-01-1974','MM-DD-YYYY')+TRUNC(DBMS_RANDOM.VALUE(0,365));
              IF (TRUNC(DBMS_RANDOM.VALUE(0,2))=0) THEN v_mail := v_mail || '@gmail.com';
                ELSE v_mail := v_mail || '@yahoo.com';
              END IF;
              v_tip := lista_tip(TRUNC(DBMS_RANDOM.VALUE(0,lista_tip.count))+1);
              INSERT INTO LOGININFO VALUES (v_i,v_user,v_parola,v_mail,v_tip);
              INSERT INTO USERSINFO VALUES (v_i,v_nume,v_prenume,v_data_nastere,v_gen);
    END LOOP;
    
END;
 
SELECT * FROM LOGININFO ORDER BY IDC;


