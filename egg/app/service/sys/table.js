'use strict';

const Service = require('egg').Service;

class TableService extends Service {
    async getAllTableName() {
        const body = this.app.model.query('SELECT table_name FROM information_schema.tables WHERE table_schema="charantia"', {
            type: 'SELECT'
        });
        return body;
    }

    async getTableFiled(tableName) {
        const body = this.app.model.query('SHOW FULL COLUMNS FROM ' + tableName, {
            type: 'SELECT'
        });
        return body;
    }
}

module.exports = TableService;
