function toColumns(line) {
    const values = [];

    let insideQuotes = false;

    let temp = '';

    for (const char of line) {
        if (char === ',' && !insideQuotes) {
            values.push(temp.replace(/'/g, '\'\''));
            
            temp = '';

            continue;
        }

        if (char === '"') {
            if (!insideQuotes) {
                insideQuotes = true;

                continue;
            }

            if (insideQuotes) {
                insideQuotes = false;

                continue;
            }
        } 

        temp += char;
    }

    values.push(temp.replace(/'/g, '\'\''));

    return values;
}

function toSQLValue(value) {
    return value ? `'${value}'` : null;
}

module.exports = {
    toColumns,
    toSQLValue,
};
