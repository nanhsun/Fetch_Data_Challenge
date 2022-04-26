# Fetch_Data_Challenge

This is my data challenge for Fetch Rewards. I will detail what I did for each problem below.

## Review Existing Unstructured Data and Diagram a New Structured Relational Data Model
I utilized Python to open the JSON files in order to explore the data. I discovered that between receipt data schema and user data schema, both can be joined via receipt data schema's user_id and user data schema's id column. I also discovered that within the receipt data schema, the field rewardsReceiptItemList contains a table. Thus, I extracted the table from the field and give it a new column that corresponds to receipt data schema's id column so I can join both schemas. Therefore, we would have 4 schemas instead of 3, the 4th being a schema that gives us information on the items purchased in each receipt.

While I've provided a method of relating receipt schema to user schema and to receipt item list schema, I couldn't find a method of relating brand schema to any other schemas at first. I assume the brand schema must be able to map to receipt item schema, as brand schema gives us information on product items' brands. In addition, the field cpg in brand schema also contains a table with only 2 fields, therefore I extract the 2 fields and merge them with the brand schema. I utilize Python again to find foreign keys that can help map brand schema to receipt item schema, and discover the composite key pair of (brandCode, cpg_id) of brand schema can map brand schema to receipt item list schema's composite key pair of (brandCode, rewardsPartnerProductId). The reason I use composite key pair is because in the brand schema, brandCode contains some duplicate values, but pairing it with cpg_id can create a composite key.

The PDF file shows the ER diagram of the 4 tables. Note that I excluded some columns for rewardsReceiptItemList, as there are too many columns for the schema and the excluded columns are, after careful inspection, of no importance when considering problem 3.

