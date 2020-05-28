
DROP VIEW viewDonationByCampaign;

CREATE VIEW viewDonationByCampaign AS

SELECT alumni_donation_memo as CampaignName, SUM(alumni_donation_amount) as TotalDonation_USD 
FROM alumni_donation d
GROUP BY alumni_donation_memo;