const {app, BrowserWindow} = require('electron')
const path = require('path')
const url = require('url')

function createWindow () {
  // Create the browser window.
	overlay = app.commandLine.getSwitchValue("overlay");
  // and load the index.html of the app.
	webPreferences =
	{
		minimumFontSize: 16,
		defaultFontSize: 16,
		defaultMonospaceFontSize: 18
	}
	if (overlay == 'kagerou'){
		win = new BrowserWindow({width: 400, height: 450, frame: false, transparent: true, webPreferences: webPreferences})
		win.loadURL('https://hibiyasleep.github.io/kagerou/overlay/?HOST_PORT=ws://127.0.0.1:10501/')
	}else if (overlay == 'cactbot'){
		win = new BrowserWindow({width: 400, height: 700, frame: false,transparent: true})
		win.loadURL('https://hibiyasleep.github.io/kagerou/overlay/?HOST_PORT=ws://127.0.0.1:10501/')
	}else if (overlay == 'counter'){
		win = new BrowserWindow({width: 300, height: 300, frame: false,transparent: true})
		win.loadURL('http://localhost:8080?OVERLAY_WS=ws://127.0.0.1:10501/ws')
	} else {
		console.log('Unsupported overlay. Use --overlay kagerou or --overlay cactbot')
		app.exit(1)
	}

}

app.on('ready', createWindow)
