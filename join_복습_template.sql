/*
1. 제품 테이블은 제품_ID 컬럼이 primary key컬럼으로 그 행을 다른 행과 식별할 때 사용된다.
2. 제품 테이블의 제조사 컬럼은 Not Null(NN) 인 것으로 봐서 NULL 인 상태일 수가 없다.
3. 고객 테이블에서 다른행과 식별할 때 사용하는 컬럼은 cust_id 이다. 
4. 고객 테이블의 전화번호 컬럼의 데이터 타입은 varchar2 으로 문자열 형태의 값 15바이트 저장할 수 있으며 NULL 값을 허용.
5. 고객 테이블의 가입일 컬럼에 대해 4번 처럼 설명해 보시오. date// 날짜 / 시간
6. 주문 테이블은 총 5개 컬럼이 있다. 정수 타입이 ______개이고 문자열 타입이 ______개 이고 날짜 타입이 __________개이다.
7. 고객 테이블과 주문테이블은 서로 관계가 있는 테이블입니다.
    부모테이블은 _ customers____________ 이고 자식 테이블은 orders 이다.
    부모테이블의 _cust_id_pk_____컬럼을 자식테이블의 _cust_id  fk_______컬럼이 참조하고 있다.
    고객테이블의 한행의 데이터는 주문테이블의 --0~n-- 행과 관계가 있을 수 있다.
    주문테이블의 한행은 고객테이블의 1행_행과 관계가 있을 수 있다.
8. 주문 테이블과 주문_제품 테이블은 서로 관계가 있는 테이블입니다.
    부모 테이블은 __orders_____ 이고 자식 테이블은 ___order_items__이다.
    부모 테이블의 __order_id_(pk)__컬럼을 자식 테이블의 _____order_id(fk)______컬럼이 참조하고 있다.
    주문 테이블의 한행의 데이터는 주문_제품 테이블의 ____0~n___ 행과 관계가 있을 수 있다.
    주문_제품 테이블의 한행은 주문 테이블의 ____1______행과 관계가 있을 수 있다.
9. 제품과 주문_제품은 서로 관계가 있는 테이블입니다. 
    부모 테이블은 __products____ 이고 자식 테이블은 ____order_items__이다.
    부모 테이블의 ___product_id_(pk)_컬럼을 자식 테이블의 ____product_id(fk)_____컬럼이 참조하고 있다.
    제품 테이블의 한행의 데이터는 주문_제품 테이블의 ___0~n___ 행과 관계가 있을 수 있다.
    주문_제품 테이블의 한행은 제품 테이블의 ______1_____행과 관계가 있을 수 있다.
*/

-- TODO: 4개의 테이블에 어떤 값들이 있는지 확인.
select * from customers c join orders o on c.cust_id=o.cust_id
                          join order_items i on o.order_id = i.order_id
                          join products p on i.product_id = p.product_id; 


-- TODO: 주문 번호가 1인 주문의 주문자 이름, 주소, 우편번호, 전화번호 조회
select  cust_name,
        c.cust_id,  -- 테이블 두개에 다있는 정보니까 앞에 테이블 을 지정해서 id  검색해야한다.
        address,
        postal_code,
        phone_number
from customers c join orders o on c.cust_id = o.cust_id  -- left join 해도 상관없다.  주문 아이디 고객아이디 not null 이기때문에  다값이 있다
where order_id = 1;                                      -- 이너 조인 값이 맞지않으면 짤
        
    

-- TODO : 주문 번호가 2인 주문의 주문일, 주문상태, 총금액, 주문고객 이름, 주문고객 이메일 주소 조회

select  o.order_date,
        o.order_status,
        o.order_total,
        c.cust_name,
        c.cust_email,
        c.address
from orders o join customers c on o.cust_id = c.cust_id
where o.order_id = 2;


