var ROOT_DOMAIN  = "http://hoho.co.kr";
var TING_LootFolder  = "/ting/";
var LoadingHtml = "<img src='"+TING_LootFolder+"img/icon_loding.gif' align='absmiddle'> <span class='txt'> Loading...</span><br> ������ �ε����Դϴ�.";
// �޴������� �˾�(�� �̸�)
function win_pupSubmit(UserIdx){
	var domain = ROOT_DOMAIN + "/CheckPlus_asp/checkplus_main.asp";
	var checkplus = document.getElementById("checkplus");
	var Hphone0 = document.getElementById("Hphone0");
	var Hphone1 = document.getElementById("Hphone1");
	var Hphone2 = document.getElementById("Hphone2");
	var Hphone3 = document.getElementById("Hphone3");
	var UserJumin1 = document.getElementById("UserJumin1");
	var UserJumin2 = document.getElementById("UserJumin2");
	var UserName = document.getElementById("UserName");
	var UserHphone0 = document.getElementById("UserHphone0");
	var UserHphone1 = document.getElementById("UserHphone1");
	var UserHphone2 = document.getElementById("UserHphone2");
	var UserHphone3 = document.getElementById("UserHphone3");
	UserHphone0.value = Hphone0.value;
	UserHphone1.value = Hphone1.value;
	UserHphone2.value = Hphone2.value;
	UserHphone3.value = Hphone3.value;
	var REQ_SEQ = document.getElementById("REQ_SEQ");
	var RES_SEQ = document.getElementById("RES_SEQ");
	var mobile_no = document.getElementById("mobile_no");
	var mobile_co = document.getElementById("mobile_co");
	if(UserHphone0 && UserHphone1 && UserHphone2 && UserHphone3 && REQ_SEQ && RES_SEQ && mobile_no && mobile_co){
		if(REQ_SEQ.value != "" && RES_SEQ.value != "" && UserHphone0.value == mobile_co.value && (UserHphone1.value+UserHphone2.value+UserHphone3.value) == mobile_no.value){
			alert("�̹� ������ �޴��� ��ȣ �Դϴ�.");
		}else{
			if(!UserHphone0.value){
				alert("��Ż縦 �������ּ���!");
			}else if(!UserHphone1.value || !UserHphone2.value || !UserHphone3.value){
				alert("�ڵ��� ��ȣ�� �Է����ּ���!");
			}else{
				window.open(domain + "?UserIdx="+UserIdx+"&UserJumin1="+UserJumin1.value+"&UserJumin2="+UserJumin2.value+"&UserName="+UserName.value+"&UserHphone0="+UserHphone0.value+"&UserHphone1="+UserHphone1.value+"&UserHphone2="+UserHphone2.value+"&UserHphone3="+UserHphone3.value,"","width=425,height=535,scrollbars=no")
			}
		}
	}else{
		alert("ERR : [�����ڿ��� �����ϼ���.]");
	}
}
var hpAuth_no = "";
var random_no = [1,2,3,4,5,6,7,8,9,0];
// �޴������� �˾�(�� �̸�)
function hpAuth(){
	var Hphone0 = document.getElementById("Hphone0");
	var Hphone1 = document.getElementById("Hphone1");
	var Hphone2 = document.getElementById("Hphone2");
	var Hphone3 = document.getElementById("Hphone3");

	var REQ_SEQ = document.getElementById("REQ_SEQ");
	var RES_SEQ = document.getElementById("RES_SEQ");
	var mobile_no = document.getElementById("mobile_no");
	var mobile_co = document.getElementById("mobile_co");

	var SendSMS = document.getElementById("SendSMS");
	var Hphone = Hphone1.value +"-"+ Hphone2.value +"-"+ Hphone3.value;

	if(Hphone0.value == ""){
		alert("��Ż縦 �������ּ���!");
		return false;
	}
	if(Hphone1.value == "" || Hphone2.value == "" || Hphone3.value == ""){
		alert("�ڵ��� ��ȣ�� �Է����ּ���!");
		return false;
	}	
	if(REQ_SEQ.value && RES_SEQ.value && Hphone0.value == mobile_co.value && (Hphone1.value+Hphone2.value+Hphone3.value) == mobile_no.value){
		alert("�̹� ������ �޴��� ��ȣ �Դϴ�.");
		return false;
	}
	hpAuth_no = "";
	for(i=0; i < 4; i++){
		hpAuth_no += randomItem(random_no);
	}

	SendSMS.src="../inc/hpAuth.asp?action=go&Hphone="+Hphone+"&Auth_no="+hpAuth_no;

	var HPAuthPopupHTML = "" +
	"<div style='margin:10px;float:left;border-bottom:1px solid #eeeeee'>" +
		"<div style='float:right;margin-bottom:10px;'><a href='javascript:void(0)' onclick=\"fncClickClose('wall','POPUP',1,1);RemoveDiv('','POPUP')\"><img src='/ting/img/service/icon_close.gif'></a></div>" +
	"</div>" +
	"<div style='margin:10px 35px 10px 35px;clear:both;line-height:170%'>" +
		"������ �޴��� SMS�� �߼۵� ������ȣ <b>4�ڸ�</b>�� ��Ȯ��<br>�Է����ֽñ� �ٶ��ϴ�." +
		"<br><br><b>������ȣ</b>&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' class='input' style='width:170px' id='C_hpAuth' name='C_hpAuth' maxlength=4>" +
		"<div style='margin-top:10px;margin-bottom:30px;text-align:center;'><a href='javascript:void(0)' onclick='hpAuth_check()'><img src='/ting/img/Auth/pop_ok.gif'></a></div>" +
	"</div>" ;
	CreateDiv("","POPUP","HPAuthPopup","none",HPAuthPopupHTML);
	fncClick("wall","POPUP", 2 , 3 ,400 , 500);
}
function hpAuth_check(){
	var Hphone0 = document.getElementById("Hphone0");
	var Hphone1 = document.getElementById("Hphone1");
	var Hphone2 = document.getElementById("Hphone2");
	var Hphone3 = document.getElementById("Hphone3");

	var REQ_SEQ = document.getElementById("REQ_SEQ");
	var RES_SEQ = document.getElementById("RES_SEQ");
	var mobile_no = document.getElementById("mobile_no");
	var mobile_co = document.getElementById("mobile_co");

	var C_hpAuth = document.getElementById("C_hpAuth");

	var AuthSuccessArea = document.getElementById("AuthSuccessArea");//�޴������� ������

	if(C_hpAuth.value == hpAuth_no){
		REQ_SEQ.value = "hoho_sms_check";
		RES_SEQ.value = "hoho_sms_check";
		mobile_no.value = Hphone1.value + Hphone2.value + Hphone3.value;
		mobile_co.value = Hphone0.value;
		alert("������ �Ϸ�Ǿ����ϴ�.");
		fncClickClose('wall','POPUP',1,1);
		RemoveDiv('','POPUP');

		if(AuthSuccessArea){AuthSuccessArea.innerHTML = "������� : ���������� ������ �Ϸ� �Ǿ����ϴ�. �����ܰ踦 �������ּ���!";}

	}else{
		alert("������ȣ�� ��ġ���� �ʽ��ϴ�. Ȯ�� �� ���Է� ���ּ���.")
	}
}
// �����̱� 1�ڸ�
function randomItem(a) {
  return a[Math.floor(Math.random() * a.length)];
}

