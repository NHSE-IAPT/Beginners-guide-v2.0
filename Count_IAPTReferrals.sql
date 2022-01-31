-- This query will return the total number of referrals to IAPT talking therapies, as displayed on the NHS Digital website 'lastest statistics' publication ----
--- The script is designed to accompany the 'Looking at SQL queries' section of the IAPT beginners guide (2.1)

---- start of script -------------------------------------------------------------------------------------------------------------------------------------------

--- declare variables to hold values for PeriodStart and PeriodEnd dates
DECLARE @PeriodStart DATE
DECLARE @PeriodEnd DATE

--- set the values for PeriodStart and PeriodEnd dates
SET @PeriodStart = '2021-09-01'
SET @PeriodEnd = '2021-09-30'

-- SELECT statement uses COUNT(DISTINCT..) and CASE WHEN to return an aggregate value AS 'Count_IAPTReferrals' between the specified period start/end dates
SELECT  COUNT(DISTINCT CASE WHEN ReferralRequestReceivedDate BETWEEN @PeriodStart and @PeriodEnd THEN PathwayID ELSE NULL END) AS Count_IAPTReferrals

-- FROM statement points to the referrals table within the IAPT v2 database (AS r) including INNER JOINS on the IsLatest_SubmissionID and IDS000_Header tables
FROM [NHSE_IAPT_v2].dbo.IDS101_Referral r
INNER JOIN [NHSE_IAPT_v2].[dbo].[IsLatest_SubmissionID] l ON r.[UniqueSubmissionID] = l.[UniqueSubmissionID] AND r.AuditId = l.AuditId
INNER JOIN [NHSE_IAPT_v2].[dbo].[IDS000_Header] h ON r.[UniqueSubmissionID] = h.[UniqueSubmissionID]

-- WHERE statement provides additional parameters to the query to ensure that all referrals are valid and within the specified period start/end dates
WHERE UsePathway_Flag = 'True' AND IsLatest = 1 AND h.[ReportingPeriodStartDate] BETWEEN DATEADD(MONTH, 0, @PeriodStart) AND @PeriodStart

---- end of script ---------------------------------------------------------------------------------------------------------------------------------------------
