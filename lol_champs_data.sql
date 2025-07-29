CREATE DATABASE lol_data;
USE lol_data;

CREATE TABLE lol_champs_data
(
	name varchar(100),
    class varchar(20),
    role varchar(10),
    tier varchar(4),
    score float,
    trend float,
    win_rate float,
    role_rate float,
    pick_rate float,
    ban_rate float,
    kda float
);

#The data was imported using the 'Table Data Import Wizard'

select *
from lol_champs_data;

#Top 10 win-rate champions
#Selecting the top 10 champions by the win rate, we come to see that half of the champions tend to be able to pay in a MID role, with the other 4 roles making up the remaining champions. This could indicate that at the time of this final patch, the MID role champions we're slightly more buffed.
#However, without game session data we cannot determine any conclusion so far.
select
	name,
    role,
	win_rate
from lol_champs_data
order by win_rate desc
limit 10;

#Top 5 win-rate champions in a top-lane role
#Dr. Mundo takes the spot as the champion with the highest win-rate within a TOP role with a 54% win rate for the final patch 23 of season 12
select
	name,
    win_rate
from lol_champs_data
where role = 'TOP'
order by win_rate desc
limit 5;

#Top 5 win-rate champions in a mid-lane role
#Singed takes the spot as the chamption with the highest win-rate within a MID role with a 58% win rate for the final patch 23 of season 12.
#This observation goes inline with our Top 10 champions query in which Singed had the highest win-rate, and also happens to be a MID role champion. However, once more this cannot prove any conclusion without more information.
select
	name,
    win_rate
from lol_champs_data
where role = 'MID'
order by win_rate desc
limit 5;

#Top 5 win-rate champions in an adc role
#Nilah takes the spot as the champion with the highest win-rate within an ADC role with a 54% win rate for the final patch 23 of season 12.
select
	name,
    win_rate
from lol_champs_data
where role = 'ADC'
order by win_rate desc
limit 5;

#Top 5 win-rate champions in a jungle role
#Rammus takes the spot as the champion with the highest win-rate within a JUNGLE role with a 54% win rate for the final patch 23 of season 12.
#Furthermore, we can see Dr.Mundo reappears within the top 5 champions, which is interesting as he was the top champion for a TOP role. This could indicate that Dr.Mundo had been a well balanced character by this last patch, that his playstyle had lots of variations to it
select
	name,
    win_rate
from lol_champs_data
where role = 'JUNGLE'
order by win_rate desc
limit 5;

#Top 5 win-rate champions in a support role
#Nami takes the spot as the champion with the highest win-rate within a SUPPORT role with a 53% win rate for the final patch 23 of season 12
#Another observation we can make is that Heimerdinger appears both in the top 5 SUPPORTs and top 5 MIDs. This could indicate that the champion roster was somewhat evenly balanced to the point of no one specific champion being overly dominant.
select
	name,
    win_rate
from lol_champs_data
where role = 'SUPPORT'
order by win_rate desc
limit 5;

# Top 5 win-rate champions per role

#Setting up a CTE will group the data by the champion name and role, and we will then find the average win rate fpr each champion, role pair 
#Create a window function by partitioning the roles into their own groups, then order by win_rate in desc order to get the highest win_rate, and we assign a unioque rank starting with 1 within each role group
#Lastly we select the name, role, and win_rate from ranked with the row number being = 1 because we are looking for the highest win_rate within each group
#This give us Nilah as ADC lead, Rammus as Jungle lead, Singed as Mid lead, Nami as Support lead, and Dr. Mundo as Top lead
with unique_champs as (
    select 
		name, 
		role, 
		round(avg(win_rate), 4) as win_rate
    from lol_champs_data
    group by name, role
),
ranked as (
    select *,
           row_number() over (
               partition by role 
               order by win_rate desc
           ) as rn
    from unique_champs
)
select 
	name, 
    role, 
    win_rate
from ranked
where rn = 1;


#Average win_rate by champion
#This query is an average for all champions' win-rate disregarding role specifics. As many of the champions can play 2 roles given the playstyle the players deems to choose.
#However, we can see that Singed is the champion with the highest win-rate overall for this last patch 23 of season 12.
select
	name,
    round(avg(win_rate), 4) as avg_win_rate
