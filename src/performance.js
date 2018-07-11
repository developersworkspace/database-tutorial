const sql = require('mssql');

(async () => {

    const connection = await sql.connect({
        database: 'DatabaseTutorial',
        options: {
            encrypt: false,
        },
        password: 'password',
        server: 'localhost\\SQLEXPRESS',
        user: 'database-tutorial',
    });
    
    const schemaTests = [
        {
            name: 'Schema-1',
            queries: [
                {
                    name: 'Find By Complaint Id',
                    sql: `SELECT * FROM [schema-1].[Complaints] WHERE [ComplaintId] = 377782;`
                },
                {
                    name: 'Find By Product, Sub-Product, Issue and ConsumerDisputed',
                    sql: `SELECT * FROM [schema-1].[Complaints] WHERE [Product] = 'Mortgage' AND [SubProduct] = 'Other mortgage' AND [Issue] = 'Other' AND [ConsumerDisputed] = 'No';`
                },
            ],
        },
        {
            name: 'Schema-2',
            queries: [
                {
                    name: 'Find By Complaint Id',
                    sql: `SELECT * FROM [schema-2].[Complaints] WHERE [ComplaintId] = 377782;`
                },
                {
                    name: 'Find By Product, Sub-Product, Issue and ConsumerDisputed',
                    sql: `SELECT * FROM [schema-2].[Complaints] WHERE [Product] = 'Mortgage' AND [SubProduct] = 'Other mortgage' AND [Issue] = 'Other' AND [ConsumerDisputed] = 'No';`
                },
            ],
        },
        {
            name: 'Schema-3',
            queries: [
                {
                    name: 'Find By Complaint Id',
                    sql: `SELECT * FROM [schema-3].[Complaints] WHERE [ComplaintId] = 377782;`
                },
                {
                    name: 'Find By Product, Sub-Product, Issue and ConsumerDisputed',
                    sql: `SELECT * FROM [schema-3].[Complaints] WHERE [ProductId] = 53 AND [SubProductId] = 61 AND [IssueId] = 53 AND [ConsumerDisputed] = 0;`
                },
            ],
        },
        {
            name: 'Schema-4',
            queries: [
                {
                    name: 'Find By Complaint Id',
                    sql: `SELECT * FROM [schema-4].[Complaints] WHERE [ComplaintId] = 377782;`
                },
                {
                    name: 'Find By Product, Sub-Product, Issue and ConsumerDisputed',
                    sql: `SELECT * FROM [schema-4].[Complaints] WHERE [ProductId] = 53 AND [SubProductId] = 61 AND [IssueId] = 53 AND [ConsumerDisputed] = 0;`
                },
            ],
        },
    ];

    const executionCount = 200;

    for (const schemaTest of schemaTests) {
        console.log(`${schemaTest.name}`);

        for (const query of schemaTest.queries) {
            console.log(`    ${query.name}`);

            const startTimestamp = new Date();
            for (let count = 0; count < executionCount; count ++) {
                const result = await connection.request().query(query.sql);
            }
            const endTimestamp = new Date();

            const timeTaken = endTimestamp.getTime() - startTimestamp.getTime();

            console.log(`        Took ${timeTaken} ms`);
            console.log(`        ${executionCount / (timeTaken / 1000)} Requests per Second`);
        }
    }

    connection.close();

})();