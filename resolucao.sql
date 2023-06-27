
use db_deliverycenter;

/*1-*/ select count( distinct(hub_city)) from hubs;
select * from hubs;

/*2-*/ select count(*) as num_pedidos
 from orders
 group by order_status('finished');
select * from orders;

/*3-*/SELECT hubs.hub_city, COUNT(stores.store_id) AS num_lojas
FROM hubs
INNER JOIN stores ON hubs.hub_id = stores.store_id
GROUP BY hubs.hub_city;
select * from stores;

/*4-*/ select max(payment_amount) from payments; 
	   select min(payment_amount) from payments; 

/*5-*/
select drivers.driver_type from drivers inner join deliveries
ON drivers.driver_id = deliveries.driver_id limit 1;

/*6-*/
select drivers.driver_modal, avg(deliveries.delivery_distance_meters) as distancia_media
from drivers
join deliveries on drivers.driver_id = deliveries.driver_id
group by drivers.driver_modal;

/*7-*/
select stores.store_name, avg(orders.order_amount) as MEDIA_VALOR
from orders
inner join stores on orders.store_id = stores.store_id
group by stores.store_name
order by media_valor desc;

/*8-*/
select COUNT(*) as total_pedidos_sem_loja
from orders
left join stores on orders.store_id = stores.store_id
where stores.store_id is null;

/*9-*/ select channel_name, count(order_amount) as VALOR_TOTAL from orders inner join channels
on channels.channel_id = orders.channel_id 
where channels.channel_name = "FOOD PLACE";

/*10-*/ Select payments.payment_status from payments 
where payments.payment_status = "chargeback";

/*11-*/ select avg(payment_amount) as valorMedioPagamentosCancelados from payments
where payments.payment_status = "chargeback" ;

/*12-*/select payment_method,avg(payment_amount)as media_valor from payments
group by payments.payment_method 
order by avg(payments.payment_amount) desc;


/*13-*/select payment_method from payments 
group by payments.payment_amount
having avg(payment_amount) >100;

/*14-*/select hubs.hub_state, stores.store_segment, channels.channel_type, avg(orders.order_amount) as result from orders
join hubs on orders.store_id = hubs.hub_id
join stores on orders.store_id = stores.store_id
join channels on orders.channel_id = channels.channel_id
group by hubs.hub_state, stores.store_segment, channels.channel_type;

/*15*/select hubs.hub_state, stores.store_segment, channels.channel_type, avg(orders.order_amount) as average_order_amount
from orders
join hubs on orders.store_id = hubs.hub_id
join stores on orders.store_id = stores.store_id
join channels on orders.channel_id = channels.channel_id
group by hubs.hub_state, stores.store_segment, channels.channel_type
having avg(orders.order_amount) > 450;
