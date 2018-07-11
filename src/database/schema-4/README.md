# Schema 4

## Tables

* `[schema-4].[Products]`
* `[schema-4].[Issues]`
* `[schema-4].[Companies]`
* `[schema-4].[States]`
* `[schema-4].[SubmittedVia]`
* `[schema-4].[Complaints]`

## Changes

* Created index on `ProductId` column in `[schema-4].[Complaints]`.
* Created index on `SubProductId` column in `[schema-4].[Complaints]`.
* Created index on `IssueId` column in `[schema-4].[Complaints]`.
* Created index on `ConsumerDisputed` column in `[schema-4].[Complaints]`.

## Performance

* Find By Complaint Id
    * 438.5964 Queries per Second
* Find By Product, Sub-Product, Issue and Consumer Disputed
    * 12.7420 Requests per Second
