
//$Id$
//  ******JS 2.0******     New Signin second cut functions added  /
var signinathmode = "lookup";//No i18N
var reload_page ="";
var isFormSubmited = isPasswordless = isSecondary = isPrimaryDevice = isTroubleSignin = isRecovery = isCountrySelected = isFaceId = isPrimaryMode = isEmailVerifyReqiured = triggeredUser = false;
var allowedmodes,digest,rmobile,zuid,temptoken,mdigest,deviceid,prefoption,devicename,emobile,deviceauthdetails,cdigest,isResend,redirectUri,secondarymodes,prev_showmode,qrtempId,mobposition,bioType,restrictTrustMfa,resendTimer,trustMfaDays,bannerTimer,oldsigninathmode,emailposition;
var callmode="primary";//no i18N
var oadevicepos = mzadevicepos =  0;
var adminEmail;
function select2_open_listener(event) {	
	if (event && $(event.target).closest('.select2-selection').length) {		
		$('.select2-dropdown').children('.select2-search').children('.select2-search__field')[0].focus();		
	}			    
}
document.addEventListener('click', select2_open_listener, true);
function submitsignin(frm){
	$(".signin_head .fielderror").removeClass("errorlabel");
	$(".signin_head .fielderror").text("");//no i18n
	if(isFormSubmited) {
		return false;
	}
	$("#nextbtn span").addClass("zeroheight");
	$("#nextbtn").addClass('changeloadbtn');
	$("#nextbtn").attr("disabled", true);
	if($('#totpverifybtn').is(":visible")){
		$('#totpverifybtn .loadwithbtn').show();
		$('#totpverifybtn .waittext').addClass('loadbtntext');
	}
	var isCaptchaNeeded = $("#captcha_container").is(":visible");
	var captchavalue = frm.captcha && frm.captcha.value.trim();
	if(isCaptchaNeeded){
		if(!isValid(captchavalue)) {
			changeHip();
			showCommonError("captcha",I18N.get("IAM.SIGNIN.ERROR.CAPTCHA.REQUIRED"));//no i18n
			return false;
		}
		if( /[^a-zA-Z0-9\-\/]/.test( captchavalue ) ) {
			changeHip();
			showCommonError("captcha",I18N.get("IAM.SIGNIN.ERROR.CAPTCHA.INVALID"));//no i18n
			return false;
		}
    }
	if(signinathmode === "lookup"){
		var LOGIN_ID = frm.LOGIN_ID.value.trim();
		if($("#portaldomain").is(":visible")){
			LOGIN_ID = LOGIN_ID+$(".domainselect").val(); 
		}
		if(!isValid(LOGIN_ID)) {
			showCommonError("login_id",I18N.get("IAM.NEW.SIGNIN.ENTER.EMAIL.OR.MOBILE"));//no i18n
			return false;
		}
		if(($(".showcountry_code").is(":visible") || $("#country_code_select").is(":visible") ) && !isPhoneNumber(LOGIN_ID)){
			showCommonError("login_id",I18N.get("IAM.PHONE.ENTER.VALID.MOBILE_NUMBER"));//no i18n
			return false;
		}
		if(!isUserName(LOGIN_ID) && !isEmailId(LOGIN_ID) && !isPhoneNumber(LOGIN_ID.split('-')[1])) {
			showCommonError("login_id",I18N.get("IAM.SIGNIN.ERROR.USEREMAIL.NOT.EXIST"));//no i18n
			return false;
		}
		LOGIN_ID = ($(".showcountry_code").is(":visible") || $("#country_code_select").is(":visible") ) ? $( "#country_code_select" ).val().split("+")[1]+'-'+LOGIN_ID : LOGIN_ID;
		LOGIN_ID = isPhoneNumber(LOGIN_ID.split('-')[1]) ? LOGIN_ID.split('-')[0].trim() + "-" + LOGIN_ID.split('-')[1].trim() : LOGIN_ID;
		var loginurl = uriPrefix +"/signin/v2/lookup/"+LOGIN_ID ;//: "/signin/v2/lookup/"+LOGIN_ID; //no i18N
		var params = "mode=primary"+ "&" + signinParams; //no i18N
		if(isCaptchaNeeded){params += "&captcha=" +captchavalue+"&cdigest="+cdigest;}
		sendRequestWithCallback(loginurl, params ,true, handleLookupDetails);//No I18N
		return false;
	}else if(signinathmode === "passwordauth"){//no i18N
		if(allowedmodes != undefined && allowedmodes.indexOf("yubikey") != -1 && !isWebAuthNSupported()){ 
			//if yubikey not supported in user's browser, block signin on first factor form and show not supported error
			showTopErrNotification(I18N.get("IAM.WEBAUTHN.ERROR.BrowserNotSupported"));
			changeButtonAction(I18N.get("IAM.NEXT"),false);
			return false;
		}
		var PASSWORD = frm.PASSWORD.value.trim();
		if(!isValid(PASSWORD)) {
			showCommonError("password",I18N.get("IAM.ERROR.ENTER_PASS")); //no i18n
			return false;
		}
		var jsonData = {'passwordauth':{'password':PASSWORD }};//no i18n
		var loginurl = uriPrefix + "/signin/v2/"+callmode+"/"+zuid+"/password?";// : "/signin/v2/"+callmode+"/"+zuid+"/password?";//no i18N
		loginurl += "digest="+digest+ "&" + signinParams; //no i18N
		if(isCaptchaNeeded){loginurl += "&captcha=" +captchavalue+"&cdigest="+cdigest;}
		sendRequestWithCallback(loginurl,JSON.stringify(jsonData),true,handlePasswordDetails);
		return false;
		
	}
	else if(signinathmode === "totpsecauth" || (signinathmode==="oneauthsec" && prefoption==="ONEAUTH_TOTP") ){//no i18N
		if(isClientPortal){var TOTP = frm.TOTP.value.trim();}
		else{var TOTP = document.getElementById("mfa_totp").firstChild.value.trim();}
		if( !isValid(TOTP)){
			showCommonError("mfa_totp",I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY"));//No I18N
			return false;
		}
		if( /[^0-9\-\/]/.test( TOTP ) ) {
			showCommonError("mfa_totp",I18N.get("IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE"));//No I18N
			return false;
		}
		callmode="secondary";//no i18n
		var loginurl= prefoption==="ONEAUTH_TOTP" ? uriPrefix+"/signin/v2/"+callmode+"/"+zuid+"/oneauth/"+deviceid+"?": uriPrefix+"/signin/v2/"+callmode+"/"+zuid+"/totp?";//no i18N
		loginurl += "digest="+digest+ "&" + signinParams; //no i18N
		if(isCaptchaNeeded){loginurl += "&captcha=" +captchavalue+"&cdigest="+cdigest;}
		var jsonData = prefoption==="ONEAUTH_TOTP" ? {'oneauthsec':{'devicepref':prefoption,'code':TOTP }} : {'totpsecauth':{'code':TOTP }};//no i18N
		var method = prefoption==="ONEAUTH_TOTP" ? "PUT": "POST";//NO i18N
		loginurl = prefoption==="ONEAUTH_TOTP" ? loginurl+"&polling="+false : loginurl; // no i18n
		sendRequestWithTemptoken(loginurl,JSON.stringify(jsonData),true,handleTotpDetails,method);
		return false;
	}else if(signinathmode === "otpsecauth"){//No I18N
		if(isClientPortal){var TFA_OTP_CODE = frm.MFAOTP.value.trim();}
		else{var TFA_OTP_CODE = $("#mfa_otp input:first-child").val() && $("#mfa_otp input:first-child").val().trim();}
		var errorfield = "mfa_otp"; // no i18n
		var incorrectOtpErr = I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.NEW");
		if(prev_showmode === "email"){
			if(isClientPortal){TFA_OTP_CODE = frm.MFAEMAIL.value.trim();}
			else{TFA_OTP_CODE = $("#mfa_email input:first-child").val() && $("#mfa_email input:first-child").val().trim();}
			errorfield = "mfa_email"; // no i18n
			incorrectOtpErr = I18N.get("IAM.NEW.SIGNIN.INVALID.EMAIL.MESSAGE.NEW");
		}
		if(!isValid(TFA_OTP_CODE)){
				showCommonError(errorfield,I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY"));//No I18N
				return false;	
		}
		if(isNaN(TFA_OTP_CODE) || TFA_OTP_CODE.length != 7) {
				showCommonError(errorfield,incorrectOtpErr);
				return false;
		}
		if( /[^0-9\-\/]/.test( TFA_OTP_CODE ) ) {
			showCommonError(errorfield,I18N.get("IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE"));//No I18N
			return false;
		}
		var mode = prev_showmode === "email" ? "EMAIL" : "MOBILE"; // no i18N
		callmode="secondary";//no i18n
		var loginurl=uriPrefix+"/signin/v2/"+callmode+"/"+zuid+"/otp/"+emobile+"?";//no i18N
		loginurl += "digest="+digest+ "&" + signinParams; //no i18N
		if(isCaptchaNeeded){loginurl += "&captcha=" +captchavalue+"&cdigest="+cdigest;}
		var isAMFA = deviceauthdetails[deviceauthdetails.resource_name].isAMFA;
		var jsonData = isAMFA  ? { 'otpsecauth' : { 'mdigest' : mdigest, 'code' : TFA_OTP_CODE , 'isAMFA' : true , 'mode' : mode} } : { 'otpsecauth' : { 'mdigest' : mdigest, 'code' : TFA_OTP_CODE  , 'mode' : mode} } ;//no i18N
		sendRequestWithTemptoken(loginurl,JSON.stringify(jsonData),true,handleTotpDetails,"PUT");//no i18n
		return false;
	}else if(signinathmode === "otpauth" ){ //no i18n 
		if(isClientPortal){var OTP_CODE = frm.OTP.value.trim();}
		else{var OTP_CODE = document.getElementById("otp").firstChild.value.trim();}
		if(allowedmodes != undefined && allowedmodes.indexOf("yubikey") != -1 && !isWebAuthNSupported()){ 
			//if yubikey not supported in user's browser, block signin on first factor  form and show not supported error
			showTopErrNotification(I18N.get("IAM.WEBAUTHN.ERROR.BrowserNotSupported"));
			changeButtonAction(I18N.get("IAM.VERIFY"),false);
			return false;
		}
		if(!isValid(OTP_CODE)){
				showCommonError("otp",I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY"));//No I18N
				return false;	
		}
		if(isNaN(OTP_CODE) || OTP_CODE.length != 7) {
				var error_msg = prev_showmode === "email" ? I18N.get("IAM.NEW.SIGNIN.INVALID.EMAIL.MESSAGE.NEW") : I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.NEW"); // no i18n
				showCommonError("otp",error_msg);//no i18n
				return false;
		}
		if( /[^0-9\-\/]/.test( OTP_CODE ) ) {
			showCommonError("otp",I18N.get("IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE"));//No I18N
			return false;
		}
		var mode = prev_showmode === "email" ? "EMAIL" : "MOBILE"; // no i18N
		var loginurl = uriPrefix+"/signin/v2/"+callmode+"/"+zuid+"/otp/"+emobile+"?";//no i18N
		loginurl += "digest="+digest+ "&" + signinParams; //no i18N
		if(isCaptchaNeeded){loginurl += "&captcha=" +captchavalue+"&cdigest="+cdigest;}
		var jsonData = { 'otpauth' : { 'code' : OTP_CODE, 'is_resend' : false  , 'mode' : mode} };//no i18N
		sendRequestWithCallback(loginurl,JSON.stringify(jsonData),true,handlePasswordDetails,"PUT");//no i18n
		return false;
	}
	else if(signinathmode=== "deviceauth" || signinathmode=== "devicesecauth"){ 
		var myzohototp;
		if(prefoption==="totp"){
			if(isClientPortal){myzohototp = isTroubleSignin ? frm.MFATOTP.value.trim() : frm.TOTP.value.trim();}
			else{myzohototp = isTroubleSignin ? document.getElementById("verify_totp").firstChild.value.trim() : document.getElementById("mfa_totp").firstChild.value.trim();}
			if( !isValid(myzohototp)){
				var container = isTroubleSignin ? "verify_totp" : "mfa_totp"; // no i18n
				showCommonError(container,I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY"));//No I18N
				return false;
			}
		}
		var loginurl="/signin/v2/"+callmode+"/"+zuid+"/device/"+deviceid+"?";//no i18N
		loginurl += "digest="+digest+ "&" + signinParams; //no i18N
		isResend = prefoption === "push" ? true : false; // no i18N
		var jsonData = prefoption==="totp" ? {'devicesecauth':{ 'devicepref' : prefoption, 'code' : myzohototp } } :{'devicesecauth':{'devicepref':prefoption }}; ;//no i18N
		if(signinathmode === "deviceauth"){
			jsonData = prefoption==="totp" ? {'deviceauth':{ 'devicepref' : prefoption, 'code' : myzohototp } } :{'deviceauth':{'devicepref':prefoption }}; ;//no i18N
		}
		var method = "POST"; // no i18n
		var invoker = handleMyZohoDetails;
		if(prefoption==="totp"){
			method = "PUT"; // no i18n
			loginurl+= "&polling="+false; // no i18n
			invoker = handleTotpDetails;
		}
		sendRequestWithTemptoken(loginurl,JSON.stringify(jsonData),true,invoker,method);
		return false;
		//Resend push for myzohoapp
	}else if(signinathmode=== "oneauthsec"){ //No i18N   
		var loginurl="/signin/v2/"+callmode+"/"+zuid+"/oneauth/"+deviceid+"?";//no i18N
		loginurl += "digest="+digest+ "&" + signinParams; //no i18N
		var jsonData = {'oneauthsec':{'devicepref':prefoption }};//no i18N
		isResend= prefoption === "totp" || prefoption === "scanqr" ? false : true;// no i18N
		sendRequestWithTemptoken(loginurl,JSON.stringify(jsonData),true,handleOneAuthDetails);
		return false;
	}else if(signinathmode==="yubikeysecauth"){ //no i18n 
		clearCommonError("yubikey");//no i18N
		if(!isWebAuthNSupported()){
			showTopErrNotification(I18N.get("IAM.WEBAUTHN.ERROR.BrowserNotSupported"));
			return false;
		}
		var loginurl="/signin/v2/"+callmode+"/"+zuid+"/yubikey/self?"+signinParams;//no i18n
		sendRequestWithTemptoken(loginurl,"",true,handleYubikeyDetails);
		return false;
		//Resend Yubikey
	}
	isFormSubmited = true;
	return false;
}
function sendRequestWithTemptoken(action, params, async, callback,method) {
	if (typeof contextpath !== 'undefined') {
		action = contextpath + action;
	}
    var objHTTP = xhr();
    objHTTP.open(method?method:'POST', action, async);
    objHTTP.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
    if(isValid(temptoken)){
    	objHTTP.setRequestHeader('Z-Authorization','Zoho-ticket '+temptoken); // no i18n
    }
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
function showCommonError(field,message){ 	
	$('.fielderror').val('');
	if($(".changeloadbtn").is(":visible")){
		var btnvalue = field==="login_id" ? I18N.get("IAM.NEXT") : field==="password" ? I18N.get("IAM.SIGNIN") : I18N.get("IAM.VERIFY"); //No i18n
		changeButtonAction(btnvalue,false);
	}
	if(field === "captcha"){
		$("#bcaptcha_container").is(":visible") ? changeHip('bcaptcha_img','bcaptcha') : changeHip(); // no i18n
	}else{
		$("#captcha_container,#bcaptcha_container").hide();
	}
	if($(".sendingotp").is(":visible")){
		$(".resendotp").removeClass("sendingotp").addClass("nonclickelem");
		$(".resendotp").text(I18N.get("IAM.NEW.SIGNIN.RESEND.OTP"));
	}
	var container=field+"_container";//no i18N
	$("#"+field).addClass("errorborder");
	$("#"+container+ " .fielderror").addClass("errorlabel");
	$("#"+container+ " .fielderror").html(message);
	$("#"+container+ " .fielderror").slideDown(200);
	$("#"+field).focus();
	if($('#totpverifybtn').is(":visible")){
		$('#totpverifybtn .loadwithbtn').hide();
		$('#totpverifybtn .waittext').removeClass('loadbtntext');
	}
	return false;
}
function callback_signin_lookup(msg) {
	showCommonError("login_id",msg);//No I18N
	$("#nextbtn span").removeClass("zeroheight");
	$("#nextbtn").removeClass("changeloadbtn");
	$("#nextbtn").attr("disabled", false);
	$("#nextbtn span").text(I18N.get("IAM.NEXT"));
	isFormSubmited = false;
	return false;
}
function changeButtonAction(textvalue,isSubmitted){
	$("#nextbtn span").removeClass("zeroheight");
	$("#nextbtn").removeClass("changeloadbtn");
	$("#nextbtn").attr("disabled", false);
	$("#nextbtn span").text(textvalue); //No I18N
	isFormSubmited = isSubmitted;
	return false;
}
function identifyEmailOrNum(login_id){
	var userLogin = isValid(login_id)? login_id : deviceauthdetails[deviceauthdetails.resource_name].loginid;
	if(isPhoneNumber(userLogin.split('-')[1])){
		return "+"+userLogin.split('-')[0]+" "+userLogin.split('-')[1];
	}else{
		return userLogin;
	}
}
function enablePassword(loginId,isOTP, isSaml, isFederated,isNoPassword,isJwt,isEOTP) {
	changeButtonAction(I18N.get('IAM.SIGNIN'),false);//no i18n
	$("#login_id_container,#showIDPs").slideUp(200);
	$("#password_container").removeClass("zeroheight");
	$("#password_container").slideDown(200);
	$(".backbtn").show();
	$("#captcha_container,.line").hide();
	$('.username').text(identifyEmailOrNum());
	$("#forgotpassword").hide();
	if(!isFederated && isNoPassword && (isOTP || isEOTP)){
		$("#password_container .textbox_div,#nextbtn").hide()
		$(".nopassword_container").css("position","unset");
		$(".nopassword_container").css("width","100%");
		$(".nopassword_container").show();
		if(isOTP || isEOTP){
			$("#nextbtn").show();
		}else{
			return false;
		}
	}
	$("#password").focus();
	signinathmode="passwordauth";//no i18N
	if (isOTP && isEOTP){
		$("#enablemore").show();
		$('#enableforgot').hide();
	}else if(isOTP){
		$("#enableotpoption").show();
		emobile=deviceauthdetails.lookup.modes.otp.data[0].e_mobile;
		rmobile=deviceauthdetails.lookup.modes.otp.data[0].r_mobile;
	}else if(isEOTP){
		$("#enableotpoption").show();
		isEmailVerifyReqiured = deviceauthdetails.lookup.isUserName ? true : false;
		emobile=deviceauthdetails.lookup.modes.email.data[0].e_email;
		rmobile=deviceauthdetails.lookup.modes.email.data[0].email;
	}
	if(isSaml){//no i18N
		$("#enablesaml").show();
	}if (isFederated){
		$(".fed_2show").show();
		$(".fed_div").hide();
		$(".googleIcon").removeClass("google_small_icon");
		if(!isOTP && !isSaml){ $("#enableforgot").show()};
		var idps = deviceauthdetails.lookup.modes.federated.data;
		idps.forEach(function(idps){
			if(isValid(idps)){
				idp = idps.idp.toLowerCase();
				$("."+idp+"_fed").attr("style","display:block !important");
            }
		});
		if($(".apple_fed").is(":visible")){
			if(!isneedforGverify) {
				$(".apple_fed").hide();
				$("#macappleicon").show();
		    	$(".googleIcon").addClass("google_small_icon");
				return false;
			}
			$("#macappleicon").hide();
		}
		if((isNoPassword && isFederated) && (!isOTP && !isEOTP)){
			$("#password_container .textbox_div,#nextbtn").hide()
			$(".nopassword_container").css("position","absolute");
			$(".nopassword_container").show();
		}
	}if(!isNoPassword){
		$("#signinwithpass").show();
	}
	if(isJwt){
		$("#enablejwt").show();
		var redirectURI = deviceauthdetails.lookup.modes.jwt.redirect_uri;
		$(".signinwithjwt").attr("href",redirectURI);
	}
	if(isOTP && isSaml && !isNoPassword){
		$('#enablemore').show();
		$('#enableforgot').hide();
	}
	if($("#enablemore").is(":visible") || $("#enableotpoption").is(":visible")){
		$("#enableforgot").hide();
	}
	if($("#enableotpoption").is(":visible") && allowedmodes.indexOf("otp") != -1){
		$("#signinwithotp").html(I18N.get("IAM.NEW.SIGNIN.USING.MOBILE.OTP"));
	}else if(allowedmodes.indexOf("email") != -1){
		$("#signinwithotp").html(I18N.get("IAM.NEW.SIGNIN.USING.EMAIL.OTP"));
	}
	return false;
}
function enableSamlAuth(samlAuthDomain){
	var login_id = deviceauthdetails.lookup.loginid;
	samlAuthDomain = samlAuthDomain === undefined ? deviceauthdetails.lookup.modes.saml.data[0].auth_domain : samlAuthDomain;
	var loginurl="/signin/v2/"+callmode+"/"+zuid+"/samlauth/"+samlAuthDomain+"?";//no i18N
	loginurl += "digest="+digest+ "&" + signinParams; //no i18N
	var jsonData = {'samlauth':{'login_id':login_id }};//no i18N
	sendRequestWithTemptoken(loginurl,JSON.stringify(jsonData),true,handleSamlAuthdetails);
	return false;
}
function handleSamlAuthdetails(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		switchto(jsonStr.samlauth.redirect_uri);
	}else{
		showTopErrNotification(I18N.get("IAM.ERROR.GENERAL"));
		return false;
	}
}
function enableOTP(enablemode) {
	showAndGenerateOtp(enablemode);
	return false;
}
function enableMfaField(mfamode){
	callmode="secondary";//no i18N
	if(mfamode==="totp"){
		$("#password_container,#captcha_container,.fed_2show,#otp_container").hide();
		$("#headtitle").text(I18N.get("IAM.NEW.SIGNIN.TOTP"));
		$(".service_name").text(I18N.get("IAM.NEW.SIGNIN.MFA.TOTP.HEADER"));
		$(".product_text,.product_head,.MAppIcon,.OnaAuthHLink,.pwless_head,.pwless_text").hide();
		$("#product_img").removeClass($("#product_img").attr('class'));
		$("#product_img").addClass("tfa_totp_mode")
		$("#forgotpassword").hide();
		$("#nextbtn span").removeClass("zeroheight");
		$("#nextbtn").removeClass("changeloadbtn");
		$("#nextbtn").attr("disabled", false);
		$("#nextbtn span").text(I18N.get("IAM.VERIFY"));
		if(!isClientPortal){enableSplitField("mfa_totp",6,I18N.get("IAM.NEW.SIGNIN.VERIFY.CODE"))}
		$("#mfa_totp_container").show();
		$(".service_name").addClass("extramargin");
		if(isClientPortal){$('#mfa_totp').focus();}
		isFormSubmited = false;
		callmode="secondary";//no i18n
		goBackToProblemSignin();
		signinathmode = "totpsecauth";//No i18N
	}else if(mfamode==="otp"){//No i18N
		$("#password_container,#captcha_container,.fed_2show,#otp_container").hide();
		var isAMFA = deviceauthdetails[deviceauthdetails.resource_name].isAMFA;
		var headTitle = isAMFA ? I18N.get("IAM.AC.CHOOSE.OTHER_MODES.MOBILE.HEADING") : I18N.get("IAM.NEW.SIGNIN.SMS.MODE");
		$("#headtitle").text(headTitle);
		var descMsg = formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.HEADER"),rmobile);
		descMsg = isAMFA ? descMsg + formatMessage(I18N.get("IAM.NEW.SIGNIN.WHY.VERIFY"),suspisious_login_link) : descMsg;
		$(".service_name").html(descMsg);
		$("#product_img").removeClass($("#product_img").attr('class'));
		$("#product_img").addClass("tfa_otp_mode");
		showTopNotification(formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.SENT"),rmobile));
		if(!isClientPortal){enableSplitField("mfa_otp",7,I18N.get("IAM.NEW.SIGNIN.OTP"))}
		$("#mfa_otp_container,#mfa_otp_container .textbox_actions").show();//no i18N
		$("#forgotpassword").hide();
		$(".service_name").addClass("extramargin");
		$("#nextbtn span").removeClass("zeroheight");
		$("#nextbtn").removeClass("changeloadbtn");
		$("#nextbtn").attr("disabled", false);
		$("#nextbtn span").text(I18N.get("IAM.VERIFY"));
		if(isClientPortal){ $('#mfa_otp').focus();}
		isFormSubmited = false;
		goBackToProblemSignin();
		callmode="secondary";//no i18n
		signinathmode = "otpsecauth";//No i18N
	}
	$(".loader,.blur").hide();
	if (!isRecovery) {allowedModeChecking();}
	return false;
}
function enableMyZohoDevice(jsonStr,trymode)
{
	jsonStr = isValid(jsonStr) ? jsonStr : deviceauthdetails;
	signinathmode = jsonStr.resource_name;
	var devicedetails = jsonStr[signinathmode].modes.mzadevice.data[parseInt(mzadevicepos)];
	deviceid= devicedetails.device_id;
	isSecondary = allowedmodes.length > 1  && (allowedmodes.indexOf("recoverycode") === -1 && allowedmodes.indexOf("passphrase") === -1 )? true : false;
	isSecondary = (allowedmodes.length > 2 && allowedmodes.indexOf("recoverycode") === -1 && allowedmodes.indexOf("passphrase") === -1) ? true : isSecondary; // no i18n
	isSecondary = (allowedmodes.indexOf("recoverycode") === -1 && allowedmodes.indexOf("passphrase") === -1) && allowedmodes.length === 3 ? false : isSecondary;
	prefoption = trymode ? trymode : devicedetails.prefer_option;
	devicename = devicedetails.device_name;
	bioType = devicedetails.bio_type;
	var loginurl="/signin/v2/"+callmode+"/"+zuid+"/device/"+deviceid+"?";//no i18N
	loginurl += "digest="+digest+ "&" + signinParams; //no i18N
	var isAMFA = deviceauthdetails[deviceauthdetails.resource_name].isAMFA
	var jsonData = callmode==="primary" ? {'deviceauth':{'devicepref':prefoption }}: {'devicesecauth':{'devicepref':prefoption }};//no i18N
	jsonData =  callmode !="primary" && isAMFA ? {'devicesecauth':{'devicepref':prefoption, 'isAMFA' : true }}  : jsonData; // no i18n
	sendRequestWithTemptoken(loginurl,JSON.stringify(jsonData),true,handleMyZohoDetails);
	signinathmode = callmode==="primary" ?"deviceauth":"devicesecauth";//no i18N
	return false;
}function enableOneauthDevice(jsonStr,index){
	index = isValid(index) ? index : parseInt(oadevicepos);
	jsonStr = isValid(jsonStr) ? jsonStr : deviceauthdetails;
	var devicedetails = jsonStr[deviceauthdetails.resource_name].modes.oadevice.data[index];
	deviceid= devicedetails.device_id;
	prefoption = devicedetails.prefer_option;
	isFaceId =devicedetails.isFaceid;
	devicename = devicedetails.device_name;
	if(prefoption==="ONEAUTH_TOTP"){
		enableTOTPdevice(jsonStr,false,true);
		return false;
	}
	var loginurl="/signin/v2/"+callmode+"/"+zuid+"/oneauth/"+deviceid+"?";//no i18N
	loginurl += "digest="+digest+ "&" + signinParams; //no i18N
	var jsonData = {'oneauthsec':{'devicepref':prefoption }};//no i18N
	sendRequestWithTemptoken(loginurl,JSON.stringify(jsonData),true,handleOneAuthDetails);
	signinathmode = "oneauthsec";//no i18N
	return false;
}
function enableYubikeyDevice(jsonStr){
	signinathmode = jsonStr.resource_name;
	if(!isWebAuthNSupported()){
		showTopErrNotification(I18N.get("IAM.WEBAUTHN.ERROR.BrowserNotSupported"));
		return false;
	}
	var loginurl="/signin/v2/"+callmode+"/"+zuid+"/yubikey/self?"+signinParams;//no i18n
	isSecondary =  allowedmodes.length >1 && allowedmodes.indexOf("recoverycode") === -1 ? true : false; // no i18n
	sendRequestWithTemptoken(loginurl,"",true,handleYubikeyDetails);
	signinathmode = "yubikeysecauth";//no i18n
	if (!isRecovery) {allowedModeChecking();}
	return false;
}
function enableTOTPdevice(resp,isMyZohoApp,isOneAuth){
	$("#password_container,#login_id_container,#captcha_container,.fed_2show,#otp_container").hide();
	$("#headtitle").text(I18N.get("IAM.NEW.SIGNIN.TOTP"));
	$(".service_name").text(I18N.get("IAM.NEW.SIGNIN.MFA.TOTP.HEADER"));
	$(".product_text,.product_head,.MAppIcon,.OnaAuthHLink,.pwless_head,.pwless_text").hide();
	$("#product_img").removeClass($("#product_img").attr('class'));
	$("#product_img").addClass("tfa_totp_mode");
	$("#forgotpassword").hide();
	$("#nextbtn span").removeClass("zeroheight");
	$("#nextbtn").removeClass("changeloadbtn");
	$("#nextbtn").attr("disabled", false);
	$("#nextbtn span").text(I18N.get("IAM.VERIFY"));
	if(isMyZohoApp){
		$(".deviceparent .devicetext").text(devicename);
		$(".devicedetails .devicetext").text(devicename);
		$("#mfa_device_container").show();
		$(".tryanother").show();
		var isAMFA = deviceauthdetails[deviceauthdetails.resource_name].isAMFA;
		if(isAMFA){
			allowedModeChecking();
			$(".tryanother").hide()
		}
		$(".service_name").text(I18N.get("IAM.NEW.SIGNIN.TOTP.HEADER"));
		$("#problemsignin,#recoverybtn,.loader,.blur,.deviceparent").hide();
		clearCommonError("mfa_totp"); // no i18n
		$('.signin_container').removeClass('mobile_signincontainer');
	}	
	else if(isOneAuth){ $(".service_name").text(I18N.get("IAM.NEW.SIGNIN.TOTP.HEADER"));}
	if(!isClientPortal){enableSplitField("mfa_totp",6,I18N.get("IAM.NEW.SIGNIN.VERIFY.CODE"))}
	$("#mfa_totp_container").show();
	if(isClientPortal){$("#mfa_totp").focus();}
	$(".service_name").addClass("extramargin");
	$('#mfa_totp').val("");
	isFormSubmited = false;
	var mzauth = callmode==="primary" ?"deviceauth":"devicesecauth";//no i18N
	signinathmode = isMyZohoApp ? mzauth : "oneauthsec";//No i18N
	if(!isMyZohoApp && !isRecovery){allowedModeChecking()};
	return false;
}
function enableOneAuthBackup(){
	changeRecoverOption(allowedmodes[0]);
	$('#backup_container .backoption,#recovery_passphrase,#recovery_backup').hide();
	allowedmodes.indexOf("passphrase") != -1 ? $('#recovery_passphrase').show() : $('#recovery_passphrase').hide();
	allowedmodes.indexOf("recoverycode") != -1 ? $('#recovery_backup').show() : $('#recovery_backup').hide();
} // no i18n
function handleYubikeyDetails(resp){ // no i18n
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp); // no i18n
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			var successCode = jsonStr.code;
			if(successCode==="SI203"){
				$(".loader,.blur").hide();
			   	showYubikeyDetails();
			   	getAssertion(jsonStr.yubikeysecauth);
			}	
		}
		else{
			if(jsonStr.cause==="throttles_limit_exceeded"){
				showCommonError("yubikey",jsonStr.localized_message); //no i18n
				return false;
			}
			showCommonError("password",jsonStr.localized_message); //no i18n
			return false;
		}
		return false;
	   	
	}else{
		 var errorcontainer = signinathmode ==="passwordauth"? "password":"login_id";//no i18n
		 showCommonError(errorcontainer,I18N.get(jsonStr.localized_message)); //no i18n
		return false;	
	}
	return false;
}

function getAssertion(parameters) {
	var requestOptions = {};
	requestOptions.challenge = strToBin(parameters.challenge);
	requestOptions.timeout = parameters.timeout;
	requestOptions.rpId = parameters.rpId;
	requestOptions.allowCredentials = credentialListConversion(parameters.allowCredentials);
	if ('authenticatorSelection' in parameters) {
      requestOptions.authenticatorSelection = parameters.authenticatorSelection;
    }
	requestOptions.extensions = {};
	if ('extensions' in parameters) {
		if ('appid' in parameters.extensions) {
			requestOptions.extensions.appid = parameters.extensions.appid;
		}
	}
	/*Yubikey sigin issue on android mobile issue temporary fix
	requestOptions.extensions.uvm = true;*/
	return navigator.credentials.get({
		"publicKey": requestOptions //No I18N
	}).then(function(assertion) {
	    var publicKeyCredential = {};
	    if ('id' in assertion) {
	      publicKeyCredential.id = assertion.id;
	    }
	    if ('type' in assertion) {
	      publicKeyCredential.type = assertion.type;
	    }
	    if ('rawId' in assertion) {
	      publicKeyCredential.rawId = binToStr(assertion.rawId);
	    }
	    if (!assertion.response) {
			showCommonError("yubikey",formatMessage(I18N.get("IAM.WEBAUTHN.ERROR.AUTHENTICATION.InvalidResponse"),accounts_support_contact_email_id)); //no i18n
			$("#yubikey_container").show();
			showError();
	    }
	    /*Yubikey sigin issue on android mobile issue temporary fix
	    if (assertion.getClientExtensionResults) {
	      if (assertion.getClientExtensionResults().uvm != null) {
	        publicKeyCredential.uvm = serializeUvm(assertion.getClientExtensionResults().uvm);
	      }
	    }
        */
	    var _response = assertion.response;

	    publicKeyCredential.response = {
	      clientDataJSON:     binToStr(_response.clientDataJSON),
	      authenticatorData:  binToStr(_response.authenticatorData),
	      signature:          binToStr(_response.signature),
	      userHandle:         binToStr(_response.userHandle)
	    };
	     var yubikey_sec_data ={};
	     yubikey_sec_data.yubikeysecauth = publicKeyCredential;
	     sendRequestWithTemptoken("/signin/v2/secondary/"+zuid+"/yubikey/self",JSON.stringify(yubikey_sec_data),true,VerifySuccess,"PUT");//no i18N
	}).catch(function(err) {
		if(err.name == 'NotAllowedError') {
			showCommonError("yubikey",I18N.get("IAM.WEBAUTHN.ERROR.NotAllowedError")); //no i18n	
		} else if(err.name == 'InvalidStateError') {
			showCommonError("yubikey",I18N.get("IAM.WEBAUTHN.ERROR.AUTHENTICATION.InvalidStateError")); //no i18n	
		} else if (err.name == 'AbortError') {
			showCommonError("yubikey",I18N.get("IAM.WEBAUTHN.ERROR.AbortError")); //no i18n
		} else if(err.name == 'UnknownError') {
			showCommonError("yubikey",formatMessage(I18N.get("IAM.WEBAUTHN.ERROR.UnknownError"), accounts_support_contact_email_id)); //no i18n
		} else {
			showCommonError("yubikey",formatMessage(I18N.get("IAM.WEBAUTHN.ERROR.AUTHENTICATION.ErrorOccurred"),accounts_support_contact_email_id)+ '<br>' +err.toString()); //no i18n
		}
		$("#yubikey_container").show();
		showError();
	});
}

function showYubikeyDetails(){
	var headtitle="IAM.NEW.SIGNIN.YUBIKEY.TITLE";//no i18n
	var headerdesc= isMobile?"IAM.NEW.SIGNIN.YUBIKEY.HEADER.NEW.FOR.MOBILE":"IAM.NEW.SIGNIN.YUBIKEY.HEADER.NEW";//no i18n
	$("#password_container,#login_id_container,#captcha_container,.fed_2show,#otp_container").hide();
	$("#headtitle").text(I18N.get(headtitle));
	$(".service_name").text(I18N.get(headerdesc));
	$(".product_text,.product_head,.MAppIcon,.OnaAuthHLink,.pwless_head,.pwless_text").hide();
	$("#product_img").removeClass($("#product_img").attr('class'));
	$("#product_img").addClass("tfa_yubikey_mode");
	$("#forgotpassword").hide();
	$("#nextbtn").hide();
	$(".service_name").addClass("extramargin");
	$('.deviceparent').removeClass('hide');
	$('.deviceparent').css('display','');
	$("#mfa_device_container,.devicedetails").show();
	$(".devices .selection").hide();
	$("#waitbtn").show();
	$(".loadwithbtn").show();
	$(".waitbtn .waittext").text(I18N.get("IAM.NEW.SIGNIN.WAITING.APPROVAL"));
	$("#waitbtn").attr("disabled", true);
	if (!isRecovery) {allowedModeChecking();}
	return false;
}
function handleLookupDetails(resp,isExtUserVerified,ispasskeyfailed){
	if($(".blur,.loader").is(":visible")){
		$(".blur,.loader").hide();	
	}
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if(isClientPortal && jsonStr.code==="U300"){
			if(isValid(jsonStr.lookup.signup_url)){
				var form = document.createElement("form");
				form.setAttribute("id", "signupredirection");
				form.setAttribute("method", "POST");
			    form.setAttribute("action", jsonStr.lookup.signup_url);
			    form.setAttribute("target", "_self");
				var hiddenField = document.createElement("input");
				var csrfField = document.createElement("input");				
				
				csrfField.setAttribute("type", "hidden");
				csrfField.setAttribute("name", csrfParam);
				csrfField.setAttribute("value", getCookie(csrfCookieName));
		        
				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", "LOGIN_ID");
				hiddenField.setAttribute("value", jsonStr.lookup.loginid ); 
				
				form.appendChild(hiddenField);
				form.appendChild(csrfField);
			   	document.documentElement.appendChild(form);
			  	form.submit();
			  	return false;
			}
			return false;
		}
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) { 
			$(".fed_2show,.line,#signuplink,.banner_newtoold").hide();
			$("#smartsigninbtn").addClass("hide");
			digest = jsonStr[signinathmode].digest;
			zuid = jsonStr[signinathmode].identifier;
			if(isPhoneNumber(de("login_id").value)){
				$('#login_id').val($("#country_code_select").val().split('+')[1]+ "-" + $('#login_id').val());
			}
			deviceauthdetails=jsonStr;
			if(!isExtUserVerified){
				if(jsonStr[signinathmode].ext_usr){
	                $("#forgotpassword,#nextbtn").hide();
					var loginId = jsonStr[signinathmode].loginid?jsonStr[signinathmode].loginid:de("login_id").value;//no i18n
					$("#login_id_container,#showIDPs").slideUp(200);
					$("#password_container").removeClass("zeroheight");
					$("#password_container").slideDown(200);
					$('.username').text(identifyEmailOrNum());
					$("#password_container .textbox_div").hide();
					$(".externaluser_container").html(jsonStr[signinathmode].ext_msg);
					$(".externaluser_container,#continuebtn").show();
					return false;
				}
			}else{
				$(".externaluser_container,#continuebtn").hide();
				$("#forgotpassword,#nextbtn").show();
				$("#login_id_container,#showIDPs").slideDown(200);
				$("#password_container").addClass("zeroheight");
				$("#password_container .textbox_div").show();
			}
			adminEmail = jsonStr[signinathmode].admin;
			var isOTP = isSaml = isFederated = isNoPassword = isJwt = isEOTP = false;
			if(isEmpty(jsonStr[signinathmode].modes) || !isValid(jsonStr[signinathmode].modes)){
                changeButtonAction(I18N.get('IAM.SIGNIN'),false);//no i18n
                $("#forgotpassword").hide();
				var loginId = jsonStr[signinathmode].loginid?jsonStr[signinathmode].loginid:de("login_id").value;//no i18n
				$("#login_id_container,#showIDPs").slideUp(200);
				$("#password_container").removeClass("zeroheight");
				$("#password_container").slideDown(200);
				identifyEmailOrNum(loginId);
				$('.username').text(identifyEmailOrNum());
				$("#password_container .textbox_div,#nextbtn").hide()
				$(".nopassword_container").css("position","absolute");
				$(".nopassword_container").show();
				$("#captcha_container").hide();
				return false;
			}
			isPrimaryMode =  true;
			allowedmodes = jsonStr[signinathmode].modes.allowed_modes;
			prev_showmode = allowedmodes[0];
			var altmode = allowedmodes[1];
			var isothermodeavailable = typeof altmode != "undefined";//no i18n
			isNoPassword = true;
			$(".otp_actions .signinwithjwt,.otp_actions .signinwithsaml,.otp_actions .showmoresigininoption").hide();
			if(ispasskeyfailed){
				allowedmodes.splice(allowedmodes.indexOf("passkey"), 1);
				isPasswordless=false;
			} 
			isEmailVerifyReqiured = jsonStr[signinathmode].isUserName && allowedmodes.indexOf("email") != -1 ? true : false;
			if(allowedmodes[0]==="passkey"){
				if(!isWebAuthNSupported()) {
					showTopErrNotification(I18N.get("IAM.WEBAUTHN.ERROR.BrowserNotSupported"));
					changeButtonAction(I18N.get("IAM.NEXT"),false);
					return false;
				}
				isPasswordless=true;
				enableWebauthnDevice();
			} else if( allowedmodes[0] === "password" || allowedmodes[0] === "federated"){
				if(isothermodeavailable){
					var samlcount = jsonStr[signinathmode].modes && jsonStr[signinathmode].modes.saml && jsonStr[signinathmode].modes && jsonStr[signinathmode].modes.saml.count;
					if((allowedmodes.indexOf("otp") != -1 && allowedmodes.indexOf("saml") != -1) || (samlcount > 1)){
						$('#enablemore').show();
						$('#enableforgot').hide();
					}else if(allowedmodes.indexOf("otp") != -1 && allowedmodes.indexOf("jwt") != -1){
						$('#enablemore').show();
						$('#enableforgot').hide();
					}
					else if(allowedmodes.indexOf("otp") != -1 && allowedmodes.indexOf("email") != -1){
						$('#enablemore').show();
						$('#enableforgot').hide();
					}
					else if(allowedmodes.indexOf("saml") != -1 && allowedmodes.indexOf("email") != -1){
						$('#enablemore').show();
						$('#enableforgot').hide();
					}
					else if(allowedmodes.length >= 2){
						allowedmodes.forEach(function(usedmodes){
							switch(usedmodes){
								case "otp": //no i18n
									isOTP = true;
									break;
								case "saml": //no i18n
									isSaml = true;
									break;
								case "jwt": //no i18n
									isJwt = true;
									break;
								case "federated": //no i18n
									isFederated =true;
									break;
								case "password": //no i18n
									isNoPassword = false;
									break;
								case "email": //no i18n
									isEOTP = true;
							}
						});
						enablePassword(jsonStr[signinathmode].loginid,isOTP, isSaml, isFederated,isNoPassword,isJwt,isEOTP);
						if($("#enablemore").is(":visible") || $("#enableotpoption").is(":visible")){
							$("#enableforgot").hide();
						}
						return false;
					}
					
				}else{
					if(allowedmodes[0]==="federated"){
						isFederated =true;
						isNoPassword = true;
					}
					$("#enableforgot").show();
				}
				enablePassword(deviceauthdetails.lookup.loginid,isOTP, isSaml, isFederated,isNoPassword,isJwt,isEOTP);
				return false;
			}else if( allowedmodes[0] === "otp" || allowedmodes[0] === "email" ){
				emobile = allowedmodes[0] === "otp" ? jsonStr[signinathmode].modes.otp.data[0].e_mobile : jsonStr[signinathmode].modes.email.data[0].e_email;
				rmobile = allowedmodes[0] === "otp" ? jsonStr[signinathmode].modes.otp.data[0].r_mobile : jsonStr[signinathmode].modes.email.data[0].email;
				$('#signinwithpass').hide();
				isNoPassword = true;
				if(allowedmodes.length >= 2){
					allowedmodes.forEach(function(usedmodes){
						switch(usedmodes){
							case "otp": //no i18n
								isOTP = true;
								break;
							case "password": //no i18n
								isNoPassword = false;
								break;
							case "saml": //no i18n
								isSaml = true;
								break;
							case "jwt": //no i18n
								isJwt = true;
								break;
							case "federated": //no i18n
								isFederated =true;
								break;
							case "email": //no i18n
								isEOTP = true;
						}
					});
				}
				enablePassword(jsonStr[signinathmode].loginid,isOTP, isSaml, isFederated,isNoPassword,isJwt,isEOTP);
				$(".otp_actions .signinwithjwt,.otp_actions .signinwithsaml,.otp_actions .showmoresigininoption").hide();
				enableOTP(allowedmodes[0]);
				if(isSaml){//no i18N
					$("#enablesaml").show();
				}
				return false;
			}else if(allowedmodes[0]==="mzadevice"){
				isPasswordless=true;
				secondarymodes = allowedmodes;
				enableMyZohoDevice(jsonStr);
				handleSecondaryDevices(allowedmodes[0]);
				return false;
			}else if(allowedmodes[0]==="saml"){
				var isMoreSaml = jsonStr[signinathmode].modes.saml.count > 1;
				if(isMoreSaml){
					$("#login_id_container,#showIDPs").slideUp(200);
					showmoresigininoption(isMoreSaml);
					$(".backoption,#forgotpassword").hide();
				}else if(allowedmodes.length > 1){
					enableSamlAuth();
				}else{
					var redirecturi = jsonStr[signinathmode].modes.saml.data[0].redirect_uri;
					switchto(redirecturi);
				}
				return false;
			}else if(allowedmodes[0]==="jwt"){
				var redirecturi = jsonStr[signinathmode].modes.jwt.redirect_uri;
				switchto(redirecturi);
				return false;
			}			
		}else{
			if(jsonStr.cause==="throttles_limit_exceeded"){
				callback_signin_lookup(jsonStr.localized_message);
				return false;
			}
			var error_resp = jsonStr.errors[0];
			var errorCode=error_resp.code;
			var errorMessage = jsonStr.localized_message;
			if(errorCode === "U400"){ //no i18N
				var loginid = jsonStr.data.loginid;
		    	if(loginid && (isEmailId(loginid) || isUserName(loginid)) || isPhoneNumber(loginid.split('-')[1])){
		    		var deploymentUrl = jsonStr.data.redirect_uri;
			    	var signinParams = removeParamFromQueryString("LOGIN_ID");//No I18N
			    	var loginurl = deploymentUrl+"/signin?" + signinParams; //no i18n
		    		var oldForm = document.getElementById("signinredirection");
		    		if(oldForm) {
		    			document.documentElement.removeChild(oldForm);
		    		}
		    		var form = document.createElement("form");
		    		form.setAttribute("id", "signinredirection");
		    		form.setAttribute("method", "POST");
		    	    form.setAttribute("action", loginurl);
		    	    form.setAttribute("target", "_parent");
		    	    	    		
		    		var hiddenField = document.createElement("input");
		    		hiddenField.setAttribute("type", "hidden");
		    		hiddenField.setAttribute("name", "LOGIN_ID");
		    		hiddenField.setAttribute("value", loginid); 
		    		form.appendChild(hiddenField);
		            
		    		
		    	   	document.documentElement.appendChild(form);
		    	  	form.submit();
		    	  	return false;
		    	}
		    	return false;
			}else if(errorCode==="U201"){ //no i18n
				switchto(error_resp.redirect_uri);
				return false;
			}
			else if(errorCode==="IN107" || errorCode === "IN108"){
				$(".fed_2show,.line").hide();
				cdigest=jsonStr.cdigest;
				showHip(cdigest); //no i18N 
				showCaptcha(I18N.get("IAM.NEXT"),false,"login_id");//no i18N
				if( errorCode === "IN107"){
					showCommonError("captcha",errorMessage); //no i18n	
				}
				return false;
			}
			else if(errorCode === "U401"){ //no i18N
				callback_signin_lookup(errorMessage);
				return false;
			}else if(errorCode === "R303"){ //no i18N
				showRestrictsignin();
				return false;
			}else if(errorCode === "U404"	&&  canShowResetIP=='true'){ //no i18N
				hiderightpanel();
				$("#login,.fed_2show,.line").hide();
				var LOGIN_ID = de('login_id').value.trim(); // no i18n
				LOGIN_ID = ($(".showcountry_code").is(":visible") || $("#country_code_select").is(":visible") ) ? $( "#country_code_select" ).val().split("+")[1]+'-'+LOGIN_ID : LOGIN_ID;
				LOGIN_ID = isPhoneNumber(LOGIN_ID.split('-')[1]) ? LOGIN_ID.split('-')[0].trim() + "-" + LOGIN_ID.split('-')[1].trim() : LOGIN_ID;
				$('.resetIP_container .username').text(identifyEmailOrNum(LOGIN_ID));
				$(".resetIP_container,#goto_resetIP").show();
				if($("#smartsigninbtn").length==1)
				{
					$("#smartsigninbtn").addClass("hide");
				}
				$("#signuplink").hide();
			}else{
				callback_signin_lookup(errorMessage);
				return false;
			}
		}
	}else {
		callback_signin_lookup(I18N.get("IAM.ERROR.GENERAL"));
		return false;
	}
	return false;
}
function enableWebauthnDevice(){
	if(!isWebAuthNSupported()){
		showTopErrNotification(I18N.get("IAM.WEBAUTHN.ERROR.BrowserNotSupported"));
		return false;
	}
	var loginurl = uriPrefix + "/signin/v2/primary/"+zuid+"/passkey/self?";// : "/signin/v2/"+callmode+"/"+zuid+"/webauthn?";//no i18N
	loginurl += "digest="+digest+ "&" + signinParams; //no i18N
	sendRequestWithCallback(loginurl,"",true,handleWebauthnDevice);
	return false;
}
function handleWebauthnDevice(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			var successCode = jsonStr.code;
			if(successCode==="SI203"){
				getAssertionLookup(jsonStr.passkeyauth);
			}	
		}
		else{
			if(jsonStr.cause==="throttles_limit_exceeded"){
				showCommonError("yubikey",jsonStr.localized_message); //no i18n
				return false;
			}
			showCommonError("password",jsonStr.localized_message); //no i18n
			return false;
		}
		return false;
	   	
	}else{
		 var errorcontainer = signinathmode ==="passwordauth"? "password":"login_id";//no i18n
		 showCommonError(errorcontainer,I18N.get(jsonStr.localized_message));
		return false;	
	}
	return false;
}
function getAssertionLookup(parameters) {
	var requestOptions = {};
	requestOptions.challenge = strToBin(parameters.challenge);
	requestOptions.timeout = parameters.timeout;
	requestOptions.rpId = parameters.rpId;
	requestOptions.allowCredentials = credentialListConversion(parameters.allowCredentials);
	if ('authenticatorSelection' in parameters) {
      requestOptions.authenticatorSelection = parameters.authenticatorSelection;
    }
	requestOptions.extensions = {};
	if ('extensions' in parameters) {
		if ('appid' in parameters.extensions) {
			requestOptions.extensions.appid = parameters.extensions.appid;
		}
	}
	/*Yubikey sigin issue on android mobile issue temporary fix
	requestOptions.extensions.uvm = true;*/
	return navigator.credentials.get({
		"publicKey": requestOptions //No I18N
	}).then(function(assertion) {
	    var publicKeyCredential = {};
	    if ('id' in assertion) {
	      publicKeyCredential.id = assertion.id;
	    }
	    if ('type' in assertion) {
	      publicKeyCredential.type = assertion.type;
	    }
	    if ('rawId' in assertion) {
	      publicKeyCredential.rawId = binToStr(assertion.rawId);
	    }
	    if (!assertion.response) {
	    	showTopErrNotification(formatMessage(I18N.get("IAM.WEBAUTHN.ERROR.AUTHENTICATION.PASSKEY.InvalidResponse"),accounts_support_contact_email_id));
	    	signinathmode = "lookup"; // no i18n
	    	handleLookupDetails(JSON.stringify(deviceauthdetails), false,true);
	    }
	    /*Yubikey sigin issue on android mobile issue temporary fix
	    if (assertion.getClientExtensionResults) {
	      if (assertion.getClientExtensionResults().uvm != null) {
	        publicKeyCredential.uvm = serializeUvm(assertion.getClientExtensionResults().uvm);
	      }
	    }
        */
	    var _response = assertion.response;

	    publicKeyCredential.response = {
	      clientDataJSON:     binToStr(_response.clientDataJSON),
	      authenticatorData:  binToStr(_response.authenticatorData),
	      signature:          binToStr(_response.signature),
	      userHandle:         binToStr(_response.userHandle)
	    };
	     var passkey_data ={};
	     passkey_data.passkeyauth = publicKeyCredential;
	     sendRequestWithTemptoken("/signin/v2/primary/"+zuid+"/passkey/self?"+"digest="+digest+ "&" + signinParams,JSON.stringify(passkey_data),true,VerifySuccess,"PUT");//no i18N
	}).catch(function(err) {
		if(err.name == 'NotAllowedError') {
			showTopErrNotification(I18N.get("IAM.WEBAUTHN.ERROR.NotAllowedError")); //no i18n	
			signinathmode = "lookup"; // no i18n
			handleLookupDetails(JSON.stringify(deviceauthdetails), false,true);
		} else if(err.name == 'InvalidStateError') {
			showTopErrNotification(I18N.get("IAM.WEBAUTHN.ERROR.AUTHENTICATION.PASSKEY.InvalidStateError")); //no i18n	
			signinathmode = "lookup"; // no i18n
			handleLookupDetails(JSON.stringify(deviceauthdetails), false,true);
		} else if (err.name == 'AbortError') {
			showTopErrNotification(I18N.get("IAM.WEBAUTHN.ERROR.AbortError")); //no i18n
			signinathmode = "lookup"; // no i18n
			handleLookupDetails(JSON.stringify(deviceauthdetails), false,true);
		} else if (err.name == 'TypeError') {
			showTopErrNotificationStatic(I18N.get("IAM.WEBAUTHN.ERROR.TYPE.ERROR"),formatMessage(I18N.get("IAM.WEBAUTHN.ERROR.HELP.HOWTO"),passkeyURL)); //no i18n
			signinathmode = "lookup"; // no i18n
			handleLookupDetails(JSON.stringify(deviceauthdetails), false,true);
		} else {
			showTopErrNotification(formatMessage(I18N.get("IAM.WEBAUTHN.ERROR.AUTHENTICATION.PASSKEY.ErrorOccurred"),accounts_support_contact_email_id)+ '<br>' +err.toString()); //no i18n
			signinathmode = "lookup"; // no i18n
			handleLookupDetails(JSON.stringify(deviceauthdetails), false,true);
		}
	});
}
function showmoresigininoption(isMoreSaml){
	if(isPasswordless){
		if($("#password").is(":visible")){prev_showmode="password"}
		$("#enableoptionsoneauth").is(":visible") ? $("#enableoptionsoneauth").hide() : $("#enableoptionsoneauth").show();
		allowedmodes.indexOf("password") != -1 && prev_showmode != "password" ? $("#signinwithpassoneauth").css("display","block") : $("#signinwithpassoneauth").hide(); // no i18n
		allowedmodes.indexOf("otp") != -1 && prev_showmode != "otp" ? $("#signinwithotponeauth").css("display","block") : $("#signinwithotponeauth").hide(); // no i18n
		allowedmodes.indexOf("email") != -1 && prev_showmode != "email" ? $("#passlessemailverify").css("display","block") : $("#passlessemailverify").hide(); // no i18n
		allowedmodes.indexOf("saml") != -1 && prev_showmode != "saml" ? $(".signinwithsamloneauth").css("display","block") : $(".signinwithsamloneauth").hide(); // no i18n
		allowedmodes.indexOf("jwt") != -1 && prev_showmode != "jwt" ? $(".signinwithfedoneauth").css("display","block") : $(".signinwithfedoneauth").hide(); // no i18n
		allowedmodes.indexOf("federated") != -1 && prev_showmode != "federated" ? $(".signinwithfedoneauth").css("display","block") : $(".signinwithfedoneauth").hide(); // no i18n
		allowedmodes.indexOf("otp") != -1 ? $("#signinwithotponeauth").html(formatMessage(I18N.get("IAM.NEW.SIGNIN.PASSWORDLESS.OTP.VERIFY.TITLE"),deviceauthdetails[deviceauthdetails.resource_name].modes.otp.data[0].r_mobile)) : "";
		allowedmodes.indexOf("email") != -1 ? $("#passlessemailverify").html(formatMessage(I18N.get("IAM.NEW.SIGNIN.PASSWORDLESS.EMAIL.VERIFY.TITLE"),deviceauthdetails[deviceauthdetails.resource_name].modes.email.data[0].email)) : "";
		if($("#enableoptionsoneauth").is(":visible")){
			setTimeout(function(){document.getElementsByClassName("signin_container")[0].addEventListener('click',function hideandforgetEnableoption(){
				$('#enableoptionsoneauth').hide();
				document.getElementsByClassName("signin_container")[0].removeEventListener('click',hideandforgetEnableoption)// no i18n
			})},10)
			}
		
		return false;
	}
	$('#enablemore').hide();
	if(!isMoreSaml){
		allowedmodes.splice(allowedmodes.indexOf(prev_showmode), 1);
		allowedmodes.unshift(prev_showmode);
	}
	$("#emailverify_container").hide();
	$("#login").show();
	var problemsignin_con = "";
	var backoption = isMoreSaml === "getbackemailverify" ? "getbackemailverify()" : "hideSigninOptions()";  // no i18n
	var i18n_msg = {"otp":["IAM.NEW.SIGNIN.OTP.TITLE","IAM.NEW.SIGNIN.OTP.HEADER"],"saml":["IAM.NEW.SIGNIN.SAML.TITLE","IAM.NEW.SIGNIN.SAML.HEADER"], "password":["IAM.NEW.SIGNIN.PASSWORD.TITLE","IAM.NEW.SIGNIN.PASSWORD.HEADER"],"jwt":["IAM.NEW.SIGNIN.JWT.TITLE","IAM.NEW.SIGNIN.SAML.HEADER"],"email":["IAM.NEW.SIGNIN.EMAIL.TITLE","IAM.NEW.SIGNIN.OTP.HEADER"]}; //No I18N
	var problemsigninheader = "<div class='problemsignin_head'><span class='icon-backarrow backoption' onclick='"+backoption+"'></span>"+I18N.get("IAM.NEW.SIGNIN.CHOOSE.OTHER.WAY")+"</div>";
	allowedmodes.forEach(function(prob_mode,position){
		if((position != 0) || isMoreSaml){
				var saml_position;
				var secondary_header = i18n_msg[prob_mode] ?  I18N.get(i18n_msg[prob_mode][0]) : "";
				var secondary_desc = i18n_msg[prob_mode] ?  I18N.get(i18n_msg[prob_mode][1]) : "";
				if(prob_mode==="otp"){
					emobile=deviceauthdetails.lookup.modes.otp.data[0].e_mobile;
					rmobile=deviceauthdetails.lookup.modes.otp.data[0].r_mobile;
					secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),rmobile);
					problemsignin_con += createSigninMoreOptions(prob_mode,saml_position,secondary_header,secondary_desc);
				}
				else if(prob_mode==="saml"){
					var saml_modes = deviceauthdetails.lookup.modes.saml.data;
					saml_modes.forEach(function(data,index){
						var displayname = deviceauthdetails.lookup.modes.saml.data[index].display_name;
						var domainname = deviceauthdetails.lookup.modes.saml.data[index].domain;
						secondary_header = formatMessage(I18N.get(i18n_msg[prob_mode][0]),displayname);
						secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),domainname);
						saml_position = index;
						problemsignin_con += createSigninMoreOptions(prob_mode,saml_position,secondary_header,secondary_desc);
					});
				}
				else if(prob_mode==="jwt"){
					var domainname = deviceauthdetails.lookup.modes.jwt.domain;
					secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),domainname);
					problemsignin_con += createSigninMoreOptions(prob_mode,saml_position,secondary_header,secondary_desc);
				}
				else if(prob_mode==="email"){
					emobile=deviceauthdetails.lookup.modes.email.data[0].e_email;
					rmobile=deviceauthdetails.lookup.modes.email.data[0].email;
					secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),rmobile);
					problemsignin_con += createSigninMoreOptions(prob_mode,saml_position,secondary_header,secondary_desc);
				}
				else if(prob_mode==="federated"){ // no i18n
					var count = deviceauthdetails.lookup.modes.federated.count;
					var idp = deviceauthdetails.lookup.modes.federated.data[0].idp.toLocaleLowerCase();
					var secondary_header = count > 1 ? I18N.get("IAM.NEW.SIGNIN.MORE.FEDRATED.ACCOUNTS.TITLE") : "<span style='text-transform: capitalize;'>"+idp+"</span>";
					var secondary_desc =  count > 1 ? I18N.get("IAM.NEW.SIGNIN.MORE.FEDRATED.ACCOUNTS.DESC") : formatMessage(I18N.get("IAM.NEW.SIGNIN.IDENTITY.PROVIDER.TITLE"),idp);
					problemsignin_con += createSigninMoreOptions(prob_mode,count,secondary_header,secondary_desc);
				}
				else{
					problemsignin_con += createSigninMoreOptions(prob_mode,saml_position,secondary_header,secondary_desc);
				}
		}
	});
	$('#problemsigninui').html(problemsigninheader +"<div class='problemsignincon'>"+ problemsignin_con+"</div>");
	$('#password_container,#nextbtn,.signin_head,#otp_container,#captcha_container,.fed_2show').hide();
	$('#problemsigninui').show();
	return false;
}
function createSigninMoreOptions(prob_mode,saml_position,secondary_header,secondary_desc){
	var prefer_icon =  prob_mode; // no i18n
	var secondary_con = "<div class='optionstry options_hover' id='secondary_"+prob_mode+"' onclick=showallowedmodes('"+prob_mode+"','"+saml_position+"')>\
							<div class='img_option_try img_option icon-"+prefer_icon+"'></div>\
							<div class='option_details_try decreasewidth'>\
								<div class='option_title_try'>"+secondary_header+"</div>\
								<div class='option_description'>"+secondary_desc+"</div>\
							</div>\
						</div>"
	return secondary_con;
}
function handlePasswordDetails(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		signinathmode = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) { 
			zuid = zuid ? zuid : jsonStr[signinathmode].identifier;
			restrictTrustMfa = jsonStr[signinathmode].restrict_trust_mfa || jsonStr[signinathmode].isAMFA;
			if(typeof adminEmail != 'undefined' && !(jsonStr[signinathmode].isAMFA)){
				$('.contact_support .option_title').html(I18N.get("IAM.NEW.SIGNIN.CONTACT.ADMIN.TITLE"));
				$('.contact_support .contactsuprt').html(formatMessage(I18N.get("IAM.NEW.SIGNIN.CONTACT.ADMIN.DESC"),adminEmail));
			}
			if(!restrictTrustMfa) {
				trustMfaDays = ''+jsonStr[signinathmode].trust_mfa_days;
			}
			$('.overlapBanner,.dotHead,#emailverify_container').hide();
			$('.mfa_panel,#login').show();
			var successCode = jsonStr.code;
			if(jsonStr[signinathmode].isAMFA){
				$("#problemsignin").text(I18N.get("IAM.AC.VIEW.OPTION"));
				$("#recoverybtn").text(I18N.get("IAM.NEW.SIGNIN.PROBLEM.SIGNIN"));
			}
			if(successCode === "SI302"|| successCode==="SI200" ||successCode === "SI300" || successCode === "SI301" || successCode === "SI303"){
				switchto(jsonStr[signinathmode].redirect_uri);
				return false;
			}else if(successCode==="P500"||successCode==="P501"){//No i18N
				temptoken = jsonStr[signinathmode].token;
				showPasswordExpiry(jsonStr[signinathmode].pwdpolicy);
				return false;
			}
			else if(successCode === "MFA302"){//No i18N
				$("#enablemore").hide();
				if(!isValid(digest)){
					digest = jsonStr[signinathmode].digest;
				}
				allowedmodes = jsonStr[signinathmode].modes.allowed_modes;
				if(allowedmodes != undefined && allowedmodes.indexOf("yubikey") != -1 && !isWebAuthNSupported()){ 
					//if yubikey not supported in user's browser, block signin on first factor form and show not supported error
					showTopErrNotification(I18N.get("IAM.WEBAUTHN.ERROR.BrowserNotSupported"));
					changeButtonAction(I18N.get("IAM.NEXT"),false);
					return false;
				}
				if(allowedmodes.length < 1){
					showCantAccessDevice();
					$("#product_img").removeClass($("#product_img").attr('class'));
					$("#product_img").addClass("tfa_ga_mode");
					$('#recovery_container .backoption').hide();
					return false;
				}
				isPrimaryMode = false;
				deviceauthdetails=jsonStr;
				isSecondary = allowedmodes.length > 1 && allowedmodes.indexOf("recoverycode") === -1 ? true : false;//no i18n
				temptoken = jsonStr[signinathmode].token;
				secondarymodes = allowedmodes;
				prev_showmode = allowedmodes[0];
				handleSecondaryDevices(prev_showmode);
				if(isPasswordless){
					callmode="secondary";//no i18n
					showMoreSigninOptions();
					$("#product_img").removeClass($("#product_img").attr('class'));
					$("#product_img").addClass("tfa_ga_mode");
					return false;
				}
				if(allowedmodes[0]==="otp" || allowedmodes[0]==="email"){
					emobile = allowedmodes[0]==="otp" ? jsonStr[signinathmode].modes.otp && jsonStr[signinathmode].modes.otp.data[0].e_mobile : jsonStr[signinathmode].modes.email && jsonStr[signinathmode].modes.email.data[0].e_email;
					rmobile = allowedmodes[0]==="otp" ? jsonStr[signinathmode].modes.otp && jsonStr[signinathmode].modes.otp.data[0].r_mobile : jsonStr[signinathmode].modes.email && jsonStr[signinathmode].modes.email.data[0].email;
					callmode="secondary";//no i18n
					allowedmodes[0] ==="email" ? emailposition = 0 : mobposition = 0;
					generateOTP(false,allowedmodes[0]);
					return false;
				}
				else if(allowedmodes[0]==="mzadevice"){
					callmode="secondary";//no i18n
					enableMyZohoDevice(jsonStr);
					return false;
				}
				else if(allowedmodes[0]==="oadevice"){
					callmode="secondary";//no i18n
					enableOneauthDevice(jsonStr, oadevicepos);
					return false;
				}
				else if(allowedmodes[0]==="yubikey"){
					callmode="secondary";//no i18N
					enableYubikeyDevice(jsonStr);
					return false;
				}
				else if(allowedmodes[0]==="recoverycode" || allowedmodes[0]==="passphrase"){
					callmode="secondary";//no i18N
					enableOneAuthBackup();
					return false;
				}
				enableMfaField(allowedmodes[0]);
				return false;
			}
		}else{
			if(jsonStr.cause==="throttles_limit_exceeded"){
				var errorfield = $("#emailverify").is(":visible") ? "emailverify" : signinathmode==="otpauth"?"otp":"password" ; // no i18n
				showCommonError(errorfield,jsonStr.localized_message);
				return false;
			}
			var error_resp = jsonStr.errors[0];
			var errorCode=error_resp.code;
			var errorMessage = jsonStr.localized_message;
			if(errorCode==="IN107" || errorCode === "IN108"){
				cdigest=jsonStr.cdigest;
				showHip(cdigest); //no i18N 
				showCaptcha(I18N.get("IAM.NEXT"),false,"password");//no i18N
				if( errorCode === "IN107"){
					showCommonError("captcha",errorMessage); //no i18n	
				}
				return false;
			}else if(errorCode === "R303"){ //no i18N
				showRestrictsignin();
				return false;
			}else{
				var errorfield = $("#emailverify").is(":visible") ? "emailverify" : signinathmode==="otpauth"?"otp":"password" ; // no i18n
				showCommonError(errorfield ,errorMessage);
				return false;	
			}
		}
	}else{
		var errorfield = $("#emailverify").is(":visible") ? "emailverify" : signinathmode==="otpauth"?"otp":"password" ; // no i18n
		showCommonError(errorfield,I18N.get("IAM.ERROR.GENERAL")); //no i18n
		return false;
	}
	return false;
}
function handleTotpDetails(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		signinathmode = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		var container = signinathmode==="otpsecauth"?"mfa_otp": signinathmode==="otpauth" ? "otp" :"mfa_totp";//no i18n
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			$(".go_to_bk_code_container").removeClass("show_bk_pop");
			var successCode = jsonStr.code;
			var statusmsg = jsonStr[signinathmode].status;
			if(successCode === "SI302"|| successCode==="SI200" ||successCode === "SI300" || successCode === "SI301" || successCode === "SI303"){
				switchto(jsonStr[signinathmode].redirect_uri);
				return false;
			}
			else if(statusmsg==="success"){
				if(restrictTrustMfa){
					updateTrustDevice(false);
					return false;
				}
				showTrustBrowser();
				return false;
			}
			else if(successCode==="P500"||successCode==="P501"){
				temptoken = jsonStr[signinathmode].token;
				showPasswordExpiry(jsonStr[signinathmode].pwdpolicy);
				return false;
			}
		}else{
			
			container = isTroubleSignin ? 'verify_totp' : prev_showmode==="email" ? "mfa_email" : container; // no i18n
			if(jsonStr.cause==="throttles_limit_exceeded"){
				showCommonError(container,jsonStr.localized_message); //no i18n
				return false;
			}
			var error_resp = jsonStr.errors[0];
			var errorCode = error_resp.code;
			var errorMessage = jsonStr.localized_message;
			if(errorCode==="IN107" || errorCode === "IN108"){
				cdigest=jsonStr.cdigest;
				showHip(cdigest); //no i18N 
				showCaptcha(I18N.get("IAM.NEXT"),false,container);//no i18N
				if( errorCode === "IN107"){
					showCommonError("captcha",errorMessage); //no i18n	
				}
				return false;
			}else if(errorCode === "R303"){ //no i18N
				showRestrictsignin();
				return false;
			}else{
				showCommonError(container,errorMessage); //no i18n
				return false;	
			}
			return false;
		}
	}else{
		var container = signinathmode==="otpsecauth"?"mfa_otp": signinathmode==="otpauth" ? "otp" :"mfa_totp";//no i18n
		container = isTroubleSignin ? 'verify_totp' : container; // no i18n
		showCommonError(container,I18N.get("IAM.ERROR.GENERAL")); //no i18n
		return false;
	}
	return false;
}
function handleMyZohoDetails(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		signinathmode = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			var successCode = jsonStr.code;
			if(successCode === "SI202"||successCode==="MFA302" || successCode==="SI302" || successCode==="SI201"){
				temptoken = jsonStr[signinathmode].token;
				if(isResend){
					showResendPushInfo();
					if(isPasswordless && jsonStr[signinathmode].rnd != undefined){
						$("#rnd_num").html(jsonStr[signinathmode].rnd);
						resendpush_checking(time = 25);
					}
					return false;
				}
				isTroubleSignin = false;
				if(prefoption==="totp"){
					$('.step_two').html(I18N.get("IAM.NEW.SIGNIN.RIGHT.PANEL.VERIFY.TOTP"));
					$('.step_three').html(I18N.get("IAM.NEW.SIGNIN.RIGHT.PANEL.ALLOW.TOTP"));
					$('.approved').css('background','url("../images/TOTP_Verify.svg") no-repeat transparent');
					$("#mfa_scanqr_container,#mfa_push_container,#waitbtn,#openoneauth").hide();
					enableTOTPdevice(jsonStr,true,false);
	    			$(".rnd_container").hide();
					return false;
				}
				var headtitle = prefoption ==="push" ? "IAM.NEW.SIGNIN.VERIFY.PUSH" : prefoption === "totp" ? "IAM.NEW.SIGNIN.TOTP" : prefoption === "scanqr" ? "IAM.NEW.SIGNIN.QR.CODE" : "";//no i18N
				var headerdesc = prefoption ==="push" ? "IAM.NEW.SIGNIN.MFA.PUSH.HEADER" : prefoption === "totp" ? "IAM.NEW.SIGNIN.TOTP.HEADER" : prefoption === "scanqr" ? "IAM.NEW.SIGNIN.QR.HEADER":"";//no i18N
				$("#password_container,#login_id_container,#captcha_container,.fed_2show,#recoverybtn,#otp_container,.deviceparent").hide();
				$("#headtitle").text(I18N.get(headtitle));
				$('.devices .selection').css('display','');
				headerdesc = deviceauthdetails[deviceauthdetails.resource_name].isAMFA ? I18N.get(headerdesc) + "<br>" + formatMessage(I18N.get("IAM.NEW.SIGNIN.WHY.VERIFY"),suspisious_login_link) : headerdesc;
				$(".service_name").html(I18N.get(headerdesc));
				$(".product_text,.product_head,.MAppIcon,.OnaAuthHLink,.pwless_head,.pwless_text").hide();
				$("#product_img").removeClass($("#product_img").attr('class'));
				$("#product_img").addClass("tfa_"+prefoption+"_mode");
				$("#forgotpassword,#problemsignin,#recoverybtn").hide();
				$("#nextbtn").hide();
				$("#mfa_"+prefoption+"_container").show();
				$(".service_name").addClass("extramargin");
    			$("#mfa_device_container").show();
    			$('.signin_container').removeClass('mobile_signincontainer');
    			$(".rnd_container").hide();
    			if(prefoption === "push" || prefoption==="scanqr" ){
    				var wmsid = jsonStr[signinathmode].WmsId && jsonStr[signinathmode].WmsId.toString();
    				isVerifiedFromDevice(prefoption,true,wmsid);
    			}
    			if(prefoption==="push"){
    				if(isPasswordless && jsonStr[signinathmode].rnd != undefined){
	    				$(".rnd_container").show();
        				$("#rnd_num").html(jsonStr[signinathmode].rnd);
        				$("#waitbtn,.loadwithbtn").hide();
	    				$("#mfa_scanqr_container,#mfa_totp_container,#openoneauth").hide();
	    				$(".service_name").text(I18N.get("IAM.NEW.SIGNIN.PUSH.RND.DESC"));
	    				$(".loader,.blur").hide();
	    				resendpush_checking(time = 20);
        			}
    				else{
	    				$("#waitbtn,.loadwithbtn").show();
	    				$(".rnd_container").hide();
	    				$(".waitbtn .waittext").text(I18N.get("IAM.NEW.SIGNIN.WAITING.APPROVAL"));
	    				$("#waitbtn").attr("disabled", true);
	    				$("#mfa_scanqr_container,#mfa_totp_container,#openoneauth").hide();
	    				$(".loader,.blur").hide();
	    				window.setTimeout(function (){
	        				$(".waitbtn .waittext").text(I18N.get("IAM.PUSH.RESEND.NOTIFICATION"));
	        				$(".loadwithbtn").hide();
	        				$("#waitbtn").attr("disabled", false);
	        				isFormSubmited = false;
	        				return false;
	        				
	    				},20000);
    				}
    			}
    			if(prefoption==="scanqr"){
    				$('.step_two').html(I18N.get("IAM.NEW.SIGNIN.RIGHT.PANEL.ALLOW.SCANQR"));
    				$('.step_three').html(I18N.get("IAM.NEW.SIGNIN.RIGHT.PANEL.VERIFY.SCANQR"));
    				$('.approved').css('background','url("../images/SCANQR_Verify.svg") no-repeat transparent');
    				signinathmode = jsonStr.resource_name;
    				$("#waitbtn").hide();
    				var qrcodeurl = jsonStr[signinathmode].img;
    				qrtempId =  jsonStr[signinathmode].temptokenid;
    				isValid(qrtempId) ? $("#openoneauth").show() : $("#openoneauth").hide();
    				$("#mfa_push_container,#mfa_totp_container").hide();
    				$("#qrimg").attr("src",qrcodeurl);//no i18n
    				$(".checkbox_div").addClass("qrwidth");
    			}
    			$(".tryanother").show()
    			var isAMFA = deviceauthdetails[deviceauthdetails.resource_name].isAMFA;
    			if(isAMFA){
    				allowedModeChecking();
    				$(".tryanother").hide()
    			}
				isFormSubmited = false;
				signinathmode = callmode === "primary" ? "deviceauth" : "devicesecauth";//no i18N
				$(".loader,.blur").hide();
				return false;
			}
		}else{
			var errorcontainer= isPasswordless ? "login_id" : prefoption==="totp"? "mfa_totp": $("#password_container").is(":visible") ? "password" : $("#otp_container").is(":visible") ?"otp" : "yubikey";//no i18n
			errorcontainer = isResend ? "yubikey" : errorcontainer;//no i18N
			errorcontainer === "yubikey" ? $("#yubikey_container").show() : $("#yubikey_container").hide();//no i18N
			var error_resp = jsonStr.errors && jsonStr.errors[0];
			var errorCode = error_resp && error_resp.code;
			if(errorCode === "D105"){
				$('.fed_2show').hide();
				showCommonError(errorcontainer,jsonStr.localized_message); //no i18n
				if (!isRecovery) {allowedModeChecking();}
				return false;
			}
			$('#problemsignin,#recoverybtn').hide();
			if(jsonStr.cause==="throttles_limit_exceeded"){
				showCommonError(errorcontainer,jsonStr.localized_message); //no i18n
				$(".loader,.blur").hide();
				return false;
			}

			if(jsonStr.cause==="pattern_not_matched"){
				changeHip();
				showCommonError("captcha",jsonStr.localized_message);//no i18n
				$(".loader,.blur").hide();
				return false;
			}else if(errorCode === "R303"){ //no i18N
				showRestrictsignin();
				return false;
			}
			var error_resp = jsonStr.errors[0];
			var errorCode=error_resp.code;
			var errorMessage = jsonStr.localized_message;
			if(prefoption==="push" || prefoption==="scanqr"){
				showTopErrNotificationStatic(jsonStr.localized_message);
			}else{
				showCommonError(errorcontainer,errorMessage); //no i18n
			}
			$(".loader,.blur").hide();
			return false;
	   }
		
	}else{
		var errorcontainer = signinathmode ==="passwordauth"? "password":"login_id";//no i18n
		showCommonError(errorcontainer,I18N.get("IAM.ERROR.GENERAL")); //no i18n
		return false;
	}
	return false;
}
function handleOneAuthDetails(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		signinathmode = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
	if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
		var successCode = jsonStr.code;
		if(successCode==="SI302"||successCode==="MFA302"||successCode==="SI202"|| successCode==="SI201"){
			temptoken = jsonStr[signinathmode].token;
			prefoption = deviceauthdetails[deviceauthdetails.resource_name].modes.oadevice.data[oadevicepos].prefer_option;
			var devicemode = prefoption ==="ONEAUTH_PUSH_NOTIF" ? "push" : prefoption === "ONEAUTH_TOTP" ? "totp" : prefoption === "ONEAUTH_SCAN_QR" ? "scanqr" : prefoption === "ONEAUTH_FACE_ID" ? "faceid": prefoption === "ONEAUTH_TOUCH_ID" ? "touch" : "";//no i18N
			if(isResend){
				showResendPushInfo();
				return false;
			}
			var headtitle = prefoption ==="ONEAUTH_PUSH_NOTIF" ? "IAM.NEW.SIGNIN.VERIFY.PUSH" : prefoption === "ONEAUTH_TOTP" ? "IAM.NEW.SIGNIN.TOTP" : prefoption === "ONEAUTH_SCAN_QR" ? "IAM.NEW.SIGNIN.QR.CODE" : prefoption === "ONEAUTH_FACE_ID" ? "IAM.NEW.SIGNIN.FACEID.TITLE": prefoption === "ONEAUTH_TOUCH_ID" ? "IAM.NEW.SIGNIN.TOUCHID.TITLE" : "";//no i18N
			var headerdesc = prefoption ==="ONEAUTH_PUSH_NOTIF" ? "IAM.NEW.SIGNIN.MFA.PUSH.HEADER" : prefoption === "ONEAUTH_TOTP" ? "IAM.NEW.SIGNIN.ONEAUTH.TOTP.HEADER" : prefoption === "ONEAUTH_SCAN_QR" ? "IAM.NEW.SIGNIN.QR.HEADER" : prefoption === "ONEAUTH_FACE_ID" ? "IAM.NEW.SIGNIN.FACEID.HEADER": prefoption === "ONEAUTH_TOUCH_ID" ? "IAM.NEW.SIGNIN.TOUCHID.HEADER":"";//no i18N
			if(isFaceId === true){
				headtitle = "IAM.NEW.SIGNIN.FACEID.TITLE";//No i18N
				headerdesc ="IAM.NEW.SIGNIN.FACEID.HEADER"; //No i18N
				devicemode = "faceid";//no i18N
			}
			$("#password_container,#login_id_container,#captcha_container,.fed_2show,#otp_container,.deviceparent").hide();
			$("#headtitle").text(I18N.get(headtitle));
			$(".service_name").text(I18N.get(headerdesc));
			$(".product_text,.product_head,.MAppIcon,.OnaAuthHLink,.pwless_head,.pwless_text").hide();
			$("#product_img").removeClass($("#product_img").attr('class'));
			$('.devices .selection').css('display','');
			$("#product_img").addClass("tfa_"+devicemode+"_mode");
			$("#forgotpassword").hide();
			$("#nextbtn").hide();
			$("#mfa_"+devicemode+"_container").show();
			$(".service_name").addClass("extramargin");
			$("#mfa_device_container").show();
			if (!isRecovery) {allowedModeChecking();}
			$(".loader,.blur").hide();
			if(devicemode==="push"||devicemode==="touch"|| devicemode==="faceid" ||devicemode === "scanqr"){
				var wmsid = jsonStr[signinathmode].WmsId && jsonStr[signinathmode].WmsId.toString();
				callmode="secondary";//no i18n
				isVerifiedFromDevice(prefoption,false,wmsid);
			}
			if(devicemode==="push"||devicemode==="touch"|| devicemode==="faceid"){
				$("#waitbtn").attr("disabled", true);
				$(".waitbtn .waittext").text(I18N.get("IAM.NEW.SIGNIN.WAITING.APPROVAL"));
				$(".loadwithbtn").show();
				$("#waitbtn").show();
				$("#openoneauth").hide();
				window.setTimeout(function (){
					$(".waitbtn .waittext").text(I18N.get("IAM.PUSH.RESEND.NOTIFICATION"));
					$("#waitbtn").attr("disabled", false);
					$(".loadwithbtn").hide();
					isFormSubmited = false;
					return false;
					
				},20000);
			}
			if(devicemode==="scanqr"){
				var qrcodeurl = jsonStr[signinathmode].img;
				qrtempId =  jsonStr[signinathmode].temptokenid;
				isValid(qrtempId) ? $("#openoneauth").show() : $("#openoneauth").hide();
				$("#qrimg").attr("src",qrcodeurl);//no i18n
				$(".checkbox_div").addClass("qrwidth");
			}
			isFormSubmited = false;
			return false;
			}
		}
		else{
			var errorcontainer= (prefoption==="totp"||prefoption==="ONEAUTH_TOTP") ? "mfa_totp": "yubikey";//no i18n
			errorcontainer === "yubikey" ? $("#yubikey_container").show() : $("#yubikey_container").hide();//no i18N
			var error_resp = jsonStr.errors[0];
			var errorCode = error_resp.code;
			if(errorCode === "D105"){
				showCommonError(errorcontainer,jsonStr.localized_message); //no i18n
				$('.fed_2show').hide();
				if (!isRecovery) {allowedModeChecking();}
				return false;
			}else if(errorCode === "R303"){ //no i18N
				showRestrictsignin();
				return false;
			}
			if(jsonStr.cause==="throttles_limit_exceeded"){
				showCommonError(errorcontainer,jsonStr.localized_message); //no i18n
				return false;
			}
			showCommonError(errorcontainer,jsonStr.localized_message); //no i18n
			return false;
		}
		return false;
	}else{
		var errorcontainer = signinathmode ==="passwordauth"? "password":"login_id";//no i18n
		showCommonError(errorcontainer,I18N.get("IAM.ERROR.GENERAL")); //no i18n
		return false;
	}
	return false;
}
function handlePassphraseDetails(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		signinathmode = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			var successCode = jsonStr.code;
			var statusmsg = jsonStr.passphrasesecauth.status;
			if(statusmsg==="success"){
				if(restrictTrustMfa){
					updateTrustDevice(false);
					return false;
				}
				showTrustBrowser();
				return false;
			}else if(successCode==="P500"||successCode==="P501"){//no i18N
				temptoken = jsonStr[signinathmode].token;
				showPasswordExpiry(jsonStr[signinathmode].pwdpolicy);
				return false;
			}
			else{
				showCommonError("passphrase",jsonStr.localized_message);//no i18n
				return false;
			}
		}else{
			if(jsonStr.cause==="throttles_limit_exceeded"){
				showCommonError("passphrase",jsonStr.localized_message); //no i18n
				return false;
			}
			var error_resp = jsonStr.errors && jsonStr.errors[0];
			var errorCode= error_resp && error_resp.code;
			if(errorCode==="IN107" || errorCode === "IN108"){
				$(".fed_2show,.line").hide();
				cdigest=jsonStr.cdigest;
				showHip(cdigest, 'bcaptcha_img'); //no i18N
				$("#bcaptcha_container").show();
				$("#bcaptcha").focus();
				clearCommonError('bcaptcha');//no i18N
				changeButtonAction(I18N.get("IAM.VERIFY"),false);
				if( errorCode === "IN107"){
					showCommonError("bcaptcha",errorMessage); //no i18n	
				}
				return false;
			}else if(errorCode === "R303"){ //no i18N
				showRestrictsignin();
				return false;
			}
			showCommonError("passphrase",jsonStr.localized_message);//no i18n
			return false;
		}
	}
}
function resendpush_checking(resendtiming){
	clearInterval(resendTimer);
	$('.rnd_resend').addClass('nonclickelem');
	$('.rnd_resend').html(I18N.get('IAM.NEW.SIGNIN.RESEND.PUSH.COUNTDOWN'));
	$('.rnd_resend span').text(resendtiming);
	resendTimer = setInterval(function(){
		resendtiming--;
		$('.rnd_resend span').text(resendtiming);
		if(resendtiming === 0) {
			clearInterval(resendTimer);
			$('.rnd_resend').html(I18N.get('IAM.NEW.SIGNIN.RESEND.PUSH'));
			$('.rnd_resend').removeClass('nonclickelem');
		}
	},1000);
}
var wmscount =0;
var _time;
var verifyCount = 0;
var totalCount = 0;
var isWmsRegistered=false;
var wmscallmode,wmscallapp,wmscallid;
function isVerifiedFromDevice(prefmode,isMyZohoApp,WmsID) {
	if(isWmsRegistered === false && isValid(WmsID) && WmsID != "undefined" ){
		wmscallmode=prefmode;wmscallapp=isMyZohoApp;wmscallid=WmsID;
		try {
			WmsLite.setNoDomainChange();
	 		WmsLite.registerAnnon('AC', WmsID ); //No I18N
	 		isWmsRegistered=true;
	 		
	 	} catch (e) {
		//no need to handle failure
	 	}
	}
	prefmode = prefmode === undefined ? wmscallmode:prefmode;
    isMyZohoApp = isMyZohoApp === undefined ? wmscallapp : isMyZohoApp;
    WmsID = WmsID === undefined ? wmscallid : WmsID;
	clearInterval(_time);
	if(isValid(WmsID) && WmsID!="undefined"){
		wmscount++;
		if(verifyCount > 15) {
			return false;
			}
	}else{
		if(verifyCount > 25) {
   			return false;
   			}
	}
	var loginurl = isMyZohoApp ? "/signin/v2/"+callmode+"/"+zuid+"/device/"+deviceid+"?":"/signin/v2/"+callmode+"/"+zuid+"/oneauth/"+deviceid+"?";//no i18N
	loginurl += "digest="+digest+ "&" + signinParams+"&polling="+true ; //no i18N
	var jsonData = {'oneauthsec':{'devicepref':prefmode }};//no i18N
	if(isMyZohoApp){
		jsonData = callmode==="primary" ? {'deviceauth':{'devicepref':prefmode }} : {'devicesecauth':{'devicepref':prefmode }};//no i18N
		var isAMFA = deviceauthdetails[deviceauthdetails.resource_name].isAMFA;
		jsonData =  callmode !="primary" && isAMFA ? {'devicesecauth':{'devicepref':prefoption, "isAMFA" : true }}  : jsonData; // no i18n
	}
	sendRequestWithTemptoken(loginurl,JSON.stringify(jsonData),true,VerifySuccess,"PUT");//No i18N
	verifyCount++;
	if(isValid(WmsID) && WmsID!="undefined"){
		if(wmscount < 6){
			_time = setInterval("isVerifiedFromDevice(\""+prefmode+"\","+isMyZohoApp+",\""+WmsID+"\")", 5000);//No I18N

		}else{
			_time = setInterval("isVerifiedFromDevice(\""+prefmode+"\","+isMyZohoApp+",\""+WmsID+"\")", 25000);//No I18N
		}
	}else{
		_time = setInterval("isVerifiedFromDevice(\""+prefmode+"\","+isMyZohoApp+",\""+WmsID+"\")", 5000);//No I18N
	}
	return false;
}
function VerifySuccess(res) {
	if(IsJsonString(res)) {
		var jsonStr = JSON.parse(res);
		signinathmode = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			var successCode = jsonStr.code;
			var statusmsg = jsonStr[signinathmode].status;
			if(successCode === "SI302"|| successCode==="SI200" ||successCode === "SI300" || successCode === "SI301" || successCode === "SI303"){
				switchto(jsonStr[signinathmode].redirect_uri);
				return false;
			}
			else if(statusmsg==="success"){
				clearInterval(_time);
				if(restrictTrustMfa){
					updateTrustDevice(false);
					return false;
				}
				showTrustBrowser();
				return false;
			}
			else if(successCode==="P500"||successCode==="P501"){
				temptoken = jsonStr[signinathmode].token;
				showPasswordExpiry(jsonStr[signinathmode].pwdpolicy);
				return false;
			}
		} else if(statusCode == "500") {
			var error_resp = jsonStr.errors && jsonStr.errors[0].code;
			if(error_resp == "Y401") {
				if(isPasswordless){
					showTopErrNotification(I18N.get("IAM.SIGNIN.ERROR.YUBIKEY.VALIDATION.FAILED"));
					return false;
				}else if(error_resp === "R303"){ //no i18N
					showRestrictsignin();
					return false;
				}
				showCommonError("yubikey",I18N.get("IAM.SIGNIN.ERROR.YUBIKEY.VALIDATION.FAILED")); //no i18n	
				$("#yubikey_container").show();
				showError();
			}
		}
 	}
	return false;
}
function handleSecondaryDevices(primaryMode){
	if(primaryMode === "oadevice" || primaryMode === "mzadevice"){
		$('.secondary_devices').find('option').remove().end();
		var deviceDetails = deviceauthdetails[deviceauthdetails.resource_name].modes;
		var isSecondaryDevice = false;
		var optionElem = '';
		secondaryMode = "oadevice"; //no i18n
		if(primaryMode == "oadevice") {
			secondaryMode = "mzadevice"; // no i18n
		}
		if(deviceDetails[primaryMode]){
			var oneauthdetails = deviceDetails[primaryMode].data;
			if(oneauthdetails[0].prefer_option != "push"){
				optionElem += "<option value='0' version='"+oneauthdetails[0].app_version+"'>"+oneauthdetails[0].device_name+"</option>";
				isSecondaryDevice = true;
			}else{
				oneauthdetails.forEach(function(data,index){
					optionElem += "<option value="+index+" version='"+data.app_version+"'>"+data.device_name+"</option>";
					isSecondaryDevice = true;
				});
			}
		}
		if(deviceDetails[secondaryMode]){
			var oneauthdetails = deviceDetails[secondaryMode].data;
			if(oneauthdetails[0].prefer_option != "push"){
				optionElem += "<option value='0' version='"+oneauthdetails[0].app_version+"'>"+oneauthdetails[0].device_name+"</option>";
				isSecondaryDevice = true;
			}else{
				oneauthdetails.forEach(function(data,index){
					optionElem += "<option value="+index+" version='"+data.app_version+"'>"+data.device_name+"</option>";
					isSecondaryDevice = true;
				});
			}
		}
		document.getElementsByClassName('secondary_devices')[0].innerHTML = optionElem; // no i18n
		if(isSecondaryDevice){
			try { 
				$(".secondary_devices").select2({
			        allowClear: true,
			        templateResult: secondaryFormat,
			        minimumResultsForSearch: Infinity,
			        templateSelection: function (option) {
			              return "<div><span class='icon-device select_icon'></span><span class='select_con options_selct' value="+$(option.element).attr("value")+" version="+$(option.element).attr("version")+">"+option.text+"</span><span class='downarrow'></span></div>";
			        },
			        escapeMarkup: function (m) {
			          return m;
			        }
			      });
				window.setTimeout(function(){
					$('.devices .select2').addClass("device_select");
					$('.devices .select2').show();
					$('.devices .select2-selection--single').addClass('device_selection');
					$('.devicedetails').hide();
					$(".select2-selection__arrow").addClass("hide");
					if(!($('.secondary_devices option').length > 1 )){
						$('.downarrow').hide();
						$('.devices .selection').css("pointer-events", "none");
					}
				},100);
			}catch(err){
				$('.secondary_devices').css('display','block');
				if(!($('.secondary_devices option').length > 1 )){
					$('.secondary_device').css("pointer-events", "none");
				}
				$('option').each(function() {
					if(this.text.length > 20){
						var optionText = this.text;
						var newOption = optionText.substring(0, 20);
						$(this).text(newOption + '...');
					}
				});
			}
		}
	}
}
function secondaryFormat(option){
	return "<div><span class='icon-device select_icon'></span><span class='select_con' value="+$(option.element).attr("value")+" version="+$(option.element).attr("version")+">"+option.text+"</span></div>";
}
function showMoreSigninOptions(){
	showproblemsignin(true);
	showCantAccessDevice();
	$('.problemsignin_head,.recoveryhead .backoption').hide();
	allowedmodes.indexOf("recoverycode") != -1 ? $('#recoverOption').show() : $('#recoverOption').hide();
	allowedmodes.indexOf("passphrase") != -1 ? $('#passphraseRecover').show() : $('#passphraseRecover').hide();
	$('.rec_head_text').text(I18N.get("IAM.NEW.SIGNIN.FEDERATED.LOGIN.TITLE"));
	$(".signin_head").prepend( "<span class='icon-backarrow backoption' onclick='hideCantAccessDevice(this)'></span>" );
	$('.backuphead .backoption,.greytext').hide();
	$('.recoveryhead .backoption').css("cssText", "display: none !important;");
	$('#recoverymodeContainer').html($('.problemsignincon').html()+$('.recoverymodes').html());
	$('.recoverymodes').hide();
	if($('#recoverymodeContainer').children().length - !$('#recoverOption').is(":visible") - !$('#passphraseRecover').is(":visible")  > 3 && !isMobile){
		$('#recoverymodeContainer').addClass('problemsignincontainer');
	}
	isRecovery= true; // no i18n
	isPasswordless = false;
}

