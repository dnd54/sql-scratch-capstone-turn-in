 --Quiz Funnel
 SELECT *
 FROM survey
 LIMIT 10; 
 SELECT question,
   COUNT(DISTINCT user_id)
FROM survey
GROUP BY question;

--Home Try-On Funnel

SELECT *
FROM quiz
LIMIT 5;

SELECT *
FROM home_try_on 
LIMIT 5;

SELECT *
FROM purchase
LIMIT 5; 

SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs as 'is_number_of_pairs',
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id
 LIMIT 10;

WITH funnel AS
(SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id)
   SELECT number_of_pairs, COUNT(*) AS purchased
   FROM funnel
   WHERE is_purchase = 1
   GROUP BY number_of_pairs;

 with funnel as 
(SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs as 'number_of_pairs',
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id)
select count(*) as 'wp_quiz', sum(is_purchase) as 'purchased', 1.0 * sum(is_purchase) / (count(*)) as 'overall_purchase_rate'
from funnel;

with funnel as 
(SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs as 'number_of_pairs',
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id)
select count(*) as 'wp_quiz', sum(is_home_try_on) as 'try_on', 1.0 * sum(is_home_try_on) / (count(*)) as 'quiz_to_try_on_rate'
from funnel;                                                                                               
with funnel as 
(SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs as 'number_of_pairs',
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id)
SELECT sum(is_home_try_on) as 'try_on', SUM(is_purchase) as 'purchased', 1.0 * SUM(is_purchase) / (SUM(is_home_try_on)) as 'try_on_to_purchase_rate'
FROM funnel;                                                
                                      
with funnel as 
(SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs as 'number_of_pairs',
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id)
SELECT sum(is_home_try_on) as '3_pair_try_on', sum(is_purchase) as '3_pair_purchase', 1.0 * sum(is_purchase) / sum(is_home_try_on) as 'try_on_to_purchase_rate_3pair'
FROM funnel
WHERE number_of_pairs = '3 pairs';

with funnel as 
(SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs as 'number_of_pairs',
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id)
SELECT sum(is_home_try_on) as '5_pair_try_on', sum(is_purchase) as '5_pair_purchase', 1.0 * sum(is_purchase) / sum(is_home_try_on) as 'try_on_to_purchase_rate_5pair'
FROM funnel
WHERE number_of_pairs = '5 pairs'; 
