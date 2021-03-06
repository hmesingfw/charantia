module.exports = {
    extends: 'eslint-config-egg',
    rules: {
        indent: ['error',
            4
        ], // 两个tab
        'space-before-function-paren': [
            'error',
            {
                anonymous: 'ignore',
                named: 'ignore',
                asyncArrow: 'ignore',
            },
        ], // 要求或禁止函数圆括号之前有一个空格  https://eslint.bootcss.com/docs/rules/space-before-function-paren/
        'array-bracket-spacing': 'off', // 强制数组方括号中使用一致的空格
        "prefer-const": [
            "error",
            {
                "destructuring": "all",
                "ignoreReadBeforeAssign": true
            }
        ]
    }
};