function generateOTP(isResendOnly,mode){	
	if(typeof mode !== 'undefined' && isResendOnly){
		mode = prev_showmode; 
	}
	mode = (mode && mode.toLowerCase() == "email" ) ? "EMAIL" : "MOBILE";//No i18n
	if(isResendOnly){
		$('.resendotp').addClass("sendingotp");//no i18N
		$('.resendotp').text(I18N.get("IAM.NEW.GENERAL.SENDING.OTP"));//no i18N
	}
	if(isPrimaryMode){
		generateOTPAuth(isResendOnly,mode);
		return false;
	}
	var loginurl=uriPrefix+"/signin/v2/"+callmode+"/"+zuid+"/otp/"+emobile;//no i18N
	var isAMFA = deviceauthdetails[deviceauthdetails.resource_name].isAMFA; 
	var callback = prev_showmode == "email" ? enableOTPForEmail : enableOTPDetails; // no i18n
	if(isResendOnly){
		loginurl += "?digest="+digest+ "&" + signinParams; //no i18N
		var jsonData = isAMFA ? { "otpsecauth" : { 'mdigest' : mdigest, 'is_resend' : true, 'isAMFA' : true , 'mode' : mode }} : { "otpsecauth" : { 'mdigest' : mdigest, 'is_resend' : true , 'mode' : mode }};//no i18N
		sendRequestWithTemptoken(loginurl,JSON.stringify(jsonData),true,showResendInfo,"PUT");//no i18n
		return false;		
	}else{
		loginurl += "?digest="+digest+ "&" + signinParams; //no i18N
		var isAMFA = deviceauthdetails[deviceauthdetails.resource_name].isAMFA;
		var jsonData = isAMFA ? { "otpsecauth" : { 'isAMFA' : true , 'mode' : mode }} : { "otpsecauth" : { 'mode' : mode }};//no i18N
		sendRequestWithTemptoken(loginurl, JSON.stringify(jsonData) ,true,callback );	
	}
	
	return false;
}
function generateOTPAuth(isResendOnly,mode){
	var emailID = $("#emailcheck").val();
	if($("#emailcheck_container").is(":visible")  && (!isValid(emailID) || !isEmailId(emailID))){
		!isValid(emailID) ? showCommonError("emailcheck",I18N.get("IAM.NEW.SIGNIN.ENTER.EMAIL.ADDRESS")) : showCommonError("emailcheck",I18N.get("IAM.SIGNIN.ERROR.USEREMAIL.NOT.EXIST"));//no i18n
		return false;
	}
	var loginurl=uriPrefix+"/signin/v2/"+callmode+"/"+zuid+"/otp/"+emobile+"?digest="+digest+"&" + signinParams;//no i18N
	var callback = isResendOnly ? showResendInfo : enableOTPDetails;
	callback = $("#emailcheck_container").is(":visible") ? enableEmailOTPDetails :callback; 
	var jsonData = isValid(emailID) ? {"otpauth" : {"email_id" : emailID , 'mode' : mode }} : {"otpauth" : { 'mode' : mode  }}; // no i18n
	var jsonDataResend = isResendOnly && $("#emailverify_container").is(":visible") ? {"otpauth" : {"is_resend" : true ,"email_id" : emailID , 'mode' : mode  }} : {"otpauth" : {"is_resend" : true , 'mode' : mode  }}; // no i18n
	!isResendOnly ? sendRequestWithTemptoken(loginurl,JSON.stringify(jsonData),true,callback) : sendRequestWithTemptoken(loginurl,JSON.stringify(jsonDataResend),true,callback)
	return false;
}
function showResendInfo(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		signinathmode = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			var successCode = jsonStr.code;
			if(successCode === "SI201"|| successCode==="SI200" ){
				mdigest = jsonStr[signinathmode].mdigest;
				showTopNotification(formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.SENT"),rmobile))
				resendotp_checking();
				if(allowedmodes.indexOf("recoverycode") != -1){
					setTimeout(function(){
						if($("#mfa_otp_container").is(":visible")){$(".go_to_bk_code_container").addClass("show_bk_pop")};
					},30000);
					
				}
				return false;
			
				
			}
		}else{
			if(jsonStr.cause==="throttles_limit_exceeded"){
				if(isPrimaryDevice){
					showTopErrNotification(jsonStr.localized_message);
					return false;
				}
				showCommonError("otp",jsonStr.localized_message); //no i18n
				return false;
			}
			var error_resp = jsonStr.errors && jsonStr.errors[0];
			var errorCode= error_resp && error_resp.code;
			var errorMessage = jsonStr.localized_message;
			if(errorCode==="IN107" || errorCode === "IN108"){
				cdigest=jsonStr.cdigest;
				showHip(cdigest); //no i18N 
				showCaptcha(I18N.get("IAM.NEXT"),false,"otp");//no i18N
				if( errorCode === "IN107"){
					showCommonError("captcha",errorMessage); //no i18n	
				}
				return false;
			}
			else if(errorCode === "R303"){ //no i18N
				showRestrictsignin();
				return false;
			}
			else{
				showCommonError("otp",errorMessage); //no i18n
				return false;	
			}
			
		}
	}
	return false;
	
}
function enableOTPDetails(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		signinathmode = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			var successCode = jsonStr.code;
			if(successCode === "SI201"|| successCode==="SI200" ){
				$(".loader,.blur").hide();
				mdigest = jsonStr[signinathmode].mdigest;
				isSecondary = deviceauthdetails.passwordauth && deviceauthdetails.passwordauth.modes.otp.count > 1 || (allowedmodes.length >1 && allowedmodes.indexOf("recoverycode") === -1) ? true : false; // no i18n
				if(signinathmode === "otpauth"){
					clearCommonError("otp"); // no i18n
					$('#login').show();
					$("#emailcheck_container").hide();
					$("#emailcheck").val("");
					showTopNotification(formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.SENT"),rmobile));
					resendotp_checking();
					allowedmodes.indexOf("saml") != -1 ? $(".otp_actions .signinwithsaml").show() : $(".otp_actions .signinwithsaml").hide();
					allowedmodes.indexOf("jwt") != -1 ? $(".otp_actions .signinwithjwt").show() : $(".otp_actions .signinwithjwt").hide();
					if(allowedmodes.indexOf("saml") != -1 && allowedmodes.indexOf("jwt") != -1){
						$(".otp_actions .showmoresigininoption").show();
						$(".otp_actions .signinwithjwt,.otp_actions .signinwithsaml,.otp_actions .showmoresigininoption").hide();
					}else{
						$(".otp_actions .showmoresigininoption").hide();
					}
					showOtpDetails();
					return false;	
				}
				if(!isValid(digest)){
					digest = jsonStr[signinathmode].mdigest;					
				}
				enableMfaField("otp");//no i18N
				resendotp_checking();
				return false;
			}
			return false;
		}
		else{
			if(jsonStr.errors && jsonStr.errors[0] && jsonStr.errors[0].code == "AS115"){
				showTopErrNotification(jsonStr.localized_message);
				return false;
			}
			var errorfield = $("#emailcheck_container").is(":visible")  ? "emailcheck" : "password"; //no i18n
			if(jsonStr.cause==="throttles_limit_exceeded"){
				showCommonError(errorfield,jsonStr.localized_message); 
				return false;
			}
			var errorMessage = jsonStr.localized_message;
			showCommonError(errorfield,errorMessage); 
			return false;
		}
	}
	return false;
}
function enableOTPForEmail(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		signinathmode = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			var successCode = jsonStr.code;
			$(".loader,.blur").hide();
			mdigest = jsonStr[signinathmode].mdigest;
			goBackToProblemSignin();
			var emaillist = deviceauthdetails[deviceauthdetails.resource_name].modes && deviceauthdetails[deviceauthdetails.resource_name].modes.email;
			isSecondary = emaillist && emaillist.count > 1 || (allowedmodes.length >1 && allowedmodes.indexOf("recoverycode") === -1);
			$("#password_container,#captcha_container,.fed_2show,#otp_container").hide();
			$("#headtitle").text(I18N.get("IAM.AC.CHOOSE.OTHER_MODES.EMAIL.HEADING"));
			$(".service_name").html(formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.HEADER"),rmobile)+"<br>"+formatMessage(I18N.get("IAM.NEW.SIGNIN.WHY.VERIFY"),suspisious_login_link));
			$("#product_img").removeClass($("#product_img").attr('class'));
			$("#product_img").addClass("tfa_otp_mode");
			showTopNotification(formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.SENT"),rmobile));
			if(!isClientPortal){enableSplitField("mfa_email",7,I18N.get("IAM.NEW.SIGNIN.OTP"))}
			$("#mfa_email_container,#mfa_email_container .textbox_actions").show();//no i18N
			$("#forgotpassword").hide();
			$(".service_name").addClass("extramargin");
			$("#nextbtn span").removeClass("zeroheight");
			$("#nextbtn").removeClass("changeloadbtn");
			$("#nextbtn").attr("disabled", false);
			$("#nextbtn span").text(I18N.get("IAM.VERIFY"));
			if(isClientPortal){$('#mfa_email').focus()}
			isFormSubmited = false;
			callmode="secondary";//no i18n
			resendotp_checking();
			allowedModeChecking();
			if(!isValid(digest)){
				digest = jsonStr[signinathmode].mdigest;					
			}
			signinathmode = jsonStr.resource_name;
			return false;
		}
		else{
			if(triggeredUser){
				showTopErrNotification(jsonStr.localized_message);
				return false;
			}
			if(jsonStr.cause==="throttles_limit_exceeded"){
				showCommonError("password",jsonStr.localized_message);  // no i18n
				return false;
			}
			var errorMessage = jsonStr.localized_message;
			showCommonError("password",errorMessage);  // no i18n
			return false;
		}
	}
	return false;
}
function resendotp_checking(){
	var resendtiming = 60;
	clearInterval(resendTimer);
	if($('.resendotp').hasClass('sendingotp')){$('.resendotp').removeClass('sendingotp');}
	$('.resendotp').addClass('nonclickelem');
	$('.resendotp span').text(resendtiming);
	$('.resendotp').html(I18N.get('IAM.TFA.RESEND.OTP.COUNTDOWN'));
	resendTimer = setInterval(function(){
		resendtiming--;
		$('.resendotp span').text(resendtiming);
		if(resendtiming === 0) {
			clearInterval(resendTimer);
			$('.resendotp').html(I18N.get('IAM.NEW.SIGNIN.RESEND.OTP'));
			$('.resendotp').removeClass('nonclickelem');
		}
	},1000);
}

