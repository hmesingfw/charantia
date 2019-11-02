const { app, BrowserWindow, Menu } = require('electron')

function createWindow() {
    // 创建浏览器窗口
    // let win = new BrowserWindow({
    //     width: 800,
    //     height: 600,
    //     webPreferences: {
    //         nodeIntegration: true
    //     }
    // })
    Menu.setApplicationMenu(null);          // 隐藏菜单栏
    // let win = new BrowserWindow({ show: false });       // 最大化
    let win = new BrowserWindow({fullscreen: true});   // 全屏

    // win.webContents.openDevTools();  //开启调试工具
    win.maximize()
    win.show()
    // 加载index.html文件
    // win.loadFile('dist/index.html')
    win.loadURL(`file://${__dirname}/dist/index.html`);//在窗口内要展示的内容index.html 就是打包生成的index.html
}

app.on('ready', createWindow)