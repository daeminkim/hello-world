/*
1. ��ǰ ���̺��� ��ǰ_ID �÷��� primary key�÷����� �� ���� �ٸ� ��� �ĺ��� �� ���ȴ�.
2. ��ǰ ���̺��� ������ �÷��� Not Null(NN) �� ������ ���� NULL �� ������ ���� ����.
3. �� ���̺��� �ٸ���� �ĺ��� �� ����ϴ� �÷��� cust_id �̴�. 
4. �� ���̺��� ��ȭ��ȣ �÷��� ������ Ÿ���� varchar2 ���� ���ڿ� ������ �� 15����Ʈ ������ �� ������ NULL ���� ���.
5. �� ���̺��� ������ �÷��� ���� 4�� ó�� ������ ���ÿ�. date// ��¥ / �ð�
6. �ֹ� ���̺��� �� 5�� �÷��� �ִ�. ���� Ÿ���� ______���̰� ���ڿ� Ÿ���� ______�� �̰� ��¥ Ÿ���� __________���̴�.
7. �� ���̺�� �ֹ����̺��� ���� ���谡 �ִ� ���̺��Դϴ�.
    �θ����̺��� _ customers____________ �̰� �ڽ� ���̺��� orders �̴�.
    �θ����̺��� _cust_id_pk_____�÷��� �ڽ����̺��� _cust_id  fk_______�÷��� �����ϰ� �ִ�.
    �����̺��� ������ �����ʹ� �ֹ����̺��� --0~n-- ��� ���谡 ���� �� �ִ�.
    �ֹ����̺��� ������ �����̺��� 1��_��� ���谡 ���� �� �ִ�.
8. �ֹ� ���̺�� �ֹ�_��ǰ ���̺��� ���� ���谡 �ִ� ���̺��Դϴ�.
    �θ� ���̺��� __orders_____ �̰� �ڽ� ���̺��� ___order_items__�̴�.
    �θ� ���̺��� __order_id_(pk)__�÷��� �ڽ� ���̺��� _____order_id(fk)______�÷��� �����ϰ� �ִ�.
    �ֹ� ���̺��� ������ �����ʹ� �ֹ�_��ǰ ���̺��� ____0~n___ ��� ���谡 ���� �� �ִ�.
    �ֹ�_��ǰ ���̺��� ������ �ֹ� ���̺��� ____1______��� ���谡 ���� �� �ִ�.
9. ��ǰ�� �ֹ�_��ǰ�� ���� ���谡 �ִ� ���̺��Դϴ�. 
    �θ� ���̺��� __products____ �̰� �ڽ� ���̺��� ____order_items__�̴�.
    �θ� ���̺��� ___product_id_(pk)_�÷��� �ڽ� ���̺��� ____product_id(fk)_____�÷��� �����ϰ� �ִ�.
    ��ǰ ���̺��� ������ �����ʹ� �ֹ�_��ǰ ���̺��� ___0~n___ ��� ���谡 ���� �� �ִ�.
    �ֹ�_��ǰ ���̺��� ������ ��ǰ ���̺��� ______1_____��� ���谡 ���� �� �ִ�.
*/

-- TODO: 4���� ���̺� � ������ �ִ��� Ȯ��.
select * from customers c join orders o on c.cust_id=o.cust_id
                          join order_items i on o.order_id = i.order_id
                          join products p on i.product_id = p.product_id; 


-- TODO: �ֹ� ��ȣ�� 1�� �ֹ��� �ֹ��� �̸�, �ּ�, �����ȣ, ��ȭ��ȣ ��ȸ
select  cust_name,
        c.cust_id,  -- ���̺� �ΰ��� ���ִ� �����ϱ� �տ� ���̺� �� �����ؼ� id  �˻��ؾ��Ѵ�.
        address,
        postal_code,
        phone_number
from customers c join orders o on c.cust_id = o.cust_id  -- left join �ص� �������.  �ֹ� ���̵� �����̵� not null �̱⶧����  �ٰ��� �ִ�
where order_id = 1;                                      -- �̳� ���� ���� ���������� ©
        
    

-- TODO : �ֹ� ��ȣ�� 2�� �ֹ��� �ֹ���, �ֹ�����, �ѱݾ�, �ֹ��� �̸�, �ֹ��� �̸��� �ּ� ��ȸ

select  o.order_date,
        o.order_status,
        o.order_total,
        c.cust_name,
        c.cust_email,
        c.address
from orders o join customers c on o.cust_id = c.cust_id
where o.order_id = 2;