function changeRecoverOption(recoverOption){
	recoverOption === "passphrase" ? showPassphraseContainer() : showBackupVerificationCode(); //no i18n
	if(recoverOption === "passphrase"){
		recoverTitle = I18N.get("IAM.NEW.SIGNIN.PASSPHRASE.RECOVER.TITLE");
		recoverHeader = I18N.get("IAM.NEW.SIGNIN.PASSPHRASE.RECOVER.HEADER");
	}else if(recoverOption === "recoverycode"){ // no i18n
		recoverTitle = I18N.get("IAM.BACKUP.VERIFICATION_CODE");
		recoverHeader = I18N.get("IAM.NEW.SIGNIN.BACKUP.RECOVER.HEADER");
	}
	$('#backup_container #backup_title').text(recoverTitle);
	$('#backup_container .backup_desc').text(recoverHeader);
	$("#backup_container .backoption").hide();
}
function showError(){
	$(".waitbtn .waittext").text(I18N.get("IAM.NEW.SIGNIN.RETRY.YUBIKEY"));
	$(".loadwithbtn").hide();
	$("#waitbtn").attr("disabled", false);
	isFormSubmited = false;
	return false;
}
function showMoreIdps(){
	$("#login,.line").hide();
	$(".small_box").removeClass("small_box");
    $(".fed_div").addClass("large_box")
    $(".fed_text,.fed_2show").show();
	$(".zohosignin").removeClass("hide");
	$("#showIDPs").hide();
	$(".fed_div").show();
	$(".more").hide();
	$(".signin_fed_text").addClass("signin_fedtext_bold");
	$(".signin_container").css("height","auto");//no i18n
	$(".linkedicon").removeClass("icon-linkedin_small").addClass("icon-linkedIn_L");
	$(".baiduicon").removeClass("icon-baidu_small").addClass("icon-baidu_L");
	$(".intuiticon").removeClass("icon-intuit_small").addClass("icon-intuit_L");
	$(".intuit_icon,.intuit_icon .fed_center").removeClass("intuit_fed");
	if(!isneedforGverify) {
		$(".fed_center_google").css("width","max-content");
		$(".googleIcon").removeClass("google_small_icon");
		$(".apple_fed").hide();
		$("#macappleicon").show();
		return false; 
	}
	$("#macappleicon").hide();
 }
