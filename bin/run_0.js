var Mr = Mr || {};
Mr.readFile =
function Mr_readFile
(	foString
)
{	var fActiveXObject;
	var bFile;
	var bString;
	
	if (foString.indexOf(":") < 0)		// if filename is a relative path
	{	foString = WScript.ScriptFullName.slice(0, -WScript.ScriptName.length) +
			foString;					// append path
	}
	fActiveXObject = new ActiveXObject("Scripting.FileSystemObject");
	try
	{	bFile = fActiveXObject.OpenTextFile(foString ,1);
	}
	catch (e)
	{	WScript.Echo("File "+foString+" was not found");
		WScript.Quit();
	}
	bString = bFile.ReadAll();
	return bString;
};
eval(Mr.readFile("mr\\js_script_lib.js",true));

var aShell;
var bExec;
/*
var Mr;
Mr = Mr || {};
Mr.argvFunction = WScript.Arguments;
Mr.argc = Mr.argvFunction.length;
Mr.argvString = "";
for (var k = 0; k < Mr.argc; ++k)
{	Mr.argvString += Mr.argvFunction(k)+" ";
}
// ugly hack to convert ' to "
Mr.argvString = Mr.argvString.replace(/''/g,"4915345876");
Mr.argvString = Mr.argvString.replace(/'/g,'"');
Mr.argvString = Mr.argvString.replace(/4915345876/g,"'");
*/
var bAString;
var bString;
var cString;
var bRx;
var k;
var e;
var r;

aShell = WScript.CreateObject("WScript.Shell");
bString = Mr.argwString;
switch (bString.substring(0, 7))
{
case '--hide ':
case '--mini ':
	switch (bString.substring(0, 7))
	{
	case '--hide ':
		r = 0;
		break;
	case '--mini ':
		r = 7;
		break;
	}
	bString = bString.substring(7);
	Mr.argwString = bString.trim();
	break;
default:
	r = 8;
	break;
}
/*								change current directory, false good idea
e = bString.length;
if (bString.slice(0, 1) == '"')
{	k = bString.indexOf('"', 1);
	if (k < 0)
	{	cString = "";
	}
	else
	{	cString = bString.substring(1, k);
	}
}
else
{	bRx = /[\s&><|]/g;
	if (bRx.test(bString))
	{	k = bRx.lastIndex;
	}
	else
	{	k = e;
	}
	cString = bString.substring(0, k);
}
cString = cString.trim();
bAString = cString.split("\\");
if (bAString.length > 1)
{	cString = bAString.pop();
	switch (cString)
	{
	case 'java.exe':
	case 'javaw.exe':
	case 'vim.exe':
	case 'notepad.exe':
	case 'vi.exe':
	case 'textpad.exe':
	case 'notepad.exe':
		break;
	default:
		Mr.echo(cString);
		cString = bAString.join('\\');
		if (!File.exists(cString))
		{	Mr.s("can't find dir: %s\nfor input: %s", cString, Mr.argwString);
			Mr.exit(1);
		}
		cString = File.absPath(cString);
		aShell.CurrentDirectory  = cString;
		break;
	}
}
//Mr.argwString = "Gridmove.exe";
*/
try
{	//Mr.writeFile("c:\\tmp.txt", Mr.argwString + '\n' + r);
	bExec = aShell.Run(Mr.argwString, r, false);
}
catch (e)
{	Mr.echo("The system cannot find the file specified");
	Mr.echo(Mr.argwString);
}
