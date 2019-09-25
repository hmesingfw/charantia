const Sequelize = require('sequelize');
exports.sequelize = function () {
    return new Sequelize('generate_table', 'root', 'woxihuanni', {
        'dialect': 'mysql', // 数据库使用mysql
        'host': 'localhost', // 数据库服务器ip
        'port': 3306, // 数据库运行端口
        'timestamp': true, // 这个参数为true是MySQL会自动给每条数据添加createdAt和updateAt字段
        'quoteIdentifiers': true
    });
};