//��ũ ����
function bluring(){if(event.srcElement.tagName=="A"||event.srcElement.tagName=="IMG") document.body.focus();}
document.onfocusin=bluring;
//�˾�(��ũ,����,����,��Ÿ��Ÿ��)
function win_pup(domain,name,style){window.open(domain,name,style)}
function openWin(pURL, pWinName, pWidth, pHeight, pToolbar,pMenubar,pLocation,pScrollbars)
{
if (pToolbar==null)	pToolbar = "no"; 
if (pMenubar==null)	pMenubar = "no"; 
if (pLocation==null)	pLocation = "no"; 
if (pScrollbars==null)	pScrollbars = "no"; 
pWidth	= (pWidth<=0)  ? (screen.availWidth -pWidth ) : pWidth;
pHeight	= (pHeight<=0) ? (screen.availHeight-pHeight) : pHeight;
var tLeft  = screen.width /2 - pWidth /2;
var tTop   = screen.height/2 - pHeight/2;
tParam = "toolbar=" + pToolbar + ",menubar=" + pMenubar + ",location=" + pLocation + ",scrollbars=" + pScrollbars + ",status=yes"
		+ ",left=" + tLeft + ",top=" +  tTop + ",width=" + pWidth + ",height=" + pHeight;
var tWin = window.open(pURL, pWinName, tParam );
}
// iframe �ڵ� ������
function resizeHeight(fr_obj,ifr_nm) {
	var ifrm_name = window.frames[0].document.body;
	fr_obj = typeof fr_obj == 'string' ? document.getElementById(fr_obj) : fr_obj;
	fr_obj.style.height = ifrm_name.scrollHeight;
}
// ���� �̺�Ʈ
function captureReturnKey(e) {
 if(e.keyCode==13 && e.srcElement.type != 'textarea'){
	serch_form()
 }
}
// ��üũ
function chk(str){
  var flag = str.checked ? true : false;
  var obj = document.list_form.elements;
  for(var i=0;i<obj.length;i++){
   if(obj[i].name.substr(0,str.name.length) == str.name) {
    obj[i].checked = flag;
	}
  }
}
// �̸��� ��������
function mailChange(obj) {
    var m2 = document.getElementById("UserEmail2");
    var m3 = document.getElementById("UserEmail3");
    var email3
    if( obj.value == "freeWrite" ){
        m2.style.display = "inline";
    }else{
        m2.style.display = "none";
		m2.value=m3.value
    }
}
//��й�ȣ ���� ���� ���� üũ
function CheckPass(str){ 
	var reg1 = /^[a-zA-Z0-9]{5,20}/g;
	var reg2 = /[a-zA-Z]/g; 
	var reg3 = /[0-9]/g; 
	return ( reg1.test(str) && reg2.test(str) && reg3.test(str) ); 
}
//����,Ư������ üũ
function CheckSpace(str) {
   var reg1 = /[\s~!|@\#$%^&*\()\-=+\\/\[\]?<>,."']/gi;
   return (reg1.test(str)); 
}

//�̸� Ư������ ���� ���� ����
function CheckSpaceName(str) {
   var reg1 = /[\s~!|@\#$%^&*\(){}`;:\-_=+\\/\[\]?<>,."'0-9a-zA-Z]/gi;
   return (reg1.test(str)); 
}
//�̸� Ư������ ���� ���� ���� üũ
function CheckSpaceName_alert(str){
  var strobj = str; //�Է°��� ��������.
  var re = /[\s~!|@\#$%^&*\(){}`;:\-_=+\\/\[\]?<>,."'0-9a-zA-Z]/gi;
  if(re.test(strobj.val())){
    alert("Ư�����ڴ� �Է��ϽǼ� �����ϴ�.");
    strobj.val( strobj.val().replace(re,"") );
  }
}

//���̵� Ư������ ���� ���� ����
function CheckSpaceId(str) {
   var reg1 = /[\s~!|@\#$%^&*\(){}`;:\-=+\\/\[\]?<>,."'��-��|��-��|��-�R]/gi;
   return (reg1.test(str)); 
}
//���̵� Ư������ ���� ���� ���� üũ
function CheckSpaceId_alert(str){
  var strobj = str; //�Է°��� ��������.
  var re = /[\s~!|@\#$%^&*\(){}`;:\-=+\\/\[\]?<>,."'��-��|��-��|��-�R]/gi;
  if(re.test(strobj.val())){
    alert("Ư�����ڴ� �Է��ϽǼ� �����ϴ�.");
    strobj.val( strobj.val().replace(re,"") );
  }
}


//����,Ư������ üũ
function inputCheckSpecial(str){
  var strobj = str; //�Է°��� ��������.
  re = /[\s~!|@\#$%^&*\()\-=+_\\/\[\]?<>,."']/gi;
  if(re.test(strobj.value)){
    alert("Ư�����ڴ� �Է��ϽǼ� �����ϴ�.");
    strobj.value=strobj.value.replace(re,"");
  }
}
//����,Ư������ üũ(���� ȸ������ _ ���� )
function inputCheckSpecial_(str){
  var strobj = str; //�Է°��� ��������.
  re = /[\s~!|@\#$%^&*\(){}`;:\-=+\\/\[\]?<>,."']/gi;
  if(re.test(strobj.value)){
    alert("Ư�����ڴ� �Է��ϽǼ� �����ϴ�.");
    strobj.value=strobj.value.replace(re,"");
  }
}
//Ư������ üũ
function CheckSpace2(str) {
   var reg1 = /[~!|@\#$%^&*\()\-=+_\\/\[\]?<>,."']/gi;
   return (reg1.test(str)); 
}
//Ư������ üũ
function inputCheckSpecial2(str){
  var strobj = str; //�Է°��� ��������.
  re = /[\s~!|@\#$%^&*\(){}`;:\-_=+\\/\[\]?<>,."']/gi;
  if(re.test(strobj.value)){
    alert("Ư�����ڴ� �Է��ϽǼ� �����ϴ�.");
    strobj.value=strobj.value.replace(re,"");
  }
}
//����Ű�� �Է� �����ϰ�..
function onlyNumber(e){
	var obj = e.srcElement||e.target;
	var key = e.keyCode;
	if((key < 48 || key > 57) && (key < 96 || key > 105) &&(key != 8 ) &&(key != 9 )) {
		obj.blur(); 
		setTimeout(function() { //����� ������ ������ ��( ����� ����� ǥ���� ��Ű�� ����)
		 obj.focus();
		}, 30); //ũ�� ������ ��ġ�� �����Ͽ����ϴ�.( ���ŷ�� �ȵǴ� ��Ȳ�� ũ���� ����ġ�� �����ϳ׿� ) 
	}
}
//���� ǥ������ ����Ͽ� ȭ��Ʈ�����̽��� ���ڷ� ��ȯ
function trim(str){ 		
	str = str.replace(/^\s*/,'').replace(/\s*$/, '');
	return str; //��ȯ�� ��Ʈ���� ����.
}
//�ѱ۸� �Է�
function onlyChar(e){
	var obj = e.srcElement||e.target;
	var key = e.keyCode;
	if( (key >= 32) && (key <= 126) ) {
		obj.blur(); 
		setTimeout(function() { //����� ������ ������ ��( ����� ����� ǥ���� ��Ű�� ����)
		 obj.focus();
		}, 30); //ũ�� ������ ��ġ�� �����Ͽ����ϴ�.( ���ŷ�� �ȵǴ� ��Ȳ�� ũ���� ����ġ�� �����ϳ׿� ) 
	}
 }
//-------------------------------------------------------
// �ֹι�ȣ check Main Function.
//-------------------------------------------------------
function id_no_chk(obj1,obj2){
    // CheckSum üũ
    if (chksumID(obj1,obj2) == false)
        return false;
    strReg1 = obj1.value;
    strReg2 = obj2.value;
    sGender = strReg2.substring(0,1);
    sYear = strReg1.substring(0,2);
    // �ι�° �ܶ� ù��° ���ڴ� 4���� Ŭ �� ����.
    if (sGender > 4) {
        return false;
    }
    // 2000�⵵ ������ ���ڴ� 1, ���ڴ� 2
    // 2000�⵵ ���Ĵ� ���ڴ� 3, ���ڴ� 4
    if (sYear != '00') {
        if ((sGender != '1') && (sGender != '2')) {
            return false;
        }
    } else {
        if ((sGender != '3') && (sGender != '4')) {
            return false;
        }
    }
    // ������� ����� �ƴѰ� ������� üũ
    if (ValidregNo(obj1) == false)
        return false; 
	return true;
}
//-------------------------------------------------------
// �ܱ��ε�Ϲ�ȣ check Main Function.
//-------------------------------------------------------
function id_no_chk2(obj1,obj2){
    // CheckSum üũ
    if (chksumID(obj1,obj2) == false)
        return false;
    strReg1 = obj1.value;
    strReg2 = obj2.value;
    sGender = strReg2.substring(0,1);
    sYear = strReg1.substring(0,2);
    // 2000�⵵ ������ ���ڴ� 5, ���ڴ� 6
    // 2000�⵵ ���Ĵ� ���ڴ� 7, ���ڴ� 8
    if (sYear != '00') {
        if ((sGender != '5') && (sGender != '6')) {
            return false;
        }
    } else {
        if ((sGender != '7') && (sGender != '8')) {
            return false;
        }
    }
    // ������� ����� �ƴѰ� ������� üũ
    if (ValidregNo(obj1) == false)
        return false; 
	return true;
}
//-------------------------------------------------------
// �ֹι�ȣ ���ڸ� check check.
//-------------------------------------------------------
function ValidregNo(obj1){
    strReg1 = obj1.value;
    // YYMMDD�� �´��� Ȯ���Ѵ�.
    a = new String(strReg1);
    if(a == '') return false;
    if(a.length != 6 ) return false;
    intYear = parseInt(a.substring(0,2) , 10);
    intMonth = parseInt(a.substring(2,4) , 10);
    intDay = parseInt(a.substring(4,6) , 10);
    if(intMonth < 0 || intMonth > 12){ 
        return false;
    }
    switch(intMonth){
        case 2 :
            if(intDay < 0 || intDay > 29){
                return false;
                breake;
            }
        case 4 :
            if(intDay < 0 || intDay > 30){
                return false;
                breake;
            }
        case 6 :
            if(intDay < 0 || intDay > 30){
                return false;
                breake;
            }
        case 9 :
            if(intDay < 0 || intDay > 30){
                return false;
                breake;
            }
        case 11 :
            if(intDay < 0 || intDay > 30){
                return false;
                breake;
            }
        default :
            if(intDay < 0 || intDay > 31){
                return false;
                breake;
            }
    }
    return true;
}

//-------------------------------------------------------
// �ֹι�ȣ checksum check.
//-------------------------------------------------------
function chksumID(obj1,obj2){
    //���ڷθ������Ǿ� �ִ��� Test�� ����ǥ��.
	var regExpr = /^[0-9]+$/;
    var str1 = obj1.value;
    var str2 = obj2.value;
    var li_lastid,li_mod,li_minus,li_last;
    var value0,value1,value2,value3,value4,value5,value6;
    var value7,value8,value9,value10,value11,value12;
    if (regExpr.test(str1) &&  regExpr.test(str2)) {
        li_lastid    = parseFloat(str2.substring(6,7));
        value0  = parseFloat(str1.substring(0,1))  * 2;
        value1  = parseFloat(str1.substring(1,2))  * 3;
        value2  = parseFloat(str1.substring(2,3))  * 4;
        value3  = parseFloat(str1.substring(3,4))  * 5;
        value4  = parseFloat(str1.substring(4,5))  * 6;
        value5  = parseFloat(str1.substring(5,6))  * 7;
        value6  = parseFloat(str2.substring(0,1))  * 8;
        value7  = parseFloat(str2.substring(1,2))  * 9;
        value8  = parseFloat(str2.substring(2,3))  * 2;
        value9  = parseFloat(str2.substring(3,4))  * 3;
        value10 = parseFloat(str2.substring(4,5))  * 4;
        value11 = parseFloat(str2.substring(5,6))  * 5;
        value12 = 0;
        value12 = value0+value1+value2+value3+value4+value5+value6+value7+value8+value9+value10+value11+value12 ;
        li_mod = value12 %11;
        li_minus = 11 - li_mod;
        li_last = li_minus % 10;
        if (li_last != li_lastid){
            return false;
        } else
            return true;
    } else
    return false;
}
//-------------------------------------------------------
// �ܱ��ε�Ϲ�ȣ checksum check.
//-------------------------------------------------------
function chksumID2(obj1,obj2) {
	var reg_no = obj1+obj2;
    var sum = 0;
    var odd = 0;
    buf = new Array(13);
    for (i = 0; i < 13; i++) buf[i] = parseInt(reg_no.charAt(i));
    odd = buf[7]*10 + buf[8];
    if (odd%2 != 0) {
      return false;
    }
    if ((buf[11] != 6)&&(buf[11] != 7)&&(buf[11] != 8)&&(buf[11] != 9)) {
      return false;
    }
    multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];
    for (i = 0, sum = 0; i < 12; i++) sum += (buf[i] *= multipliers[i]);
    sum=11-(sum%11);
    if (sum>=10) sum-=10;
    sum += 2;
    if (sum>=10) sum-=10;
    if ( sum != buf[12]) {
        return false;
    }else{
        return true;
    }
}

//-------------------------------------------------------
// ���� , 7�� , 30����
//-------------------------------------------------------
function date_input(Indate,Outdate,value1,value2){
	Indate = document.getElementById(Indate);
	Outdate = document.getElementById(Outdate);
	Indate.value=value1;
	Outdate.value=value2;
}
//-------------------------------------------------------
// DIV �˾��� ����/�ݱ�
//-------------------------------------------------------
function fncShow(WallName , Zindex, num ){
	var scrollheight = document.compatMode == "CSS1Compat" ?
					   document.documentElement.scrollHeight : document.body.scrollHeight;
	var clientHeight = document.compatMode == "CSS1Compat" ?
					   document.documentElement.clientHeight : document.body.clientHeight;
	var objHeight = scrollheight > clientHeight ? scrollheight : clientHeight;
    var obj = document.getElementById(WallName);
    switch( num )
    {
        case 1 :
            obj.style.display   = 'none';
            obj.style.zIndex   = Zindex;
            break;
        case 2 :
			obj.style.height  = objHeight;
            obj.style.display  = '';
            obj.style.zIndex   = Zindex;
            break;
    }
}


function fncClick(wall , pop, wallZindex , popZindex ,w , h ){
    var obj = document.getElementById(pop);
	var winl = (screen.width-w)/2;
	//var wint = (screen.height-h)/2-100;
	//var wint = h;
	var wint = document.body.scrollTop + 100;
	if(!document.getElementById(wall)){
	
	var parent = document.body;
	var wallDiv = document.createElement("div");
		wallDiv.id = wall;
		wallDiv.className = "wall";
		wallDiv.style.display = "none";
		parent.appendChild(wallDiv)
	}
    obj.style.left  = winl;
    obj.style.top  = wint;
    obj.style.display = '';
	obj.style.zIndex = popZindex;
	fncShow(wall , wallZindex , 2 );
}

function fncClick_pop(pop,popZindex,left,top)
{
    var obj = document.getElementById(pop);
    obj.style.left  = left;
    obj.style.top  = top;
    obj.style.display = '';
	obj.style.zIndex = popZindex;
}
function fncClickClose(wall , pop , wallZindex , popZindex)
{
    if(document.getElementById(pop)){
		var obj = document.getElementById(pop);
		obj.style.display = 'none';
		obj.style.zIndex = popZindex;
	}

	if(!document.getElementById(wall)){
	
	var parent = document.body;
	var wallDiv = document.createElement("div");
		wallDiv.id = wall;
		wallDiv.className = "wall";
		wallDiv.style.display = "none";

		parent.appendChild(wallDiv)
	}
	fncShow(wall , wallZindex , 1 );
}
/*===========================================================================
 * Div ��ü�����ϱ�
 *===========================================================================*/
function CreateDiv(parentId,ObjId,className,display,html){
if(!parentId){
	var parent = document.body;
}else{
	var parent = document.getElementById(parentId);
}
var CDiv = document.createElement("div");
	CDiv.id = ObjId;
	CDiv.className = className;
	CDiv.style.display = display;
	CDiv.innerHTML = html

	parent.appendChild(CDiv)
}
function RemoveDiv(parentId,ObjId){
if(!parentId){
	var parent = document.body;
}else{
	var parent = document.getElementById(parentId);
}
var Obj = document.getElementById(ObjId)
	if(Obj){
		parent.removeChild(Obj)
	}
}


/*===========================================================================
 * �����ȣ ã��.
 *===========================================================================*/
function searchZipCode(frm, zip1, zip2, addr1, addr2,strTable) {
	var winstyle;
	var strAppVersion = navigator.appVersion;
	var zipURL = "/common/zip.asp?frm="+frm+"&zip1="+zip1+"&zip2="+zip2+"&addr1="+addr1+"&addr2="+addr2+"&strTable="+strTable;
	var winName = "_ZIPCODE_";
	
	if (strAppVersion.indexOf('MSIE')!=-1 && strAppVersion.substr(strAppVersion.indexOf('MSIE')+5,1) > 4) {
		winstyle = "width=388px, height=310px, scrollbars=yes, center=yes";
		window.open(zipURL, winName, winstyle);
	} else {
		winpos = "left=" + ((window.screen.width-500)/2)+",top=" + ((window.screen.height-350)/2);
		winstyle="width=470,height=310,status=no,toolbar=no,menubar=no," + "location=no, resizable=no,scrollbars=auto,copyhistory=no," + winpos;
		window.open(zipURL, winName, winstyle);
	}
}
/*===========================================================================
 * �����ȣ ����.
 *===========================================================================*/
function setZipCode(frm, zip1, zip2, addr1, addr2, strZip, strAddr) {
	try	{
		if(opener)	{
			var strForm = "opener.document."+frm;
			var obj = eval(strForm+'.'+zip1);
			if(obj.length && obj.length==2)	{
				obj[0].value = strZip.substring(0,3);
				obj[1].value = strZip.substring(4,7);
			}
			else	{
				eval(strForm+'.'+zip1).value = strZip.substring(0,3);
				eval(strForm+'.'+zip2).value = strZip.substring(4,7);
			}
			eval(strForm+'.'+addr1).value = strAddr;
			eval(strForm+'.'+addr2).focus();
		}
	
		window.close();
		
	} catch(ex) {};
}

function zip_popup(){
var parent = document.body;
var ZIPDiv = document.createElement("div");
	ZIPDiv.id = "ZIPPOP";
	ZIPDiv.className = "ZIP_POP";
	parent.appendChild(ZIPDiv);
var ZIPPOP = document.getElementById("ZIPPOP");

	ZIPPOP.innerHTML = "<div style='float:right;padding:10px 20px 10px 0px;'><img src=\""+TING_LootFolder+"img/service/icon_close.gif\" onclick=\"zip_popup_close()\" style=\"cursor:pointer\" align=absmiddle></div>" +
	"<table cellpadding=0 cellspacing=0 border=0 width=400>" +
	"	<tr>" +
	"		<td align=center><img src=\"/common/img/zip_01.jpg\"></td>" +
	"	</tr>" +
	"<tr>" +
	"	<td align=center>" +		
	"		<table cellpadding=0 cellspacing=5 width=370 bgcolor=#eaeaea>" +
	"			<tr>" +
	"				<td style=padding:1 bgcolor=ffffff>" +					
	"					<table cellpadding=0 cellspacing=0 width=100% bgcolor=#eaeaea>" +
	"						<tr><td height=10></td></tr>" +
	"						<tr>" +
	"							<td width=250 align=center><input type=text name=schDong id=schDong class=input5 style=width:225px;ime-mode:active; onkeydown='if(event.keyCode==13)searchZipCodeAJAX();'></td>" +
	"							<td><a href=\"javascript:void(searchZipCodeAJAX())\"><img src=\"/common/img/zip_btn.jpg\" align=absmiddle></a></td>" +
	"						</tr>" +
	"						<tr><td height=10></td></tr>" +
	"					</table>" +
	"				</td>" +
	"			</tr>" +
	"		</table>" +

	"	</td>" +
	"</tr>" +
	"<tr><td height=10></td></tr>" +
	"<tr>" +
	"	<td align=center>" +
	"		<div style='width:370px;margin:0 auto;background-color:#f6f6f6;border-top:1px solid #d9d9d9'>" +
	"			<div class='line06' style='clear:both;float:left;width:61px;line-height:23px;color:#555555'>�����ȣ</div>" +
	"			<div class='line07' style='float:left;width:308px;line-height:23px;'>�ּ�</div>" +
	"		</div>"+
	"		<div style='clear:both;width:370px;margin:0 auto;' id=zipArea></div>" +
	"	</td>" +
	"</tr>" +
	"</table>";

	fncClick("wall","ZIPPOP", 2 , 3 ,470 , 200 );
	var schDong = document.getElementById("schDong");
	schDong.focus();

}
function zip_popup_close(){
	fncClickClose("wall","ZIPPOP",1,1)
	RemoveDiv("","ZIPPOP")
}
/*===========================================================================
 * �����ȣ ã��.AJAX
 *===========================================================================*/
function searchZipCodeAJAX() {
	var schDong = document.getElementById("schDong");
	var params = "schDong="+encodeURIComponent(schDong.value);
	new ajax.xhr.Request("/common/zip_rss.asp",params,setZipCodeAJAX,"GET")
}
/*===========================================================================
 * �����ȣ ����.AJAX
 *===========================================================================*/
function setZipCodeAJAX(req) {
var zipArea = document.getElementById("zipArea");
	CreateDiv("","LoadingDiv","","none",LoadingHtml)
	if(req.readyState == 4){
		if(req.status == 200){
			fncClickClose("wallzip","LoadingDiv",1,1)
			RemoveDiv("","LoadingDiv")
			var xmlDoc = req.responseXML;
			var code = xmlDoc.getElementsByTagName('code').item(0).firstChild.nodeValue;
			if(code == 'success'){
				var ListData = eval("("+xmlDoc.getElementsByTagName('data').item(0).firstChild.nodeValue+")");
				for(var i = 0 ; i < ListData.length; i++){
					var ZIPDiv = ZIPListView(ListData[i]);
					zipArea.appendChild(ZIPDiv);
				}
			}else if(code == "error"){
				alert('���� : ' + req.responseText);
			}
		}else{
			alert('���� : ' + req.responseText);
		}
	}else{
		fncClick("wallzip","LoadingDiv", 3 , 4 ,300 , 200 )
		zipArea.innerHTML = "";
	}
}
function ZIPListView(common){
	var date_div = document.createElement("div");
	date_div.innerHTML = "<table cellpadding=0 cellspacing=0 height=23><tr align=center>" +
						"<td class=line06 width=61><a href=\"javascript:void(setZipAJAX('"+common.zip+"','"+common.addr1 +" "+ common.addr2+"'))\">"+common.zip+"</a></td>" +
						"<td class=line07 width=308><a href=\"javascript:void(setZipAJAX('"+common.zip+"','"+common.addr1 +" "+ common.addr2+"'))\">"+common.addr1 +" "+ common.addr2+"</a></td>" +
						"</tr></table>";

	return date_div;
}

function setZipAJAX(strZip, strAddr) {
var UserZipcode1 = document.getElementById("UserZipcode1");
var UserZipcode2 = document.getElementById("UserZipcode2");
var UserAddr1 = document.getElementById("UserAddr1");
var UserAddr2 = document.getElementById("UserAddr2");

	UserZipcode1.value = strZip.substring(0,3);
	UserZipcode2.value = strZip.substring(4,7);
	UserAddr1.value = strAddr;
	UserAddr2.focus();

	zip_popup_close()
}

/*=====================================================================
 * �޷�.
 *=====================================================================*/
var calendarDivId    = "__DIV_CALENDAR__";
var calendarIframeId = "__IFRAME_CALENDAR__";
//�޷� ������ ��ġ ã��:Top
function getRealOffsetTop(o) {
	return o ? o.offsetTop + getRealOffsetTop(o.offsetParent) : 3;
}
//�޷� ������ ��ġ ã��:Left
function getRealOffsetLeft(o) {
	return o ? o.offsetLeft + getRealOffsetLeft(o.offsetParent) : 2;
}
function hideCalendar()	{
	var cal = document.getElementById(calendarDivId);
		if(cal) cal.style.display = "none";
}
function callCalendar(obj)	{
	var top  = getRealOffsetTop(obj)+17;
	var left = getRealOffsetLeft(obj)-6;
	
	var param = '';
	if(obj) {
		var tokens = obj.value.split("-");
		if(tokens.length==3)
		{
			param   = "&year="+tokens[0];
			param  += "&month="+tokens[1];
			param  += "&day="+tokens[2];
		}
	}
	url = "/common/calender.asp?obj="+obj.form.name+"."+obj.name;	
	if(param!="") url += param;
	var width = 215;
	var height = 155;
	var ifrm = document.getElementById(calendarIframeId);
	var div = document.getElementById(calendarDivId);
	if(!div)
	{
		div = document.createElement("DIV");
		div.id = calendarDivId;
		div.style.display = "none";
		div.style.position = "absolute";
		div.style.left = left;
		div.style.top = top;
		div.style.zIndex = 100;
		document.body.appendChild(div);
	}else{
		div.style.left = left;
		div.style.top = top;
	}
	if(!ifrm)
	{
		ifrm = document.createElement("IFRAME");
		ifrm.id = calendarIframeId;
		ifrm.width = width;
		ifrm.height = height;
		ifrm.frameBorder = 0;
		ifrm.scrolling = "no";
		div.appendChild(ifrm);
	}
	div.style.display = "inline";
	ifrm.src = url;
}
//�������ε� �̸�����
function fileUploadPreview(thisObj, preViewer) {
 if(!/(\.gif|\.jpg|\.jpeg|\.png)$/i.test(thisObj.value)) {
  alert("�̹��� ������ ������ �����Ͻʽÿ�");
  return;
 }
 preViewer = (typeof(preViewer) == "object") ? preViewer : top.document.getElementById(preViewer);
 var ua = window.navigator.userAgent;
 if (ua.indexOf("MSIE") > -1) {
  var img_path = "";
  if (thisObj.value.indexOf("\\fakepath\\") < 0) {
   img_path = thisObj.value;
  } else {
   thisObj.select();
   var selectionRange = document.selection.createRange();
   img_path = selectionRange.text.toString();
   thisObj.blur();
  }
  preViewer.innerHTML = "";
  preViewer.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='fi" + "le://" + img_path + "', sizingMethod='scale')";
 } else {
  preViewer.innerHTML = "";
  var W = preViewer.offsetWidth;
  var H = preViewer.offsetHeight;
  var tmpImage = document.createElement("img");
  preViewer.appendChild(tmpImage);
  tmpImage.onerror = function () {
   return preViewer.innerHTML = "";
  }
  tmpImage.onload = function () {
   if (this.width > W) {
    this.height = this.height / (this.width / W);
    this.width = W;
   }
   if (this.height > H) {
    this.width = this.width / (this.height / H);
    this.height = H;
   }
  }
  if (ua.indexOf("Firefox/3") > -1) {
   var picData = thisObj.files.item(0).getAsDataURL();
   tmpImage.src = picData;
  } else {
   tmpImage.src = "file://" + thisObj.value;
  }
 }
}

// üũ�ڽ��˻�
function hasCheckedBox(input) {
    return hasCheckedRadio(input);
}
// �����˻�
function hasCheckedRadio(input) {
    if (input.length > 1) {
        for (var inx = 0; inx < input.length; inx++) {
            if (input[inx].checked) return true;
        }
    } else {
        if (input.checked) return true;
    }
    return false;
}

// �迭��ǲ�˻�
function hasCheckedInput(input) {
    if (input.length > 1) {
        for (var inx = 0; inx < input.length; inx++) {
            if (input[inx].value) return true;
        }
    } else {
        if (input.value) return true;
    }
    return false;
}


// �迭��ǲ�� ����
function ValueReutnInput(input) {
    if (input.length > 1) {
        for (var inx = 0; inx < input.length; inx++) {
            if (input[inx].checked) return input[inx].value;
        }
    } else {
        if (input.checked) return input.value;
    }
    return false;
}

// �迭üũ index ����
function IndexReutnInput(input) {
    if (input.length > 1) {
        for (var inx = 0; inx < input.length; inx++) {
            if (input[inx].checked) return inx;
        }
    } else {
        if (input.checked) return 0;
    }
    return false;
}


//Ŭ���ۺ���
function TextClipBoard(x){
	if(x){
		alert("Ŭ�����忡 ��ġ �ڵ尡 ����Ǿ����ϴ�.\n\nCtrl+VŰ�� ���� �ٿ��־� ����ϼ���.")
		window.clipboardData.setData('Text',x)
	}
}

//�����ð� ��� 

function getTime(LaterTime) {
now = new Date();
later = new Date(LaterTime); //�Ϸ�ð� ���� - �� �� �� �� �� ��
days = (later - now) / 1000 / 60 / 60 / 24;
daysRound = Math.floor(days);
hours = (later - now) / 1000 / 60 / 60 - (24 * daysRound);
hoursRound = Math.floor(hours);
minutes = (later - now) / 1000 /60 - (24 * 60 * daysRound) - (60 * hoursRound);
minutesRound = Math.floor(minutes);
seconds = (later - now) / 1000 - (24 * 60 * 60 * daysRound) - (60 * 60 * hoursRound) - (60 * minutesRound);
secondsRound = Math.round(seconds);


   
if (secondsRound <= 9) {
  document.getElementById("ss1").src = TING_LootFolder+"img/time/icon_pink_" + "0" + ".gif";
  document.getElementById("ss2").src = TING_LootFolder+"img/time/icon_pink_" + secondsRound + ".gif";
} else {
  document.getElementById("ss1").src = TING_LootFolder+"img/time/icon_pink_" + Math.floor(secondsRound/10) + ".gif";
  document.getElementById("ss2").src = TING_LootFolder+"img/time/icon_pink_" + secondsRound%10 + ".gif";
}
   
if (minutesRound <= 9) {
  document.getElementById("mm1").src = TING_LootFolder+"img/time/icon_black_" + "0" + ".gif";
  document.getElementById("mm2").src = TING_LootFolder+"img/time/icon_black_" + minutesRound + ".gif";
} else {
  document.getElementById("mm1").src = TING_LootFolder+"img/time/icon_black_" + Math.floor(minutesRound/10) + ".gif";
  document.getElementById("mm2").src = TING_LootFolder+"img/time/icon_black_" + minutesRound%10 + ".gif";
}
   
if (hoursRound <= 9) {
  document.getElementById("hh1").src = TING_LootFolder+"img/time/icon_black_" + "0" + ".gif";
  document.getElementById("hh2").src = TING_LootFolder+"img/time/icon_black_" + hoursRound + ".gif";
} else {
  document.getElementById("hh1").src = TING_LootFolder+"img/time/icon_black_" + Math.floor(hoursRound/10) + ".gif";
  document.getElementById("hh2").src = TING_LootFolder+"img/time/icon_black_" + hoursRound%10 + ".gif";
}
   

newtime = window.setTimeout("getTime('"+LaterTime+"');", 1000);
}


function Left(str, n){
if (n <= 0)
    return "";
else if (n > String(str).length)
    return str;
else
    return String(str).substring(0,n);
}

function Right(str, n){
    if (n <= 0)
       return "";
    else if (n > String(str).length)
       return str;
    else {
       var iLen = String(str).length;
       return String(str).substring(iLen, iLen - n);
    }
}

//���ڸ�
function sunsign(month,date) {
	if(month == 1 && date <=19){return "�����ڸ�";}
	if(month == 1 && date >=20){return "�����ڸ�";}
	if(month == 2 && date <=18){return "�����ڸ�";}
	if(month == 2 && date >=19){return "������ڸ�";}
	if(month == 3 && date <=20){return "������ڸ�";}
	if(month == 3 && date >=21){return "���ڸ�";}
	if(month == 4 && date <=20){return "���ڸ�";}
	if(month == 4 && date >=21){return "Ȳ���ڸ�";}
	if(month == 5 && date <=20){return "Ȳ���ڸ�";}
	if(month == 5 && date >=21){return "�ֵ����ڸ�";}
	if(month == 6 && date <=20){return "�ֵ����ڸ�";}
	if(month == 6 && date >=21){return "���ڸ�";}
	if(month == 7 && date <=21){return "���ڸ�";}
	if(month == 7 && date >=22){return "�����ڸ�";}
	if(month == 8 && date <=21){return "�����ڸ�";}
	if(month == 8 && date >=22){return "ó���ڸ�";}
	if(month == 9 && date <=21){return "ó���ڸ�";}
	if(month == 9 && date >=22){return "õĪ�ڸ�";}
	if(month == 10 && date <=21){return "õĪ�ڸ�";}
	if(month == 10 && date >=22){return "�����ڸ�";}
	if(month == 11 && date <=21){return "�����ڸ�";}
	if(month == 11 && date >=22){return "�ü��ڸ�";}
	if(month == 12 && date <=20){return "�ü��ڸ�";}
	if(month == 12 && date >=21){return "�����ڸ�";}
}


function imgSize(which,max_width,max_height){
	var myImg = document.getElementById(which);
   
    if ( myImg.width > max_width ) {
       var height = myImg.height/(myImg.width / max_width);
       myImg.width = max_width;     
       myImg.height = height;
    } 
	if ( myImg.height > max_height ) {
       var width = myImg.width/(myImg.height / max_height);
       myImg.width = width;     
       myImg.height = max_height;
	  
    } 
}
function sizeComma(bytes){

var byte = new String(bytes);
var len = byte.length;var one;var two;var three;
	if(len > 3) {
		one = byte.substring(len-3,len);
		if(len > 6) {
			two = byte.substring(len-6,len-3);
			if(len > 9) {
				three = byte.substring(len-9,len-6);
				byte = byte.substring(0,len-9);
				byte = byte + ',' + three + ',' + two +  ',' + one;
			}else{
				byte = byte.substring(0,len-6);
				byte = byte + ',' + two +  ',' + one;
			}
		}else{
			byte = byte.substring(0,len-3);
			byte = byte + ',' + one;
		}
	}

return byte;
};
/*===========================================================================
 * �ѱ����� ���ڿ� ���� üũ.
 *===========================================================================*/
String.prototype.lengthB = function() 
{
    var str = this;
    var len = 0; 
    for (var i=0; i<str.length; i++) len += (str.charCodeAt(i) > 128) ? 2 : 1;

    return len;
}
/*===========================================================================
 * �ѱ����� ���ڿ� �ڸ���.
 *===========================================================================*/
String.prototype.substrB = function(len) 
{
    var str = this;
    var to = 0;
    for (var i=0; i<str.length; i++) {
        to += (str.charCodeAt(i) > 128) ? 2 : 1;
        if (to > len) return str.substring(0,i);
    }
    return str;
}


//���ڿ��� �޸��� ���� ��ȯ.
function rtnnumber(n){
 n=n.replace(/,/g,"");
 if(isNaN(n)){return 0;} else{return n;}
}
 
// ���ڸ� ��ȯ..
function addComma(n) {
 if(isNaN(n)){return 0;}
  var reg = /(^[+-]?\d+)(\d{3})/;   
  n += '';
  while (reg.test(n))
    n = n.replace(reg, '$1' + ',' + '$2');
  return n;
}


//�¢� ���� Ȯ���� Ȯ�� �¢¢¢¢¢¢¢¢¢¢¢¢¢¢¢¢�
 function getFileType(filePath)
 {
	 var index = -1;
		 index = filePath.lastIndexOf('.');

	var type = "";

	if(index != -1)
	 {
		 type = filePath.substring(index+1, filePath.len);
	 }
	 else
	 {
		 type = "";
	 }

	return type;
 }



 var Request = function()
 {
     this.getParameter = function( name )
     {
         var rtnval = '';
         var nowAddress = unescape(location.href);
         var parameters = (nowAddress.slice(nowAddress.indexOf('#')+1,nowAddress.length)).split('&');
 
        for(var i = 0 ; i < parameters.length ; i++)
         {
             var varName = parameters[i].split('=')[0];
             if(varName.toUpperCase() == name.toUpperCase())
             {
                 rtnval = parameters[i].split('=')[1];
                 break;
             }
         }
         return rtnval;
         //document.write( rtnval );
     }
 }
 
var request = new Request();


//���ƿ� ��ư
function facebookLikeBtn(LikeUrl){
var LikeDomain = ROOT_DOMAIN + LikeUrl;
var Obj ="<div id=\"fb-root\"></div>" +
		"<div class=\"fb-like\" data-href=\""+LikeDomain+"\" data-send=\"true\" data-width=\"420\" data-show-faces=\"false\" style='width:420px;'></div>";

	return Obj;
}

function callFacebook(d, s, id) {;
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/ko_KR/all.js#xfbml=1&appId=129471967162062";
  fjs.parentNode.insertBefore(js, fjs);
}
//�̸��� ����üũ
function check_email(txt){
	if((txt.indexOf("@")==-1) || (txt.indexOf(".")==-1)){
		return false;
	}else{
		return true;
	}
}


// ��Ű ����
 function setCookie(cName, cValue, cDay){
	  var expire = new Date();
	  expire.setDate(expire.getDate() + cDay);
	  cookies = cName + '=' + escape(cValue) + '; path=/ '; // �ѱ� ������ �������� escape(cValue)�� �մϴ�.
	  if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
	  document.cookie = cookies;
 }

 // ��Ű ��������
 function getCookie(cName) {
	  cName = cName + '=';
	  var cookieData = document.cookie;
	  var start = cookieData.indexOf(cName);
	  var cValue = '';
	  if(start != -1){
		   start += cName.length;
		   var end = cookieData.indexOf(';', start);
		   if(end == -1)end = cookieData.length;
		   cValue = cookieData.substring(start, end);
	  }
	  return unescape(cValue);
 }