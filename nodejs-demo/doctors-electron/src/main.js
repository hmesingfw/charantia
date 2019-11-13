const { app, BrowserWindow, Menu, electron } = require('electron')
function createWindow() {
    // 创建浏览器窗口
    let win = new BrowserWindow({
        width: 1920,
        height: 1080,
        fullscreen:true,				// true全屏
        webPreferences: {
            nodeIntegration: true,				//是否集成Node，默认为false。
            // preload: path.join(__dirname, '/public/renderer.js'),   // 但预加载的 js 文件内仍可以使用 Nodejs 的 API
        }
    })
    Menu.setApplicationMenu(null);          // 隐藏菜单栏
    // let win = new BrowserWindow({ show: false });       // 最大化
    // let win = new BrowserWindow({fullscreen: true});   // 全屏

    // win.webContents.openDevTools();  //开启调试工具
    win.maximize()
    win.show()
    // 加载index.html文件
    win.loadURL(`file://${__dirname}/dist/index.html`);//在窗口内要展示的内容index.html 就是打包生成的index.html

    // setTimeout(function(){

    // win.close();
    // },3000)

    const ipc = require('electron').ipcMain
	ipc.on('close', e => win.close());
}

app.on('ready', createWindow)