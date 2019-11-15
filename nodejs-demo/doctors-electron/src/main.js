const { app, BrowserWindow, Menu, electron, ipcMain } = require('electron')
const path = require('path')
const fs = require("fs")
function createWindow() {
    // 创建浏览器窗口
    let win = new BrowserWindow({
        width: 1920,
        height: 1080,
        fullscreen:true,				// true全屏
        show:false,						// 先隐藏
        webPreferences: {
            nodeIntegration: true,				//是否集成Node，默认为false。
            // preload: path.join(__dirname, '/public/renderer.js'),   // 但预加载的 js 文件内仍可以使用 Nodejs 的 API
        },
       
    })
    win.on('ready-to-show', function () {
		win.show(); // 初始化后再显示
		// win.webContents.send('main-url', 'http://192.168.31.135:8081');
		// ipcMain.sender.send('main-url', 'http://192.168.31.135:8081')
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
    var url = 'http://192.168.31.135:8080'
    if (fs.existsSync(process.cwd() + '/config.txt')) {
		url = fs.readFileSync(process.cwd() + '/config.txt');
	}

	var time = 1000 * 60 * 5;
	if (fs.existsSync(process.cwd() + '/time.txt')) {
		time = fs.readFileSync(process.cwd() + '/time.txt');
	}
    
	ipcMain.on('close', e => win.close());
	ipcMain.on('asynchronous-message', (event, arg) => {
  		console.log(arg)  // prints "ping"
	 	// event.sender.send('asynchronous-reply', 'http://192.168.31.135:8081');				// 异步
	 	event.returnValue = url;				// 同步
	});	
	ipcMain.on('asynchronous-time', (event, arg) => {
  		console.log(arg)  // prints "ping"
	 	// event.sender.send('asynchronous-reply', 'http://192.168.31.135:8081');				// 异步
	 	event.returnValue = time;				// 同步
	});	

}

app.on('ready', createWindow)