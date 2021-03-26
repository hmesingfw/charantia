/* 
*
*   抖音极速版 
**/

// 开启日志
console.show();
app.launch('com.ss.android.ugc.live');


var height = device.height;
var width = device.width;
setScreenMetrics(width, height);                    // 设置脚本坐标点击所适合的屏幕宽高


for (let i = 0; i < 10; i++) {
    swipe(465, 789, 466, 363, 300)
    console.log('count: i', i);
    sleep(random(5000, 10000))
}