-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

with total_msgs as (
  select user_id, 
       date(sent_at) as day,
      count(message_id) as total_msgs
from npn_users u
left join npn_messages m
on u.user_id = m.sender_id
group by user_id, date(sent_at)
                      ) ,
ranked as (
  select day, total_msgs, user_id,
         rank() over (partition by day order by total_msgs desc) as rnk
  from total_msgs
  ) 

select day, user_id, total_msgs
from ranked 
where rnk =1
