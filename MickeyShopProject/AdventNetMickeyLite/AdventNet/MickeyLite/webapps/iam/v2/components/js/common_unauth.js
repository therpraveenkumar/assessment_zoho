//$Id$
var I18N = {
		data : {},
		load : function(arr) {
			$.extend(this.data, arr);
			return this;
		},
		get : function(key, args) {
			if (typeof key == "object") {
				for ( var i in key) {
					key[i] = I18N.get(key[i]);
				}
				return key;
			}
			var msg = this.data[key] || key;
			if (args) {
				arguments[0] = msg;
				return Util.format.apply(this, arguments);
			}
			return msg;
		}
};
var Util = {
	euc : function(value) {
		return encodeURIComponent(value);
	},
	duc : function(value) {
		return decodeURIComponent(value);
	},
	format : function(msg, args) {
		if (msg) {
			for (var i = 1; i < arguments.length; i++) {
				msg = msg.replace(new RegExp("\\{" + (i - 1) + "\\}", "g"), arguments[i]);
			}
		}
		return msg;
	}
}
PasswordPolicy = {
		data : {},
		load : function(arr) {
			$.extend(this.data, arr);
			return this;
		},
		isHaveMinLength : function(password){
			return password.length>=this.data.min_length;
		},
		isHavingSpecialChars : function(password) {
			return (((password.match(new RegExp("[^a-zA-Z0-9]","g")) || []).length	) >= this.data.min_spl_chars);
		},
		isHavingNumber : function(password){
			return (((password.match(new RegExp("[0-9]","g")) || []).length) >= this.data.min_numeric_chars);
		},
		isHavingUpperCase : function(password){
			return	new RegExp("[A-Z]","g").test(password);
		},
		isHavingLowerCase : function(password){
			return new RegExp("[a-z]","g").test(password);
		}
}
function validateConfirmPassword(pass_ele){
	var confirm_ele;
	if($(".signup_container").length!=0 && !$(pass_ele).parent().hasClass('idp_infomation_card')){
		confirm_ele = $(pass_ele).parent().next().children("input"); //No I18N
	}
	else{
		confirm_ele = $(pass_ele).parent().next().next().children("input"); //No I18N		
	}
	var newPassword = $(pass_ele).val();
	var confPassword = $(confirm_ele).val();
	if((newPassword!="")&&(confPassword!="")){
		if(newPassword==confPassword && $(pass_ele).siblings(".pass_allow_indi").hasClass("show_pass_allow_indi")){
			$(confirm_ele).siblings(".pass_allow_indi").addClass("show_pass_allow_indi");
			return true;
		}
		else{
			$(confirm_ele).siblings(".pass_allow_indi").removeClass("show_pass_allow_indi");
			return false;
		}
	}
}
function changePasswordCheckIndicator(ele,changePositive){
	if(changePositive){
		$(ele).addClass("grn_tick");
		return true;
	}
	else{
		$(ele).removeClass("grn_tick");
		return false;
	}
}

function validatePassword(pass_ele){
	var ppCheckValue = true;

	var password = $(pass_ele).val();
	$(".password_indicator span").addClass("grn_tick");                                                                                                                                                                                                                                                                                                                                                                                            
	if(!PasswordPolicy.isHaveMinLength(password) && PasswordPolicy.data.min_length != 0){
		changePasswordCheckIndicator("#char_check",false);//No I18N
		ppCheckValue = false;
	}
	if(!PasswordPolicy.isHavingSpecialChars(password) && PasswordPolicy.data.min_spl_chars!= 0) {
		changePasswordCheckIndicator("#spcl_char_check",false);//No I18N
		ppCheckValue = false;
	}
	if(!PasswordPolicy.isHavingNumber(password) && PasswordPolicy.data.min_numeric_chars != 0){
		changePasswordCheckIndicator("#num_check",false);//No I18N
		ppCheckValue = false;
	}
	if(JSON.parse(PasswordPolicy.data.mixed_case)){
		if(!PasswordPolicy.isHavingUpperCase(password)){
			changePasswordCheckIndicator("#uppercase_check",false); //No I18N
			ppCheckValue = false;
		}
		if(!PasswordPolicy.isHavingLowerCase(password)){
			changePasswordCheckIndicator("#lowercase_check",false);//No I18N
			ppCheckValue = false;
		}
	}
	validPasswordChanges(ppCheckValue,pass_ele)
	return ppCheckValue;
		
}
function validPasswordChanges(isValidPass,ele){
	if($(ele).val().length<=0){
		$(".password_indicator").slideUp(300);
		$(".pass_allow_indi").removeClass("show_pass_allow_indi");
	}
	if(!$(".password_indicator").is(":visible")&&!isValidPass){
		$(".password_indicator").slideDown(300);
	}
	if(isValidPass){
		$(".password_indicator").slideUp(300);
		$(ele+"~.pass_allow_indi").addClass("show_pass_allow_indi");
	}
	else{
		$(ele+"~.pass_allow_indi").removeClass("show_pass_allow_indi");
	}
	validateConfirmPassword(ele);
}
function setFooterPosition(){
	var top_value = window.innerHeight-60;	
	if($(".container")[0] && ($(".container")[0].offsetHeight+$(".container")[0].offsetTop)<top_value){
		$("#footer").css("top",top_value+"px"); // No I18N
	}
	else{
		$("#footer").css("top",$(".container")[0] && ($(".container")[0].offsetHeight+$(".container")[0].offsetTop)+"px"); // No I18N
	}
}

