SELECT
	LoanRuleNum,
	Name,
	NormalLoanPeriod
FROM
	loan_rule
WHERE
	LoanRuleNum NOT IN(
		SELECT
			rule_number FROM determiner)