OPERATION documents
http://optimiso/data/procedures/p-ops-02-d2p2.html

SIC specs
I:\CS\Core Banking Solutions\SIC euroSIC\English_2009_siceurosic_user_manual.pdf
 MT A10 page 276
 MT A11 page 283

SWIFT specs
i:\CS\Core Banking Solutions\Requests & Problems\CLOSED\2010-00214_SWF_SIC_2010\SWIFT\fsrg2010.zip

doc sungard/apsys
I:\CS\Core Banking Solutions\APSYS\Steform\Docs_Sungard_et_Sterci


[ ] meeting Tuesday 20th March
	[ ] Match persons
		[ ] if name 100% match, do we care about addresses
		[ ] reconfirm that in case of joint accounts, any individual can deposit
		[ ] demo how it is currently being done in Mt4

[ ] questions:
	[ ] check deposit is the first for a particular client
		[ ] should we count a reversed deposit as one payment or none


"I:\CS\Core Banking Solutions\Steform Active\Steform_4.3\TEST\Steform-RulesEditor\Steform-RulesEditor.jnlp"
Customer
customer
load c:\tmp\a\mr1.graphml
Run
debug mode

withdrawal:
	initiation process: what if process changes and it is not Ops who initiates it but Sales (ie, sales doesn't have apsys)

java.io.OutputStream oOutputStream = null;
java.io.InputStream iInputStream = null;
java.net.Socket bSocket = null;
StringBuilder	bStringBuilder;
String	mString = null;
String	bString;
String	cString;
byte[]	bA_byte;
int		r;
int		e;
int		z;
while_label:
while (true)
{
bString = null;
if (msg != null)
{	bString = msg.getData("INTERPRETED");
}
if (bString == null)
{	bString = "null";
}
bStringBuilder = new StringBuilder();
bStringBuilder.append(new java.util.Date());
bStringBuilder.append("\n");
bStringBuilder.append("<Tw:root><interpreted>");
bA_byte = new byte[2048];
{
	final char[] CA = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".toCharArray();
	final byte[] sArr = bString.getBytes("UTF-8");
	int sLen = sArr.length;
	int eLen = (sLen / 3) * 3;                              // Length of even 24-bits.
	int dLen = ((sLen - 1) / 3 + 1) << 2;                   // Returned character count
	byte[] dArr = new byte[dLen];
	for (int s = 0, d = 0, cc = 0; s < eLen;) {
		int i = (sArr[s++] & 0xff) << 16 | (sArr[s++] & 0xff) << 8 | (sArr[s++] & 0xff);
		// Encode the int into four chars
		dArr[d++] = (byte) CA[(i >>> 18) & 0x3f];
		dArr[d++] = (byte) CA[(i >>> 12) & 0x3f];
		dArr[d++] = (byte) CA[(i >>> 6) & 0x3f];
		dArr[d++] = (byte) CA[i & 0x3f];
	}
	int left = sLen - eLen; // 0 - 2.
	if (left > 0) {
		int i = ((sArr[eLen] & 0xff) << 10) | (left == 2 ? ((sArr[sLen - 1] & 0xff) << 2) : 0);
		// Set last four chars
		dArr[dLen - 4] = (byte) CA[i >> 12];
		dArr[dLen - 3] = (byte) CA[(i >>> 6) & 0x3f];
		dArr[dLen - 2] = left == 2 ? (byte) CA[i & 0x3f] : (byte) '=';
		dArr[dLen - 1] = '=';
	}
	
	bString = new String(dArr);
}
bStringBuilder.append("</interpreted></Tw:root>");
try
{
bSocket = new java.net.Socket("127.0.0.1", 23456);
oOutputStream = new java.io.BufferedOutputStream(bSocket.getOutputStream());	
iInputStream = new java.io.BufferedInputStream(bSocket.getInputStream());	
cString = Integer.toString(bString.length());
while (cString.length() < 8)
{	cString = "0" + cString;
}
oOutputStream.write(cString.getBytes());
oOutputStream.write(bString.getBytes("UTF-8"));
oOutputStream.flush();
e = 0;
z = 8;
while (e < z)
{	r = iInputStream.read(bA_byte, e, z - e);
	if (r < 0)
	{	mString = "ERROR socket 0";
		break while_label;
	}
	e += r;
}
z += Integer.parseInt(new String(bA_byte, 0, 8));
while (e < z)
{	r = iInputStream.read(bA_byte, e, z - e);
	if (r < 0)
	{	mString = "ERROR socket 1";
		break while_label;
	}
	e += r;
}
bString = new String(bA_byte, 8, z);
if (msg != null)
{	msg.setData("MRANSWER", bString);
}
}
catch (Exception eException)
{	mString = "ERROR " + eException.getMessage();
	throw new RuntimeException(eException);
}
finally
{	
	try{oOutputStream.close();}catch(Exception zz){}
	try{iInputStream.close();}catch(Exception zy){}
	try{bSocket.close();}catch(Exception xz){}
}
break while_label;
}
System.out.println("end of while_label");
	
dbtest enable messagerie swift, see ~/.profile and look for . ~/set_emi_vars
 exit
 su - dbtest
 stopdisp
 ps -ef | grep dbtest | grep -v -i ora
 start_dsp.csh
#install_steform.sh

sic eurosic field specs specifications
	page 239 english_2009_siceurosic_user_manual.pdf



select * from apsys.tdsmee where dtcptl = 20120402 and fiches = '003958'; -- viewable in meemon(Monitor of incoming messages)
select * from apsys.tdsmpm where dtcptl = 20120402 and fiches = '003955'; -- viewable in mpbmon(Monitor of Payment messages - Back Office), mpm_L001 (List o payment messages), 
select * from apsys.tdstrc where dtcptl = 20120402 and fiches = '574664'; -- viewable in tdsmon(Monitor: TDS detail)

Reloader les custom rules steform (a condition que les fichiers soient dans $APSYS_DEV/steform/Custom/Rules/suitcheck/)
 Adm_Menu
  3 Steform
  8

tblee sens direction paire currency TABTRN -> DEE
cdsmaf table spreads MAFTRN
keystore:
 keytool -genkey -alias tw0 -keystore tw0.jks -validity 50000
