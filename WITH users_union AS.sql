-- Find the popularity percentage for each user on Meta/Facebook. The popularity percentage is defined as the total number of friends the user has divided by the total number of users on the platform, then converted into a percentage by multiplying by 100.
-- Output each user along with their popularity percentage. Order records in ascending order by user id.
-- The 'user1' and 'user2' column are pairs of friends.

WITH users_union AS
  (SELECT user1,
          user2
   FROM facebook_friends
   UNION SELECT user2 AS user1,
                user1 AS user2
   FROM facebook_friends)
SELECT user1,
       count(*)::float /
  (SELECT count(DISTINCT user1)
   FROM users_union)*100 AS popularity_percent
FROM users_union
GROUP BY 1
ORDER BY 1

-- ეს არის პოპულარობის პროცენტობის გამოთვლის სოლუშენი აქ ყურადღება უნდა მივაქციოთ ამ ნაწილს რომელიც ყველაზე საინტერესოა    UNION SELECT user2 AS user1,
                -- user1 AS user2  იუნიონი აერტიანებს ორ სელექთ სტეიტმენტს შესაბამისად როცა გაერთიანდებიან ჩვენ უნდა ვუზრუნველყოთ რომ 
                --უსერებს შორის ბინარული ურთიერთობა ასახული და შენარჩუნებული იქნება მიღებულ ტაბელზე მაგ:

                   -- USER1 USER 2

                --    1       6
                --    2       7
                --    3       8
                --    4       9
                --    5       10 

                -- ამის მერე UNION SELECT user2 AS user1,
                --user1 AS user2

                -- მივიღებთ ამას 
                
                --    1       6
                --    2       7
                --    3       8
                --    4       9
                --    5       10 
                --    6       1
                --    7       2
                --    8       3
                --    9       4
                --    10       5  

                -- ეს იქნება გაერთიანებული რომელიც ორივეს შეიცავს და აჩვენებს ბინარულობას აქ მომხმარებელ 1ში შეგვიძლია წარმოვიდგინოთ იუზერები და
                -- მომხმარებელ ოში მეგობრები

