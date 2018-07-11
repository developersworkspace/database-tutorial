CREATE SCHEMA [schema-3];

DROP TABLE IF EXISTS [schema-3].[Products];

CREATE TABLE [schema-3].[Products] (
    [ProductId] INT IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR(255)
);

DROP TABLE IF EXISTS [schema-3].[Issues];

CREATE TABLE [schema-3].[Issues] (
    [IssueId] INT IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR(255)
);

DROP TABLE IF EXISTS [schema-3].[Companies];

CREATE TABLE [schema-3].[Companies] (
    [CompanyId] INT IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR(255)
);

DROP TABLE IF EXISTS [schema-3].[States];

CREATE TABLE [schema-3].[States] (
    [StateId] INT IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR(255)
);

DROP TABLE IF EXISTS [schema-3].[SubmittedVia];

CREATE TABLE [schema-3].[SubmittedVia] (
    [SubmittedViaId] INT IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR(255)
);

DROP TABLE IF EXISTS [schema-3].[Complaints];

CREATE TABLE [schema-3].[Complaints] (
    [DateReceived] DATE NOT NULL,
    [ProductId] INT,
    [SubProductId] INT,
    [IssueId] INT,
    [SubIssueId] INT,
    [ConsumerComplaintNarrative] VARCHAR(4096),
    [CompanyPublicResponse] VARCHAR(255),
    [CompanyId] INT,
    [StateId] INT,
    [ZIPCode] VARCHAR(255),
    [Tags] VARCHAR(255),
    [ConsumerConsentProvided] BIT,
    [SubmittedViaId] INT,
    [DateSentToCompany] DATE,
    [CompanyResponseToConsumer] VARCHAR(255),
    [TimelyResponse] BIT,
    [ConsumerDisputed] BIT,
    [ComplaintId]  INT NOT NULL
);

INSERT INTO [schema-3].[Products] ([Name])
SELECT [Product] FROM [schema-1].[Complaints]
WHERE [Product] IS NOT NULL
GROUP BY [Product]
UNION
SELECT [SubProduct] AS [Product] FROM [schema-1].[Complaints] WHERE [SubProduct] IS NOT NULL 
GROUP BY [SubProduct];

INSERT INTO [schema-3].[Issues] ([Name])
SELECT [Issue] FROM [schema-1].[Complaints] WHERE [Issue] IS NOT NULL GROUP BY [Issue];

INSERT INTO [schema-3].[Companies] ([Name])
SELECT [Company] FROM [schema-1].[Complaints] WHERE [Company] IS NOT NULL GROUP BY [Company];

INSERT INTO [schema-3].[States] ([Name])
SELECT [State] FROM [schema-1].[Complaints] WHERE [State] IS NOT NULL GROUP BY [State];

INSERT INTO [schema-3].[SubmittedVia] ([Name])
SELECT [SubmittedVia] FROM [schema-1].[Complaints] WHERE [SubmittedVia] IS NOT NULL GROUP BY [SubmittedVia];


INSERT INTO [schema-3].[Complaints] 
SELECT 
[complaint].[DateReceived],
[product].[ProductId],
[subProduct].[ProductId] AS [SubProductId],
[issue].[IssueId],
[subIssue].[IssueId] AS [SubIssueId],
[ConsumerComplaintNarrative],
[CompanyPublicResponse],
[company].[CompanyId],
[state].[StateId],
[ZIPCode],
[Tags],
CASE [ConsumerConsentProvided]
  WHEN 'N/A' THEN NULL 
  WHEN 'Consent provided' THEN 1 
  WHEN 'Consent not provided' THEN 0
END AS [ConsumerConsentProvided],
[submittedVia].[SubmittedViaId],
[DateSentToCompany],
[CompanyResponseToConsumer],
CASE [TimelyResponse]
  WHEN NULL THEN NULL 
  WHEN 'Yes' THEN 1 
  WHEN 'No' THEN 0
END AS [TimelyResponse],
CASE [ConsumerDisputed]
  WHEN NULL THEN NULL 
  WHEN 'Yes' THEN 1 
  WHEN 'No' THEN 0
END AS [ConsumerDisputed],
[ComplaintId]
FROM [schema-1].[Complaints] AS [complaint]
LEFT JOIN [schema-3].[Products] AS [product]
ON [product].[Name] = [complaint].[Product]
LEFT JOIN [schema-3].[Products] AS [subProduct]
ON [subProduct].[Name] = [complaint].[SubProduct]
LEFT JOIN [schema-3].[Issues] AS [issue]
ON [issue].[Name] = [complaint].[Issue]
LEFT JOIN [schema-3].[Issues] AS [subIssue]
ON [subIssue].[Name] = [complaint].[SubIssue]
LEFT JOIN [schema-3].[Companies] AS [company]
ON [company].[Name] = [complaint].[Company]
LEFT JOIN [schema-3].[States] AS [state]
ON [state].[Name] = [complaint].[State]
LEFT JOIN [schema-3].[SubmittedVia] AS [submittedVia]
ON [submittedVia].[Name] = [complaint].[SubmittedVia];

CREATE INDEX index_complaintId
ON [schema-3].[Complaints] ([ComplaintId]);
