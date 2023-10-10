SELECT
	*
FROM (
	SELECT
		l.LoanRuleNum,
		l.name,
		d.id,
		d.location,
		d.itype,
		d.ptype,
		CASE WHEN l.code = 'R' THEN
			'R-Days'
		WHEN l.code = 'K' THEN
			'K-Hours no overnight'
		WHEN l.code = 'J' THEN
			'J-Hours overnight'
		WHEN l.code = 'N' THEN
			'N-Non-circulating'
		WHEN l.code = 'I' THEN
			'I-Hours rounded to minute'
		END AS 'code',
		l.NormalLoanPeriod,
		l.Holdable,
		l.MaxNumberOfRenewals,
		l.GracePeriodForFines,
		CASE WHEN l.GracePeriodForFines = '0' THEN
			l.AmountOfFine1stFPer
		ELSE
			l.AmountOfFine2NDFPer
		END AS AmountOfFine,
		CASE WHEN l.GracePeriodForFines = '0' THEN
			l.NumberOfDHR1stFPer
		ELSE
			l.NumberOfDHR2ndFPer
		END AS LengthOfFinePeriod,
		l.DefaultItemCost
	FROM
		determiner_expanded d
		JOIN loan_rules l ON d.rule_number = l.LoanRuleNum
	WHERE
		d.itype IN(?, '9999')
		AND d.active = 'Y'
		AND(d.location LIKE substr(?, 1, 5) || '%'
			OR d.location = '?????')
		AND d.ptype IN(?, '9999')) a
ORDER BY
	a.id DESC
LIMIT 1