function showZohoSignin(){
	$("#login").show();
	if(!isMobile){$(".line").show();}
	$(".zohosignin").addClass("hide");
	$(".fed_text,.fed_div").hide();
	$(".signin_fed_text").removeClass("signin_fedtext_bold");
	$(".more,.show_fed").show();
	if(de("login_id")){
   		$('#login_id').focus();
   	 }
	$(".large_box").removeClass("large_box");
    $(".fed_div").addClass("small_box");
	$(".linkedicon").addClass("icon-linkedin_small").removeClass("icon-linkedIn_L");
	$(".baiduicon").addClass("icon-baidu_small").removeClass("icon-baidu_L");
	$(".intuiticon").addClass("icon-intuit_small").removeClass("icon-intuit_L");
	$(".intuit_icon,.intuit_icon .fed_center").removeClass("intuit_fed");
    fediconsChecking();
 }
function showHidePassword(){
	var passwordField = $("#new_password").is(":visible") ? "#new_password" :"#password";//no i18N
 	passwordField = $("#passphrase").is(":visible") ? "#passphrase" :passwordField; // no i18n
	 var passType = $(passwordField).attr("type");//no i18n
	 if(passType==="password"){
		$(passwordField).attr("type","text");//no i18n
		$(".show_hide_password").addClass("icon-show");
	 }else{
		$(passwordField).attr("type","password");//no i18n
		$(".show_hide_password").removeClass("icon-show");
	 }
	 $(passwordField).focus();
}
function changeCountryCode(){
	$('.select_country_code').text($('#country_code_select').val());
}
function fediconsChecking(){
	$(".large_box").removeClass("large_box");
	if(!isneedforGverify){
	    $("#appleNormalIcon").remove();
	    $("#macappleicon").show();
    }else if($("#macappleicon").length == 1){
	    $("#macappleicon").remove();
	    $("#appleNormalIcon").show();
    }
    $(".fed_div").addClass("small_box");
    $(".fed_text,.fed_div").hide();
    var isSafari = /^((?!chrome|android).)*safari/i.test(navigator.userAgent) || /Mac|iPad|iPhone|iPod/.test(navigator.platform || "");
    isneedforGverify ? $(".google_icon .fed_text").show(): $(".google_icon .fed_text").hide();
	if(document.getElementsByClassName('fed_div').length > 0){
		document.getElementsByClassName('fed_div')[0].style.display = "inline-block";
		document.getElementsByClassName('fed_div')[0].classList.add("show_fed"); // no i18n
	    var fed_all_width = isneedforGverify ? $('.signin_box').width() - 90 : $('.signin_box').width();
	    var show_fed_length = Math.floor(fed_all_width / 50) && Math.floor(fed_all_width % 50) > $(".fed_div").outerWidth() ? Math.floor(fed_all_width / 50)+1 : Math.floor(fed_all_width / 50);
	    if($('.fed_div').length -1 > show_fed_length){
		    show_fed_length = !isneedforGverify ? show_fed_length -1 : show_fed_length;
		    for(var i= 0; i < show_fed_length; i++){
			    document.getElementsByClassName('fed_div')[i].style.display = "inline-block";
			    document.getElementsByClassName('fed_div')[i].classList.add("show_fed"); // no i18n
		    }
	        $('.more').show();
	        $('.fed_2show').show();
	    }else{
	    	$('.more').remove();
	    	$(".fed_div:last").css("margin","0px");
		    $('.fed_div,.fed_2show').show();
	    }
		if($('.fed_div').length < 0){
			$('.fed_2show').hide();
		}
	}
}
function onSigninReady(){
	if(!isClientPortal){setTimeout(function(){
		document.querySelector(".load-bg").classList.add("load-fade"); //No I18N
		setTimeout(function(){
			document.querySelector(".load-bg").style.display = "none";
		}, 300)
	}, 500);}
	clearInterval(_time);
	reload_page =setInterval(checkCookie, 5000); //No I18N
	isMobileonly = false;
	!isMobile && enableServiceBasedBanner ? loadRightBanner() : hiderightpanel();
	if(!isPreview){
		setCookie(24);
	    if(document.cookie.indexOf("IAM_TEST_COOKIE") != -1){ // cookie is Enabled
	        setCookie(0);
	        $('#enableCookie').hide();
	    } else { // cookie is disabled
	        $('.signin_container,#signuplink,.banner_newtoold').hide();
	        $('#enableCookie').show();
	        return false;
	    }
    }
	if(!isValid(loginID) && trySmartSignin && localStorage && localStorage.getItem("isZohoSmartSigninDone")){
		openSmartSignInPage();
		return false;
	}
	if(!isMobile){$('#login_id').focus()};
	if(isCaptchaNeeded === "true"){
		changeHip();
		$("#captcha_container").show();
		$("#login_id").attr("tabindex", 1);
		$("#captcha").attr("tabindex", 2);
		$("#nextbtn").attr("tabindex", 3);
	}
	if(isValid(CC)){ $("#country_code_select").val($("#"+CC).val()) };
	if(isValid(reqCountry)){
      	reqCountry = "#"+reqCountry.toUpperCase();
      	$('#country_code_select option:selected').removeAttr('selected');
      	$("#country_code_select "+reqCountry).attr('selected', true);
      	$("#country_code_select "+reqCountry).trigger('change');
      }
	$(".select_country_code").text($("#country_code_select").val());
	$("#country_code_select").select2({
        allowClear: true,
        templateResult: format,
        templateSelection: function (option) {
              return option.text;
        },
        language: {
	        noResults: function(){
	            return I18N.get("IAM.NO.RESULT.FOUND");
	        }
	    },
        escapeMarkup: function (m) {
          return m;
        }
      });
      $("#select2-country_code_select-container").html($("#country_code_select").val());
      $("#country_code_select").change(function(){
        $(".country_code").html($("#country_code_select").val());
        $("#select2-country_code_select-container").html($("#country_code_select").val());
        $("#login_id").removeClass("textindent62");
        $("#login_id").removeClass("textintent52");
        $("#login_id").removeClass("textindent42");
        checkTestIndent();
        $(".select2-search__field").attr("placeholder", I18N.get("IAM.SEARCHING"));
        if(isMobile && $(".select_country_code").is(":visible")){
       	   $("#login_id").addClass("textindent62");
           return false;
        }
      });
}
function changeSecDevice(elem){
	var version = $(elem).children("option:selected").attr('version');
	var device_index = $(elem).children("option:selected").val();
	version === "1.0" ? oadevicepos = device_index : mzadevicepos = device_index ;
	version === "1.0" ? enableOneauthDevice() : enableMyZohoDevice();
	hideTryanotherWay();
    if(version == "1.0"){$('.tryanother').hide();};
}
function checkTestIndent(){
	if($("#select2-country_code_select-container").html() && $("#select2-country_code_select-container").html().length=="3"){
        $("#login_id").addClass("textintent52");
        return false;
    }
    if($("#select2-country_code_select-container").html() && $("#select2-country_code_select-container").html().length=="2"){
        $("#login_id").addClass("textindent42");
        return false;
    }
    if($("#select2-country_code_select-container").html() && $("#select2-country_code_select-container").html().length=="4"){
        $("#login_id").addClass("textindent62");
        return false;
    }
}
function loadRightBanner(){
	var action = "/signin/v2/banner"; // no i18n
	if (typeof contextpath !== 'undefined') {
		action = contextpath + action;
	}
	$.ajax({
		  url:  action,
		  data: signinParams,
		  success: function(resp){
			  handleRightBannerDetails(resp);
		  },
		  headers: { 
			  'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8', //no i18n
			  'X-ZCSRF-TOKEN': csrfParam+'='+euc(getCookie(csrfCookieName)) //no i18n
		  }
		});
}
function handleRightBannerDetails(resp){
	var rightboxHtml = $(".rightside_box").html();
	if(IsJsonString(resp)) {
		resp = JSON.parse(resp);
	}
	$('.overlapBanner').remove()
	if(resp.banner[0].template.length === 1){
		$(".rightside_box").html(rightboxHtml +"<div class='overlapBanner' " + resp.banner[0].template+"</div>");
		$(".mfa_panel").hide();
		$('.overlapBanner').show();
	}else if(resp.banner[0].template.length > 1){
		var dottedHtml = bannerHtml = "";
		var bannerDetails = resp.banner[0].template;
		var count;
		bannerDetails.forEach(function(data,index){
            if(index != 0){
               bannerHtml += "<div id='banner_"+index+"' class='rightbanner rightbannerTransition slideright' >"+data+"</div>"; 
            }else{
            	bannerHtml += "<div id='banner_"+index+"' class='rightbanner rightbannerTransition' >"+data+"</div>";
            }
			dottedHtml += "<div class='dot' id='dot_"+index+"'><div></div></div>";
			count = index +1;
		});
		$(".rightside_box").html(rightboxHtml + "<div class='overlapBanner' style='width:300px'>"+bannerHtml+"</div><div class='dotHead'>"+dottedHtml+"</div>");
		$(".mfa_panel").hide();
		$(".overlapBanner,.dotHead").show();
        $("#dot_0").attr("selected",true);
        handleRightBannerAnimation(count); 
	}else{
		hiderightpanel();
	}
}
function handleRightBannerAnimation(count){
	bannerPosition = 0;
    bannerTimer = setInterval(function(){
        changeBanner(false,bannerPosition,count);
        bannerPosition++;
        if(bannerPosition >= count){
            bannerPosition = 0;
        }
    },5000);
}
function changeBanner(elem,bannerPosition,count){
	bannerPosition = bannerPosition != undefined ? bannerPosition : parseInt(elem.getAttribute('bannerposition'));
    if(bannerPosition === count - 1){
    	$('#banner_0').removeClass('slideright');
    }
    else{        	
    	$('#banner_'+(bannerPosition+1)).removeClass('slideright');
    }
	$('#banner_'+bannerPosition).addClass('slideright');
    var dotPosition = bannerPosition === (count -1) ? 0 : bannerPosition + 1;
 	$(".dot").attr("selected",false);
	$("#dot_"+(dotPosition)).attr("selected",true); // no i18n
}
function hiderightpanel(){
	$(".signin_container").css("maxWidth","500px");
	$(".rightside_box").hide();
	$("#recoverybtn, #problemsignin, .tryanother").css("right","0px");
}
function format (option) {
	var spltext;
      if (!option.id) { return option.text; }
         spltext=option.text.split("(");
         var cncode = $(option.element).attr("data-num");//no i18N 
		 var cnnumber = $(option.element).attr("value");//no i18N
		 var cnnum = cnnumber.substring(1);
		 var flagcls="flag_"+cnnum+"_"+cncode;//no i18N
      var ob = '<div class="pic '+flagcls+'" ></div><span class="cn">'+spltext[0]+"</span><span class='cc'>"+cnnumber+"</span>" ;
      return ob;
 };
