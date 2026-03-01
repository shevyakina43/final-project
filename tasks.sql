-- ============================================
-- SQL BLOCK
-- BigQuery: thelook_ecommerce
-- ============================================

-- Завдання 1: Користувачі з Бразилії (2023)

SELECT 
  first_name,
  last_name,
  email
FROM `bigquery-public-data.thelook_ecommerce.users`
WHERE country = 'Brasil'
  AND EXTRACT(YEAR FROM created_at) = 2023;
-- Тут ми вивели Ім'я, Прізвище, Е-мейл з таблиці `bigquery-public-data.thelook_ecommerce.users`, де відобразили тільки Бразилію і тільки 2023 рік.


-- Завдання 2: Кількість товарів у кожній категорії

SELECT 
  category,
  COUNT(*) AS total_products
FROM `bigquery-public-data.thelook_ecommerce.products`
GROUP BY category
ORDER BY total_products DESC;
-- Ми порахували кількість товарів у категорії, потім згрупували та відсортували від більшого до меншого, у результаті ми отримали, що «Intimates» — це категорія з найбільшою кількістю товарів.


-- Завдання 3: Замовлення зі статусом 'Shipped'

SELECT 
  o.order_id,
  u.first_name,
  u.last_name,
  o.status
FROM `bigquery-public-data.thelook_ecommerce.orders` AS o
JOIN `bigquery-public-data.thelook_ecommerce.users` AS u
  ON o.user_id = u.id
WHERE o.status = 'Shipped';
-- Ми об'єднали таблиці замовлень і користувачів і вивели з них Ім'я, Прізвище та статус (відправлено).
-- o.order_id  → из orders
-- u.first_name → из users


-- Завдання 4: Топ-10 найдорожчих замовлень

SELECT 
  order_id,
  user_id,
  SUM(sale_price) AS total_order_amount
FROM `bigquery-public-data.thelook_ecommerce.order_items`
GROUP BY order_id, user_id
ORDER BY total_order_amount DESC
LIMIT 10;
-- Згрупували за order_id, підрахували загальну вартість замовлення, відсортували і взяли топ-10 замовлень.
-- 1369,94 = це означає найдорожче замовлення (грошових одиниць).


-- Завдання 5: Країни з понад 500 користувачами

SELECT 
  country,
  COUNT(DISTINCT id) AS total_users
FROM `bigquery-public-data.thelook_ecommerce.users`
GROUP BY country
HAVING COUNT(DISTINCT id) > 500
ORDER BY total_users DESC;
-- У базі даних тільки 11 країн мають понад 500 користувачів, що свідчить про те, що клієнтська база компанії:
-- зосереджена в обмеженій кількості країн.
-- нерівномірно розподілена глобально.
