
/*------------- Q1: Select all films in which actress Jennifer_Davis participates --------------*/

select title from actor as a
left join actorfilm as af
on a.id = af.actor_id
left join film as f
on af.film_id = f.id
where name = 'JENNIFER_DAVIS';

/*------------- Q2:  --------------*/

select * from rental;