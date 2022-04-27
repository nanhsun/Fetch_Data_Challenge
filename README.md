# Fetch_Data_Challenge

This is my data challenge for Fetch Rewards. I will detail what I did for each problem below.

## Review Existing Unstructured Data and Diagram a New Structured Relational Data Model
I utilized Python to open the JSON files in order to explore the data. I discovered that between receipt data schema and user data schema, both can be joined via receipt data schema's user_id and user data schema's id column. I also discovered that within the receipt data schema, the field rewardsReceiptItemList contains a table. Thus, I extracted the table from the field and give it a new column that corresponds to receipt data schema's id column so I can join both schemas. Therefore, we would have 4 schemas instead of 3, the 4th being a schema that gives us information on the items purchased in each receipt.

While I've provided a method of relating receipt schema to user schema and to receipt item list schema, I couldn't find a method of relating brand schema to any other schemas at first. I assume the brand schema must be able to map to receipt item schema, as brand schema gives us information on product items' brands. In addition, the field cpg in brand schema also contains a table with only 2 fields, therefore I extract the 2 fields and merge them with the brand schema. I utilize Python again to find foreign keys that can help map brand schema to receipt item schema, and discover the composite key pair of (brandCode, cpg_id) of brand schema can map brand schema to receipt item list schema's composite key pair of (brandCode, rewardsPartnerProductId). The reason I use composite key pair is because in the brand schema, brandCode contains some duplicate values, but pairing it with cpg_id can create a composite key.

The PDF file shows the ER diagram of the 4 tables. Note that I excluded some columns for rewardsReceiptItemList, as there are too many columns for the schema and the excluded columns are, after careful inspection, of no importance when considering problem 3.

## Write a query that directly answers a predetermined question from a business stakeholder
The SQL code is included in the repository. I picked the first bullet point to answer. I assume that we only need brand code and their number in different receipts. I joined the two tables by using brandCode, cpg_id and rewardsProductPartnerId, as mentioned above.

##  Evaluate Data Quality Issues in the Data Provided
While doing exploratory analysis, as mentioned in Problem 1, I found out that there are data that are wrapped inside brackets in columns, such as id column, cpg column, and also receiptItemList. While it may be an easier way to store data in JSON, I do have to unwrap those columns before proceeding.

Besides the wrapped data in columns, I also noticed that there are a lot of null values in brandCode column in both brand schema and receipt item list schema. Using Python, I found that 20% of the brandCode column in the brand schema are null values, and up to 64% of the brandCode column in receipt item list schema are null values. The null values in both schemas can create holes in the data, as it means that for the brand schema, some listed brands cannot be found via brandCode, and for the receipt item list schema, some items cannot be mapped to the brand schema, thus preventing us to know which item belongs to which brand.

In addition, some brandCodes in receipt item list schema are spelled differently than those in the brand schema, for example, Ben and Jerry's is spelled as Ben and Jerrys in receipt item list schema, while in the brand schema it is spelled as Ben & Jerry's. This is shown in the Python code provided. This can create inconsistencies when mapping items to brands, and worse, it could be infeasible to join both schemas. 

Lastly, around 80% of the brandCodes in receipt item list schema cannot be mapped into the brand schema, as the brand schema is either missing the brandCodes or have the brandCodes spelled differently than those in receipt item list. This can lead into the problem of not being able to correctly find the brands of each item in the receipt list.

## Communicate with Stakeholders
The PDF file is the email I'd send to stakeholders detailing my questions regarding the data.
