with payment as (
    
    select
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status,
        amount

    from stripe.payment
)

select * from payment