function handleRequestCountryCode(resp){
	if(IsJsonString(resp)){resp=JSON.parse(resp) }
	if(resp.isd_code){
		reqCountry = resp.country_code;
		reqCountry = "#"+reqCountry.toUpperCase();
      	$('#country_code_select option:selected').removeAttr('selected');
      	$("#country_code_select "+reqCountry).attr('selected', true);
      	document.getElementById("country_code_select").value = "+" + resp.isd_code;
      	$("#country_code_select "+reqCountry).trigger('change');
      	$("#login_id").removeClass("textindent62");
        $("#login_id").removeClass("textintent52");
        $("#login_id").removeClass("textindent42");
	}
}
function checking(){
	var a=$("#login_id").val();
	var check=/^(?:[0-9] ?){2,1000}[0-9]$/.test(a);
	$(".select2-selection--single").attr("tabindex","-1");//no i18N
	if(!isCountrySelected){
		var reqUrl = uriPrefix +"/accounts/public/api/locate"; // no i18n
		sendRequestWithCallback(reqUrl,"",true,handleRequestCountryCode); // no i18n
		isCountrySelected = true;
	}
	if((check==true)&&(a)){
		try{
			checkTestIndent();
			$(".selection").addClass("showcountry_code");
			if(isMobile){
		  		$('.select_country_code,#country_code_select').show();
		  		$('#country_code_select').select2('destroy');
		  	} 
			else{
				$('.select2').show();
			}
		}catch(err){
			$('.select_country_code,#country_code_select').css("display","block");
			$("#login_id").addClass("textindent62");
		}
	}
	else if(check==false){
        $("#login_id").removeClass("textindent62");
        $("#login_id").removeClass("textintent52");
        $("#login_id").removeClass("textindent42");
		$(".selection").removeClass("showcountry_code");
		$('.select_country_code,#country_code_select,.select2').hide();
	}
	if(!isMobile && !$(".domainselect").is(":visible")){
		$("#portaldomain .select2").css("display","block");
	}
}
function IsJsonString(str) {
	try {
		$.parseJSON(str);
	} catch (e) {
		return false;
	}
	return true;
}
function isValid(instr) {
	return instr != null && instr != "" && instr != "null";
}

function de(id) {
	return document.getElementById(id);
}

function euc(i) {
	return encodeURIComponent(i);
}

