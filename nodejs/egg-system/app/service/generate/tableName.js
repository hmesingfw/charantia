'use strict';

const Service = require('egg').Service;

class TableName extends Service {
    async getAllTableName() {
        const body = this.app.model.query('SELECT table_name,table_comment,table_rows,create_time,update_time FROM information_schema.tables WHERE table_schema="charantia_sys"', {
            type: 'SELECT',
        });
        return body;
    }

    async getTableFiled(tableName) {
        const body = this.app.model.query('SHOW FULL COLUMNS FROM ' + tableName, {
            type: this.app.Sequelize.QueryTypes.SELECT,
            fieldMap: {
                Field: 'field',
                Type: 'type',
                Collation: 'collation',
                Null: 'null',
                Key: 'key',
                Default: 'default',
                Extra: 'extra',
                Privileges: 'privileges',
                Comment: 'comment',
            },
        });
        return body;
    }
}

module.exports = TableName;