-- TODO : �� ID�� 120�� ���� �̸�, ����, �����ϰ� //(������� �����Ǻ���)
--���ݱ��� �ֹ��� �ֹ������� �ֹ�_ID, �ֹ���, �ѱݾ��� ��ȸ (������ ���� �ƴϸ� ����) �׷��� outer ���� ��� (cust_id�� 0~n�� �� ���踦 ���� �ֱ⶧��) 
select  c.cust_name,
        c.gender,
        decode(c.gender, 'M','����','����') ����,
        case c.gender when 'M' then '����'
                      when 'F' then '����'
                      --else '����' end ����,
                      end ����2,
        c.join_date,
        o.order_id,
        o.order_date,
        o.order_total
from orders o right join customers c on o.cust_id = c.cust_id
where c.cust_id =120;   -- 120 �� ����� �ֹ��� �ѹ��� ���ߴٸ� .. /// cust _ id �� 0���� ���踦 �����ִٸ�..
--from custmers c , orders o
--where c.cust_id=o.cust_id(+)
--and c.cust_id = 120; 

-- TODO : �� ID�� 110�� ���� �̸�, �ּ�, ��ȭ��ȣ, �װ� ���ݱ��� �ֹ��� �ֹ������� �ֹ�_ID, �ֹ���, �ֹ����� ��ȸ
 select  c.cust_name,
         c.address,
         c.phone_number,
         o.order_id,
         o.order_date,
         o.order_status
from orders o right join customers c on o.cust_id = c.cust_id
where c.cust_id =110;

-- TODO : �� ID�� 120�� ���� ������ ���ݱ��� �ֹ��� �ֹ������� ��� ��ȸ.
 select  *
 --select c.* customers �� Į����
 --select c.*   ��csutomers �� ��� ���� , �׸��� orders ���̺��� date�� 
   --     o.order_date
from orders o right join customers c on o.cust_id = c.cust_id
where c.cust_id =120;  -- ���������� 0~n���Ͱ��谡 �����ϱ� outer



-- TODO : '2017/11/13'(�ֹ���¥) �� �ֹ��� �ֹ�///(�ҽ����̺�)�� �ֹ����� ��_ID, �̸�, �ֹ�����, �ѱݾ��� ��ȸ
select  c.cust_id,
        c.cust_name,
        o.order_status,
        o.order_total,
        to_char(o.order_total,'fmL999,999')
from orders o join customers c on o.cust_id = c.cust_id   -- cust_id�� NN�̴ϱ� �̳� ������ �ϴ� �ƿ��͸� �ϴ� �������.
--from orders o left join customers c on o.cust_id = c.cust_id  (join �Ȱ� �ִ� ���� �ٺ����� �ƿ��� ����)
where o.order_date= '2017/11/13';
--where o.order_date = to_date('2017/11/13','yyyy/mm/dd');


-- TODO : �ֹ��� ID�� xxxx(������ id)�� �ֹ���ǰ�� ��ǰ�̸�, �ǸŰ���, ��ǰ������ ��ȸ.

select * from order_items;

select  i.order_item_id,
        p.product_name "��ǰ�̸�", -- ������ ,�ֱ�
        i.sell_price "�ǸŰ���",
        p.price "��ǰ ����"
from order_items i join products p on i.product_id = p.product_id
where i.order_item_id = 1;

        
-- TODO : �ֹ� ID�� 4�� �ֹ��� �ֹ� ���� �̸�, �ּ�, �����ȣ, �ֹ���, �ֹ�����, �ѱݾ�, �ֹ� ��ǰ�̸�, ������, ��ǰ����, �ǸŰ���, ��ǰ������ ��ȸ.
select  c.cust_name,
        c.address,
        c.postal_code,
        o.order_date,
        o.order_status,
        o.order_total,
        p.product_name,
        p.maker,
        p.price,
        i.quantity,
        o.order_id "�ֹ� ID"
from orders o left join customers c on c.cust_id = o.cust_id
              left join order_items i on o.order_id = i.order_id
              left   join products p on i.product_id = p.product_id
where o.order_id = 4 ;



-- TODO : ��ǰ ID�� 200�� ��ǰ�� 2017�⿡ � �ֹ��Ǿ����� ��ȸ.
--
select  i.quantity "����",
        p.product_id "��ǰ ID",
       -- count(*)"�ֹ� Ƚ��",
        --sum(i.quantity)"�� �ǸŰ���"
from orders o join order_items i on o.order_id = i.order_id
              join products p on i.product_id = p.product_id
where p.product_id = 200 
and to_char(o.order_date, 'yyyy') = 2017;

--group by ���� ������ ������ i.quantity, p.product_id�� select ���� ���� �� �����ϴ�.


-- TODO : ��ǰ�з��� �� �ֹ����� ��ȸ
select category from products;


select  p.category,
        nvl(sum(i.quantity),0) "�� �ֹ���"
from products p left join order_items i on p.product_id = i.product_id   -- �ҽ����̺��� ���� ���� ������ outer join
--from products p join order_items i on p.product_id = i.product_id  null �� ���� //join �� �͸� ���� ���� �� 
group by p.category;