function getCookie(cookieName) {
	var nameEQ = cookieName + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i].trim();
		if (c.indexOf(nameEQ) == 0){ 
			return c.substring(nameEQ.length,c.length)
		};
	}
	return null;
}
function clearCommonError(field){
	var container=field+"_container";//no i18N
	$("#"+field).removeClass("errorborder");
	$("#"+container+ " .fielderror").slideUp(100);
	$("#"+container+ " .fielderror").removeClass("errorlabel");
	$("#"+container+ " .fielderror").text("");
}
function clearFieldValue(fieldvalue){
	$('#'+fieldvalue).val("");
}
var I18N = {
		data : {},
		load : function(arr) {
			$.extend(this.data, arr);
			return this;
		},
		get : function(key, args) {
			// { portal: "IAM.ERROR.PORTAL.EXISTS" }
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
function resetForm(isfromIP) {
	if(isfromIP && enableServiceBasedBanner)
	{
		$(".signin_container").css("maxWidth","");
		$(".rightside_box").show();
		$("#recoverybtn, #problemsignin, .tryanother").css("right","");
	}
	$("#signuplink").show();
	$("#login_id_container").slideDown(200);
	$("#captcha_container,.textbox_actions,#mfa_device_container,#backupcode_container,#recoverybtn,#waitbtn,.textbox_actions_more,#openoneauth,.textbox_actions_saml,#problemsignin,.nopassword_container,.externaluser_container,.resetIP_container,#continuebtn").hide();
	$("#password_container").addClass("zeroheight");
	$("#password_container,#otp_container").slideUp(200);
	$("#forgotpassword,#nextbtn,#password_container .textbox_div").show();
	$("#smartsigninbtn").removeClass("hide");
	$(".fed_div_text span").text("");
	$(".facebook_fed").removeClass("fed_div_text");
	$(".signin_fed_text").show();
	$("#login").show();
	$("#goto_resetIP").hide();
	$("#nextbtn span").text(I18N.get("IAM.NEXT"));
	$(".backbtn").hide();
	$(".fielderror").removeClass("errorlabel");
	$("input").removeClass("errorborder");
	$(".fielderror").text("");
	var userId = $("#login_id").val();
	$(".select2-selection__arrow").removeClass("hide");
	changeButtonAction(I18N.get('IAM.NEXT'),false);//no i18n
	if(userId.indexOf("-") != -1){
		var phoneId = userId.split("-");
		if(isPhoneNumber(phoneId[1])){
			$("#login_id").val(phoneId[1]);
			$("#select2-country_code_select-container").html("+"+phoneId[0]);
			$( "#country_code_select").val("+"+phoneId[0])
			checking();
		}
	}
	$('#headtitle').text(I18N.get("IAM.SIGNIN"));
	$('.service_name').removeClass('extramargin');
	$('.service_name').html(formatMessage(I18N.get("IAM.NEW.SIGNIN.SERVICE.NAME.TITLE"),displayname));
	if(!isMobile){$(".line").show();}
	$(".fed_2show,#signuplink,#showIDPs,.banner_newtoold,.show_fed").show();
	if(de('forgotpassword')) {
		$("#forgotpassword").removeClass("nomargin");
	}
	de("password").value=""; //No I18N
	$("#login_id").focus();
	isFormSubmited = false;
	signinathmode = "lookup";//No i18N
	callmode="primary"; // No i18n
	isHideFedOptions === 0 ? $(".fed_2show,.line").hide() : fediconsChecking();
	if(isClientPortal){
		return false;
	}
	de("otp").value=""; //No I18N
	
}
function switchto(url){
	clearTimeout(reload_page);
	if(url.indexOf("http") != 0) { //Done for startsWith(Not supported in IE) Check
		var serverName = window.location.origin;
		if (!window.location.origin) {
			serverName = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port: '');
		}
		if(url.indexOf("/") != 0) {
			url = "/" + url;
		}
		url = serverName + url;
	}
	if(isClientPortal && load_iframe){
		window.location.href = url; 
		return false;
	}
	window.top.location.href=url;
}
function showAndGenerateOtp(enablemode){
	prev_showmode = enablemode = enablemode != undefined ? enablemode : allowedmodes.indexOf("email") != -1 ? "email" : "otp"; // no i18n
	if(isPasswordless && typeof enablemode !== "undefined"){
		emobile = enablemode === 'email' ? deviceauthdetails[deviceauthdetails.resource_name].modes.email.data[0].e_email : deviceauthdetails[deviceauthdetails.resource_name].modes.otp.data[0].e_mobile;
		rmobile = enablemode === 'email' ? deviceauthdetails[deviceauthdetails.resource_name].modes.email.data[0].email : deviceauthdetails[deviceauthdetails.resource_name].modes.otp.data[0].r_mobile;
	}
	if(isEmailVerifyReqiured && enablemode == "email"){
		checkEmailOTPInitiate();
		return false;
	}
	generateOTP(false,enablemode);
	return false;
}
function showOtpDetails(){
	$("#password_container").slideUp(300);
	var loginId = deviceauthdetails && deviceauthdetails.lookup.loginid?deviceauthdetails.lookup.loginid:de("login_id").value;//no i18n
	$('.textbox_actions').show();
	if($("#enablemore").is(":visible")){
		$('.textbox_actions').hide();
		$('.textbox_actions,.blueforgotpassword').hide();
		goBackToCurrentMode(true);
	}
	$('#otp_container .username').text(identifyEmailOrNum());
	if(!isClientPortal){enableSplitField("otp",7,I18N.get("IAM.NEW.SIGNIN.OTP"))}
	$("#otp_container").slideDown(300);
	$("#captcha_container,#enableforgot").hide();
	$("#otp").val("");
	if(isClientPortal){$("#otp").focus();}
	changeButtonAction(I18N.get('IAM.VERIFY'),false);//no i18n
	if(isPasswordless){
		$('#signinwithpass,#enableoptionsoneauth').hide();
		$('.signin_head').css('margin-bottom','10px');
		$("#nextbtn span").text(I18N.get('IAM.SIGNIN'));
		$('.username').text(identifyEmailOrNum());
		resendotp_checking(); 
		if (!isRecovery) {allowedModeChecking();}
		$('#problemsignin,#recoverybtn,.tryanother').hide();
		$("#enablemore #resendotp").show();
		$("#enablemore #blueforgotpassword").hide();
		if(secondarymodes.length > 1){
			$(".otp_actions").hide();
		}
		if(isPasswordless){
			var showingmodes = secondarymodes;
			if(showingmodes.length == 3){
				showingmodes.indexOf("password") != -1 ? $("#signinwithpass").show() : showingmodes.indexOf("saml") != -1 ? $("#enablesaml").show() : $("#enablejwt").show();
				$(".otp_actions").show();
			}else{
				$("#enableoptionsoneauth").hide();
				allowedmodes.indexOf("password") != -1 ? $("#signinwithpassoneauth").css("display","block") : $("#signinwithpassoneauth").hide();
				allowedmodes.indexOf("otp") != -1 ? $("#signinwithotponeauth").css("display","block") : $("#signinwithotponeauth").hide();
				allowedmodes.indexOf("email") != -1 ? $("#passlessemailverify").css("display","block") : $("#passlessemailverify").hide();
				allowedmodes.indexOf("saml") != -1 ? $(".signinwithsamloneauth").css("display","block") : $(".signinwithsamloneauth").hide();
				allowedmodes.indexOf("jwt") != -1 ? $(".signinwithfedoneauth").css("display","block") : $(".signinwithfedoneauth").hide();
				allowedmodes.indexOf("federated") != -1 ? $(".signinwithfedoneauth").css("display","block") : $(".signinwithfedoneauth").hide();
				allowedmodes.indexOf("otp") != -1 ? $("#signinwithotponeauth").html(formatMessage(I18N.get("IAM.NEW.SIGNIN.PASSWORDLESS.OTP.VERIFY.TITLE"),deviceauthdetails[deviceauthdetails.resource_name].modes.email.data[0].r_mobile)) : "";
				allowedmodes.indexOf("email") != -1 ? $("#passlessemailverify").html(formatMessage(I18N.get("IAM.NEW.SIGNIN.PASSWORDLESS.EMAIL.VERIFY.TITLE"),deviceauthdetails[deviceauthdetails.resource_name].modes.email.data[0].email)) : "";
				if(prev_showmode == "otp"){
					 $("#signinwithotponeauth").hide()
				}
				if(prev_showmode == "email"){
					$("#passlessemailverify").hide();
				}
			}
			return false;
		}
	}
}
function showPassword(){
	prev_showmode = "password"; // no i18n
	$('#password_container').removeClass('zeroheight');
	$("#otp_container").slideUp(300);
	$("#password_container").slideDown(300);
	changeButtonAction(I18N.get('IAM.SIGNIN'),false);//no i18n
	signinathmode="passwordauth";//no i18N
	$(".mobile_message").hide();
	$("#captcha_container").hide();
	$("#password").focus();
	$(".service_name,#blueforgotpassword").show();
	if(isPasswordless){
		$("#enableotpoption,#enablesaml,#enablejwt,#enablemore .resendotp,#enableoptionsoneauth,#signinwithpassoneauth").hide();
		var showingmodes = secondarymodes;
		if(showingmodes.length == 3){
			showingmodes.indexOf("otp") != -1  || showingmodes.indexOf("email") != -1 ? $("#enableotpoption").show() : showingmodes.indexOf("smal") != -1 ? $("#enablesaml").show() : showingmodes.indexOf("jwt") != -1 ? $("#enablejwt").show() : ""; // no i18n
		}else if(showingmodes.length > 2){
			$("#enablemore").show();
		}
	}
}
function showTryanotherWay(){
	clearInterval(_time);
	clearCommonError("yubikey"); // no i18n
	$('.optionmod').show();
	if(isMobileonly && prev_showmode === "mzadevice"){
		$('.signin_container').addClass('mobile_signincontainer');
		$("#try"+prefoption).hide();
		$('.blur').show();
		$('.blur').addClass('dark_blur');
		allowedModeChecking_mob();
		return false;
	}
	$('.signin_head').css('margin-bottom','10px');
	$(".addaptivetfalist,.borderlesstry,#trytitle").show(); // no i18n
	$("#nextbtn,.service_name,.fieldcontainer,#headtitle,#problemsignin,#recoverybtn_mob,#problemsignin_mob,.verify_title,.tryanother,#totpverifybtn .loadwithbtn").hide();
	$("#trytitle").html("<span class='icon-backarrow backoption' onclick='hideTryanotherWay()'></span>"+I18N.get('IAM.NEW.SIGNIN.TRY.ANOTHERWAY.HEADER')+"");//no i18n
	var preferoption = deviceauthdetails[deviceauthdetails.resource_name].modes.mzadevice.data[mzadevicepos].prefer_option;
	if(preferoption === "totp") { $('#trytotp').hide();}
	if(preferoption === "scanqr") { $('#tryscanqr').hide();}
	preferoption === "totp" ? tryAnotherway('qr') : tryAnotherway('totp'); //no i18n
	if (!isRecovery) {allowedModeChecking();}
	isTroubleSignin =  true;
	return false;
}
function allowedModeChecking_mob(){
	$('.addaptivetfalist').addClass('heightChange')
	$("#recoverybtn,#recoverybtn_mob,#recoverybtn_mob,#recoverybtn").hide();
	allowedmodes.indexOf("recoverycode")!=-1 ? $('#recoverOption').show() : $('#recoverOption').hide();
	isSecondary = deviceauthdetails[deviceauthdetails.resource_name].modes.otp && deviceauthdetails[deviceauthdetails.resource_name].modes.otp.count > 1 ? true : isSecondary;
	!isSecondary ? $('#recoverybtn_mob').show() : $('#problemsignin_mob').show();
	!isSecondary ? $('#problemsignin_mob').hide(): $('#recoverybtn_mob').hide();
	return false;
}
function showmzadevicemodes(){
	$('.devices .selection').css('display','');
	showTryanotherWay();
	$('#problemsigninui,#recoverybtn').hide();
	if (!isRecovery) {allowedModeChecking();}
}
function showproblemsignin(isBackup){
	$('.devices .selection,.devicedetails').hide();
	if(isPasswordless && !isBackup){
		showCurrentMode(allowedmodes[1],0,true);
		return false;
	}
	clearInterval(_time);
	$('.signin_container').removeClass('mobile_signincontainer');
	window.setTimeout(function(){
		$(".blur").hide();
		$('.blur').removeClass('dark_blur');
	},100);
	isMobileonly ? $(".addaptivetfalist").removeClass("heightChange") : $(".addaptivetfalist").hide();
	$('#trytitle').html('');
	secondarymodes.splice(secondarymodes.indexOf(prev_showmode), 1);
	var isAMFA = deviceauthdetails[deviceauthdetails.resource_name].isAMFA;
	var currentmode = (prev_showmode === "mzadevice" && !isMobileonly && !isAMFA) ? "showmzadevicemodes()" : "goBackToCurrentMode()"; //no i18n
	secondarymodes.unshift(prev_showmode);
	var i18n_content = {"totp":["IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR","IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR.DESC"],"otp": ["IAM.NEW.SIGNIN.VERIFY.VIA.OTP","IAM.NEW.SIGNIN.OTP.HEADER"],"yubikey":["IAM.NEW.SIGNIN.VERIFY.VIA.YUBIKEY","IAM.NEW.SIGNIN.VERIFY.VIA.YUBIKEY.DESC"], "password":["IAM.NEW.SIGNIN.MFA.PASSWORD.HEADER","IAM.NEW.SIGNIN.MFA.PASSWORD.DESC"],"saml":["IAM.NEW.SIGNIN.SAML.TITLE","IAM.NEW.SIGNIN.SAML.HEADER"],"jwt":["IAM.NEW.SIGNIN.JWT.TITLE","IAM.NEW.SIGNIN.SAML.HEADER"],"email": ["IAM.NEW.SIGNIN.EMAIL.TITLE","IAM.NEW.SIGNIN.OTP.HEADER"]}; //No I18N
	var i18n_recover = {"otp" : ["IAM.AC.CHOOSE.OTHER_MODES.MOBILE.HEADING", "IAM.NEW.SIGNIN.OTP.HEADER"], "email" : ["IAM.AC.CHOOSE.OTHER_MODES.EMAIL.HEADING", "IAM.NEW.SIGNIN.OTP.HEADER"]}; // no i18n
	var jsonPackage = deviceauthdetails[deviceauthdetails.resource_name];
	var headingcontent = jsonPackage.isAMFA ? "IAM.SIGNIN.AMFA.VERIFICATION.HEADER" : "IAM.NEW.SIGNIN.PROBLEM.SIGNIN"; // no i18n
	var problemsigninheader = "<div class='problemsignin_head'><span class='icon-backarrow backoption' onclick=\""+currentmode+"\"></span><span class='rec_head_text'>"+I18N.get(headingcontent)+"</span></div>";
	var allowedmodes_con = "";
	var noofmodes = 0;
	var i18n_msg = jsonPackage.isAMFA ?  i18n_recover : i18n_content;
	secondarymodes.forEach(function(prob_mode,position){
		var listofmob = jsonPackage.modes.otp && jsonPackage.modes.otp.data;
		if(isValid(listofmob) && listofmob.length > 1 && position === 0 && prob_mode === "otp"){
			listofmob.forEach(function(data, index){
				if(index != mobposition){
					rmobile = data.r_mobile;
					var secondary_header = I18N.get(i18n_msg[prob_mode][0]);
					var secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),rmobile);
					allowedmodes_con += problemsigninmodes(prob_mode,secondary_header,secondary_desc,index);
					noofmodes++;
				}
			});
		}
		var listofemail = jsonPackage.modes.email && jsonPackage.modes.email.data;
		if(isValid(listofemail) && listofemail.length > 1 && position === 0 && prob_mode === "email"){
			listofemail.forEach(function(data, index){
				if(index != emailposition){
					rmobile = data.email;
					var secondary_header = I18N.get(i18n_msg[prob_mode][0]);
					var secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),rmobile);
					allowedmodes_con += problemsigninmodes(prob_mode,secondary_header,secondary_desc,index);
					noofmodes++;
				}
			});
		}
		if(position != 0 || isBackup){
			if(prob_mode != "recoverycode" && prob_mode != "passphrase"){
				if(prob_mode === "oadevice"){
					var oadevice_modes = jsonPackage.modes.oadevice.data;
					oadevice_modes.forEach(function(data,index){
						var oadevice_option = data.prefer_option;
						var device_name = data.device_name;
						var oneauthmode = oadevice_option ==="ONEAUTH_PUSH_NOTIF" ? "push" : oadevice_option === "ONEAUTH_TOTP" ? "totp" : oadevice_option === "ONEAUTH_SCAN_QR" ? "scanqr" : oadevice_option === "ONEAUTH_FACE_ID" ? "faceid": oadevice_option === "ONEAUTH_TOUCH_ID" ? "touchid" : "";//no i18N
						var secondary_header = I18N.get("IAM.NEW.SIGNIN.VERIFY.VIA.ONEAUTH");
						var secondary_desc = formatMessage(I18N.get("IAM.NEW.SIGNIN.VERIFY.VIA.ONEAUTH.DESC"),oneauthmode,device_name);
						allowedmodes_con += problemsigninmodes(prob_mode,secondary_header,secondary_desc,index);
						noofmodes++;
					});
				}else if(prob_mode==="mzadevice"){ // no I18N
					var mzadevice_modes = jsonPackage.modes.mzadevice.data;
					mzadevice_modes.forEach(function(data,index){
						var mzadevice_option = data.prefer_option;
						var device_name = data.device_name;
						var secondary_header = deviceauthdetails[deviceauthdetails.resource_name].isAMFA ? I18N.get("IAM.AC.CHOOSE.OTHER_MODES.DEVICE.HEADING") : I18N.get("IAM.NEW.SIGNIN.VERIFY.VIA.ONEAUTH");
						var secondary_desc = formatMessage(I18N.get("IAM.NEW.SIGNIN.VERIFY.VIA.ONEAUTH.DESC"),mzadevice_option,device_name);
						allowedmodes_con += problemsigninmodes(prob_mode,secondary_header,secondary_desc,index);
						noofmodes++;
					});
				}else if(prob_mode==="otp"){//no i18n
					listofmob.forEach(function(data,index){
						if(index != mobposition){
							rmobile = data.r_mobile;
							var secondary_header = I18N.get(i18n_msg[prob_mode][0]);
							var secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),rmobile);
							allowedmodes_con += problemsigninmodes(prob_mode,secondary_header,secondary_desc,index);
							noofmodes++;
						}
					});
				}else if(prob_mode==="email"){//no i18n
					listofemail.forEach(function(data,index){
						if(index != emailposition){
							rmobile = data.email;
							var secondary_header = I18N.get(i18n_msg[prob_mode][0]);
							var secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),rmobile);
							allowedmodes_con += problemsigninmodes(prob_mode,secondary_header,secondary_desc,index);
							noofmodes++;
						}
					});
				}else if(prob_mode==="federated"){ // no i18n
					var count = jsonPackage.modes.federated.count;
					var idp = jsonPackage.modes.federated.data[0].idp.toLocaleLowerCase();
					var secondary_header = count > 1 ? I18N.get("IAM.NEW.SIGNIN.MORE.FEDRATED.ACCOUNTS.TITLE") : "<span style='text-transform: capitalize;'>"+idp+"</span>";
					var secondary_desc =  count > 1 ? I18N.get("IAM.NEW.SIGNIN.MORE.FEDRATED.ACCOUNTS.DESC") : formatMessage(I18N.get("IAM.NEW.SIGNIN.IDENTITY.PROVIDER.TITLE"),idp);
					allowedmodes_con += problemsigninmodes(prob_mode,secondary_header,secondary_desc,count);
					noofmodes++;
				}else if(prob_mode==="email"){//no i18n
					rmobile = jsonPackage.modes.email.data[0].email;
					var secondary_header = I18N.get(i18n_msg[prob_mode][0]);
					var secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),rmobile);
					allowedmodes_con += problemsigninmodes(prob_mode,secondary_header,secondary_desc);
					noofmodes++;
				}else if(prob_mode==="saml"){// no i18n
					var saml_option = jsonPackage.modes.saml.data;
					saml_option.forEach(function(data,index){
						var secondary_header = formatMessage(I18N.get(i18n_msg[prob_mode][1]),data.auth_domain);
						var secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),data.domain);
						allowedmodes_con += problemsigninmodes(prob_mode,secondary_header,secondary_desc,index);
						noofmodes++;
					});
				}
				else if(prob_mode==="yubikey"){
					var secondary_header = I18N.get(i18n_msg[prob_mode][0]);
					var secondary_desc = I18N.get(i18n_msg[prob_mode][1]);
					allowedmodes_con += problemsigninmodes(prob_mode,secondary_header,secondary_desc);
					noofmodes++;
				}
				else{	
					if(i18n_msg[prob_mode]){
						var jwtDesc;
						if(prob_mode==="jwt"){
							var domainname = deviceauthdetails[deviceauthdetails.resource_name].modes.jwt.domain;
							jwtDesc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),domainname);
						}
						var secondary_header = I18N.get(i18n_msg[prob_mode][0]);
						var secondary_desc = prob_mode==="jwt" ? jwtDesc : I18N.get(i18n_msg[prob_mode][1]);
						allowedmodes_con += problemsigninmodes(prob_mode,secondary_header,secondary_desc);
						noofmodes++;
					}
				}
			}
			else if(prob_mode === "recoverycode"){
				$('#recoverOption').show();
			}
		} 
	});
	$('#problemsigninui').html(problemsigninheader +"<div class='problemsignincon'>"+ allowedmodes_con+"</div>");
	if($(".tryanother").is(":visible")){
		$('.tryanother').hide();
	}
	if(noofmodes > 3 && !isMobile && !isBackup){
		$('.problemsignincon').addClass('problemsignincontainer');
	}
	$('.optionstry').addClass('optionmod')
	$('#recoverybtn').show();
	var problemmode = allowedmodes[0];//no i18N
	$('#problemsignin,#headtitle,.service_name,.fieldcontainer,#nextbtn').hide();
	$('#problemsigninui').show();
}
function problemsigninmodes(prob_mode,secondary_header,secondary_desc,index){
	return  "<div class='optionstry options_hover' id='secondary_"+prob_mode+"' onclick=showCurrentMode('"+prob_mode+"',"+index+")>\
			<div class='img_option_try img_option icon-"+prob_mode+"'></div>\
			<div class='option_details_try'>\
				<div class='option_title_try'>"+secondary_header+"</div>\
				<div class='option_description'>"+secondary_desc+"</div>\
			</div>\
			</div>"
}
function showallowedmodes(enablemode,mode_index){
	$('#enablemore').show();
	var lastviewed_mode = prev_showmode;
	prev_showmode= enablemode === "federated"? prev_showmode : enablemode; // no i18n
	if(enablemode === 'saml'){
		$('#enablemore').hide();
		$(".blur,.loader").show();
		var samlAuthDomain = deviceauthdetails.lookup.modes.saml.data[mode_index].auth_domain;
		enableSamlAuth(samlAuthDomain);
		$(".blur,.loader").hide();
		return false;
		
	}
	else if(enablemode === 'jwt'){
		$(".blur,.loader").show();
		var redirectURI = deviceauthdetails.lookup.modes.jwt.redirect_uri;
		switchto(redirectURI);
		$(".blur,.loader").hide();
		return false;
		
	}
	else if(enablemode === 'otp' || enablemode === 'email'){ //no i18n
		emobile = enablemode === 'email' ? deviceauthdetails[deviceauthdetails.resource_name].modes.email.data[0].e_email : deviceauthdetails[deviceauthdetails.resource_name].modes.otp.data[0].e_mobile;
		rmobile = enablemode === 'email' ? deviceauthdetails[deviceauthdetails.resource_name].modes.email.data[0].email : deviceauthdetails[deviceauthdetails.resource_name].modes.otp.data[0].r_mobile;
		if(deviceauthdetails.lookup.isUserName && enablemode === 'email'){
			checkEmailOTPInitiate();
			prev_showmode = lastviewed_mode;
			return false;
		}
		$("#resendotp").show();
		enableOTP(enablemode);
		return false;
	}
	else if(enablemode === 'password'){
		$('#enableotpoption,#resendotp').hide();
		$(".blueforgotpassword").show();
		showPassword();
		goBackToCurrentMode(true);	
	}
	else if(enablemode === "federated"){//No i18N
		var idp = deviceauthdetails.lookup.modes.federated.data[0].idp.toLowerCase();
		mode_index == 1 ? createandSubmitOpenIDForm(idp) : showMoreFedOptions();
		return false;
	}
	return false;
}
function goBackToCurrentMode(isLookup){
	$('#headtitle,.signin_head,.service_name,.fieldcontainer,#nextbtn').show();
	$(".devices .selection,.devicedetails").hide();
	$('#problemsigninui,#recoverybtn').hide();
	prev_showmode === "mzadevice" ? $(".tryanother,.devices .selection").show() : $('.rnd_container').hide(); // no i18n
	var isAMFA = deviceauthdetails[deviceauthdetails.resource_name].isAMFA;
	if(isAMFA){
		allowedModeChecking();
		$(".tryanother").hide()
	}
	if(!isLookup && !$(".addaptivetfalist").is(":visible") && !isRecovery){
		allowedModeChecking();
	}
	if($("#waitbtn").is(":visible")||$("#mfa_scanqr_container").is(":visible")){
		$("#nextbtn").hide();
	}
	
}
function hideTryanotherWay(){
   		$("#trytitle,.borderlesstry,#recoverybtn,#problemsignin,#verify_totp_container,#verify_qr_container").hide();
   		isMobileonly ? $(".addaptivetfalist").removeClass("heightChange") : $(".addaptivetfalist").hide();
   		$(".service_name,.fieldcontainer,#headtitle").show();
   		prefoption = deviceauthdetails[deviceauthdetails.resource_name].modes.mzadevice.data[mzadevicepos].prefer_option;
   		if(prefoption==="totp"){$("#nextbtn").show();}
   		$(".tryanother").show();
   		var isAMFA = deviceauthdetails[deviceauthdetails.resource_name].isAMFA;
   		if(isAMFA){
   			allowedModeChecking();
   			$(".tryanother").hide()
   		}
   		$('.signin_container').removeClass('mobile_signincontainer');
   		window.setTimeout(function(){
   			$(".blur").hide();
   			$('.blur').removeClass('dark_blur');
   		},250);
   		isTroubleSignin = false;
   		$('#verify_qrimg').attr('src','');
   		return false;
}
function showCaptcha(btnstatus,isSubmitted,submit_id){
	$("#captcha_container").show();
	$("#captcha").focus();
	clearCommonError('captcha');//no i18N
	changeButtonAction(btnstatus,isSubmitted);
	$("#"+submit_id).attr("tabindex", 1);
	$("#captcha").attr("tabindex", 2);
	$("#nextbtn").attr("tabindex", 3)
	if(isClientPortal){
		var iFrame = parent.document.getElementById('zs_signin_iframe');
		if(iFrame){
			iFrame.style.height=iFrame.contentWindow.document.body.scrollHeight +'px';
		}
	}
	return false;
}
function changeHip(cImg,cId) {
	cId = isValid(cId) ? cId : "captcha"; //no i18N
	var captchaReqUrl = 'webclient/v1/captcha?';//no i18n
	sendRequestWithCallback(captchaReqUrl, '{"captcha":{"digest":"'+cdigest+'","usecase":"signin"}}', false, handleChangeHip); //No I18N
	showHip(cdigest, cImg);
    de(cId).value = ''; //No I18N
}
function showHip(cdigest, cImg) {
	 var captcha_resp = isValid(cdigest) ? doGet('webclient/v1/captcha/'+cdigest) : "";//no i18n
	 if(IsJsonString(captcha_resp)) {
		 captcha_resp = JSON.parse(captcha_resp);
	 }
	 var captchimgsrc = captcha_resp.cause==="throttles_limit_exceeded" || !isValid(cdigest) ? "../v2/components/images/hiperror.gif": captcha_resp.captcha.image_bytes;//no i18N
	 cImg = isValid(cImg) ? cImg : "captcha_img"; //No I18N
	 de("captcha").value = '';//no i18n
	 var hipRow = de(cImg); //No I18N
	 var captchaImgEle = document.createElement("img");
	 captchaImgEle.setAttribute("name", "hipImg");
	 captchaImgEle.setAttribute("id", "hip");
	 $('.reloadcaptcha').attr("title", I18N.get("IAM.NEW.SIGNIN.TITLE.RANDOM"));
	 captchaImgEle.setAttribute("align", "left");
	 captchaImgEle.setAttribute("src", captchimgsrc);
	 if(!isMobile){ $(captchaImgEle).css("mix-blend-mode","multiply");}//no i18N
	 $(hipRow).html(captchaImgEle);
}
function handleChangeHip(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if(jsonStr.cause==="throttles_limit_exceeded"){
			cdigest = '';
			showHip(cdigest); //no i18N 
			showCaptcha(I18N.get("IAM.NEXT"),false);;//no i18N
			return false;
		}
		cdigest = jsonStr.digest;
	}
	return false;
}

