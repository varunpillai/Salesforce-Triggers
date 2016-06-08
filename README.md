# Salesforce-Triggers

1. Campaign Date Validation - checks if the Start Date of the Campaign is always before End Date
2. Revenue Amortization per Month - Amortizes the Amount received in Opportunity by number of days per month the Campaign was run between.
                                    It requires a child object Monthly_Forecast__c with the fields as shown in the image which is linked to Opportunity.Id

![alt tag](https://raw.githubusercontent.com/varunpillai/Salesforce-Triggers/master/Revenue%20Amortization%20per%20Month.jpg)
