SELECT *
FROM crime_scene_report
WHERE date = 20180115 AND type = 'murder'

SELECT *
FROM person
WHERE address_street_name LIKE 'Franklin_Ave%' AND name LIKE 'Annabel%'

SELECT *
From interview
where person_id = 16371

SELECT id, Name, MAX(address_number)
FROM person
WHERE address_street_name LIKE 'Northwestern_Dr' 

SELECT *
From interview
where person_id = 14887

SELECT * 
FROM get_fit_now_member gm
JOIN get_fit_now_check_in gc
on gc.membership_id = gm.id
WHERE id LIKE '48Z%'AND membership_status = 'gold' 


SELECT *
from person p
join drivers_license d
on p.license_id = d.id
where plate_number like '%H42W%' 

SELECT *
from interview
where person_id = 67318

SELECT name
FROM drivers_license d
join person p
on p.license_id = d.id
where hair_color = 'red' AND car_model = 'Model S' AND gender = 'female' 

select id, name, event_name, date
from person p
join facebook_event_checkin f
on p.id = f.person_id
where event_name = 'SQL Symphony Concert' And date like '201712%' and name IN  ('Regina George', 'Red Korb', 'Miranda Priestly')

