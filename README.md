ApexQueryUtilities

This project aims to extend the capability of standard SOQL queries in Salesforce.

2012-12-12: QueryUtil.query accepts query strings in format "Select * From ..." and dynamically replaces "*" with all fields for the sObject table being queried.

2013-02-19: QueryUtil.query can now handle extra whitespace, as often happens when entering queries in a multi-line format for readibility

2013-02-22: QueryUtil.query accepts query strings in format "Select *, Relationship__r.RelField__c From ...". Not that it can't yet handle relationship subqueries like "Select *, (SELECT ID FROM Relationship)  From ..."
