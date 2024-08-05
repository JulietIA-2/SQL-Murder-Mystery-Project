# SQL-Murder-Mystery-Project
This project is about a crime that was committed in SQL City. 
Question
A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a murder that occurred sometime on Jan.15, 2018 and that it took place in SQL City. Start by retrieving the corresponding crime scene report from the police department’s database.

I followed these steps to solve the challenge:
- Download the `SQL-murder-mystery.db` file 
- visit www.sqliteonline.com
- click on file, then open db and load in the database file you downloaded above
- write your SQL queries to see the different tables and the content
- use the schema diagram to navigate the different tables
- figure out who committed the crime with the details you remembered above
- create a word or txt document that contains your thought process, narrative and SQL codes written to arrive at the solution to the murder mystery
- submit a link to the word or txt document.

Solution

	Firstly, I downloaded the sql-murder-mystery.db file and loaded it into SQLite Online.

	I wrote simple SQL queries to explore the different tables and view their contents. 

	Using the schema diagram, I was able to navigate the relationships between tables and identify the relevant information to solve the mystery.

	Based on my memory of the crime scene report, I wrote SQL queries to filter the results and identify the perpetrator.

	To begin with I wrote the query below to filter and find out about the murder that took place in SQL City on 15 Jan 2018

                 SELECT *
        FROM crime_scene_report
        WHERE date = 20180115 AND type = 'murder' AND city = 'SQL City' 

From the above query I got the description below which gave me more information to further investigate.

‘Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".’

	Since it was clearly stated on the description that there were two witnesses. I queried the person table to get more details about each witness. 
For the first witness (Annabel) I wrote the query below
SELECT *
FROM person
WHERE address_street_name LIKE 'Franklin_Ave%' AND name LIKE 'Annabel%'
The first witness's full name, ID, license number, address, and SSN were provided via the aforementioned query.
	Also, the person_id in the interview table and the id in the person table are connected. I then queried the interview table using the id, which provides me with another clue regarding the transcript column. The query reads below
SELECT *
FROM interview
WHERE person_id = 16371
The transcript says ‘I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th’ 

	For the second witness whose name was not given but the street name was stated. I queried the person table to find out more about the witness as shown below;

                  SELECT id, Name, MAX (address_number)
                  FROM person
                  WHERE address_street_name LIKE 'Northwestern_Dr'

The above query showed me that the witness was Morty Schapiro with id as 14887 and address number as 4919.

	I went on to query the interview table with the connecting key to find out more information as shown below.
SELECT *
From interview
where person_id = 14887

The transcript column also gives me a detailed description which reads ‘I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".’

	Going with the information provided by the second witness I queried the table to filter the suspects as shown below
 
SELECT * 
FROM get_fit_now_member gm
JOIN get_fit_now_check_in gc
on gc.membership_id = gm.id
WHERE id LIKE '48Z%'AND membership_status = 'gold'. 

Which gives me the names of the likely suspects 'Jeremy Bowers' and ‘Joe Germuska’ and they both checked in on the 9th January. 

	Following Morty’s interview (the second suspect) I checked for the plate number that included "H42W" by joining person and drivers_license table and that showed that amongst the two suspects only Jeremy Bowers had “H42W" in his plate number.
See query below 

SELECT *
FROM person p
JOIN drivers_license d
ON licensed = d.id
WHERE plate number like '%H42W%'

 This give an indication that Jeremy was the murderer

	I queried the suspect Jeremy Bowers on the interview table with the person_id - 67318

SELECT *
FROM interview
WHERE person_id = 67318

Jeremy stated that ‘I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.’

	The above statement shows that Jeremy Bowers actually committed the murder but was hired by a woman. So, I went on to join the drivers-license table to person table to find her.

 SELECT name
 FROM drivers_license d
 JOIN person p
 ON p.license_id = d.id
 WHERE hair_color = 'red' AND car_model = 'Model S' AND        GENDER = 'female'

The above query gave me three names - Red Korb, Regina George, Miranda Priestly. 

	Jeremy also added that she attended an SQL Symphony concert 3 times in December 2017. So, I presumed that the information would help me filter and get the actual person. I then wrote the query below;

 SELECT id, name, event_name, date
 FROM person p
 JOIN facebook_event_checkin f
 ON p.id = f.person_id
 WHERE event_name = 'SQL Symphony Concert' And date lik e '201712%' and name IN ('Regina George', 'Red Korb',  'Miranda Priestly')

The result showed Miranda Priestly’s name three times, the corresponding event that she had attended and the three differrent dates which confirms Jeremy Bower’s statement.

In summary Miranda Priestly paid Jeremy Bower to commit the murder and this murder was witnessed by Morty Schapiro and Annabel Miller from the Get Fit Now Gym on 9th January, 2018.










