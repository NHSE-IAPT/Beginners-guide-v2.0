
-- This query will return the total number of referrals completing a course of treatment, as displayed on the NHS Digital website 'lastest statistics' publication ---------------

--- This file is designed to accompany section [] of the IAPT beginners guide (2.1)


---- start of script -------------------------------------------------------------------------------------------------------------------------------------------------------------

--- declare variables to hold values for PeriodStart and PeriodEnd dates

DECLARE @PeriodStart DATE
DECLARE @PeriodEnd DATE

--- set the values for PeriodStart and PeriodEnd dates

SET @PeriodStart = '2021-09-01'
SET @PeriodEnd = '2021-09-30'

-- SELECT statement

SELECT  COUNT(DISTINCT CASE WHEN ServDischDate BETWEEN @PeriodStart and @PeriodEnd AND CompletedTreatment_Flag = 'TRUE' THEN PathwayID ELSE NULL END) AS Count_EndedReferrals

-- FROM statement

FROM [NHSE_IAPT_v2].dbo.IDS101_Referral r
INNER JOIN [NHSE_IAPT_v2].[dbo].[IsLatest_SubmissionID] l ON r.[UniqueSubmissionID] = l.[UniqueSubmissionID] AND r.AuditId = l.AuditId
INNER JOIN [NHSE_IAPT_v2].[dbo].[IDS000_Header] h ON r.[UniqueSubmissionID] = h.[UniqueSubmissionID]

-- WHERE statement

WHERE UsePathway_Flag = 'True' AND IsLatest = 1 AND h.[ReportingPeriodStartDate] BETWEEN DATEADD(MONTH, 0, @PeriodStart) AND @PeriodStart

---- end of script ---------------------------------------------------------------------------------------------------------------------------------------------------------------