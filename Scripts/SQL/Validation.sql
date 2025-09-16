-- ========================
-- Total Loan Applications
-- ========================
SELECT	
	COUNT(id) total_loan_application 
FROM bank_loan;

SELECT 
	COUNT(id) mtd_total_loan_application
FROM bank_loan
WHERE MONTH(issue_date) = 12
AND YEAR(issue_date) = 2021;

SELECT 
	COUNT(id) pmtd_total_loan_application
FROM bank_loan
WHERE MONTH(issue_date) = 11
AND YEAR(issue_date) = 2021;

-- ===================
-- Total Funded Amount
-- ===================
SELECT 
	SUM(loan_amount) Total_Fund
FROM bank_loan;

SELECT 
	SUM(loan_amount) MTD_total_loan_amount
FROM bank_loan
WHERE YEAR(issue_date) = 2021
AND MONTH(issue_date) = 12;

SELECT 
	SUM(loan_amount) LastMonth_total_amount
FROM bank_loan
WHERE YEAR(issue_date) = 2021
AND MONTH(issue_date) = 11;

-- ======================
-- Total Amount Received
-- ======================
SELECT 
	SUM(total_payment) total_payment
FROM bank_loan;

SELECT 
	YEAR(issue_date) Year,
	MONTH(issue_date) Month,
	SUM(total_payment) total_payment
FROM bank_loan
WHERE YEAR(issue_date) = 2021
AND MONTH(issue_date) = 12
GROUP BY YEAR(issue_Date), MONTH(issue_date);

SELECT 
	YEAR(issue_date) Year,
	MONTH(issue_date) Month,
	SUM(total_payment) total_payment
FROM bank_loan
WHERE YEAR(issue_date) = 2021
AND MONTH(issue_date) = 11
GROUP BY YEAR(issue_Date), MONTH(issue_date);

-- ======================
-- Average Interest Rate
-- ======================
SELECT 
	AVG(int_rate) Avg_Intrest_Rate
FROM bank_loan;

SELECT 
	AVG(int_rate) Avg_Interest_Rate
FROM bank_loan
WHERE YEAR(issue_date) = 2021
AND MONTH(issue_date) = 12;

SELECT 
	AVG(int_rate) Previous_Month_Avg_Interest_Rate
FROM bank_loan
WHERE YEAR(issue_date) = 2021
AND MONTH(issue_date) = 11;

-- ===================================
-- Average Debt-to-Income Ratio (DTI): 
-- ===================================
SELECT
	AVG(dti) Avg_dti
FROM bank_loan;

SELECT 
	AVG(dti) MTD_Avg_Dti
FROM bank_loan
WHERE YEAR(issue_date) = 2021
AND MONTH(issue_date) = 12;

SELECT 
	AVG(dti) PMTD_Avg_Dti
FROM bank_loan
WHERE YEAR(issue_date) = 2021
AND MONTH(issue_date) = 11;


-- ==================================
-- Good Loan Application Percentage
-- ==================================
SELECT
    (COUNT(	CASE 
				WHEN loan_status IN ('Fully Paid', 'Current') THEN 1 
			END) * 100.0 / COUNT(*)) Good_Loan_Percentage
FROM bank_loan;

-- ======================
-- Good Loan Application
-- ======================
SELECT 
	COUNT(CASE	
			WHEN loan_status IN('Fully Paid', 'Current') THEN 1
		 END)  Good_loan
FROM bank_loan;
				
-- ========================
-- Good Loan Funded Amount
-- ========================
SELECT
	'Good Loan' AS loan_category,
	SUM(loan_amount) total_loan_amount
FROM bank_loan
WHERE loan_status IN ('Fully Paid', ' Current');

-- ================================
-- Good Loan Total Received Amount
-- ================================
SELECT 
    'Good Loan' AS loan_category,
    SUM(total_payment) AS total_received_amount
