youtube=> https://www.youtube.com/watch?v=P6kNMyqKD0A&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=4


answer=> 
with ct1 as (
select name,count(name) as total_visits,STRING_AGG( resources,',') as resources_used from entries group by name
),
ct2 as (

select name,cnt as most_visited_floor from (
select name,floor,count(*) as cnt from entries group by name,floor) as tb where cnt>1)

select l.name,total_visits,most_visited_floor,resources_used from ct1 l join ct2 r on l.name=r.name