from lol_champs_data
group by name
order by avg_win_rate desc;

#Average win_rate by role
#This query is an average for all champions' win-rate by role. The list starts from ADC-JUNGLE-MID-SUPPORT-TOP.
#Besides the top champions for each role, we can see that most champions don't fall below a ~45% win-rate, which could indicate that Riot had balanced out most of the characters to the point that each character could be successful at winning close to half of all the games they would play.
select
	name,
    role,
    round(avg(win_rate), 4) as avg_win_rate
from lol_champs_data
group by role, name
order by role, avg_win_rate desc;

#Average pick rate by champion
#This the average pick_rate for each champion disregarding roles. We see that Caitlyn has an 18% pick-rate for the final patch 23 of season 12.
select
	name,
    round(avg(pick_rate), 4) as avg_pick_rate
from lol_champs_data
group by name
order by avg_pick_rate desc;

#Average pick_rate by role
#This query returns the avgerage pick_rate for each champion by role.
#We see that ADC really outshines all the over roles within this patch and season, which can indicate that ADC might have dominated the player choice towards the end of the season, as no other role had a pick rate of 18% of a single champion, let alone 3.
select
	name,
    role,
    round(avg(pick_rate), 4) as avg_pick_rate
from lol_champs_data
group by role, name
order by role, avg_pick_rate desc;

#Average ban_rate by champion
#This query returns the average ban_rate of every champion for the last patch 23 of season 12
#At first glance we can see that Zed has the highest average ban_rate.
#It could be that this was the meta at the time, or the champions was over-powered. It could be many things that could have led to this but nothing can be concrete until game-session data is viewed.
select
	name,
    round(avg(ban_rate), 4) as avg_ban_rate
from lol_champs_data
group by name
order by avg_ban_rate desc;

#Average ban_rate by role
#This query returns all champions' ban_rate based on role.
#As we can see, most of the ban_rates have an similar ban_rate with a few exceptions such as Samira, Draven, Yasuo, and Caitlyn for ADC, Zed for Jungle and Mid, Morgana, and Yuumi for Support, and Fiora, Darius, and Aatrox for Top
select
	name,
    role,
    round(avg(ban_rate), 4) as avg_ban_rate
from lol_champs_data
group by role, name
order by role, avg_ban_rate desc;

#Average KDA by champion
#These results are the average kill death ratio for each champion disregarding roles.
#We can see that Yuumi has the highest KDA at 3.94, meaning that she gets almost 4 kills per death, which in a game like LoL is a lot of value
#This is surprising because Yuumi is a Support role, not exactly the role you would see providing the most kills in a game
select
	name,
    round(avg(KDA), 4) as avg_kda
from lol_champs_data
group by name
order by avg_kda desc;

#Average KDA by role
#Here we have the kill death ratio by roles
#We see that overall, most of the champions have a kda higher than 1, which is a positive thing because each champions held their value somehow.
select
	name,
    role,
    round(avg(KDA), 4) as avg_kda
from lol_champs_data
group by role, name
order by role, avg_kda desc;


#Role Popularity
#Here we see that at this time, there were 60 TOP laners, 62 MID laners, both 51 for SUPPORT, and JUNGLE, and 28 for ADC
#Because of the wild distribution of champions in each roles, we can began to see where some skewed number could have occured. 
#For example, given the smaller amount of ADC champions, it provides players with less choices to pick a character hence why a few ADC characters like Caitlyn have higher pick_rates over the entire ADC roster.
select
	count(*),
    role
from lol_champs_data
group by role;

#Champions by types of win/pick rate
#This query lets us see how each character is rated by their win/pick ratio. In theory, we should be seeing balanced for everyone at the end of the season, however, that is not the case.
select
	name,
    role,
    win_rate,
    pick_rate,
	case
		when win_rate >= 0.52 and pick_rate <=0.04 then 'high win / low pick'
		when win_rate <= 0.48 and pick_rate >=0.05 then 'low win / high pick'
		else 'balanced'
	end as category
from lol_champs_data
order by win_rate, name;