function handleMfaForIdpUsers(idpdigest){
	if(isValid(idpdigest)){
		$(".blur,.loader").show();
		$("#smartsigninbtn").addClass("hide");
		window.setTimeout(function(){$(".blur,.loader").hide();},1000);
		var loginurl = "signin/v2/lookup/"+idpdigest+"?mode=secondary";//no i18N
		var params = signinParams; //no i18N
		if(isValid(csrfParam)){
			params = params + '&' + csrfParam+'=' + getCookie(csrfCookieName);
		}
		var resp = getPlainResponse(loginurl,params);
		if(IsJsonString(resp)) {
			var jsonStr = JSON.parse(resp);
			var statusCode = jsonStr.status_code;
			if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
				$(".fed_2show,.line,#signuplink,#login_id").hide();
				$("#login_id_container,#showIDPs").slideUp(200);
				signinathmode = jsonStr.resource_name;
				restrictTrustMfa = jsonStr[signinathmode].restrict_trust_mfa;
				if(!restrictTrustMfa) {
					trustMfaDays = ''+jsonStr[signinathmode].trust_mfa_days;
				}
				allowedmodes = jsonStr[signinathmode].modes.allowed_modes;
				if(allowedmodes[0]==="mzadevice"){
					prev_showmode = allowedmodes[0];
					secondarymodes = allowedmodes;
					callmode = "secondary";	//no i18n
					zuid = jsonStr.lookup.identifier;
					temptoken = jsonStr.lookup.token;
					deviceauthdetails=jsonStr;
					enableMyZohoDevice(jsonStr);
					handleSecondaryDevices(allowedmodes[0]);
					return false;
				}else{
					handlePasswordDetails(resp);
					return false;
				}
			}else{
				if(jsonStr.cause==="throttles_limit_exceeded"){
					showCommonError("login_id",jsonStr.localized_message); //no i18n
					return false;
				}
				showCommonError("login_id",jsonStr.localized_message); //no i18n
				return false;
			}
		}
		return false;
	}
	return false;
}
function tryAnotherway(trymode){
	if(!($('#verify_'+trymode+'_container').is(":visible"))){
		$('#verify_totp').val('');
		clearCommonError('verify_totp'); // no i18n
		prefoption = trymode === 'qr' ? 'scanqr' : trymode; // no i18n
		$('.verify_totp,.verify_qr').slideUp(200);
		$('.verify_'+trymode).slideDown(200);
		$('.optionstry').removeClass("toggle_active");
		$('.verify_'+trymode).parent().addClass("toggle_active");
		if(!isClientPortal){enableSplitField("verify_totp",6,I18N.get("IAM.NEW.SIGNIN.VERIFY.CODE"))}
		else{$('#verify_totp').focus();}
		if(trymode === 'qr' &&  $('#verify_qrimg').attr('src') === ""){
			$('.verify_qr .loader,.verify_qr .blur').show();
			enableQRCodeimg();
		}
	}
	return false;
}
function showResendPushInfo(){
	$(".loadwithbtn").show();
	$(".waitbtn .waittext").text(I18N.get("IAM.NEW.SIGNIN.WAITING.APPROVAL"));
	$("#waitbtn").attr("disabled", true);
	showTopNotification(formatMessage(I18N.get("IAM.RESEND.PUSH.MSG")));
	window.setTimeout(function (){
		$(".waitbtn .waittext").text(I18N.get("IAM.PUSH.RESEND.NOTIFICATION"));
		$(".loadwithbtn").hide();
		$("#waitbtn").attr("disabled", false);
		isFormSubmited = false;
		return false;
		
	},25000);
	return false;
}
function showTrustBrowser(){
	prefoption = prefoption ==="ONEAUTH_PUSH_NOTIF" ? "push" : prefoption === "ONEAUTH_TOTP" ? "totp" : prefoption === "ONEAUTH_SCAN_QR" ? "scanqr" : prefoption === "ONEAUTH_FACE_ID" ? "faceid": prefoption === "ONEAUTH_TOUCH_ID" ? "touchid" : prefoption;//no i18N
	prefoption = isValid(prefoption) ? prefoption : allowedmodes[0];//no i18n
	$(".mod_sername").html(formatMessage(I18N.get("IAM.NEW.SIGNIN.TRUST.HEADER."+prefoption.toUpperCase()),trustMfaDays)); // no i18n
	$("#signin_div,.rightside_box,.zoho_logo,.loadwithbtn").hide();
	$(".trustbrowser_ui,.trustbrowser_ui #headtitle,.zoho_logo,.mod_sername").show();
	$(".signin_container").addClass("trustdevicebox");
	$(".signin_box").css("minHeight","auto");
	$(".signin_box").css("padding","40px");
	return false;
}
function checkEmailOTPInitiate(){
	$('#login,#enablemore').hide();
	$('.emailcheck_head').show();
	$("#emailcheck").val("");
	$("#emailcheck_container").show();
	$("#emailverify_desc").html(formatMessage(I18N.get("IAM.NEW.SIGNIN.VERIFY.EMAIL.DESC"),rmobile));
	clearCommonError('emailcheck'); // no i18n
	return false;
}
function hideEmailOTPInitiate(){
	$('#login').show();
	if(isPasswordless){$('#enablemore').show();}
	$("#emailcheck_container, .resendotp").hide();
	return false;
}
function verifyEmailValid(){
	generateOTPAuth(false,"EMAIL"); // no i18n
	return false;
}
function enableEmailOTPDetails(resp){
	var jsonStr = JSON.parse(resp);
	signinathmode = jsonStr.resource_name;
	var statusCode = jsonStr.status_code;
	if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
		var successCode = jsonStr.code;
		if(successCode === "SI201"|| successCode==="SI200" ){
			mdigest = jsonStr[signinathmode].mdigest;
			$(".emailverify_head .backup_desc").html(formatMessage(I18N.get("IAM.NEW.SIGNIN.VERIFY.EMAIL.OTP.TITLE"),rmobile));
			$("#emailverify_container,.emailverify_head").show();
			$("#emailcheck_container").hide();
			if(!isClientPortal){enableSplitField("emailverify",7,I18N.get("IAM.NEW.SIGNIN.OTP"))}
			showTopNotification(formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.SENT"),rmobile));
			$("#emailverify_container .showmoresigininoption").show();
			$("#emailverify_container .signinwithjwt,#emailverify_container .signinwithsaml,#emailverify_container #signinwithpass").hide();
			$(".resendotp").show();
			resendotp_checking();
		}
	}
	else{
		if(jsonStr.cause==="throttles_limit_exceeded"){
			showCommonError("emailcheck",jsonStr.localized_message); // no i18n
			return false;
		}
		var errorMessage = jsonStr.localized_message;
		showCommonError("emailcheck",errorMessage); // no i18n
		return false;
	}
}
function verifyEmailOTP(){
	if(isClientPortal){var OTP_CODE = $("#emailverify").val();}
	else{var OTP_CODE = document.getElementById("emailverify").firstChild.value;}
	if(!isWebAuthNSupported()){ 
		//if yubikey not supported in user's browser, block signin on first factor  form and show not supported error
		showTopErrNotification(I18N.get("IAM.WEBAUTHN.ERROR.BrowserNotSupported"));
		changeButtonAction(I18N.get("IAM.VERIFY"),false);
		return false;
	}
	if(!isValid(OTP_CODE)){
			showCommonError("emailverify",I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY"));//No I18N
			return false;	
	}
	if(isNaN(OTP_CODE) || OTP_CODE.length != 7) {
			showCommonError("emailverify",I18N.get("IAM.NEW.SIGNIN.INVALID.EMAIL.MESSAGE.NEW"));//no i18n
			return false;
	}
	if( /[^0-9\-\/]/.test( OTP_CODE ) ) {
		showCommonError("emailverify",I18N.get("IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE"));//No I18N
		return false;
	}
	var loginurl = uriPrefix+"/signin/v2/"+callmode+"/"+zuid+"/otp/"+emobile+"?";//no i18N
	loginurl += "digest="+digest+ "&" + signinParams; //no i18N
	var jsonData = { 'otpauth' : { 'code' : OTP_CODE, 'is_resend' : false } };//no i18N
	sendRequestWithCallback(loginurl,JSON.stringify(jsonData),true,handlePasswordDetails,"PUT");//no i18n
	return false;
}
function hideEmailOTPVerify(){
	$("#emailverify_container").hide();
	$("#emailcheck_container").show();
	clearCommonError('emailverify');//No i18N
	return false;
}
function getbackemailverify(){
	$("#emailcheck_container,.emailverify_head").show();
	clearCommonError('emailcheck'); // no i18n
    $("#login").hide();
    return false;
}
function updateTrustDevice(trust){
	trust ? $('.trustbtn .loadwithbtn').show() : $('.notnowbtn .loadwithbtn').show()
	trust ? $('.trustbtn .waittext').addClass('loadbtntext') : $('.notnowbtn .waittext').addClass('loadbtntext');
	$(".trustdevice").attr("disabled", true);
	var loginurl= uriPrefix+"/signin/v2/secondary/"+zuid+"/trust?";//no i18N
	var jsonData = {'trustmfa':{'trust':trust }};//no i18n
	sendRequestWithTemptoken(loginurl,JSON.stringify(jsonData),true,handleTrustDetails);
	return false;
}
function handleTrustDetails(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			signinathmode = jsonStr.resource_name;
			var successCode = jsonStr.code;
			if(successCode === "SI302"|| successCode==="SI200" ||successCode === "SI300" || successCode === "SI301" || successCode === "SI303"){
				switchto(jsonStr[signinathmode].redirect_uri);
				return false;
			}
			return false;
		}else{
			$(".trustdevice").attr("disabled", false);
			$('.trustbtn .loadwithbtn,.notnowbtn .loadwithbtn').hide();
			$('.trustbtn .waittext,.notnowbtn .waittext').removeClass('loadbtntext');
			showTopErrNotification(jsonStr.localized_message);
			return false;
		}
		return false;
	}
}

function getQueryParams(queryStrings){
	var vars={};
	queryStrings=queryStrings.substring(queryStrings.indexOf('?')+1);
	var params = queryStrings.split('&');
	for (var i = 0; i < params.length; i++) {
        var pair = params[i].split('=');
        if(pair.length==2){
        	vars[pair[0]] = decodeURIComponent(pair[1]);        	
        }else{
        	vars[pair[0]] = ""; 
        }
    }
	return vars;
}

function createandSubmitOpenIDForm(idpProvider) 
{
	if(isValid(idpProvider)) {
		var oldForm = document.getElementById(idpProvider + "form");
		if(oldForm) {
			document.documentElement.removeChild(oldForm);
		}
		var form = document.createElement("form");
		var idpurl = isClientPortal ? uriPrefix+"/clientidprequest" : "/accounts/fsrequest";//No I18N
		form.setAttribute("id", idpProvider + "form");
		form.setAttribute("method", "POST");
	    form.setAttribute("action", idpurl);
	    form.setAttribute("target", "_parent");
		
		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "provider");
		hiddenField.setAttribute("value", idpProvider.toUpperCase()); 
		form.appendChild(hiddenField);
        
		hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", csrfParam);
		hiddenField.setAttribute("value", getCookie(csrfCookieName)); 
		form.appendChild(hiddenField);
        
		var params=getQueryParams(location.search);
		for(var key in params) {
			if(isValid(params[key])) {
				hiddenField = document.createElement("input");
				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", key);
				hiddenField.setAttribute("value", params[key]);
				form.appendChild(hiddenField);
			}
		}
		
	   	document.documentElement.appendChild(form);
	  	form.submit();
	}
}
function goToForgotPassword(isIP){
	
	var tmpResetUrl= isIP?getIPRecoveryURL():getRecoveryURL(); 
	var LOGIN_ID = de('login_id').value.trim(); // no i18n
	if(de('login_id') && (isUserName(LOGIN_ID) || isEmailId(LOGIN_ID) || isPhoneNumber(LOGIN_ID.split("-")[1]))){
		var oldForm = document.getElementById("recoveryredirection");
		if(oldForm) {
			document.documentElement.removeChild(oldForm);
		}
		var login_id = isPhoneNumber(LOGIN_ID) ?  $( "#country_code_select" ).val().split("+")[1]+'-'+LOGIN_ID : LOGIN_ID;
		var form = document.createElement("form");
		form.setAttribute("id", "recoveryredirection");
		form.setAttribute("method", "POST");
	    form.setAttribute("action", tmpResetUrl);
	    if(!isClientPortal){
	    	form.setAttribute("target", "_parent");
	    } else {
	    	form.setAttribute("target", "_self");
	    }
		
		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "LOGIN_ID");
		hiddenField.setAttribute("value", login_id ); 
		form.appendChild(hiddenField);
		
	   	document.documentElement.appendChild(form);
	  	form.submit();
	  	return false;
	}
	window.location.href = tmpResetUrl;
}
function iamMovetoSignUp(signupUrl,login_id){
	if(isDarkMode){if(!(signupUrl.indexOf("darkmode=true") != -1)){signupUrl += "&darkmode=true"}}
	if(isValid(login_id)){
		var xhr = new XMLHttpRequest();
		xhr.open("POST", signupUrl, true);
		xhr.setRequestHeader('Content-Type', 'application/json');
		xhr.setRequestHeader('X-ZCSRF-TOKEN',csrfParam+'='+euc(getCookie(csrfCookieName)));
		xhr.onreadystatechange=function() {
		    if(xhr.readyState==4) {
	            if(xhr.status === 200){
	                var oldForm = document.getElementById("signupredirection");
	                if(oldForm) {
	                    document.documentElement.removeChild(oldForm);
	                }
	                var form = document.createElement("form");
	                form.setAttribute("id", "signupredirection");
	                form.setAttribute("method", "POST");
	                form.setAttribute("action", signupUrl);
	                form.setAttribute("target", "_parent");
	        
	                var hiddenField = document.createElement("input");
	                hiddenField.setAttribute("type", "hidden");
	                hiddenField.setAttribute("name", "LOGIN_ID");
	                hiddenField.setAttribute("value", login_id ); 
	                form.appendChild(hiddenField);
	                
	                hiddenField = document.createElement("input");
	                hiddenField.setAttribute("type", "hidden");
	                hiddenField.setAttribute("name", csrfParam);
	                hiddenField.setAttribute("value", getCookie(csrfCookieName)); 
	                form.appendChild(hiddenField);
	                
	                document.documentElement.appendChild(form);
	                form.submit();
	                return false;
	            }
	            else{
	                window.location.href= signupUrl;
				    return false;
	            }
		    }
		};
		xhr.send(); 
	}
	else{
        window.location.href= signupUrl;
	    return false;
    }
}
function register(){
	window.location.href= signup_url;
	return false;
}
function showBackupVerificationCode(){
	$('#login,.fed_2show,#recovery_container,#passphrase_container,#bcaptcha_container').hide();
	hideBkCodeRedirection();
	$('#backup_container,.backuphead,#backupcode_container').show();
	$("#backupcode").focus();
	$('#backup_title').html("<span class='icon-backarrow backoption' onclick='hideCantAccessDevice()'></span>"+I18N.get('IAM.TFA.USE.BACKUP.CODE'));
	$('.backup_desc').html(I18N.get("IAM.NEW.SIGNIN.BACKUP.HEADER"));
	signinathmode = "recoverycodesecauth"; // no i18n
	allowedmodes.indexOf("passphrase") != -1 ? $('#recovery_passphrase').show() : $('#recovery_passphrase').hide();
	return false;
}
function goBackToProblemSignin(){
	$('.devices .selection').css('display','');
	$('.fed_2show,#recovery_container,#backup_container').hide();
	if(isSecondary){
		isMobileonly ? $(".addaptivetfalist").removeClass("heightChange") : $(".addaptivetfalist").hide();
	}
	signinathmode = oldsigninathmode;
	$('#login').show();
	if(isClientPortal){
	$('.alt_signin_head').show();
	}
	return false;
}
function showCantAccessDevice(){
	$('.devices .selection,.devicedetails').hide();
	$('.signin_container').removeClass('mobile_signincontainer');
	allowedmodes.indexOf('passphrase') === -1 ? $('#passphraseRecover').hide() : $('#passphraseRecover').show();
	window.setTimeout(function(){
		$(".blur").hide();
		$('.blur').removeClass('dark_blur');
	},100);
	oldsigninathmode = signinathmode;
	$('#login,.fed_2show,#backup_container,.backuphead').hide();
	if(isClientPortal){
		$(".alt_signin_head").hide();
	}
	$('#recovery_container,#recoverytitle,.recoveryhead').show();
	return false;
}
function hideCantAccessDevice(ele){
    $("#recovery_container").show();
    if($("#backup_container").is(":visible")){$("#backup_container").hide();return false;}
    else if(ele != undefined){$("#"+ele.parentElement.parentElement.id).hide();}
    return false;
}
function verifyBackupCode(){
	var isBcaptchaNeeded = $("#bcaptcha_container").is(":visible");
	if(isBcaptchaNeeded){
		var bcaptchavalue = de('bcaptcha').value.trim();//no i18N
		if(!isValid(bcaptchavalue)) {
			showCommonError("bcaptcha",I18N.get("IAM.SIGNIN.ERROR.CAPTCHA.REQUIRED"));//no i18n
			return false;
		}
		if( /[^a-zA-Z0-9\-\/]/.test( bcaptchavalue ) ) {
			changeHip('bcaptcha_img','bcaptcha');// no i18n
			showCommonError("bcaptcha",I18N.get("IAM.SIGNIN.ERROR.CAPTCHA.INVALID"));//no i18n
			return false;
		}
    }
	if(signinathmode=== "passphrasesecauth"){
		var passphrase = $("#passphrase").val().trim();
		if(!isValid(passphrase)) {
			showCommonError("passphrase",I18N.get("IAM.NEW.SIGNIN.ENTER.VALID.PASSPHRASE.CODE"));//no i18n
			return false;
		}
		var loginurl=uriPrefix+"/signin/v2/secondary/"+zuid+"/passphrase?"+signinParams; // no i18n
		if(isBcaptchaNeeded){loginurl += "&captcha=" +bcaptchavalue+"&cdigest="+cdigest;}
		var recsalt = deviceauthdetails[deviceauthdetails.resource_name].modes.passphrase && deviceauthdetails[deviceauthdetails.resource_name].modes.passphrase.rec_salt;
		if(typeof recsalt !== 'undefined'){
			var derivedKey = sjcl.codec.base64.fromBits(sjcl.misc.pbkdf2(passphrase, sjcl.codec.base64.toBits(recsalt), 100000, 32 * 8));
			var jsonData =  {'passphrasesecauth':{'secret_key': derivedKey }} // no i18n
		}else{
			var jsonData =  {'passphrasesecauth':{'pass_phrase':passphrase }} // no i18n
		}
		sendRequestWithTemptoken(loginurl,JSON.stringify(jsonData),true,handlePassphraseDetails);
		return false;
	}
	var backupcode = $("#backupcode").val().trim();
	backupcode = backupcode.replace(/\s/g, "");
	var objRegExp = /^([a-zA-Z0-9]{12})$/;
	if(!isValid(backupcode)){
		showCommonError("backupcode",I18N.get("IAM.EMPTY.BACKUPCODE.ERROR"));//no i18n
		return false;
	}
	if(!objRegExp.test(backupcode)){
		showCommonError("backupcode",I18N.get("IAM.NEW.SIGNIN.ENTER.VALID.BACKUP.CODE"));//no i18n
		return false;
	}
	var loginurl=uriPrefix+"/signin/v2/secondary/"+zuid+"/recovery?"+signinParams;//no i18n
	if(isBcaptchaNeeded){loginurl += "&captcha=" +bcaptchavalue+"&cdigest="+cdigest;}
	var isAMFA = deviceauthdetails[deviceauthdetails.resource_name].isAMFA;
	var jsonData = isAMFA ?  {'recoverycodesecauth':{'code':backupcode, 'isAMFA' : true }} :  {'recoverycodesecauth':{'code':backupcode }};//no i18n
	sendRequestWithTemptoken(loginurl,JSON.stringify(jsonData),true,handleBackupVerificationDetails);	
	return false;
}
function handleBackupVerificationDetails(resp){
		if(IsJsonString(resp)) {
			var jsonStr = JSON.parse(resp);
			var statusCode = jsonStr.status_code;
			signinathmode = jsonStr.resource_name;
			if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
				var successCode = jsonStr.code;
				var statusmsg = jsonStr.recoverycodesecauth.status;
				if(statusmsg==="success"){
					if(restrictTrustMfa){
						updateTrustDevice(false);
						return false;
					}
					showTrustBrowser();
					return false;
				}else if(successCode==="P500"||successCode==="P501"){//no i18N
					temptoken = jsonStr[signinathmode].token;
					showPasswordExpiry(jsonStr[signinathmode].pwdpolicy);
					return false;
				}
				else{
					showCommonError("backupcode",jsonStr.localized_message);//no i18n
					return false;
				}
			}else{
				if(jsonStr.cause==="throttles_limit_exceeded"){
					showCommonError("backupcode",jsonStr.localized_message); //no i18n
					return false;
				}
				var error_resp = jsonStr.errors[0];
				var errorCode=error_resp.code;
				var errorMessage = jsonStr.localized_message;
				if(errorCode==="IN107" || errorCode === "IN108"){
					$(".fed_2show,.line").hide();
					cdigest=jsonStr.cdigest;
					showHip(cdigest, 'bcaptcha_img'); //no i18N
					$("#bcaptcha_container").show();
					$("#bcaptcha").focus();
					clearCommonError('bcaptcha');//no i18N
					changeButtonAction(I18N.get("IAM.VERIFY"),false);
					if( errorCode === "IN107"){
						showCommonError("bcaptcha",errorMessage); //no i18n	
					}
					return false;
				}else if(errorCode === "R303"){ //no i18N
					showRestrictsignin();
					return false;
				}else{
					showCommonError("backupcode",errorMessage);//no i18n
					return false;					
				}
			}
		return false;
		}
}
function removeParamFromQueryString(param){
	if(isValid(queryString)) {
		var prefix = encodeURIComponent(param);
		var pars = queryString.split(/[&;]/g);
		for (var i = pars.length; i-- > 0;) {
    		var paramObj = pars[i].split(/[=;]/g);
    		if(prefix === paramObj[0]) {
				pars.splice(i, 1);
			}
		}	
		if (pars.length > 0) {
			return pars.join('&');
		}
	}
	return "";
}
function allowedModeChecking(){
	if(secondarymodes.length == 1 || (secondarymodes[1] == "recoverycode" && secondarymodes.length == 2)){
		if(secondarymodes[1] == "recoverycode"){
			$('#recoverOption').show();	
		}
		$('#recoverybtn').show();
		$('#problemsignin').hide();
	}
	else{
		$('#problemsignin').show();
		$('#recoverybtn').hide();
	}
	if(isSecondary){
		$('#problemsignin').show();
		$('#recoverybtn').hide();
	}
	if(secondarymodes.indexOf("passphrase") != -1  && secondarymodes.length <= 3){
		$('#recoverybtn').show();
		$('#problemsignin').hide();
	}
	return false;

}
function showCurrentMode(pmode,index){
	mobposition = emailposition = undefined;
	$('.devices .selection,.devicedetails').hide();
	$("#mfa_totp_container,#mfa_otp_container,#mfa_email_container,#waitbtn,#nextbtn,#mfa_scanqr_container,#mfa_push_container,#openoneauth,#yubikey_container").hide();
	clearInterval(_time);
	$(".tryanother").hide();
	prev_showmode = pmode === "federated" ? prev_showmode : pmode; // no i18n
	clearCommonError(pmode)
	var authenticatemode = deviceauthdetails.passwordauth === undefined ? "lookup" : "passwordauth"; // No I18n
	if(pmode==="otp" || pmode==="email"){
		triggeredUser = true;
		$(".loader,.blur").show();
		var jsonPack = deviceauthdetails[deviceauthdetails.resource_name];
		emobile= pmode==="otp" ? jsonPack.modes.otp.data[index].e_mobile : jsonPack.modes.email.data[index].e_email;
		rmobile= pmode==="otp" ? jsonPack.modes.otp.data[index].r_mobile : jsonPack.modes.email.data[index].email;
		if(isPasswordless && deviceauthdetails.lookup.isUserName){
			checkEmailOTPInitiate();
			return false;
		}else if(isPasswordless){
			showAndGenerateOtp(pmode);
		}
		else{
			generateOTP(false,pmode)
		}
		pmode==="email" ? emailposition = index : mobposition = index; // no i18n
		isPrimaryDevice = true;
		if(isPasswordless){
			var showingmodes = secondarymodes;
			if(showingmodes == 1){
				showingmodes[0] == "otp"  || showingmodes[0] == "email" ? $("#enableotpoption").show() : showingmodes[0] == "saml" ? $("#enablesaml").show() : $("#enablejwt").show();
			}else{
				$("#enablemore").show();
			}
		}
	}
	goBackToProblemSignin();
	if(pmode==="totp"){//No i18N
		enableTOTPdevice(deviceauthdetails,false,false);
		signinathmode="totpsecauth";//no i18N
	}else if(pmode==="oadevice"){//No i18N
		$(".loader,.blur").show();
		isResend = false;
		signinathmode =authenticatemode;
		oadevicepos = index;
		enableOneauthDevice(deviceauthdetails,oadevicepos);
	}else if(pmode==="yubikey"){//No i18N
		$(".loader,.blur").show();
		signinathmode =authenticatemode;
		enableYubikeyDevice(deviceauthdetails);
	}else if(pmode === "mzadevice"){//No i18N
		$(".loader,.blur").show();
		isResend = false;
		mzadevicepos = index;
		prefoption = deviceauthdetails[deviceauthdetails.resource_name].modes.mzadevice.data[mzadevicepos].prefer_option;
		enableMyZohoDevice(deviceauthdetails, prefoption);
		if(prefoption === 'totp'){
			goBackToCurrentMode(true);
			if (isRecovery) { $('#problemsignin,#recoverybtn,.tryanother').hide();}
			return false;
		}
	}else if(pmode === "password"){//No i18N
		showPasswordContainer();
	}else if(pmode === "federated"){//No i18N
		var idp = deviceauthdetails.lookup.modes.federated.data[0].idp.toLowerCase();
		index === 1 ? createandSubmitOpenIDForm(idp) : showMoreFedOptions();
		return false;
	}else if(pmode === "saml"){ // no i18n
		$(".blur,.loader").show();
		var samlAuthDomain = deviceauthdetails[deviceauthdetails.resource_name].modes.saml.data[index].auth_domain;
		enableSamlAuth(samlAuthDomain);
		$(".blur,.loader").hide();
		return false;
	}
	else if(pmode === "jwt"){ // no i18n
		var redirectURI = deviceauthdetails[deviceauthdetails.resource_name].modes.jwt.redirect_uri;
		switchto(redirectURI);
	}
	if(pmode != 'mzadevice' && pmode != 'oadevice'){
		$('.deviceparent').addClass('hide');
	}
	goBackToCurrentMode();
	if(isPasswordless){
		$("#headtitle").html(I18N.get("IAM.NEW.SIGNIN.PROBLEM.SIGNIN"));
		$(".service_name").html(I18N.get("IAM.NEW.SIGNIN.PASSWORDLESS.PROBLEM.SIGNIN.HEADER"));
		$(".service_name").addClass("extramargin");
		hideTryanotherWay();
		$('#problemsignin,#recoverybtn,.tryanother,#enableoptionsoneauth').hide();
	}
	if(isRecovery) {$('#problemsignin,#recoverybtn,.tryanother').hide();}
	return false;
}
function showPasswordContainer(){
	$("#nextbtn").attr("disabled", false);
	$("#password").val("");
	prev_showmode = "password"; // no i18n
	$('#password_container,#enableforgot').show();
	$('#enablesaml,#enableotpoption,.textbox_actions,#otp_container').hide();
	$('#password_container').removeClass('zeroheight');
	$('#nextbtn').removeClass('changeloadbtn');
	$('#headtitle').text(I18N.get("IAM.SIGNIN"));
	$('.service_name').removeClass('extramargin');
	$('.service_name').html(formatMessage(I18N.get("IAM.NEW.SIGNIN.SERVICE.NAME.TITLE"),displayname));
	$("#nextbtn span").removeClass("zeroheight");
	$("#nextbtn span").text(I18N.get('IAM.SIGNIN'));
	$('.username').text(identifyEmailOrNum());
	if(isPasswordless && !isRecovery)  { allowedModeChecking() };
	$('.signin_head').css('margin-bottom','30px');
	$('#password').focus();
	signinathmode = "passwordauth";// No i18n
	$("#enableotpoption,#enablesaml,#enablejwt,#enablemore").hide();
	var showingmodes = secondarymodes;
	if(showingmodes.length == 3){
		showingmodes.indexOf("otp") != -1  || showingmodes.indexOf("email") != -1 ? $("#enableotpoption").show() : showingmodes.indexOf("smal") != -1 ? $("#enablesaml").show() : showingmodes.indexOf("jwt") != -1 ? $("#enablejwt").show() : ""; // no i18n
		if(showingmodes.indexOf("otp") != -1){
			$("#signinwithotp").html(I18N.get("IAM.NEW.SIGNIN.USING.MOBILE.OTP"));
		}else if(showingmodes.indexOf("email") != -1){
			$("#signinwithotp").html(I18N.get("IAM.NEW.SIGNIN.USING.EMAIL.OTP"));
		}
	}else if(showingmodes.length > 2){
		$("#enablemore").show();
	}
	isFormSubmited = false;
}
function showMoreFedOptions(){
	var idps = deviceauthdetails[deviceauthdetails.resource_name].modes.federated.data;
	var backFunction = isPrimaryMode ? "showmoresigininoption()" : "showproblemsignin()"; // no i18n
	var problemsigninheader = "<div class='problemsignin_head'><span class='icon-backarrow backoption' onclick="+backFunction+"></span><span class='rec_head_text'>"+I18N.get("IAM.NEW.SIGNIN.FEDERATED.LOGIN.TITLE")+"</span></div>";
	var idp_con = "";
	idps.forEach(function(idps){
		if(isValid(idps)){
			idp = idps.idp.toLowerCase();
			idp_con += "<div class='optionstry options_hover' id='secondary_"+idp+"' onclick=createandSubmitOpenIDForm('"+idp+"')>\
							<div class='img_option_try img_option icon-federated'></div>\
							<div class='option_details_try'>\
								<div class='option_title_try'><span style='text-transform: capitalize;'>"+idp+"<span></div>\
								<div class='option_description'>"+formatMessage(I18N.get("IAM.NEW.SIGNIN.IDENTITY.PROVIDER.TITLE"),idp)+"</div>\
							</div>\
							</div>"
        }
	});	
	$('#problemsigninui').html(problemsigninheader +"<div class='problemsignincon'>"+ idp_con+"</div>");
	$('#password_container,#nextbtn,.signin_head,#otp_container,#captcha_container,.fed_2show').hide();
	$('#problemsigninui').show();
	return false;
}
function enableQRCodeimg(){
	var prefoption = "scanqr"; // no i18n
	var deviceid = deviceauthdetails[deviceauthdetails.resource_name].modes.mzadevice.data[mzadevicepos].device_id;
	var loginurl="/signin/v2/"+callmode+"/"+zuid+"/device/"+deviceid+"?";//no i18N
	loginurl += "digest="+digest+ "&" + signinParams; //no i18N
	var jsonData = callmode==="primary" ? {'deviceauth':{'devicepref':prefoption }}: {'devicesecauth':{'devicepref':prefoption }};//no i18N
	sendRequestWithTemptoken(loginurl,JSON.stringify(jsonData),true,handleQRCodeImg);
	signinathmode = callmode==="primary" ?"deviceauth":"devicesecauth";//no i18N
}
function handleQRCodeImg(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		signinathmode = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			var successCode = jsonStr.code;
			if(successCode === "SI202"||successCode==="MFA302" || successCode==="SI302" || successCode==="SI201"){
				temptoken = jsonStr[signinathmode].token;
				var qrcodeurl = jsonStr[signinathmode].img;
				qrtempId =  jsonStr[signinathmode].temptokenid;
				isValid(qrtempId) ? $("#verify_qr_container #openoneauth").show() : $("#verify_qr_container #openoneauth").hide();
				var wmsid = jsonStr[signinathmode].WmsId && jsonStr[signinathmode].WmsId.toString();
				isVerifiedFromDevice(prefoption,true,wmsid);
				$("#verify_qrimg").attr("src",qrcodeurl);//no i18n
				$('.verify_qr .loader,.verify_qr .blur').hide();
			}
		}else{
			if(jsonStr.cause==="throttles_limit_exceeded"){
				showTopErrNotification(jsonStr.localized_message);
				return false;
			}
			var error_resp = jsonStr.errors && jsonStr.errors[0];
			var errorCode = error_resp && error_resp.code;
			if(errorCode === "R303"){ //no i18N
				showRestrictsignin();
				return false;
			}
			showTopErrNotification(jsonStr.localized_message);
			return false;
	   }
		
	}else{
		showTopErrNotification(I18N.get("IAM.ERROR.GENERAL"));
		return false;
	}
	return false;
}
function showPassphraseContainer(){
	$('#login,.fed_2show,#backupcode_container,#recovery_container,#bcaptcha_container').hide();
	$('#passphrase_container,#backup_container,.backuphead').show();
	signinathmode =  "passphrasesecauth"; //no i18n
	$('#backup_title').html("<span class='icon-backarrow backoption' onclick='hideCantAccessDevice()'></span>"+I18N.get('IAM.NEW.SIGNIN.PASS.PHRASE.TITLE'));
	$('.backup_desc').html(I18N.get("IAM.NEW.SIGNIN.PASS.PHRASE.DESC"));
	allowedmodes.indexOf("recoverycode") != -1 ? $('#recovery_backup').show() : $('#recovery_backup').hide();
}
function hideSigninOptions(){
	$('#enablemore').show();
	$('#nextbtn,.signin_head').show();
	var show_mode = prev_showmode === "email" ? "otp" : prev_showmode; //no i18n
	if(prev_showmode === "password"){
		signinathmode = "passwordauth"; // no i18N
		$(".resendotp").hide()
	}
	$("#"+show_mode+"_container").show();
	$('#problemsigninui').hide();
	return false;
} 
function QrOpenApp() {
	//Have to handle special case!!!
	var qrCodeString = "code="+qrtempId+"&zuid="+zuid+"&url="+iamurl; //No I18N
	document.location= UrlScheme+"://?"+qrCodeString;
	return false;
}
function showRestrictsignin(){
	$('#signin_div,.rightside_box,.banner_newtoold').hide();
	$("#smartsigninbtn").addClass("hide");
	$('#restict_signin').show();
	$(".zoho_logo").addClass('applycenter');
	$('.signin_container').addClass('mod_container');
	return false;
}
function setCookie(x){
	var dt=new Date();
	dt.setDate(dt.getYear() * x);
	var cookieStr = "IAM_TEST_COOKIE=IAM_TEST_COOKIE;expires="+dt.toGMTString()+";path=/;"; //No I18N
	if(cookieDomain != "null"){
		cookieStr += "domain="+cookieDomain; //No I18N
	}
	document.cookie = cookieStr;
}
function submitbackup(event){
	if(event.keyCode === 13){
		verifyBackupCode();
	}
}
function setPassword(event){
	if(event.keyCode === 13){
		updatePassword();
	}
}
function updatePassword(min_Len,max_Len,login_name) {
	remove_error();
    var newpass = $('#new_password').val().trim();
    var confirmpass = $('#new_repeat_password').val().trim();
    var passwordErr = validatePasswordPolicy.getErrorMsg(newpass);
    if(isEmpty(newpass)) {
    	$('#npassword_container').append( '<div class="field_error">'+I18N.get('IAM.ERROR.ENTER.NEW.PASS')+'</div>' );
    	$('#new_password').val("");
    	$('#new_repeat_password').val("");
    	$('#new_password').focus();
    	return false;
    } else if(passwordErr){
    	$('#new_password').focus();
    	return false;
    } else if(newpass == login_name) {
    	$('#npassword_container').append( '<div class="field_error">'+I18N.get('IAM.PASSWORD.POLICY.LOGINNAME')+'</div>' );
    	$('#new_password').focus();
    	return false;
    } else if(isEmpty(confirmpass) || newpass != confirmpass){
    	$('#rpassword_container').append( '<div class="field_error">'+I18N.get('IAM.ERROR.WRONG.CONFIRMPASS')+'</div>' );
    	$('#new_repeat_password').val("");
    	$('#new_repeat_password').focus();
    	return false;
    }
    var loginurl = uriPrefix + "/signin/v2/password/"+zuid+"/expiry?";//no i18N
    var jsonData = {'expiry':{'newpwd':newpass}};//no i18N
    sendRequestWithTemptoken(loginurl,JSON.stringify(jsonData),true,handlePasswordExpiry);
    $("#changepassword span").addClass("zeroheight");
	$("#changepassword").addClass("changeloadbtn");
	$("#changepassword").attr("disabled", true);
    return false;
}
function handlePasswordExpiry(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			if(jsonStr.expiry.status === "success"){
				$("#termin_mob").removeClass("show_oneauth");
				$(".oneAuthLable").hide();
				if(jsonStr.expiry.sess_term_tokens!=undefined	&&	jsonStr.expiry.sess_term_tokens.length>0)
				{
					if(jsonStr.expiry.sess_term_tokens.indexOf("rmwebses")==-1)
					{
						$("#terminate_web_sess").hide();
					}
					if(jsonStr.expiry.sess_term_tokens.indexOf("rmappses")==-1)
					{
						$("#terminate_mob_apps").hide();
					}
					else if(jsonStr.expiry.sess_term_tokens.indexOf("inconeauth")==-1)
					{
						$("#termin_mob").removeClass("show_oneauth");
					}
					else
					{
						$("#termin_mob").addClass("show_oneauth");
					}
					if(jsonStr.expiry.sess_term_tokens.indexOf("rmapitok")==-1)
					{
						$("#terminate_api_tok").hide();
					}
					$(".password_expiry_container").hide();
					$(".terminate_session_container").show();
				}
				else
				{
					send_terminate_session_request(document.terminate_session_container);
				}
			}
		}else{
			showCommonError("npassword",jsonStr.localized_message); //no i18n
		}
	}
	else 
	{
		showTopErrNotification(I18N.get("IAM.ERROR.GENERAL"));
	}
	$("#changepassword span").removeClass("zeroheight");
	$("#changepassword").removeClass("changeloadbtn");
	$("#changepassword").attr("disabled", false);
	return false;
}

