# Screenshots

## Captures of the LinguaSync database running in pgAdmin 4 on PostgreSQL 15. All data shown is fictional demo data.

### Database objects

![LinguaSync Tables](./pgAdmin_tables.png)
*LinguaSync Tables - The 24 tables in the public schema*

<br>
<br>



![LinguaSync Views](./pgAmin_views.png) 
*LinguaSync Views - The 19 views: 9 active-record views and 10 reporting views*

<br>
<br>



#### Reporting views

![LinguaSync Business Margin](./vw_margin_report.png) 
*Project margin report: revenue, cost and margin per project.*

<br>
<br>


![LinguaSync Overview Dashboard](./vw_project_dashboard.png) 
*Project dashboard: agency, type, rates, status and deadline flag*

<br>
<br>


#### Tests


![LinguaSync Test Constraint](./test_constraint_error.png) 
*A CHECK constraint rejecting invalid data*

<br>
<br>


![LinguaSync Test Pair Limit](./test_five_pair_limit.png) 
*The trigger refusing a sixth language pair on an account*

<br>
<br>


![LinguaSync Business Reconciliation](./test_reconcilation.png) 
*Financial reconciliation: 12,027.40 received, 7,951.30 paid out, margin 4,076.10*

<br>
<br>



The full test scripts are in `sql/tests/`, with expected and observed
results in `expected_results.md` and `test_results.md`.

For the diagrams, see [Diagrams](/diagram/README.md).