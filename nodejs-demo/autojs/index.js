// toast('hello')
console.show()                                      //      启动日志
app.launch("com.xiaomi.youpin");                    //   启动app 应用
console.log(currentActivity());                     //  查看页面的activity
//  com.xiaomi.youpin.activity.YouPinMainTabActivty



var height = device.height;
var width = device.width;
setScreenMetrics(width, height);                    // 设置脚本坐标点击所适合的屏幕宽高


// waitForActivity('com.xiaomi.youpin.activity.YouPinMainTabActivity');     //  等待指定的Activity出现，period为检查Activity的间隔。
// className("android.widget.RelativeLayout").text("我的").findOne().click()

sleep(1000)
var w = text("我的").className("android.widget.TextView").findOne();
var b = w.bounds();
if (w == null) {
    log("null");
}
if (click(b.centerX(), b.centerY())) {
    log("点击成功");

} else {
    log("点击失败");
}

sleep(3000)

if (id('rl_sign_in').exists()) {
    id('rl_sign_in').findOne().click();
    console.log('签到完成');
} else {
    console.log('签到失败');
}
