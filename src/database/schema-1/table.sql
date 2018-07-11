CREATE SCHEMA [schema-1];

DROP TABLE IF EXISTS [schema-1].[Complaints];

CREATE TABLE [schema-1].[Complaints] (
    [DateReceived] DATE NOT NULL,
    [Product] VARCHAR(255),
    [SubProduct] VARCHAR(255),
    [Issue] VARCHAR(255),
    [SubIssue] VARCHAR(255),
    [ConsumerComplaintNarrative] VARCHAR(4096),
    [CompanyPublicResponse] VARCHAR(255),
    [Company] VARCHAR(255),
    [State] VARCHAR(255),
    [ZIPCode] VARCHAR(255),
    [Tags] VARCHAR(255),
    [ConsumerConsentProvided] VARCHAR(255),
    [SubmittedVia] VARCHAR(255),
    [DateSentToCompany] DATE,
    [CompanyResponseToConsumer] VARCHAR(255),
    [TimelyResponse] VARCHAR(255),
    [ConsumerDisputed] VARCHAR(255),
    [ComplaintId]  INT NOT NULL
);