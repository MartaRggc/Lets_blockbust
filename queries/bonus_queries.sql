
/*------------- Q1: Select all films in which actress Jennifer_Davis participates --------------*/

select title from actor as a
left join actorfilm as af
on a.id = af.actor_id
left join film as f
on af.film_id = f.id
where name = 'JENNIFER_DAVIS';

/*------------- Q2: Cuántas películas hay de cada género en la base de datos de film --------------*/

select cat, count(title) as films

from
(select title, cat from film as f
left join catfilm as cf
on f.id = cf.film_id
left join category as c
on cf.category_id = c.id) patata
group by cat;

/*------------- Q3: Cuáles son los tres actores que salen en más películas de la tabla actor --------------*/

select name, count(title) as films

from
(select name, title from actor as a
left join actorfilm as af
on a.id = af.actor_id
left join film as f
on f.id = af.film_id) patata
group by name
order by films desc
limit 3;

/*------------- Q4: Qué tabla se actualizó hace más tiempo --------------*/

select tab from updates
where last_update = (select min(last_update) from updates);

/*------------- Q5: cuáles son las películas cuyos nombres empiezan por H ---------*/

select title from film as f
where title like 'H%';