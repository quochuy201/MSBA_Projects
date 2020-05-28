DROP VIEW IF EXISTS viewTop5Donation;

CREATE  VIEW viewTop5Donation AS 

SELECT a.alumni_name, Total_Donation
FROM alumni a
RIGHT JOIN (SELECT alumni_id, 
			SUM(alumni_donation_amount) AS Total_Donation
			FROM alumni_donation d
			GROUP BY alumni_id
			ORDER BY Total_Donation DESC
			LIMIT 5) AS d
ON a.alumni_id = d.alumni_id