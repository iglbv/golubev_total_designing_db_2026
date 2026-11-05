create or replace procedure add_product (
  p_restaurant_id uuid,
  p_product_category_id uuid,
  p_name varchar(100),
  p_price numeric,
  p_rating numeric default null,
  p_status product_status default 'доступно',
  p_description text default null,
  p_photo_url text default null
) language plpgsql
set
  public as $$
begin
    if not exists (
        select 1
        from restaurant
        where restaurant_id = p_restaurant_id
    ) then
        raise exception
            'Ресторан с идентификатором % не существует.',
            p_restaurant_id;
    end if;

    if not exists (
        select 1
        from product_category
        where product_category_id = p_product_category_id
    ) then
        raise exception
            'Категория с идентификатором % не существует.',
            p_product_category_id;
    end if;

    insert into product (
        product_id,
        product_name,
        product_category_id,
        price,
        restaurant_id,
        photo_url,
        rating,
        status,
        description
    )
    values (
        exts.uuid_generate_v4(),
        p_name,
        p_product_category_id,
        p_price,
        p_restaurant_id,
        p_photo_url,
        p_rating,
        p_status,
        p_description
    );

exception
    when check_violation then
        raise exception
            'Не удалось добавить блюдо: проверьте корректность введённых данных.';

    when not_null_violation then
        raise exception
            'Не удалось добавить блюдо: заполните все обязательные поля.';

    when others then
        raise;
end;
$$;