function send_terminate_session_request(formElement)
{
	var terminate_web=$('#'+formElement.id).find('input[name="signoutfromweb"]').is(":checked");
	var terminate_mob=$('#'+formElement.id).find('input[name="signoutfrommobile"]').is(":checked");
	var terminate_api=$('#'+formElement.id).find('input[name="signoutfromapiToken"]').is(":checked");
	var include_oneAuth=$('#'+formElement.id).find('#include_oneauth').is(":checked");
	
	var jsonData =
					{
						"expirysessionterminate"://No I18N
						{
							"rmwebses" :terminate_web,//No I18N  
							"rmappses" :terminate_mob,//No I18N  
							"inconeauth" :include_oneAuth,//No I18N 
							"rmapitok" :terminate_api//No I18N 
						}
					};
   
		var terminate_session_url = uriPrefix + "/signin/v2/password/"+zuid+"/expiryclosesession"; //no i18N
	
	sendRequestWithTemptoken(terminate_session_url,JSON.stringify(jsonData),true,handle_terminate_session,"PUT");//no i18N
	$("#terminate_session_submit span").addClass("zeroheight");
	$("#terminate_session_submit").addClass("changeloadbtn");
	$("#terminate_session_submit").attr("disabled", true);
	
	return false;
}

function handle_terminate_session(resp)
{
	if(IsJsonString(resp))
	{
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			if(jsonStr.code=="SES200")
			{
				var terminate_web=$('#termin_web').is(":checked");
				var terminate_mob=$('#termin_mob').is(":checked");
				var terminate_api=$('#termin_api').is(":checked");
				if(terminate_web || terminate_mob || terminate_api)
				{
					showTopNotification(jsonStr.localized_message);
					setTimeout(function(){
						window.location.reload();
					},3000);
				}
				else
				{
					window.location.reload();
				}
				return false;
			}
			else
			{
				showTopErrNotification(jsonStr.message);
				$("#terminate_session_submit span").removeClass("zeroheight");
				$("#terminate_session_submit").removeClass("changeloadbtn");
				$("#terminate_session_submit").attr("disabled", false);
			}
		}
		else
		{
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showTopErrNotification(jsonStr.message);
			}
			else
			{
				var error_resp = jsonStr.errors[0];
				var errorCode=error_resp.code;
				var errorMessage = jsonStr.message;
				showTopErrNotification(jsonStr.message);
			}
		}
	}
	else
	{
		showTopErrNotification(I18N.get("IAM.ERROR.GENERAL"));
	}
	$("#terminate_session_submit span").removeClass("zeroheight");
	$("#terminate_session_submit").removeClass("changeloadbtn");
	$("#terminate_session_submit").attr("disabled", false);
	return false;
}

function showOneAuthTerminate(ele)
{
	 $('#include_oneauth').attr('checked', false);
	 if(ele.checked && $("#termin_mob").hasClass("show_oneauth")){
		 $(".oneAuthLable").slideDown(300).addClass("displayOneAuth");
		 $("#terminate_session_weband_mobile_desc").hide();
		 $(ele).parents(".checkbox_div").addClass("showOneAuthLable");
		 $(".showOneAuthLable").addClass("displayBorder");
	 }
	 else{
		 $(".oneAuthLable").removeClass("displayOneAuth");
		 $(".showOneAuthLable").removeClass("displayBorder");
		 $("#terminate_session_weband_mobile_desc").show();
		 $(".oneAuthLable").slideUp(300,function(){			 
			 $(ele).parents(".checkbox_div").removeClass("showOneAuthLable");
		 });
	 }
}

function showTopNotification(msg)
{
	$(".alert_message").html(msg);
	$(".Alert").css("top","20px");//No i18N
	window.setTimeout(function(){$(".Alert").css("top","-100px")},5000);
}

function showTopErrNotification(msg,help)
{
	$(".error_message").html(msg);
	$(".Errormsg").css("top","20px");//No i18N
	window.setTimeout(function(){$(".Errormsg").css("top","-100px")},5000);
	if(help != undefined && help != ""){
		$(".error_help").css("display","inline-block");
		$(".error_help").html(help);
		$(".error_message").addClass("error_help_in");
		window.setTimeout(function(){$(".error_message").removeClass("error_help_in");$(".error_help").html("")},5500);
	}
}
function showTopErrNotificationStatic(msg,help)
{
	$(".error_message").html(msg);
	$(".Errormsg").css("top","20px");//No i18N
	$('.topErrClose').removeClass("hide");
	$(".error_icon").addClass("err-icon-help");
	if(help != undefined && help != ""){
		$(".error_help").css("display","inline-block");
		$(".error_help").html(help);
		$(".error_message").addClass("error_help_in");
	}
}
function closeTopErrNotification(){
	$(".Errormsg").css("top","-100px");//No i18N
	$("error_message").removeClass("error_help_in");
	$(".error_message").removeClass("error_help_in");
	$(".error_help").css("display","none");
	$(".error_help").html("");
	$(".error_icon").removeClass("err-icon-help");
	if($('.topErrClose').is(":visible")){$('.topErrClose').addClass("hide")}
}
function showPasswordExpiry(pwdpolicy){
	$("#signin_div,.rightside_box").hide();
	$(".password_expiry_container").show();
	$(".signin_container").addClass("mod_container");
	if(pwdpolicy!=undefined)
	{
		if(pwdpolicy.expiry_days!=undefined	&& 	pwdpolicy.expiry_days!=-1){
			$("#password_desc").html(formatMessage(I18N.get("IAM.NEW.SIGNIN.PASSWORD.EXPIRED.ORG.DESC"),pwdpolicy.expiry_days.toString()));
		}else{
			$("#password_desc").html(I18N.get("IAM.NEW.SIGNIN.PASSWORD.EXPIRED.ORG.DESC.NOW"));
		}
		validatePasswordPolicy.init(pwdpolicy, "#npassword_container input");//No I18N
		$("#npassword_container").attr("onkeyup","check_pp()");
		var loginName = de("login_id").value;//no i18N
		$("#changepassword").attr("onclick",'updatePassword('+pwdpolicy.min_length+','+pwdpolicy.max_length+',"'+loginName+'")');
	}
	return false;
}
function checkCookie() {
	if(isValid(getCookie(iam_reload_cookie_name))) {
        window.location.reload();
    }
}
function check_pp() {
	validatePasswordPolicy.validate("#npassword_container input");//no i18N
}
function remove_error()
{
	$(".field_error").remove();
	clearCommonError("npassword");//no i18N
}
function handleCrossDcLookup(loginID){ 
	$(".blur,.loader").show();
	if(isValid(CC)){ $("#country_code_select").val($("#"+CC).val()) };
	if(isValid(CC)){ loginID = loginID.indexOf("-") != -1 ? loginID :$("#"+CC).val().split("+")[1] + "-" + loginID};
	var loginurl = "/signin/v2/lookup/"+loginID; //no i18N
	var params = "mode=primary"+ "&" + signinParams; //no i18N
	sendRequestWithCallback(loginurl, params ,true, handleLookupDetails);//No I18N
	return false;
}
function handleConnectionError(){
	$("#nextbtn span").removeClass("zeroheight");
	$("#nextbtn").removeClass("changeloadbtn");
	$("#nextbtn").attr("disabled", false);
	isFormSubmited = false;
	showTopErrNotification(I18N.get('IAM.PLEASE.CONNECT.INTERNET'))
	return false;
}
function isEmailId(str) {
    if(!str) {
        return false;
    }
    var objRegExp = new XRegExp("^[\\p{L}\\p{N}\\p{M}\\_]([\\p{L}\\p{N}\\p{M}\\_\\+\\-\\.\\'\\&\\!\\*]*)@(?=.{4,256}$)(([\\p{L}\\p{N}\\p{M}]+)(([\\-\\_]*[\\p{L}\\p{N}\\p{M}])*)[\\.])+[\\p{L}\\p{M}]{2,22}$","i"); // No I18N
    return XRegExp.test(str.trim(), objRegExp);
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
    objHTTP.setRequestHeader('Content-length', params.length);
    objHTTP.send(params);
    return objHTTP.responseText;
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
function isUserName(str) {
	if(!str) {
        return false;
    }
	var objRegExp = new XRegExp("^[\\p{L}\\p{N}\\p{M}\\_\\.\\']+$","i"); // No I18N
    return XRegExp.test(str.trim(), objRegExp);
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
function handleDomainForPortal(domains){
	$("#login_id").attr("placeholder","");
	$("#login_id").css("borderRadius","2px 0px 0px 2px");
	$("#portaldomain").show();
	$("#login_id").css("width","55%");
	$("#portaldomain").css("width","45%");
	$("#login_id").css("display","inline-block");
	$.each(domains, function(i, v) {
		var optVal = "@"+v;
		$('#domaincontainer').append($("<option></option>"). attr("value", optVal). text(optVal)); // no i18n
	});
	if(domains.length === 1){
		$("#portaldomain").append("<span onclick='handleDomainChange(true)' class='close'> </span>");
	}else{
		$('#domaincontainer').append($("<option class='removedomain'></option>") .attr("value", "removedomain") .text(I18N.get('IAM.SIGNIN.REMOVE.DOMAIN')));//No I18N
		$(".domainselect").select2({
			allowClear: true,
			width:"100%",			 // No I18N
			theme:"domain_select",	 // No I18N
			minimumResultsForSearch: Infinity,
			templateSelection: function (option) {
				return option.text; 
			},
			escapeMarkup: function (m) {
			  return m;
			}
		  });
	}
	if(isMobile){
		if($(".domainselect").hasClass("select2-hidden-accessible")){
			$(".domainselect").select2('destroy');
		}
		$(".domainselect").show();
	}
	if(domains.length === 1){
		$(".domainselect").show();
		$('#domaincontainer').attr("disabled","disabled");
		$(".domainselect").addClass("hidearrow");
	}else{
		$("#portaldomain .select2-selection").addClass('select2domain');
		$("#portaldomain .select2").css("width","196px !important");
		$("#portaldomain .select2").show();
	}
	
}
function handleDomainChange(isClose){
	if($("#domaincontainer").val()==="removedomain" || isClose===true){
		$("#login_id").css("borderRadius","2px");
		$("#portaldomain").hide(0,function(){
			$("#login_id").css("width","100%");
			$("#login_id").focus();
		});
		$(".doaminat").show();
	}
}
function enableDomain(){
	$("#login_id").css("width","55%");
	setTimeout(function(){
		$(".domainselect").val($(".domainselect option:first").val());
		$("#select2-domaincontainer-container").text($(".domainselect").val());	
		$("#portaldomain").css("width","45%");
		$("#login_id").css("display","inline-block");
		$("#login_id").css("borderRadius","2px 0px 0px 2px");
		$(".doaminat").hide();
		$("#portaldomain").show();
	},200);
	
}

function hideBkCodeRedirection(){
	$(".go_to_bk_code_container").removeClass("show_bk_pop");
}
var validatePasswordPolicy = (function(){
	var passwordPolicy = undefined;
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
		init: function(policy, passInputID) {
			passwordPolicy = policy;
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
 		validate: function(passInputID) {
 			remove_error();
			var str=$(passInputID).val();
			this.getErrorMsg(str, setErrCallback);
 		}
	}
})();

function openSmartSignInPage(){
	var smartsigninURL = "/signin?"+signinParams;//No I18N
	if(smartsigninURL.indexOf("QRLogin=false") != -1){smartsigninURL = smartsigninURL.replace("QRLogin=false","QRLogin=true")}
	else if(!smartsigninURL.indexOf("QRLogin=true") != -1){//No I18N
		smartsigninURL+= smartsigninURL.indexOf("?") != -1 ? "&QRLogin=true" :"?QRLogin=true";
	}
	if(isDarkMode){if(!smartsigninURL.indexOf("darkmode=true") != -1){smartsigninURL+= "&darkmode=true"}}
	switchto(smartsigninURL);
}

function enableSplitField(elemID,fieldLength,placeHolder){
	splitField.createElement(elemID,{
		"splitCount":fieldLength,					// No I18N
		"charCountPerSplit" : 1,		// No I18N
		"isNumeric" : true,				// No I18N
		"otpAutocomplete": true,		// No I18N
		"customClass" : "customOtp",	// No I18N
		"inputPlaceholder":'&#9679;',	// No I18N
		"placeholder":placeHolder	// No I18N
		});
}
