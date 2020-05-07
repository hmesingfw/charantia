var a = {}
Object.defineProperty(a, "b", {
    set: function (val) {
        console.log("赋值时候调用我,我的新值是" + val)
    },
    get: function () {
        console.log("取值的时候调用我")
        return 123
    }
})
a.b = 520          // 赋值时候调用我,我的新值是520
console.log(a.b)  // 取值的时候调用我, 返回我设置123,不是开始设置的520　


