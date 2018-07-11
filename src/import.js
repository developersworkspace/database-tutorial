const fs = require('fs');
const sql = require('mssql');
const path = require('path');
const { toColumns, toSQLValue } = require('./helpers');

(async () => {

    const contents = fs.readFileSync(path.join(__dirname, 'data.csv'), 'utf-8');

    const lines = contents.split('\n');

    const connection = await sql.connect({
        database: 'DatabaseTutorial',
        options: {
            encrypt: false,
        },
        password: 'password',
        server: 'localhost\\SQLEXPRESS',
        user: 'database-tutorial',
    });

    let rowsInserted = 0;

    for (let index = 1; index < lines.length; index++) {
        const line = lines[index];

        const values = toColumns(line);

        const sql = `INSERT INTO [schema-1].[Complaints] (
    [DateReceived],
    [Product],
    [SubProduct],
    [Issue],
    [SubIssue],
    [ConsumerComplaintNarrative],
    [CompanyPublicResponse],
    [Company],
    [State],
    [ZIPCode],
    [Tags],
    [ConsumerConsentProvided],
    [SubmittedVia],
    [DateSentToCompany],
    [CompanyResponseToConsumer],
    [TimelyResponse],
    [ConsumerDisputed],
    [ComplaintId]
) VALUES (
    ${toSQLValue(values[0])},
    ${toSQLValue(values[1])},
    ${toSQLValue(values[2])},
    ${toSQLValue(values[3])},
    ${toSQLValue(values[4])},
    ${toSQLValue(values[5])},
    ${toSQLValue(values[6])},
    ${toSQLValue(values[7])},
    ${toSQLValue(values[8])},
    ${toSQLValue(values[9])},
    ${toSQLValue(values[10])},
    ${toSQLValue(values[11])},
    ${toSQLValue(values[12])},
    ${toSQLValue(values[13])},
    ${toSQLValue(values[14])},
    ${toSQLValue(values[15])},
    ${toSQLValue(values[16])},
    ${toSQLValue(values[17])}
);
`;

        try {
            await connection.request().query(sql);

            rowsInserted ++;
        } catch {
            // console.log(`Index ${index} failed`);
        }

        
        if (index % 10000 === 0) {
            console.log(`${index} [${rowsInserted}]`);
        }

    }
})();
