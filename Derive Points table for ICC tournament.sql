https://www.youtube.com/watch?v=qyAgWL066Vo&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=2


InPut :
  Team_1	    Team_2	    Winner
  India	        SL	      India
  SL	          Aus	      Aus
  SA	          Eng	      Eng
  Eng	          NZ	      NZ
  Aus	          India	    India

outPut:
 teamName	matches_played	no_of_wins	no_of_loses
    Aus	        2	              1	          1
    Eng	        2	              1	          1
    India	      2	              2	          0
    NZ	        1	              1	          0
    SA	        1	              0	          1
    SL	        2	              0	          2

Script : 

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');


Result :

with ct1 as (
select distinct teamName,sum(matches_played) as matches_played  from (
select team_1 as teamName ,count(*) as matches_played  from icc_world_cup  group by team_1 union all
select team_2,count(*) from icc_world_cup group by team_2 ) as tb group by teamName 
),
ct2 as (
select team as teamName ,sum(win) as no_of_wins from (
select team_1 as team, case when winner=team_1 then 1 else 0 end as win from icc_world_cup union all
select team_2 ,case when winner=team_2 then 1 else 0 end as win from icc_world_cup ) tb group by team
)

select l.teamName as teamName , matches_played,no_of_wins,(matches_played-no_of_wins)as no_of_loses from ct1 l join ct2 r on l.teamName=r.teamName