FROM bank_loan
WHERE loan_status IN ('Fully Paid', 'Current');

-- ================================
-- Bad Loan Application Percentage
-- ================================
SELECT 
	(COUNT(	CASE 
				WHEN loan_status = 'Charged Off' THEN 1 
			END) * 100.0 / COUNT(*)) bad_loan_percentage
FROM bank_loan;

-- =====================
-- Bad Loan Application
-- =====================
SELECT
	loan_status,
	COUNT(loan_status) bad_loan_applications 
FROM bank_loan
WHERE loan_status = 'Charged Off'
GROUP BY loan_status;

-- =======================
-- Bad Loan Funded Amount
-- =======================
SELECT 
	'Bad Loan' AS loan_category,
	SUM(loan_amount) total_loan
FROM bank_loan
WHERE loan_status = 'Charged Off';

-- ===============================
-- Bad Loan Total Received Amount
-- ===============================
SELECT 
	'Bad Loan' AS loan_category,
	SUM(total_payment) total_loan
FROM bank_loan
WHERE loan_status = 'Charged Off';


-- =============
-- Loan Status
-- =============
SELECT
	loan_status,
	COUNT(id) Total_Loan_Applications,
	SUM(total_payment) Total_amount_recieved,
	SUM(loan_amount) Total_loan_amount,
	ROUND(AVG(int_rate) * 100, 2) Intrest_Rate,
	ROUND(AVG(dti) * 100, 2) Dti
FROM bank_loan
GROUP BY loan_status;

-- ===============
-- Month To Date 
-- ===============
SELECT 
	loan_status,
	SUM(total_payment) MTD_Total_amount_received,
	SUM(loan_amount) MTD_Total_loan_amount
FROM bank_loan
GROUP BY loan_status;

-- ==================
-- Month Wise Trends
-- ==================
SELECT
	Month(issue_date) Month,
	FORMAT(issue_date, 'MMMM') Month_Of_Loan_issue,
	COUNT(id) Total_Loan_Application,
	SUM(loan_amount) Total_Loan_funded,
	SUM(total_payment) Total_Payment
FROM bank_loan
GROUP BY MONTH(issue_date), FORMAT(issue_date, 'MMMM')
ORDER BY Month(issue_date);

-- ==================
-- Regional Analysis
-- ==================
SELECT 
	address_state,
	COUNT(id) Total_Loan_Application,
	SUM(loan_amount) Total_Loan_funded,
	SUM(total_payment) Total_Payment
FROM bank_loan
GROUP BY address_state
ORDER BY SUM(loan_amount) DESC;

-- ====================
-- Loan Terms Analysis
-- ====================
SELECT
	term,
	COUNT(id) Total_Loan_Application,
	SUM(loan_amount) Total_Loan_funded,
	SUM(total_payment) Total_Payment
FROM bank_loan
GROUP BY term
ORDER BY SUM(loan_amount) DESC;

-- ========================
-- Employee Length Analysis
-- ========================
SELECT 
	emp_length,
	COUNT(id) Total_Loan_Application,
	SUM(loan_amount) Total_Loan_funded,
	SUM(total_payment) Total_Payment
FROM bank_loan
GROUP BY emp_length
ORDER BY SUM(loan_amount) DESC;

-- =======================
-- Loan Purpose Breakdown
-- =======================
SELECT 
	purpose,
	COUNT(id) Total_Loan_Applications,
	SUM(loan_amount) Total_loan_funded,
	SUM(total_payment) Total_payment
FROM bank_loan
GROUP BY purpose
ORDER BY SUM(loan_amount) DESC;

-- ========================
-- Home Ownership Analysis
-- ========================
SELECT 
	home_ownership,
	COUNT(id) Total_Loan_Applications,
	SUM(loan_amount) Total_Loan_funded,
	SUM(total_payment) Total_payment
FROM bank_loan
GROUP BY home_ownership
ORDER BY SUM(loan_amount) DESC;