-- TODO : 고객 ID가 120인 고객의 이름, 성별, 가입일과 //(여기까지 무조건보고)
--지금까지 주문한 주문정보중 주문_ID, 주문일, 총금액을 조회 (있으면 보고 아니면 말고) 그래서 outer 조인 사용 (cust_id가 0~n개 의 관계를 갖고 있기때문) 
select  c.cust_name,
        c.gender,
        decode(c.gender, 'M','남성','여성') 성별,
        case c.gender when 'M' then '남성'
                      when 'F' then '여성'
                      --else '여성' end 성별,
                      end 성별2,
        c.join_date,
        o.order_id,
        o.order_date,
        o.order_total
from orders o right join customers c on o.cust_id = c.cust_id
where c.cust_id =120;   -- 120 인 사람이 주문을 한번도 안했다면 .. /// cust _ id 가 0개의 관계를 갖고있다면..
--from custmers c , orders o
--where c.cust_id=o.cust_id(+)
--and c.cust_id = 120; 

-- TODO : 고객 ID가 110인 고객의 이름, 주소, 전화번호, 그가 지금까지 주문한 주문정보중 주문_ID, 주문일, 주문상태 조회
 select  c.cust_name,
         c.address,
         c.phone_number,
         o.order_id,
         o.order_date,
         o.order_status
from orders o right join customers c on o.cust_id = c.cust_id
where c.cust_id =110;

-- TODO : 고객 ID가 120인 고객의 정보와 지금까지 주문한 주문정보를 모두 조회.
 select  *
 --select c.* customers 의 칼럼만
 --select c.*   ㅊcsutomers 의 모든 정보 , 그리고 orders 테이블에서 date만 
   --     o.order_date
from orders o right join customers c on o.cust_id = c.cust_id
where c.cust_id =120;  -- 마찬가지로 0~n개와관계가 잇으니까 outer



-- TODO : '2017/11/13'(주문날짜) 에 주문된 주문///(소스테이블)의 주문고객의 고객_ID, 이름, 주문상태, 총금액을 조회
select  c.cust_id,
        c.cust_name,
        o.order_status,
        o.order_total,
        to_char(o.order_total,'fmL999,999')
from orders o join customers c on o.cust_id = c.cust_id   -- cust_id가 NN이니까 이너 조인을 하던 아우터를 하던 상관업삳.
--from orders o left join customers c on o.cust_id = c.cust_id  (join 된게 있던 없던 다보려면 아우터 조인)
where o.order_date= '2017/11/13';
--where o.order_date = to_date('2017/11/13','yyyy/mm/dd');


-- TODO : 주문상세 ID가 xxxx(임의의 id)인 주문제품의 제품이름, 판매가격, 제품가격을 조회.

select * from order_items;

select  i.order_item_id,
        p.product_name "제품이름", -- 구분자 ,넣기
        i.sell_price "판매가격",
        p.price "제품 가격"
from order_items i join products p on i.product_id = p.product_id
where i.order_item_id = 1;

        
-- TODO : 주문 ID가 4인 주문의 주문 고객의 이름, 주소, 우편번호, 주문일, 주문상태, 총금액, 주문 제품이름, 제조사, 제품가격, 판매가격, 제품수량을 조회.
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
        o.order_id "주문 ID"
from orders o left join customers c on c.cust_id = o.cust_id
              left join order_items i on o.order_id = i.order_id
              left   join products p on i.product_id = p.product_id
where o.order_id = 4 ;



-- TODO : 제품 ID가 200인 제품이 2017년에 몇개 주문되었는지 조회.
--
select  i.quantity "수량",
        p.product_id "제품 ID",
       -- count(*)"주문 횟수",
        --sum(i.quantity)"총 판매개수"
from orders o join order_items i on o.order_id = i.order_id
              join products p on i.product_id = p.product_id
where p.product_id = 200 
and to_char(o.order_date, 'yyyy') = 2017;

--group by 절이 빠졌기 때문에 i.quantity, p.product_id를 select 절에 넣을 수 없습니다.


-- TODO : 제품분류별 총 주문량을 조회
select category from products;


select  p.category,
        nvl(sum(i.quantity),0) "총 주문량"
from products p left join order_items i on p.product_id = i.product_id   -- 소스테이블을 전부 보고 싶을때 outer join
--from products p join order_items i on p.product_id = i.product_id  null 값 제거 //join 된 것만 보고 싶을 때 
group by p.category;