$(window).resize(function(){
	setFooterPosition();
});

$("document").ready(function(){
	setFooterPosition();
	$.fn.focus=function(){ 
		if(this.length){
			$(this)[0].focus();
		}
		return $(this);
	}
});

function hideLoadinginButton(){
	if($("#loadingImg").is(":visible"))
	{
		$("#loadingImg").hide();
    }
}

function isEmailId(str) {
    if(!str) {
        return false;
    }
    str = str.trim();
    var objRegExp  = /^[\w]([\w\-\.\+\'\!\*]*)@([\w\-\.]*)(\.[a-zA-Z]{2,22}(\.[a-zA-Z]{2}){0,2})$/i;
    return objRegExp.test(str);
}

function isPhoneNumber(str) {
    if(!str) {
        return false;
    }
    str = str.trim();
    var objRegExp = /^([0-9]{7,14})$/;
    return objRegExp.test(str);
}


function formatMessage() {
    var msg = arguments[0];
    if(msg != undefined) {
	for(var i = 1; i < arguments.length; i++) {
	    msg = msg.replace('{' + (i-1) + '}', escapeHTML(arguments[i]));
	}
    }
    return msg;
}
function escapeHTML(value) {
	if(value) {
		value = value.replace("<", "&lt;");
		value = value.replace(">", "&gt;");
		value = value.replace("\"", "&quot;");
		value = value.replace("'", "&#x27;");
		value = value.replace("/", "&#x2F;");
    }
    return value;
}
function de(id) {
    return document.getElementById(id);
}
function euc(i) {
    return encodeURIComponent(i);
}
function isEmpty(str) {
    return str ? false : true;
}
function getPlainResponse(action, params) {
	if (typeof contextpath !== 'undefined') {
		action = contextpath + action;
	}
    if(params.indexOf("&") === 0) {
	params = params.substring(1);
    }
    var objHTTP,result;
    objHTTP = xhr();
    objHTTP.open('POST', action, false);
    objHTTP.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
    if(isEmpty(params)) {
        params = "__d=e"; //No I18N
    }
    objHTTP.setRequestHeader('Content-length', params.length);
    objHTTP.send(params);
    return objHTTP.responseText;
}


function getErrorMessage(response)
{
	var msg= response.localized_message!=undefined? response.localized_message:response.message!=undefined?response.message:err_try_again;
	return msg;
}


function showErrMsg(msg) 
{
	$( "#error_space" ).removeClass("show_error");
	$(".cross_mark").removeClass("cross_mark_success");
	//$(".top_div").css({"border-right": "3px solid #ef4444", "color": "#ef4444"});     	
	$(".cross_mark").css("background","#DA6161");					
	//$(".crossline1").css({"top": "18px", "left": "0px", "width":"20px"}); 			
	//$(".crossline2").css("left","0px");		
    $('.top_msg').html(msg); //No I18N
    $(".cross_mark").addClass("cross_mark_error");
    $( "#error_space" ).addClass("show_error");
    
    setTimeout(function() {
    	$( "#error_space" ).removeClass("show_error");
    	$(".cross_mark").removeClass("cross_mark_error");
    	 $('.top_msg').html("");
    }, 5000);;

}

function showmsg(msg) 
{
	$( "#error_space" ).removeClass("show_error");
	$(".cross_mark").removeClass("cross_mark_error");
	//$(".top_div").css({"border-right": "3px solid #50BF54", "color": "#50BF54"});     	
	$(".cross_mark").css("background","#69C585");					
	//$(".crossline1").css({"top": "22px", "left": "-6px", "width":"12px"}); 			
	//$(".crossline2").css("left","4px");		
    $('.top_msg').html(msg); //No I18N
    $( ".cross_mark" ).addClass("cross_mark_success");
    $( "#error_space" ).addClass("show_error");
    
    setTimeout(function() {
    	$( "#error_space" ).removeClass("show_error");
    	$(".cross_mark").removeClass("cross_mark_success");
    	 $('.top_msg').html("");
    }, 5000);

}

function show_blur_screen()
{
  $(".blur").css({"z-index":3,"opacity":.6});
  $('html, body').css({
      overflow: "hidden" //No I18N
  });
}

function xhr() {
    var xmlhttp;
    if (window.XMLHttpRequest) {
	xmlhttp=new XMLHttpRequest();
    }
    else if(window.ActiveXObject) {
	try {
	    xmlhttp=new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch(e) {
	    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
    }
    return xmlhttp;
}


function sendRequestWithCallback(action, params, async, callback,method) {
	if (typeof contextpath !== 'undefined') {
		action = contextpath + action;
	}
    var objHTTP = xhr();
    objHTTP.open(method?method:'POST', action, async);
    objHTTP.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
    objHTTP.setRequestHeader('X-ZCSRF-TOKEN',csrfParam+'='+euc(getCookie(csrfCookieName)));
    if(async){
	objHTTP.onreadystatechange=function() {
	    if(objHTTP.readyState==4) {
	    	if (objHTTP.status === 0 ) {
				handleConnectionError();
				return false;
			}
			if(callback) {
			    callback(objHTTP.responseText);
			}
	    }
	};
    }
    objHTTP.send(params);
    if(!async) {
	if(callback) {
            callback(objHTTP.responseText);
        }
    }
}  


$(function() 
		{
			$("input").keyup(function()
			{
				$( ".error_notif" ).remove();

			});
		});


function redirectLink(link,ele){
	if(ele){
		disabledButton(ele);
	}
	 window.location.href = link;
}

function err_remove()
{	
	$(".err_text").remove();
	//for org invitations sections
	$(".chk_err_text").remove();
	$(".textbox_div").removeClass("error_field_card");
	
}

function disabledButton(form_ele){
	$(form_ele).attr("disabled", "disabled");
	$(form_ele).addClass("disable_button");
}
function removeButtonDisable(form_ele){
	$(form_ele).removeAttr("disabled");
	$(form_ele).removeClass("disable_button");
}
function getCookie(cname) {
	  var name = cname + "=";
	  var decodedCookie = decodeURIComponent(document.cookie);
	  var ca = decodedCookie.split(';');
	  for(var i = 0; i <ca.length; i++) {
	    var c = ca[i];
	    while (c.charAt(0) == ' ') {
	      c = c.substring(1);
	    }
	    if (c.indexOf(name) == 0) {
	      return c.substring(name.length, c.length);
	    }
	  }
	  return "";
}
function isUserName(str) {
	if(!str) {
        return false;
    }
	var objRegExp = new XRegExp("^[\\p{L}\\p{N}\\p{M}\\_\\.]+$","i"); // No I18N
    return XRegExp.test(str.trim(), objRegExp);
}
function isValidNameString(str)
{
	var objRegExp = new XRegExp("^[\\p{L}\\p{M}\\p{N}\\-\\_\\ \\.\\+\\!\\[\\]\\']+$","i")	//No i18N
	return objRegExp.test(str.trim())
}
function doGet(action, params) {
	if (typeof contextpath !== 'undefined') {
		action = contextpath + action;
	}
    var objHTTP;
    objHTTP = xhr();
    if(isEmpty(params)) {
        params = "__d=e"; //No I18N
    }
	objHTTP.open('GET', action + "?" + params, false);	//No I18N
    objHTTP.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8');	//No I18N
    objHTTP.send(params);
    return objHTTP.responseText;
}
function check_pp(cases,spl,num,minlen,formID, passInputID) {
	validatePasswordPolicy().validate(formID, passInputID);
}

function validatePasswordPolicy(passwordPolicy) {
	passwordPolicy = passwordPolicy || PasswordPolicy.data;
	var initCallback = function(id, msg) {
		var li = document.createElement('li');//No I18N
        li.setAttribute("id","pp_"+id);//No I18N
        li.setAttribute("class","pass_policy_rule");//No I18N
        li.textContent = msg;
        return li;
	}
	var setErrCallback = function(id) {
		$("#pp_"+id).removeClass('success');//No I18N
		return id;
	}
	return {
		getErrorMsg: function(value, callback) {
			if(passwordPolicy) {
				var isInit = value ?  false : true;
	 			value = value || '';
	 			callback = callback || setErrCallback;
	 			var rules = [ 'MIN_MAX', 'SPL', 'NUM', 'CASE']; //No I18N
	 			var err_rules = []; 
	 			var err_msg = []; 
	 			if(!isInit) {
	 				$('.pass_policy_rule').addClass('success');//No I18N
	 			}
	 			for(var i = 0; i < rules.length; i++) {
	 				switch (rules[i]) {
	 					case 'MIN_MAX': //No I18N
	 						if(value.length<passwordPolicy.min_length || value.length>passwordPolicy.max_length) {
	 							err_rules.push(callback(rules[i], isInit ? formatMessage(I18N.get("IAM.PASS_POLICY.MIN_MAX"), passwordPolicy.min_length.toString(), passwordPolicy.max_length.toString()) : undefined));
	 						}
	 						break;
	 					case 'SPL': //No I18N
	 						if((passwordPolicy.min_spl_chars > 0) &&  (((value.match(new RegExp("[^a-zA-Z0-9]","g")) || []).length) < passwordPolicy.min_spl_chars)) {
	 							err_rules.push(callback(rules[i], isInit ? formatMessage(I18N.get(passwordPolicy.min_spl_chars === 1 ? "IAM.PASS_POLICY.SPL_SING" : "IAM.PASS_POLICY.SPL"), passwordPolicy.min_spl_chars.toString()) : undefined));
	 						}
	 						break;
	 					case 'NUM': //No I18N
	 						if((passwordPolicy.min_numeric_chars > 0) &&  (((value.match(new RegExp("[0-9]","g")) || []).length) < passwordPolicy.min_numeric_chars)){
	 							err_rules.push(callback(rules[i], isInit ? formatMessage(I18N.get(passwordPolicy.min_numeric_chars === 1 ? "IAM.PASS_POLICY.NUM_SING" : "IAM.PASS_POLICY.NUM"), passwordPolicy.min_numeric_chars.toString()) : undefined));
	 						}
	 						break;
	 					case 'CASE': //No I18N
	 						if((passwordPolicy.mixed_case) && !((new RegExp("[A-Z]","g").test(value))&&(new RegExp("[a-z]","g").test(value)))) {
	 							err_rules.push(callback(rules[i], isInit ? I18N.get("IAM.PASS_POLICY.CASE") : undefined));
	 						}
	 						break;
	 				}
	 			}
	 			return err_rules.length && err_rules;
			}
		},
		init: function(passInputID) {
 			$('.hover-tool-tip').remove();//No I18N
 			var tooltip = document.createElement('div');//No I18N
 			tooltip.setAttribute("class",isMobile ? "hover-tool-tip no-arrow" : "hover-tool-tip");//No I18N
 			var p = document.createElement('p');//No I18N
 			p.textContent = I18N.get("IAM.PASS_POLICY.HEADING");//No I18N
 			var ul = document.createElement('ul');//No I18N
 			var errList = this.getErrorMsg(undefined, initCallback);
 			if(errList) {
 				errList.forEach(function(eachLi) {
	 	 			ul.appendChild(eachLi);
	 			});
	 			tooltip.appendChild(p);
	 			tooltip.appendChild(ul);
	 			document.querySelector('body').appendChild(tooltip);//No I18N
	 			$(passInputID).on('focus blur', function(e){//No I18N
	 			    if(e.type === 'focus') {//No I18N
	 			    	var offset = document.querySelector(passInputID).getBoundingClientRect();
	 		 			$('.hover-tool-tip').css(isMobile ? {
	 		 				top: offset.bottom + $(window).scrollTop() + 8,
	 		 				left: offset.x,
	 		 				width: offset.width - 40
	 		 			} : {
	 		 				top: offset.y + $(window).scrollTop(),
	 		 				left: offset.x + offset.width + 15
	 		 			});
	 			    	$('.hover-tool-tip').css('opacity', 1);//No I18N
	 			    } else {
	 			    	$('.hover-tool-tip').css('opacity', 0);//No I18N
	 			    	var offset = document.querySelector('.hover-tool-tip').getBoundingClientRect();//No I18N
	 		 			$('.hover-tool-tip').css({
	 		 				top: -offset.height,
	 		 				left: -(offset.width + 15)
	 		 			})
	 			    }
	 			});
 			}
 		},
 		validate: function(formID, passInputID) {
			var str=$(passInputID).val();
			this.getErrorMsg(str, setErrCallback);
 		}
	}
}
function decodeHTML(t){
	return t != "" ? $('<textarea />').html(t).text() : "";
}