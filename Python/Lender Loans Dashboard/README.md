# 😎 Mortgage Insurance Dashboard for Lenders 

## Project Goal
The goal of this project is to create a comprehensive, self-serve dashboard for mortgage insurance lenders in Canada. The dashboard enables lenders to analyze historical trends, predict future developments, and assess risks associated with mortgage insurance applications

## Project Overview
This project gathers, organizes, transforms, and analyzes data to create a self-serve dashboard for Mortgage Insurance Lenders in Canada.
The process involved several Python programs and utilized a combination of SQL, Excel, and Python to process and modify the data.

---

## Technologies Used

- **Python**: Core language for the analysis.
- **Pandas**: For data manipulation and cleaning.
- **SQL**: For data manipulation.
- **Databricks**: To document and run the analysis.

---

**Examples of Code**:

```python
#Create Integer Date filters for the monthly calculation
from datetime import datetime, timedelta 
from dateutil.relativedelta import relativedelta
today = datetime.today()

CURRENT_YTD_END = datetime(today.year, today.month, 1) - relativedelta(days=1)
CURRENT_YTD_BEG = datetime(today.year, 1, 1)
PRIOR_YTD_END = datetime(today.year - 1, today.month, 1) - relativedelta(days=1)
PRIOR_YTD_BEG = datetime(PRIOR_YTD_END.year, 1, 1)
PRIOR_YTD = datetime(today.year - 1, today.month, 1) - relativedelta(days=1)
```
```python
#Import Excel file to join with the dataset
bns = pd.read_excel(
    "BNS Name List Last Update.xlsx", dtype={"INACTIVE_DATE_LASTUPDATE": str}
).astype(str)
bns["LENDER_CHANNEL_LASTUPDATE"] = bns["LENDER_CHANNEL_LASTUPDATE"].replace(
    " ", "", regex=True
)
df_bns = ss.createDataFrame(bns)
df_bns = df_bns.withColumn(
    "LENDER_CHANNEL_LASTUPDATE", trim(df_bns.LENDER_CHANNEL_LASTUPDATE)
)
df_bns.createOrReplaceTempView("df_bns")
```
```python
#Join Application messages with Low Ratio base data and save table in Sandbox
mess_2 = mess.withColumnRenamed("cmhc_loan_account_nbr","cmhc_loan_account_nbr_2")
df_result = df_lr_2.join(mess_2, df_lr_2.cmhc_loan_account_nbr == mess_2.cmhc_loan_account_nbr_2,how='left')
df_result.write.mode("overwrite").format("orc").saveAsTable("sb_rmo_ho_reporting.lender_dashboard_low_ratio")
print("Low Raio Final Data with PVII Appraisal table creation completed at: ", str(datetime.now()))
```

## Key Insights/Results

### **Cleaned, joined, and tested data for analysis**

The data was thoroughly cleaned to remove inconsistencies, missing values, and duplicates, ensuring it was ready for accurate analysis. Afterward, multiple datasets were joined using relevant keys, and rigorous testing was conducted to validate the integrity and accuracy of the combined data for analysis.

### **Created datasets used for PBI Dashboard**
Datasets were created specifically for the Power BI dashboard, designed to encapsulate key metrics and insights necessary for comprehensive data visualization. These datasets were structured to facilitate efficient querying and reporting, ensuring that the dashboard provides real-time insights and supports informed decision-making.

