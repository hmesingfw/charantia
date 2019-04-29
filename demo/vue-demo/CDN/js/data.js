function getDataList(){
    var Random = Mock.Random;
    var data = Mock.mock({
        'tableData|8': [{
            'id|+1': Random.natural(10000, 99999),
            'name|1': '@FIRST', //随便名字
            'sex|1': ['1', '2'],
            'hobby|1': ['篮球', '足球', '乒乓球', '羽毛球', '冰球'],
            'address|1': ['上海市普陀区金沙江路 1518', '上海市普陀区金沙江路 1519', '上海市普陀区金沙江路 1520',
                '上海市普陀区金沙江路 1521'
            ], //随机一个
        }]
    })

    return data;
}

