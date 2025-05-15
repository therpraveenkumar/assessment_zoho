//$Id$
var resendTimer, resendtiming, altered;
/////////////////
var Account = ZResource.extendClass({
	resourceName: "Account",//No I18N
	identifier: "zaid"	//No I18N  
});
var User  = ZResource.extendClass({
	resourceName: "User",//No I18N
	identifier: "zuid",	//No I18N 
	attrs : [ "first_name","last_name","display_name","gender","country","language","timezone","state" ], // No i18N
	parent : Account
});
var Mfa = ZResource.extendClass({ 
	resourceName: "MFA",//No I18N
	identifier: "mode",	//No I18N 
	attrs : ["activate","makeprimary","mode","primary"],// No i18N
	parent : User
});
var MfaTOTP=  ZResource.extendClass({ 
	resourceName: "MFAOTP",//No I18N
	attrs : ["code"], // No i18N
	path : 'otp',// No i18N
	parent : Mfa
});
var MfaMobile = ZResource.extendClass({ 
	resourceName: "MFAMobile",//No I18N
	attrs : ["mobile","countrycode","code"], // No i18N
	path : 'mobile',// No i18N
	identifier: "number",	//No I18N 
	parent : Mfa
});
var MfaDevice = ZResource.extendClass({ 
	resourceName: "Device",//No I18N
	identifier: "device_token",	//No I18N 
	parent : Mfa
});
var MfaYubikey = ZResource.extendClass({ 
	resourceName: "MFAYubikey",//No I18N
	path : 'yubikey',// No i18N
	attrs : [ "key_name","id","type","rawId","extensions","response"],// No i18N
	parent : Mfa
});
var BackupCodes = ZResource.extendClass({ 
	resourceName: "BackupCodes",//No I18N
	parent : User
});
var Phone = ZResource.extendClass({
	resourceName: "Phone",//No I18N
	identifier: "phonenum",	//No I18N 
	parent : User
});
var MobileMakeMfa = ZResource.extendClass({
	resourceName: "makemfa",//No I18N
	parent : Phone
});
var BackupCodesStatus = ZResource.extendClass({ 
	  resourceName: "status",//No I18N
	  path : 'status',//No I18N 
	  attrs : ["status"], //No I18N
	  parent : BackupCodes
});

function isValidSecurityKeyName(val){
	var pattern = /^[0-9a-zA-Z_\-\+\.\$@\,\:\'\!\[\]\|\u0080-\uFFFF\s]+$/;
	return pattern.test(val.trim());
}

function isOTPValid(code , istotp){
	if(code.length != 0){
		if(istotp){
			var totpsize =Number(totpConfigSize);
			var codePattern = new RegExp("^([0-9]{"+totpsize+"})$");
			if(codePattern.test(code)){
				return true;
			}
		} else {
			var codePattern = new RegExp("^([0-9]{7})$");
			if(codePattern.test(code)){
				return true;
			}
		}
	}
	return false;
}

function makeCredential(options) {
  var makeCredentialOptions = {};
    makeCredentialOptions.rp = options.rp;
    makeCredentialOptions.user = options.user;
    makeCredentialOptions.user.id = strToBin(options.user.id);
    makeCredentialOptions.challenge = strToBin(options.challenge);
    makeCredentialOptions.pubKeyCredParams = options.pubKeyCredParams;
    makeCredentialOptions.timeout  = options.timeout;
    makeCredentialOptions.extensions = {};
    if ('extensions' in options) {
		if ('appidExclude' in options.extensions) {
			makeCredentialOptions.extensions.appidExclude = options.extensions.appidExclude;
		}
	}
    if ('excludeCredentials' in options) {
      makeCredentialOptions.excludeCredentials = credentialListConversion(options.excludeCredentials);
    }
    if ('authenticatorSelection' in options) {
      makeCredentialOptions.authenticatorSelection = options.authenticatorSelection;
    }
    if ('attestation' in options) {
      makeCredentialOptions.attestation = options.attestation;
    }
    return navigator.credentials.create({
      "publicKey": makeCredentialOptions //No I18N
    }).then(function(attestation){
	    $('.yubikey-two').slideUp(300);
	    $('.yubikey-three').slideDown(300, function(){
			$("#yubikey_input").focus();
		});
        var publicKeyCredential = {};
        if ('id' in attestation) {
          publicKeyCredential.id = attestation.id;
        }
        if ('type' in attestation) {
          publicKeyCredential.type = attestation.type;
        }
        if ('rawId' in attestation) {
          publicKeyCredential.rawId = binToStr(attestation.rawId);
        }
        if (!attestation.response) {
			showErrMsg(I18N.get("IAM.WEBAUTHN.ERROR.InvalidResponse"));//No I18N
        }
        var response = {};
        response.clientDataJSON = binToStr(attestation.response.clientDataJSON);
        response.attestationObject = binToStr(attestation.response.attestationObject);

        if (attestation.response.getTransports) {
          response.transports = attestation.response.getTransports();
        }

        publicKeyCredential.response = response;
        credential_data =  publicKeyCredential;
      }).catch(function(err){ 
    	  if(err.name == 'NotAllowedError') {
			showErrMsg(I18N.get("IAM.WEBAUTHN.ERROR.NotAllowedError"));
    	  } else if(err.name == 'InvalidStateError') {
			showErrMsg(I18N.get("IAM.WEBAUTHN.ERROR.InvalidStateError"));
		  } else if(err.name == 'NotSupportedError') {
			showErrMsg(I18N.get("IAM.WEBAUTHN.ERROR.NotSupportedError"));
    	  } else if(err.name == 'AbortError') {
			showErrMsg(I18N.get("IAM.WEBAUTHN.ERROR.AbortError"));
    	  } else {
			showErrMsg(formatMessage(I18N.get("IAM.WEBAUTHN.ERROR.ErrorOccurred"),accounts_support_contact_email_id)+ '<br>' +err.toString()); //no i18n
    	  }
    	  yubikeyOneStepBack();
      });
}

function popup_blurHandler(ind) {
	$(".blur").show();
    $(".blur").css({"z-index":ind, "background-color": "#00000099", opacity: "1" });
    $("body").css({
    	overflow: "hidden" //No I18N
    });
    $(".blur").bind("click", function(){
		$(".delete-cancel-btn").click();
		if($(".msg-popups .oneauth-headerandoptions2:visible").length || $(".msg-popups .bio-steps:visible").length ||
			$(".msg-popups .relogin-desc:visible").length){
			$(".pop-close-btn").click();
		}
		if($(".msg-popups .swap-desc1:visible").length){
			$(".msg-popups .cancel-btn").click();
		}
	})
}
function closePopup(){
	//Dint implement a popup callback since the popups are less
	if($(".confirm-swap:visible").length){
		$(".already-verified-recovery .verified-selected").removeClass("verified-selected");
	}
	if($(".oneauth-headerandoptions2:visible").length){
		setTimeout(function(){
			$(".popup-body").removeClass("padding-oneauthpop");
			$(".msg-popups").css("max-width","600px");
			$(".popup-header").show();
		},200)
		}
	$(".msg-popups").slideUp(200, function(){
		removeBlur();
	});
}
function remove_error(ele) {
	if (ele) {
		$(ele).siblings(".field_error").remove();
	} else {
		$(".field_error").remove();
	}
}
function show_error_msg(sibilingClassorID, msg) {
	var errordiv = document.createElement("div");
    errordiv.classList.add("error_msg"); //No I18N
    errordiv.textContent = msg;
    $(errordiv).insertAfter(sibilingClassorID);
    $(".error_msg").slideDown(150); //No I18N
}

var prevSelect;
function selectandslide(e) {
	//temporary handling for one-header click
	if(e.target.classList.contains("one-header") && e.target.parentNode.classList.contains("empty-oneauth-header")){ //No I18N
		window.open("https://zurl.to/mfa_banner_oaweb", "_blank"); //No I18N
		return;
	}
	if(e.target.classList.contains("add-oneauth") || e.target.classList.contains("download") || e.target.classList.contains("common-btn")){ //No I18N
		return;
	}
	//for unselecting the selected number or device
	if(e.target.parentNode.classList.contains("sms-container") || e.target.parentNode.classList.contains("oneauth-container")){
		if(e.target.parentNode.querySelector(".verified-selected")){
			e.target.parentNode.querySelector(".verified-selected").classList.remove("verified-selected") //No I18N
			$(".pref-info.pref").remove();
			smsPrevSelect = "";
		}
	} 
	//actual selectandslide
	if(prevSelect != undefined && prevSelect.parentNode.classList.contains("oneauth-container") && (!mfaData.devices|| !mfaData.devices.count)){
		$(e.target.nextElementSibling).slideDown(250);
		e.target.querySelector(".down-arrow").classList.add("up"); //No I18N
		if (prevSelect != undefined && prevSelect.nextElementSibling != e.target.nextElementSibling) {
			prevSelect.querySelector(".tag").style.opacity = "1"; //No I18N
			prevSelect.querySelector(".mode-icon").classList.remove("mode-icon-large") //No I18N
			prevSelect.nextElementSibling.style.overflow="hidden"; //No I18N
			$(prevSelect).children(".add-oneauth").slideUp(200);
			prevSelect.classList.remove("empty-oneauth-header"); //No I18N
			prevSelect.querySelector(".add-qr").classList.remove("qr-anim"); //No I18N
			prevSelect.querySelector(".oneauth-desc").style.display = "none"; //No I18N
			$(prevSelect.nextElementSibling).slideUp(250);
			prevSelect.querySelector(".down-arrow").classList.remove("up"); //No I18N
		}
	}
	else if(e.target.parentNode.classList.contains("oneauth-container") && (!mfaData.devices|| !mfaData.devices.count)){
		$(e.target.nextElementSibling).slideDown(250, function(){
				e.target.nextElementSibling.style.overflow="unset"; //No I18N
			e.target.querySelector(".add-qr").classList.add("qr-anim") //No I18N
			e.target.classList.add("empty-oneauth-header"); //No I18N
		});
		$(e.target).children(".add-oneauth").slideDown(200);
		e.target.querySelector(".tag").style.opacity = "0" //No I18N
		e.target.querySelector(".mode-icon").classList.add("mode-icon-large") //No I18N
		e.target.querySelector(".mode-header-texts").classList.add("oneauth-head-text"); //No I18N
		e.target.querySelector(".oneauth-desc").style.display = "block";
		e.target.querySelector(".down-arrow").classList.add("up"); //No I18N
		if (prevSelect != undefined && prevSelect.nextElementSibling != e.target.nextElementSibling) {
			$(prevSelect.nextElementSibling).slideUp(250);
			prevSelect.querySelector(".down-arrow").classList.remove("up"); //No I18N
		}
	}else {
		$(e.target.nextElementSibling).slideDown(250);
		e.target.querySelector(".down-arrow").classList.add("up"); //No I18N
		if (prevSelect != undefined && prevSelect.nextElementSibling != e.target.nextElementSibling) {
			$(prevSelect.nextElementSibling).slideUp(250);
			prevSelect.querySelector(".down-arrow").classList.remove("up"); //No I18N
		}
	}
	prevSelect = e.target;
}

/*function phoneSelectformat(option) {
	var spltext;
	if (!option.id) {
		return option.text;
	}
    spltext = option.text.split("(");
    var num_code = $(option.element).attr("data-num");
    var string_code = $(option.element).attr("value");
    var ob ='<div class="pic flag_' + string_code +'" ></div><span class="cn">' + spltext[0] + "</span><span class='cc'>" + num_code + "</span>";
    return ob;
}
function selectFlag(e) {
	var flagpos = "flag_" + $(e).val().toUpperCase(); //No I18N
	$(".select2-selection__rendered").attr("title", "");
	e.parent().siblings(".select2").find("#selectFlag").attr("class", ""); //No I18N
	e.parent().siblings(".select2").find("#selectFlag").addClass("selectFlag");
	e.parent().siblings(".select2").find("#selectFlag").addClass(flagpos);
}
function codelengthChecking(length_id, changeid) {
	var code_len = $(length_id).attr("data-num").length;
	var length_ele = $(length_id).parent().siblings("#" + changeid);
    length_ele.removeClass("textindent58");
    length_ele.removeClass("textindent66");
    length_ele.removeClass("textindent78");
    if (code_len == "3") {
		length_ele.addClass("textindent66");
	} else if (code_len == "2") {
		length_ele.addClass("textindent58");
	} else if (code_len == "4") {
		length_ele.addClass("textindent78");
	}
	length_ele.focus();
}

var isMobileSelectInit = false;
function mobileSelectInit() {
	$(document.confirm_form.countrycode)
          .select2({
            width: "82px", //No I18N
            templateResult: phoneSelectformat,
            templateSelection: function (option) {
              selectFlag($(option.element));
              codelengthChecking(option.element, "mobile_input"); //No I18N
              return $(option.element).attr("data-num");
            },
            language: {
              noResults: function () {
                return I18N.get("IAM.NO.RESULT.FOUND");
              }
            },
            escapeMarkup: function (m) {
              return m;
            }
          })
          .on("select2:open", function () {
            $(".select2-search__field").attr("placeholder", I18N.get("IAM.SEARCHING"));
		});
    $("#select_phonenumber .select2-selection").append("<span id='selectFlag' class='selectFlag'></span>");
    selectFlag($(document.confirm_form.countrycode).find("option:selected"));
	$(".select2-selection__rendered").attr("title", "");
	$(document.confirm_form.countrycode).on("select2:close", function (e) {
		$(e.target).siblings("input").focus();
    });
    setMobileNumPlaceholder(document.confirm_form.countrycode);
    if(!showMobileNoPlaceholder){
		$("#mobile_input").on("input", function(event){
			numbOnly(event);
		})
	}
	splitField.createElement("otp_split_input", {
		splitCount: 7,
        charCountPerSplit: 1,
        isNumeric: true,
        otpAutocomplete: true,
        customClass: "customOtp",  //No I18N
        inputPlaceholder: "&#9679;",
        placeholder: I18N.get("IAM.ENTER.CODE")
	});
	$("#otp_split_input .splitedText").attr("onkeydown", "clearError('#otp_split_input', event)");
}
var recMobiles =[];
function addNewNumber(e) {
	$(document.verify_sms_form).hide();
	$(".new-number button.back-btn").hide();
	if(mobCount>0){
		$(".new-number button.back-btn").show();
	}
	if(e.target.parentNode.classList.contains("already-verified")){
		$(".already-verified").slideUp(200);
		$(document.confirm_form).show();
	}
	if(e.target.parentNode.classList.contains("already-verified-recovery")){
		$(".already-verified-recovery").slideUp(200);
		$(document.confirm_form).slideDown(200);
	}
	if(e.target.parentNode.classList.contains("add-new-cont")){
		if(mfaData.otp && mfaData.otp.show_suggestion){
			selectRecoveryNumbers(true);
		}else{
			$(document.confirm_form).show();
		}
	}
	if(recMobiles.length<1){
		$(".already-added-but").hide();
	}
	$(".totp-container, .oneauth-container, .yubikey-container").slideUp(200);
	$(".add-new-number").slideUp(200);
	$(".new-number").slideDown(200, function(){
		$("#mobile_input").val("").focus();
	});
	if(nModes > 1){
		$(".sms-container").css("border-bottom","1px solid #d8d8d8")
		$(".show-all-modes-but").slideDown(200);
	}
	if (!isMobileSelectInit) {
		mobileSelectInit();
		if(!IPcountry == ""){
			$(document.confirm_form.countrycode).val(IPcountry);
			$(document.confirm_form.countrycode).trigger('change');
		}
		if(mfaData.otp && mfaData.otp.recovery_count){
			$(".already-added-but").show();
          	recMobiles =  mfaData.otp.recovery_mobile.map(function(arrEle){
					return arrEle.r_mobile;
			})
		}
		isMobileSelectInit = true;
	}
}

var swapElement;
function showConfirmSwap(e){
	if(e.target.classList.contains("verified-checkbox")){
		var swap = e.target.parentNode.dataset.swapnumber;
		var arrpos = e.target.parentNode.dataset.recArr;
		swapElement = e.target.parentNode;
	}else{
		var swap = e.target.dataset.swapnumber;
		var arrpos = e.target.dataset.recArr;
		swapElement = e.target;
	}
	if(mfaData.modes.length == 0){
		document.querySelector(".swap-desc1").textContent = I18N.get("IAM.MFA.ANNOUN.SMS.SWAP.DESC.NEW"); //No I18n
		$(".confirm-swap").html("<span></span>"+I18N.get("IAM.MFA.CHANGE.ENABLE.MFA")); //No I18n
	}
	document.querySelector(".msg-popups .popup-icon").classList.remove("icon-success")  //No I18n
	document.querySelector(".msg-popups .popup-heading").textContent = I18N.get("IAM.MFA.ANNOUN.SMS.SWAP.HEADING");  //No I18n
	document.querySelector(".msg-popups .popup-body").innerHTML = document.querySelector(".number-swap").innerHTML;  //No I18n
	document.querySelector(".msg-popups .pop-close-btn").style.display = "none";
	document.querySelector(".confirm-swap").dataset.swap = swap; //No I18N
	document.querySelector(".confirm-swap").dataset.swapArr = arrpos; //No I18N
	popup_blurHandler(6);
	$(".msg-popups").slideDown(300);
	$(".msg-popups").focus();
}
function swapNumber(e){
	e.target.setAttribute("disabled","");
	e.target.children[0].classList.add("loader");
	mnumb = e.target.dataset.swap;
	arraypos = e.target.dataset.swapArr;
	var payload = MobileMakeMfa.create();
	payload.PUT("self","self",mnumb.split("-")[1]).then(function(resp){ //No I18N
		if(resp.code == "MOB201"){
		e.target.removeAttribute("disabled");
		e.target.children[0].classList.remove("loader");
		if(mfaData.modes.length==0){
			showSuccessMfapop();
			return;
		}
		$(".msg-popups").slideUp();
		removeBlur();
		showErrMsg(resp.localized_message,true);
		if(mobCount){
			mfaData.otp.mobile.push(mfaData.otp.recovery_mobile[arraypos]);
			mfaData.otp.count = mobCount + 1;
		} else {
			mfaData.otp.mobile =  [mfaData.otp.recovery_mobile[arraypos]];
			mfaData.otp.count = 1;
		}
		addConfiguredMobile({"mobile":[mfaData.otp.recovery_mobile[arraypos]], "count":1 }, true); //No I18n
		$(swapElement).animate({ "padding": "0px" , "height": "0px" , "font-size":"0px"}, 200, function(){ $(this).remove()})
		smsPrevSelect ="";
		recMobiles = recMobiles.filter(function(ele){ return ele!== mnumb})
		mfaData.otp.recovery_mobile[arraypos] = {};
		newSms = $(".already-verified .verified-numb-cont")[0];
		$(".new-number").slideUp();
		$(".already-verified-recovery").hide();
		$(".already-verified").slideDown(250,function(){
			newSms.click();
		});
		} else {
			e.target.removeAttribute("disabled");
			e.target.children[0].classList.remove("loader");
			if(resp.cause && resp.cause.trim() === "invalid_password_token") {
				showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
			}else{
				classifyError(resp);
			}
		}
	}, function(resp){
		e.target.removeAttribute("disabled");
		e.target.children[0].classList.remove("loader");
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
			classifyError(resp);
		}
	});
}

function smsAlreadyStepBack(){
	$(".new-number").slideUp(250);
	$(".sms-container .mode-header").click();
	$(".already-verified").slideDown(250);
}
function selectAlreadyNumbers() {
	$(".new-number").slideUp();
	$(".sms-body .already-verified, .sms-container .mode-header").slideDown(200);
	$(".totp-container, .oneauth-container, .yubikey-container").slideDown(200);
	$(".sms-container.mode-cont").css("border-bottom", "1px solid #d8d8d8");
	$(".enable-mfa").show();
}
function selectRecoveryNumbers(isSuggestion, isAlready){
	var parCont = document.querySelector(".already-verified-recovery"); //No I18n
	if( !parCont.querySelector(".verified-numb-cont")){
		for(i = 0; i < mfaData.otp.recovery_mobile.length; i++){
			var verifiedCont = document.querySelector(".verified-numb-cont").cloneNode(true); //No I18N
			var numb = mfaData.otp.recovery_mobile[i].r_mobile.split("-");
			var displayNo = "+"+numb[0]+" "+numb[1];
			verifiedCont.querySelector(".verified-number").textContent = displayNo; //No I18N
			verifiedCont.querySelector(".added-period").textContent = mfaData.otp.recovery_mobile[i].created_time_elapsed; //No I18N
			verifiedCont.querySelector(".delete-icon").style.display = "none";
			verifiedCont.dataset.swapnumber = mfaData.otp.recovery_mobile[i].r_mobile;
			verifiedCont.dataset.recArr = i;
			verifiedCont.addEventListener("click", showConfirmSwap)
			verifiedCont.style.display = "flex";
			parCont.insertBefore(verifiedCont, parCont.querySelector(".add-new-number-but")); //No I18N
		}
	}
	if(isSuggestion){
		parCont.querySelector(".suggest-recovery-desc").style.display="block";
	}else if(isAlready){
		parCont.querySelector(".already-recovery-desc").style.display="block";
		parCont.querySelector(".verified-recovery-desc").style.display="none";
		parCont.querySelector(".suggest-recovery-desc").style.display="none";
	}else{
		parCont.querySelector(".suggest-recovery-desc").style.display="none";
		parCont.querySelector(".already-recovery-desc").style.display="none";
		if(mfaData.otp.recovery_count === 1){
			parCont.querySelector(".verified-recovery-desc.one").style.display="block";
		}else{
			parCont.querySelector(".verified-recovery-desc").style.display="block";
		}	
	}
	if(parCont.querySelector(".verified-selected")){
		parCont.querySelector(".verified-selected").classList.remove("verified-selected"); //No i18n
	}
	$(document.confirm_form).slideUp(200);
	$(parCont).slideDown(200);
}
	  
function isRecoveryNumber(mobNumber){
	for(y=0; y<recMobiles.length; y++){
		if(recMobiles[y] == mobNumber){
			selectRecoveryNumbers(false, true);
			return true;
		}
	}
	return false;
}
*/
var hardKeyTransition;
function addNewYubikey(e) {
	if(e.target.parentNode.classList.contains("already-yubikey-conf")){
		$(".yubikey-one button.back-btn").attr("onclick", "yubikeyAlreadyStepBack()");
		$(".yubikey-one button.back-btn").show();
	}
	if(isMobile && hardKeyTransition === undefined){
		$(".dot_status .dot").removeClass('grow_width');
		$(".dot_status .dot_1").addClass("grow_width");
		hardKeyTransition = setInterval(function(){
		    var cur_grow = $(".dot_status .grow_width");
		    cur_grow.removeClass('grow_width');
		    cur_grow.siblings('.dot').addClass('grow_width');
		    $(".yubikey_anim_container").toggleClass('move_pic');
		},5000)
	}
    $(".sms-container, .totp-container, .oneauth-container").slideUp(200);
    $(".yubikey-body .already-yubikey-conf, .add-new-yubikey").slideUp(200);
    $(".new-yubikey").slideDown(200);
    if(nModes > 1){
		$(".yubikey-container").css("border-bottom","1px solid #d8d8d8")
		$(".show-all-modes-but").slideDown(200);
	}
}

function scanYubikey(){
	var params = {};
	var payload = MfaYubikey.create(params);
	payload.POST("self","self","mode").then(function(resp) //No I18N
    {
		$(".yubikey-one").slideUp(200);
		$(".yubikey-two").slideDown(200);
		if(resp != null)
		{
			yubikey_challenge=resp.mfayubikey[0];
			$("#pop_action .yubikeyregis").hide();
			$("#pop_action #ubkey_wait_butt").show();
			makeCredential(yubikey_challenge);
		}
    },
    function(resp){
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
			classifyError(resp);
		}
	});
}

function configureYubikey()
{
	if(!isWebAuthNSupported()){
		showErrMsg(I18N.get("IAM.WEBAUTHN.ERROR.BrowserNotSupported"));
		return false;
	}
	var name=$("#yubikey_input").val();
	if(isEmpty(name))
	{
		show_error_msg("#yubikey_input", I18N.get("IAM.ERROR.EMPTY.FIELD"));//No I18N
		return false;
	}else if(name.length > 50){
		show_error_msg("#yubikey_input", I18N.get("IAM.TFA.PASSKEY.NAME.MAX.LENGTH.ERROR"));//No I18N
		return false;
	}else if(!isValidSecurityKeyName(name))
	{
		show_error_msg("#yubikey_input", I18N.get("IAM.MFA.YUBIKEY.INVALID.YUBIKEY_NAME.ERROR"));//No I18N
		return false;
	}
	else{
		if(mfaData.yubikey && mfaData.yubikey.yubikey){
		for(y=0;y<mfaData.yubikey.count;y++){
			if(mfaData.yubikey.yubikey[y].key_name === name){
				show_error_msg("#yubikey_input", I18N.get("IAM.TFA.YUBIKEY.EXIST.MSG"));//No I18N
				return false;
			}
		}
	}
	}
	$(".configure-btn span")[0].classList.add("loader");
	$(".configure-btn").attr("disabled","");
	credential_data.key_name = name;
	var payload = MfaYubikey.create(credential_data);
	payload.PUT("self","self","mode","self").then(function(resp){	//No I18N
		if(resp.code === "Y201"){	
		$(".configure-btn span")[0].classList.remove("loader");
		if(mfaData.modes.length==0 || (mfaData.modes.length==1 && mfaData.modes[0] == "otp")){
			setTimeout(function(){
				showSuccessMfapop();
			},1000)
				return;	
		}else{
			showErrMsg(resp.localized_message, true);
		}
		var yubiObject ={key_name: name, created_time_elapsed: I18N.get("IAM.JUST.NOW"), yubikey: true, e_keyName: resp.mfayubikey.yubikey.e_keyName}; //No I18n
		if(keyCount){
			mfaData.yubikey.yubikey.push(yubiObject);
			mfaData.yubikey.count = keyCount+1;
		}else{
			mfaData.yubikey = {"yubikey":[yubiObject]}
			Object.assign(mfaData.yubikey, {"count":1});  //No I18n
			keyCount = 0;
		}
		addConfiguredYubikey({"yubikey": [yubiObject]}, true);
		yubiObject = {};
		setTimeout(function(){
				$(".new-yubikey").slideUp(250);
				$(".already-yubikey-conf").slideDown(250);
				$(".configure-btn").prop("disabled",false);
				$(".yubikey-two, .yubikey-three").hide();
				$("#yubikey_input").val("");
				$(".yubikey-one").show();
				$(".yubikey-body .hidden-checkbox")[0].classList.add("verified-selected");
				$(".yubikey-container .mode-header").click();
		}, 300);
		}
    },
    function(resp)
	{
		$(".configure-btn span")[0].classList.remove("loader");
		$(".configure-btn").removeAttr("disabled","");
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
    		classifyError(resp, "#yubikey_input"); //No I18n
    	}
	});
}

function yubikeyAlreadyStepBack(){
	$(".new-yubikey").slideUp(300);
	$(".already-yubikey-conf").slideDown(300,function(){
		$(".yubikey-container .mode-header").click();
	});
}
function yubikeyStepBack(){
	$(".new-yubikey").slideUp(300);
	$(".add-new-yubikey").slideDown(300);
}
function yubikeyOneStepBack(){
	$(".new-yubikey .yubikey-three, .new-yubikey .yubikey-two").slideUp(300, function(){
		document.querySelector("#yubikey_input").value = ""; //No I18n
		clearError("#yubikey_input"); //No I18n
	});
	$(".new-yubikey .yubikey-one").slideDown(300);
}

function numbOnly(e){
	e.target.value = e.target.value.slice(0, e.target.value.length).replace(/[^0-9]/gi, "");
}
var encKey;
var mobile="";
var mobObject = {};
function sendSms(e){
	if(document.querySelector(".sms-container .send_otp_btn").disabled){
		return false;
	}
	altered = false;
	mobile = $("#mobile_input").val().replace(/[+ \[\]\(\)\-\.\,]/g,'');
	if(mobile == ""){
		show_error_msg("#mobile_input",I18N.get("IAM.ERROR.EMPTY.FIELD")); //No I18n
		return false;
	}
	if(isPhoneNumber(mobile)){
		var dialingCode = $('#countNameAddDiv option:selected').attr("data-num");
		mobObject.r_mobile = dialingCode.split("+")[1]+"-"+mobile;
		if(!(isRecoveryNumber(mobObject.r_mobile))){
		e.target.setAttribute("disabled",'');
		e.target.querySelector("span").classList.add("loader","miniloader","leftMargin"); //No i18N
		$(".resend_otp").html("<div class='loader nonclic'></div>"+I18N.get('IAM.GENERAL.OTP.SENDING'));
		$(".resend_otp").addClass("nonclickelem");
        var countryCode = $('#countNameAddDiv option:selected').attr("id");
        var params = {"mobile":mobile,"countrycode":countryCode}; //No I18N
        mobObject.country_code = countryCode;
        var payload = MfaMobile.create(params);
        var otpform = document.verify_sms_form;
		otpform.querySelector(".valuemobile").textContent = dialingCode+" "+mobile; //No I18N
		document.querySelectorAll(".otp_split_input_otp").forEach(function(eachEle){ eachEle.value =""; }); //No i18n
		clearError("#otp_split_input") //No i18n
		payload.POST("self","self","mode").then(function(resp){ //No I18N
			$(document.confirm_form).slideUp(200, function(){
				e.target.removeAttribute("disabled");
				e.target.querySelector("span").classList.remove("loader","miniloader","leftMargin"); //No i18N
			});
			$(otpform).slideDown(200);
			var mfaMobile=resp.mfamobile;
			mobObject.e_mobile = mfaMobile.encryptedMobile;
			encKey = mfaMobile.encryptedMobile;
			setTimeout(function(){
				$(".resend_otp").html("<div class='tick nonclic'></div>"+I18N.get('IAM.GENERAL.OTP.SUCCESS'));
				setTimeout(function(){
				resendOtpChecking();
				}, 1000);
				}, 800);
		},
		function(resp){
			e.target.removeAttribute("disabled");
			e.target.querySelector("span").classList.remove("loader","miniloader","leftMargin"); //No i18N
			if(resp.cause && resp.cause.trim() === "invalid_password_token") {
				showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
			}else{
				classifyError(resp, "#mobile_input"); //No I18n
			}
			
		});
		}
	}
	else{
		show_error_msg("#mobile_input",I18N.get("IAM.PHONE.ENTER.VALID.MOBILE_NUMBER")); //No I18n
	}
}
/*
function verifySmsOtp(e){
	var code = $("#otp_split_input_full_value").val();
	if(code == ""){
		show_error_msg("#otp_split_input", I18N.get("IAM.ERROR.EMPTY.FIELD"));//No I18N
		return;
	}
	if(!isOTPValid(code)){
		show_error_msg("#otp_split_input", I18N.get("IAM.ERROR.ENTER.VALID.OTP"));//No I18N
		return;
	}
	e.target.setAttribute("disabled",'');
	e.target.querySelector("span").classList.add("loader","miniloader"); //No i18N
	var param = { "code":code }; //No I18N
	var payload = MfaMobile.create(param); 
	payload.PUT("self","self","mode",encKey).then(function(resp){       //No I18N
		if(resp.code === "MOB201"){
			e.target.removeAttribute("disabled");
			e.target.querySelector("span").classList.remove("loader","miniloader"); //No i18N
			$(".verify-btn").html("<div class='verified_tick'></div>"+I18N.get('IAM.VERIFIED')); //No I18N
			if(mfaData.modes.length==0){
				showSuccessMfapop();
				return;	
			}
			mobObject.created_time_elapsed = I18N.get("IAM.JUST.NOW"); //No I18N
			if(mobCount){
				mfaData.otp.mobile.push(mobObject);
				mfaData.otp.count = mobCount + 1;
			} else {
				if(mfaData.hasOwnProperty("otp")){
					Object.assign(mfaData.otp, {"mobile":[mobObject]});
				}else{
					mfaData.otp = {"mobile":[mobObject]};
				}
				Object.assign(mfaData.otp, {"count":1});  //No I18n
				mobCount = 0;
			}
			addConfiguredMobile({"mobile":[mobObject]}, true);
			mobObject = {};
			newSms = $(".already-verified .verified-numb-cont")[0];
			setTimeout(function(){
				$(".new-number").slideUp(250);
				$(".already-verified").slideDown(250,function(){
					newSms.click();
				});
				document.querySelectorAll(".otp_split_input_otp").forEach(function(eachEle){ eachEle.value =""; }); //No i18n
				$(".verify-btn").html("<span></span>"+I18N.get('IAM.VERIFY'));
				resendtiming = 1;
				$(".verify_sms_form").hide();
				$("#mobile_input").val("");
				$(".confirm_form").show();
				
			}, 1500);
		}
	},
	function(resp)
	{
		e.target.removeAttribute("disabled");
		e.target.querySelector("span").classList.remove("loader","miniloader"); //No i18N
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
			classifyError(resp,"#otp_split_input") //No I18N
		}
	});	
}
*/
function allowSubmit(e) {
	if(mobile === e.target.value || mobile === ""){
		altered=false;
		if (!resendtiming == 0) {
			$(".send_otp_btn").prop("disabled", true);
		}
	}
	else {
		altered = true;
		$(".send_otp_btn span").html("");
		$(".send_otp_btn").prop("disabled", false);
		resendtiming = 1;
	}
}
function resendOtpChecking() {
	resendtiming = 60;
	clearInterval(resendTimer);
	$(".resend_otp").addClass("nonclickelem");
	$(".resend_otp span").text(resendtiming);
	$(".resend_otp").html(I18N.get('IAM.TFA.RESEND.OTP.COUNTDOWN'));
	$(".send_otp_btn").prop("disabled", true);
	resendTimer = setInterval(function () {
		resendtiming--;
		$(".resend_otp span").html(resendtiming);
		if(!altered){
			$(".send_otp_btn span").css("margin-left","5px");
			$(".send_otp_btn span").html(resendtiming+"s"); //No I18N
		}
		if (resendtiming == 0) {
			clearInterval(resendTimer);
			$(".resend_otp").html(I18N.get("IAM.TFA.RESEND.OTP"));
			$(".send_otp_btn span").html("");
			$(".send_otp_btn span").css("margin","0px");
			$(".resend_otp").removeClass("nonclickelem");
			$(".send_otp_btn").removeAttr("disabled");
		}
	}, 1000);
}
function showModes(){
	if($(".mode-cont:visible")[0] == $(".mode-cont")[nModes-1]){
		$(".mode-cont:visible").css("border-bottom", "none");	
	}
	$(".mode-cont:hidden").slideDown(200);
	$(".show-all-modes-but").slideUp(200);
}
function editNumber(){
	$(document.verify_sms_form).slideUp(200);
	$(document.confirm_form).slideDown(200);
	$("#mobile_input").focus();
}
function addNewTotp(e){
	if(e.target.parentNode.classList.contains("already-totp-conf")){
		$(".new-totp-codes button.back-btn").show();
		$(".already-totp-conf").slideUp();
		$(document.verify_totp_form).hide();
	}
	$(".sms-container, .oneauth-container, .yubikey-container").slideUp(400);
	if(nModes > 1){
		$(".totp-container").css("border-bottom","1px solid #d8d8d8")
		$(".show-all-modes-but").slideDown(400);
	}
	var payload = MfaTOTP.create();
	payload.POST("self","self","mode").then(function(resp){ //No I18N
		
		var mfaTOTP=resp.mfaotp[0]; 
		de('gauthimg').src="data:image/jpeg;base64,"+mfaTOTP.qr_image;
		var key=mfaTOTP.secretkey;
		var displaykey = "<span>"+key.substring(0, 4)+"</span>"+"<span style='margin-left:5px'>"+key.substring(4, 8)+"</span>"+"<span style='margin-left:5px'>"+key.substring(8,12)+"</span>"+"<span style='margin-left:5px'>"+key.substring(12)+"</span>"; //No I18N
		$('#skey').html(displaykey);
		encKey = mfaTOTP.encryptedSecretKey;	
		$("#gauth_code").keyup(function(event) {
			if (event.keyCode === 13) {
			        $("#auth_app_confirm").click();
			    }
			});
		if(isMobile){
			$(".qr_key_note").text(I18N.get("IAM.TAP.TO.COPY"));
		}
		$(".add-new-totp").slideUp(200);
		$(".new-totp-codes").show();
		$(".new-totp").slideDown(200);
	},
	function(resp){
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
			classifyError(resp);
		}
		if(e.target.parentNode.classList.contains("already-totp-conf")){
				$(".already-totp-conf").slideDown();
				$(".new-totp-codes button.back-btn").hide();
		}
	});
}
var smsPrevSelect;
function selectNumberDevice(e){
	var isCheckbox = e.target.classList.contains("verified-checkbox");//No I18N
	if(isCheckbox){
		e.target.classList.add("verified-selected");//No I18N
		if(smsPrevSelect != e.target.parentNode &&  !e.target.parentNode.parentNode.classList.contains("already-verified-recovery")){
			if($(e.target).parents(".sms-body").length){
				if(mfaData.otp.count>1){
					showPreferedInfo(e.target.parentNode);
				}
			}else if($(e.target).parents(".oneauth-body").length){
				if(mfaData.devices.count>1){
					showPreferedInfo(e.target.parentNode);
				}
			}
		}
		if(smsPrevSelect && smsPrevSelect != e.target.parentNode){
			smsPrevSelect.querySelector(".verified-checkbox").classList.remove("verified-selected");//No I18N
			if(!smsPrevSelect.parentNode.classList.contains("already-verified-recovery") && !smsPrevSelect.parentNode.classList.contains("delpref-cont")){
				smsPrevSelect.querySelector(".pref-info").remove(); //No I18N
			}	
		}
		smsPrevSelect = e.target.parentNode;
	}
	else if(e.target.classList.contains("verified-app-cont")|| e.target.classList.contains("verified-numb-cont")){
		e.target.querySelector(".verified-checkbox").classList.add("verified-selected");//No I18N
		if(smsPrevSelect != e.target && ! e.target.parentNode.classList.contains("already-verified-recovery")){
			if($(e.target).parents(".sms-body").length){
				if(mfaData.otp.count>1){
					showPreferedInfo(e.target);
				}
			}else if($(e.target).parents(".oneauth-body").length){
				if(mfaData.devices.count>1){
					showPreferedInfo(e.target);
				}
			}
		}
		if(smsPrevSelect && smsPrevSelect != e.target){
			smsPrevSelect.querySelector(".verified-checkbox").classList.remove("verified-selected");//No I18N
			if(smsPrevSelect != e.target && !smsPrevSelect.parentNode.classList.contains("already-verified-recovery")){
				if(smsPrevSelect.querySelector(".pref-info")){
					smsPrevSelect.querySelector(".pref-info").remove(); //No I18N
				}
			}
		}
		smsPrevSelect = e.target;
	}
	
	if(nModes > 1){
		if($(".already-verified:visible").length || $(".already-verified-recovery:visible").length){
		$(".totp-container, .oneauth-container, .yubikey-container").slideUp(200);
		}else if($(".already-verified-app:visible").length){
			$(".totp-container, .sms-container, .yubikey-container").slideUp(200);
		}
		$(".show-all-modes-but").slideDown(200);
	}
}

/*function resendSms(){
	if($(".resend_otp").is(":visible")){
		$(".resend_otp").addClass("nonclickelem");
		$(".resend_otp").html("<div class='loader nonclic'></div>"+I18N.get('IAM.GENERAL.OTP.SENDING'));
	}
	var parms = {};
	var payload = MfaMobile.create(parms);
	
	payload.PUT("self","self","mode",encKey).then(function(resp){ //No I18N
		setTimeout(function(){
				$(".resend_otp").html("<div class='tick nonclic'></div>"+I18N.get('IAM.GENERAL.OTP.SUCCESS'));
				setTimeout(function(){
				resendOtpChecking();
				}, 1000);
				}, 800);
	},
	function(resp){
		$(".resend_otp").removeClass("nonclickelem");
		$(".resend_otp").html(I18N.get("IAM.TFA.RESEND.OTP"));
		resendTiming = 1; 
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
			classifyError(resp);
		}
	});
}
*/
function showPreferedInfo(parentEle){
	var sibEle = parentEle.querySelector(".delete-icon"); //No I18N
	var newEle = document.querySelector(".pref-info").cloneNode(true)  //No I18N
	if(parentEle.classList.contains("verified-numb-cont")){
		newEle.querySelector(".pref-text span").textContent = I18N.get("IAM.MFA.ANNOUN.SMS.PREF.LABEL") //No I18n
		newEle.querySelector(".pref-desc").textContent = I18N.get("IAM.MFA.ANNOUN.SMS.PREF.LABEL.DESC")//No I18n
	}else{
		newEle.querySelector(".pref-text span").textContent = I18N.get("IAM.MFA.ANNOUN.ONEAUTH.PREF.LABEL")//No I18n
		newEle.querySelector(".pref-desc").textContent = I18N.get("IAM.MFA.ANNOUN.ONEAUTH.PREF.LABEL.DESC")//No I18n
	}
	newEle.style.display="inline-block";
	newEle.classList.add("pref"); //No I18N
	if(!parentEle.querySelector(".pref-info")){
	parentEle.insertBefore(newEle, sibEle)
	}
}
var deleteEvent={};
function handleDelete(e, dfunc, mode){
		e.stopPropagation();
		deleteEvent = e.target;
		switch(mode){
			case "totp" : $(".delete-desc").html(I18N.get("IAM.MFA.CONFIRM.DELETE.MODE", I18N.get("IAM.AUTHENTICATR.APP")));  //No I18n
						  break;
			case "sms":	//No I18n
				var content = $(e.target.parentNode).find(".name-detail")[0].textContent;
				if(e.target.dataset.primary=="true" && mobCount > 1){
					prefDeleteNumbList(content)
					document.querySelector(".confirm-delete-btn").setAttribute("disabled", "disabled"); // No I18N
					document.querySelector(".delpref-cont").addEventListener("click", function(e){ // No I18N
						if($(e.target).children(".verified-selected").length>0){ // No I18N
							document.querySelector(".confirm-delete-btn").removeAttribute("disabled"); // No I18N
						}
					})
					document.querySelector(".confirm-delete-btn").setAttribute("isPrefDel", true); // No I18N
					break;
				} else {
					document.querySelector(".confirm-delete-btn").removeAttribute("disabled"); // No I18N
					document.querySelector(".confirm-delete-btn").removeAttribute("isPrefDel"); // No I18N
				}
			case "oneauth": //No I18n
			case "yubikey": //No I18n
				content = $(e.target.parentNode).find(".name-detail")[0].textContent;
				$(".delete-desc").html(I18N.get("IAM.MFA.CONFIRM.DELETE.MODE",content));  //No I18n
				break;
		}
		document.querySelector(".confirm-delete-btn").addEventListener("click",dfunc);  //No I18n
	popup_blurHandler(6);
	$(".delete-popup").show();
	$(".delete-popup").focus();
	
}

/*function prefDeleteNumbList(content){
	$(".delete-popup .popup-heading").text(I18N.get("IAM.MFA.DEL.PREF.NUMB"));
	$(".delete-desc").html(I18N.get("IAM.MFA.DEL.PREF.NUMB.DESC",content));  //No I18n
	$(".delete-desc").css("font-weight","normal")
	var delPrefCont = document.createElement("DIV");
	delPrefCont.classList.add("delpref-cont") //No I18n
	var delPrefdesc = document.createElement("DIV");
	$(delPrefdesc).addClass("delpref-desc");
	delPrefdesc.textContent = I18N.get("IAM.SELECT.NEW.PREF.NUMB");
	delPrefCont.append(delPrefdesc);
	for(x=0; x<mfaData.otp.mobile.length; x++){
		if(Object.keys(mfaData.otp.mobile[x]).length !== 0 && !mfaData.otp.mobile[x].is_primary){
			var verifiedCont = document.querySelector("#verifiedNumb").cloneNode(true); //No I18N
			var numb = mfaData.otp.mobile[x].r_mobile.split("-");
			var displayNo = "+"+numb[0]+" "+numb[1];
			verifiedCont.querySelector(".verified-number").textContent = displayNo; //No I18N
			verifiedCont.querySelector(".added-period").textContent = mfaData.otp.mobile[x].created_time_elapsed; //No I18N
			verifiedCont.querySelector(".verified-checkbox").dataset.enckey = mfaData.otp.mobile[x].e_mobile;
			verifiedCont.querySelector(".delete-icon").style.display = "none"; // No I18N
			verifiedCont.dataset.pos = x;
			verifiedCont.style.display = "flex";
			delPrefCont.append(verifiedCont);
		}
	}
	var exisnode = $(".popup-body .delete-desc")[0]
	exisnode.parentNode.insertBefore(delPrefCont, exisnode.nextSibling);
}
function deletePhNumber(e){

	var isPrefDel=e.target.getAttribute("isPrefDel")?true:false;
	var enckey = deleteEvent.dataset.enckey;
	$(".confirm-delete-btn").attr("disabled","");
	$(".confirm-delete-btn span")[0].classList.add("loader"); // No I18N

	if(isPrefDel){
		primenc = document.querySelector(".delpref-cont .verified-selected").dataset.enckey; // No I18N
		var uri = new URI(MfaMobile,"self","self","mode",enckey).addQueryParam("primary", primenc); // No I18N
	} else {
		var uri = new URI(MfaMobile,"self","self","mode",enckey); // No I18N
	}
	uri.DELETE().then(function(resp){
		if(resp.code === "MOB206"){
			if(isPrefDel){
				var parnod = document.querySelector(".delpref-cont .verified-selected").parentNode // No I18N
				mfaData.otp.mobile[parnod.dataset.pos].is_primary = true;
				document.querySelector("#verifiedNumb"+parnod.dataset.pos+" .delete-icon").dataset.primary = true; // No I18N
			}
			$(".delete-popup").slideUp(250, function(){ // No I18N
				$(".delpref-cont").remove(); // No I18N
			});
			removeBlur();
			if(isPrefDel){
				showErrMsg(I18N.get("IAM.MFA.DEL.PREF.SUCC.MSG"), true);
			}else{
				showErrMsg(resp.localized_message, true);
			}
			
			$(deleteEvent).parent().animate({ "padding": "0px" , "height": "0px" , "font-size":"0px"}, 200, function(){ 
				$(this).remove()
				if(!$(".modes-container .verified-selected:visible").length){ // No I18N
				$(".sms-container .mode-header").click(); // No I18N
				smsPrevSelect = "";
			}
			})
			$(".confirm-delete-btn span")[0].classList.remove("loader"); // No I18N
			$(".confirm-delete-btn").removeAttr("disabled");
			arraypos = deleteEvent.dataset.pos;
			mfaData.otp.mobile[arraypos] ={};
			mfaData.otp.count -= 1;
			mobCount -= 1;
			if ($(".sms-container .mode-header-texts span:visible").length > 1){ // No I18N
				document.querySelectorAll(".sms-container .mode-header-texts span")[1].remove(); // No I18N
			}
			var headerText = getModeHeaderText(mobCount, mobileHeader)
			if(headerText instanceof HTMLElement){ 
				document.querySelector(".sms-container .mode-header-texts").append(headerText);//No I18N
			}
			if(mobCount == 1){
				$(".sms-container .already-desc.many").hide(); // No I18N
				$(".sms-container .already-desc.one").show(); // No I18N
				$(".sms-container .new-added-desc").hide(); // No I18N
			}
			if(mobCount < 1){
				$(".already-verified").slideUp(250);
				$(".add-new-number").slideDown(250);
			}
		}
	},function(resp){
		$(".confirm-delete-btn span")[0].classList.remove("loader"); // No I18N
		$(".confirm-delete-btn").removeAttr("disabled"); // No I18N
		document.querySelector(".confirm-delete-btn").removeAttribute("disabled"); // No I18N
		cancelDelete();
		if(resp.cause && resp.cause.trim() === "invalid_password_token") { // No I18N
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
			classifyError(resp);
		}
	})
	isPrefDel?e.target.removeAttribute("isPrefDel"):false;
}
*/
function deleteYubikey(){
	var e_keyname = deleteEvent.dataset.eyubikeyid;
	new URI(MfaYubikey,"self","self","mode",e_keyname).DELETE().then(function(resp){  //No I18n
		if(resp.code === "Y404"){
			$(".delete-popup").slideUp(200);
			removeBlur();
			showErrMsg(resp.localized_message, true);
			$(deleteEvent).parent().animate({ "padding": "0px" , "height": "0px" , "font-size":"0px"}, 200, function(){ $(this).remove()})
			$(".confirm-delete-btn span")[0].classList.remove("loader");
			$(".confirm-delete-btn").removeAttr("disabled");
			arraypos = deleteEvent.dataset.pos;
			mfaData.yubikey.yubikey[arraypos] = {};
			mfaData.yubikey.count -= 1;
			keyCount -= 1;
			if ($(".yubikey-container .mode-header-texts span:visible").length > 1){
				document.querySelectorAll(".yubikey-container .mode-header-texts span")[1].remove();
			}
			var headerText = getModeHeaderText(keyCount, yubikeyHeader)
			if(headerText instanceof HTMLElement){ 
				document.querySelector(".yubikey-container .mode-header-texts").append(headerText);//No I18N
			}
			if(keyCount<2){
				$(".yubikey-container .warning-msg").hide();
				$(".yubikey-container .already-desc").hide();
				$(".yubikey-container .new-added-desc.many").hide();
				$(".yubikey-container .new-added-desc.one").show();
			}
			if(keyCount < 1){
				$(".already-yubikey-conf").slideUp(250,function(){
					$(".yubikey-body .hidden-checkbox")[0].classList.remove("verified-selected");
					$(".yubikey-container .mode-header").click();
				});
				$(".add-new-yubikey").slideDown(250);
			}
		}
	},
	function(resp){
		$(".confirm-delete-btn span")[0].classList.remove("loader");
		$(".confirm-delete-btn").removeAttr("disabled");
		cancelDelete();
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
			classifyError(resp);
		}
	})
}

function deleteConfTotp(){
	$(".confirm-delete-btn").attr("disabled","");
	$(".confirm-delete-btn span")[0].classList.add("loader");
	new URI(MfaTOTP,"self","self","mode").DELETE().then(function(resp){  //No I18n
		if(resp.code === "TOTP202"){
			$(".delete-popup").slideUp(300);
			removeBlur();
			showErrMsg(resp.localized_message, true);
			$(".confirm-delete-btn span")[0].classList.remove("loader");
			$(".confirm-delete-btn").removeAttr("disabled");
			mfaData.totp={};
			$(".already-totp-conf").slideUp(250);
			$(".add-new-totp").slideDown(250, function(){
				$(".totp-container .mode-header").click();
			});
			document.querySelectorAll(".totp-container .mode-header-texts span")[1].remove();
		}
	},function(resp){
		$(".confirm-delete-btn span")[0].classList.remove("loader");
		$(".confirm-delete-btn").removeAttr("disabled");
		cancelDelete();
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
			classifyError(resp);
		}
	})
}

function deleteOneAuth(){
	var enckey = deleteEvent.dataset.enckey;
	$(".confirm-delete-btn").attr("disabled","");
	$(".confirm-delete-btn span")[0].classList.add("loader");
	new URI(MfaDevice,"self","self","mode",enckey).DELETE().then(function(resp){  //No I18n
		if(resp.code === "MYZD208"){
			$(".delete-popup").slideUp(200);
			removeBlur();
			showErrMsg(resp.localized_message, true);
			$(deleteEvent).parent().animate({ "padding": "0px" , "height": "0px" , "font-size":"0px"}, 200, function(){ 
				$(this).remove()
				if(!$(".modes-container .verified-selected:visible").length){
					$(".oneauth-container .mode-header").click();
					smsPrevSelesct = "";
				}
			})
			$(".confirm-delete-btn span")[0].classList.remove("loader");
			$(".confirm-delete-btn").removeAttr("disabled");
			arraypos = deleteEvent.dataset.pos;
			mfaData.devices.device[arraypos] = {}
			mfaData.devices.count -= 1;
			devCount -= 1;
			if ($(".oneauth-container .mode-header-texts span:visible").length > 1){
				document.querySelectorAll(".oneauth-container .mode-header-texts span")[1].remove();
			}
			var headerText = getModeHeaderText(devCount, oneauthHeader)
			if(headerText instanceof HTMLElement){ 
				document.querySelector(".oneauth-container .mode-header-texts").append(headerText);//No I18N
			}
			if(devCount<2){
				$(".oneauth-container .warning-msg").hide();
				$(".oneauth-container .already-desc.many").hide();
				$(".oneauth-container .already-desc.one").show();
			}
			if(devCount < 1){
				$(".already-verified-app").slideUp(250);
				$(".oneauth-container .mode-header").children(".add-oneauth").slideDown(200, function(){ //No I18N
					document.querySelector(".add-new-oneauth").style.overflow="unset"; //No I18N
					document.querySelector(".add-qr").classList.add("qr-anim") //No I18N
					document.querySelector(".oneauth-container .mode-header").classList.add("empty-oneauth-header"); //No I18N
				});
				document.querySelector(".oneauth-container .tag").style.opacity = "0" //No I18N
				document.querySelector(".oneauth-container .mode-icon").classList.add("mode-icon-large")//No I18N
				document.querySelector(".oneauth-container .mode-header-texts").classList.add("oneauth-head-text"); //No I18N
				document.querySelector(".oneauth-container .oneauth-desc").style.display = "block";
			}

		}
	},
	function(resp){
		$(".confirm-delete-btn span")[0].classList.remove("loader");
		$(".confirm-delete-btn").removeAttr("disabled");
		cancelDelete();
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
			classifyError(resp);
		}
	})
}

function getModeHeaderText(count, modeHeaderObject){
	var configSpan = document.createElement("span");
	if(count<1){
		return false;
	}else if(count  === 1){
		configSpan.textContent = I18N.get(modeHeaderObject[1]);
	}else if(count>1){
		configSpan.textContent = I18N.get(modeHeaderObject[2], count);
	}
	return configSpan;
}

function cancelDelete(){
	$(".delete-popup").slideUp(300, function(){
		$(".delpref-cont").remove();
	});
	removeBlur();
	$(".delete-cancel-btn").unbind();
}

function escape(e){
	if(e.keyCode == 27){
		cancelDelete();
		closePopup();
	}
}
function removeBlur(){
	$(".blur").css({"opacity":"0"});
	$("body").css("overflow","auto");
	$(".blur").hide();
	$(".blur").unbind();
}

function showTotpOtp(){
	$(".sms-container, .oneauth-container, .yubikey-container").slideUp(200);
	if(nModes > 1){
		$(".show-all-modes-but").slideDown(200);
	}
	$(".new-totp-codes").slideUp(200);
	$(document.verify_totp_form).slideDown(200);
}
function verifyTotpCode(e){
	var code = $('#totp_split_input_full_value').val();
	if(code == ""){
		show_error_msg("#totp_split_input", I18N.get("IAM.ERROR.EMPTY.FIELD"));//No I18N
		return;
	}
	if(!isOTPValid(code, true)){
		show_error_msg("#totp_split_input", I18N.get("IAM.ERROR.ENTER.VALID.OTP"));//No I18N
		return;
	}
	e.target.setAttribute("disabled",'');
	e.target.querySelector("span").classList.add("loader","miniloader"); //No i18N
	var param = { "code":code }; //No I18N
	var payload = MfaTOTP.create(param);
	payload.PUT("self","self","mode",encKey).then(function(resp){ //No I18N
		if(resp.code === "TOTP201"){
			e.target.removeAttribute("disabled");
			$(e.target).html("<div class='verified_tick'></div>"+I18N.get('IAM.VERIFIED')); //No I18N
			if(mfaData.modes.length==0 || (mfaData.modes.length==1 && mfaData.modes[0] == "otp")){
				showSuccessMfapop();
				return;	
			} else {
				showErrMsg(resp.localized_message,true);
			}
			setTimeout(function(){
				$(".new-totp").slideUp(250);
				$(".already-totp-conf-desc.before").hide()
				$(".already-totp-conf-desc.after").show();
				if(!mfaData.totp || Object.keys(mfaData.totp).length == 0){
					var headerText = document.createElement("span");
					headerText.textContent =  I18N.get("IAM.CONFIGURED");
					document.querySelector(".totp-container .mode-header-texts").append(headerText);//No I18n
				}
				$(".verify-totp-pro-but").hide();
				$(".delete_totp_conf").show();
				$(".already-totp-conf .add-new-totp-but").addClass("change-config")
				$(".already-totp-conf .hidden-checkbox")[0].classList.add("verified-selected");  //No I18n
				$(".already-totp-conf").slideDown(250);
				document.querySelectorAll(".totp_split_input_otp").forEach(function(eachEle){ eachEle.value =""; }); //No i18n
				$(e.target).html("<span></span>"+I18N.get('IAM.VERIFY'));
				$(document.verify_totp_form).hide();
				$(".totp-container .mode-header").click();
			}, 300);
		}
	},
	function(resp)
	{	
		e.target.querySelector("span").classList.remove("loader","miniloader"); //No I18n
		e.target.removeAttribute("disabled");
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
			classifyError(resp, "#totp_split_input"); //No I18n
		}
		return;
	});	
}

function verifyOldTotp(e){
	encKey = mfaData.totp.secretkey;
	$(".totp_input_container button.back-btn").attr("onclick", "totpAlreadyStepBack()");
	$(".new-totp-codes").hide();
	$(document.verify_totp_form).show();
	$(".already-totp-conf").slideUp(200);
	$(".new-totp").slideDown(200);
}
function totpAlreadyStepBack(){
	$(".new-totp").slideUp(200, function(){
		$(".totp-container .mode-header").click();
	});
	clearError('#totp_split_input'); //no i18n
	document.querySelectorAll(".totp_split_input_otp").forEach(function(eachEle){ eachEle.value =""; }); //No i18n
	$(".already-totp-conf").slideDown(200);
}
function totpStepBack(){
	$(document.verify_totp_form).slideUp(200);
	clearError('#totp_split_input'); //no i18n
	document.querySelectorAll(".totp_split_input_otp").forEach(function(eachEle){ eachEle.value =""; }); //No i18n
	$(".new-totp-codes").slideDown(200);
}
var styleOrder=0;
function displayAlreadyConfigured(mode, modeData){
	switch(mode){
		case "totp":  //No I18N
		$(".totp-container").insertBefore($(".mode-cont")[styleOrder]);
		styleOrder++;
		if(addConfiguredTotp(modeData)){
		document.querySelector(".add-new-totp").style.display ="none" //No I18N
		document.querySelector(".already-totp-conf").style.display = "block"; //No I18N
		}
		break;
/*		case "otp": //No I18N
		$(".sms-container").insertBefore($(".mode-cont")[styleOrder]);
		styleOrder++;
		if(addConfiguredMobile(modeData)){
		document.querySelector(".add-new-number").style.display ="none"; //No I18N
		document.querySelector(".already-verified").style.display = "block"; //No I18N
		}
		break;*/
		case "devices": //No i18n
		$(".oneauth-container").insertBefore($(".mode-cont")[styleOrder]);
		styleOrder++;
		if(addConfiguredDevice(modeData)){
			if(isBioEnforced){
				$(".already-verified-app .already-desc").hide();
			}
			document.querySelector(".add-new-oneauth").style.display = "none";
			document.querySelector(".already-verified-app").style.display = "block";
		}
		break;
		case "yubikey": //No I18N
		$(".yubikey-container").insertBefore($(".mode-cont")[styleOrder]);
		styleOrder++;
		if(addConfiguredYubikey(modeData)){
		document.querySelector(".add-new-yubikey").style.display ="none"; //No I18N
		document.querySelector(".already-yubikey-conf").style.display = "block"; //No I18N
		}
		break;
	}
}

function addConfiguredTotp(modeData){
	if(document.querySelector(".totp-container")){
	var headerText = document.createElement("span");
	headerText.textContent =  I18N.get("IAM.CONFIGURED");
	document.querySelector(".totp-container .mode-header-texts").append(headerText);//No I18N
	document.querySelector(".already-totp-conf-desc>span").textContent = modeData.created_time_formated; //No I18N
	document.querySelector(".delete-totp-conf").dataset.secretkey = modeData.secretkey;  //No I18n
	return true;
	} else {
		return false;
	}
}
/*var mobCount;
function addConfiguredMobile(modeData, isNew){
	if(document.querySelector(".sms-container")){
	mobCount = mobCount == undefined ? modeData.count : mobCount + 1;
	if(mobCount){
		var headerText = getModeHeaderText(mobCount, mobileHeader)
		//// op /////
		if ($(".sms-container .mode-header-texts span:visible").length > 1){
			document.querySelectorAll(".sms-container .mode-header-texts span")[1].remove();
		}
		document.querySelector(".sms-container .mode-header-texts").append(headerText);//No I18N
	}
	if(mobCount == 1){
		if(isNew){
			$(".already-verified .already-desc").hide();
			$(".already-verified .new-added-desc.one").show();
		} else {
			$(".already-verified .already-desc.one").show();
		}
	}else if(mobCount>1){
		if(isNew){
			$(".already-verified .already-desc").hide();
			$(".already-verified .new-added-desc.many").show();
		} else {
			$(".already-verified .already-desc.many").show();
		}
	}
	
	for(i = 0; i < modeData.mobile.length;i++){
		var verifiedCont = document.querySelector("#verifiedNumb").cloneNode(true); //No I18N
		var numb = modeData.mobile[i].r_mobile.split("-");
		var displayNo = "+"+numb[0]+" "+numb[1];
		
		verifiedCont.querySelector(".verified-number").textContent = displayNo; //No I18N
		verifiedCont.querySelector(".added-period").textContent = I18N.get("IAM.USER.CREATED.TIME.ADDED", modeData.mobile[i].created_time_elapsed); //No I18N
		verifiedCont.querySelector(".delete-icon").dataset.enckey = modeData.mobile[i].e_mobile;
		verifiedCont.querySelector(".verified-checkbox").dataset.enckey = modeData.mobile[i].e_mobile;
		if(modeData.mobile[i].hasOwnProperty("is_primary")){
			verifiedCont.querySelector(".delete-icon").dataset.primary = "true" // No I18N
		}else{
			verifiedCont.querySelector(".delete-icon").dataset.primary = "false" // No I18N
		}
		if(isNew){
			verifiedCont.querySelector(".delete-icon").dataset.pos = (mfaData.otp.mobile.length)-1; //No I18N
			verifiedCont.id = verifiedCont.id + ((mfaData.otp.mobile.length)-1);
		} else{
			verifiedCont.id = verifiedCont.id + i;
			verifiedCont.querySelector(".delete-icon").dataset.pos = i; //No I18N
		}
		//need to check and set if new number is added  //No I18n
		var exisnode = document.querySelector(".already-verified .descriptions"); //No I18n
		verifiedCont.style.display = "flex";
		exisnode.parentNode.insertBefore(verifiedCont, exisnode.nextSibling);
	}
	return true;
	} else {
		return false;
	}
}*/
var primDev;
var devCount;
function addConfiguredDevice(modeData){
	if(document.querySelector(".oneauth-container")){
	devCount = devCount == undefined ? modeData.count : devCount+1;
	var headerText = getModeHeaderText(devCount, oneauthHeader)
	if(devCount == 1){
		$(".already-verified-app .already-desc.many").hide();
		$(".already-verified-app .already-desc.one").show();
	}else if(devCount>1){
		$(".oneauth-body .warning-msg.many").show();
		$(".already-verified-app .already-desc.many").show();
		$(".already-verified-app .already-desc.one").hide();
	}
	document.querySelector(".oneauth-container .mode-header-texts").append(headerText); //No I18N
	for(i=0;i<modeData.device.length;i++){
		var oneCont = document.querySelector(".verified-app-cont.cloner").cloneNode(true); //No I18N
		oneCont.classList.remove("cloner"); //No I18N
		oneCont.querySelector(".verified-device").textContent = modeData.device[i].device_name;
	
		var devimage = findDeviceImage(modeData.device[i].device_info);
		oneCont.querySelector(".device-image").innerHTML = fontDevicesToHtmlElement[devimage];
		devimage = "icon2-" + devimage; //No I18N
		oneCont.querySelector(".device-image").classList.add(devimage); //No I18N
		
		oneCont.querySelector(".delete-icon").dataset.enckey = modeData.device[i].device_id;
		oneCont.querySelector(".delete-icon").dataset.pos = i;  //No I18n
		if(modeData.device[i].is_primary){
			primDev = modeData.device[i].device_name;
		}
		if(parseInt(modeData.device[i].app_version)<2){
			oneCont.setAttribute("onclick","");
			oneCont.querySelector(".verified-checkbox").style.visibility = "hidden";
			oneCont.querySelector(".added-period").textContent = ""; //No I18N
			oneCont.querySelector(".added-period").style.opacity= "1"; //No I18N
			var updatepref = document.querySelector(".pref-info").cloneNode(true)  //No I18N
			updatepref.classList.add("update-app"); //No I18n
			updatepref.style.display = "block";
			updatepref.querySelector(".pref-text span").textContent = I18N.get("IAM.MFA.ANNOUN.ONEAUTH.UP.LABEL");//No I18n
			updatepref.querySelector(".pref-desc").textContent = I18N.get("IAM.MFA.ANNOUN.ONEAUTH.UP.LABEL.DESC");//No I18n
			oneCont.querySelector(".added-period").append(updatepref);//No I18n
			oneCont.querySelector(".verified-app-details").style.pointerEvents = "auto";//No I18n
		} else if(isBioEnforced){
			if(modeData.device[i].is_primary){
				oneCont.querySelector(".delete-icon").remove(); //No I18n
			}
			oneCont.setAttribute("onclick","");
			oneCont.querySelector(".verified-checkbox").style.visibility = "hidden";
			oneCont.querySelector(".added-period").textContent =  I18N.get("IAM.USER.CREATED.TIME.ADDED", modeData.device[i].created_time_elapsed); //No I18N
		} else{			
		oneCont.querySelector(".added-period").textContent =  I18N.get("IAM.USER.CREATED.TIME.ADDED", modeData.device[i].created_time_elapsed); //No I18N
		oneCont.querySelector(".verified-checkbox").dataset.enckey = modeData.device[i].device_id;
		oneCont.querySelector(".verified-checkbox").dataset.pref = modeData.device[i].pref_option;
		}
		var exisnode = document.querySelector(".already-verified-app .already-desc.one");//No I18n
		oneCont.style.display = "flex";
		exisnode.parentNode.insertBefore(oneCont, exisnode.nextSibling);
		if(isBioEnforced){
			$(".oneauth-body .warning-msg").hide();
			$(".oneauth-body .biometric-msg").show();
			$(".add-new-oneauth-but").hide();
		}
	}
	return true;
	} else {
		return false;
	}
}
var keyCount;
function addConfiguredYubikey(modeData, isNew){
	if(document.querySelector(".yubikey-container")){
	keyCount = keyCount == undefined ? modeData.count : keyCount+1;
	var headerText = getModeHeaderText(keyCount, yubikeyHeader)
	if ($(".yubikey-container .mode-header-texts span:visible").length > 1){
		document.querySelectorAll(".yubikey-container .mode-header-texts span")[1].remove();
	}
	document.querySelector(".yubikey-container .mode-header-texts").append(headerText); //No I18N
	if(keyCount == 1){
		if(isNew){
			$(".already-yubikey-conf .already-desc").hide();
			$(".already-yubikey-conf .new-added-desc.one").show();
		}
		else{
			$(".already-yubikey-conf .already-desc.one").show();
		}
	}else if(keyCount>1){
		if(isNew){
			$(".already-yubikey-conf .already-desc").hide();
			$(".already-yubikey-conf .new-added-desc.one").hide();
			$(".already-yubikey-conf .new-added-desc.many").show();
		}else{
			$(".already-yubikey-conf .already-desc.many").show();
		}
		$(".yubikey-body .warning-msg").slideDown(300);
	}
	for(i=0;i<modeData.yubikey.length;i++){
		var yubiCont = document.querySelector(".verified-yubikey-cont").cloneNode(true); //No I18N
		yubiCont.querySelector(".verified-yubikey").textContent = decodeHTML(modeData.yubikey[i].key_name); //No I18N
		yubiCont.querySelector(".added-period").textContent = I18N.get("IAM.USER.CREATED.TIME.ADDED", modeData.yubikey[i].created_time_elapsed); //No I18N
		yubiCont.querySelector(".delete-icon").dataset.eyubikeyid = modeData.yubikey[i].e_keyName;
		if(isNew){
			yubiCont.querySelector(".delete-icon").dataset.pos = keyCount - 1; //No I18N
		} else{
			yubiCont.querySelector(".delete-icon").dataset.pos = i; //No I18N
		}
		var exisnode = document.querySelector(".already-yubikey-conf .descriptions");//No I18n
		yubiCont.style.display = "flex";
		exisnode.parentNode.insertBefore(yubiCont, exisnode.nextSibling);
	}
	return true;
	}else {
		return false;
	}
}

function findDeviceImage(deviceInfo){
	deviceInfo = deviceInfo.toLowerCase();
	if((/iphone/).test(deviceInfo)){
		return "iphone"; //No I18N
	} else if((/macbook/).test(deviceInfo)){
		return "macbook"; //No I18N
	} else if((/ipad/).test(deviceInfo)){
		return "ipad"; //No I18N
	} else if((/oneplus/).test(deviceInfo)){
		return "oneplus"; //No I18N
	} else if((/samsungtab|sm-t|sm-x/).test(deviceInfo)){
		return "samsungtab"; //No I18N
	} else if((/samsung|sm-g|sm-f/).test(deviceInfo)){
		return "samsung"; //No I18N
	} else if((/pixel|google|nexus/).test(deviceInfo)){
		return "pixel"; //No I18N
	} else if((/oppo/).test(deviceInfo)){
		return "oppo"; //No I18N
	} else {
		return "mobile_uk"; //No I18N
	}
}
function show_error_msg(siblingClassorID, msg) {
	var errordiv = document.createElement("div");
	errordiv.classList.add("error_msg"); //No I18N
	$(errordiv).html(msg)
	$(errordiv).insertAfter(siblingClassorID)
	$(siblingClassorID).addClass("errorborder")
	parentform = $(siblingClassorID).closest("form")[0];
	parentform.querySelector("button").setAttribute('disabled', ''); //No I18n
	$(".error_msg").slideDown(150);
}
      
function clearError(ClassorID, e){
	if( e && e.keyCode == 13 && $(".error_msg:visible").length){
		return;
	}
	parentform = $(ClassorID).closest("form")[0];
	parentform.querySelector("button").removeAttribute('disabled'); //No I18n
    $(ClassorID).removeClass("errorborder") //No I18n
    $(".error_msg").remove(); //No I18n
}

function checkNetConnection(){
	setInterval(function(){
		if(window.navigator.onLine){
			$(".verify_btn, .resend_otp, .send_otp_btn").prop("disabled", false);
		}
	}, 2000)
}

function reloginRedirect(){
	var service_url = euc(window.location.href);
	window.open(contextpath + $("#error_space")[0].getAttribute("resp")+"?serviceurl="+service_url+"&post="+true, '_blank') //No i18N
}

function showErrMsg(msg, isSuccessMsg, isRelogin){
	if(isSuccessMsg){
		document.getElementsByClassName("error_icon")[0].classList.remove("warning_icon");//No I18N
		document.getElementById("error_space").classList.remove("warning_space") //No I18N
		document.getElementById("error_space").classList.add("success_space") //No I18N
		document.getElementsByClassName("error_icon")[0].classList.add("verified-selected");//No I18N
		document.getElementsByClassName("error_icon")[0].innerHTML = ""; //No I18N
	}else if(isRelogin){
		document.getElementById("error_space").classList.remove("success_space") //No I18N
		document.getElementsByClassName("error_icon")[0].classList.remove("verified-selected");//No I18N
		document.getElementsByClassName("error_icon")[0].classList.add("warning_icon");//No I18N
		document.getElementById("error_space").classList.add("warning_space") //No I18N
		document.getElementsByClassName("error_icon")[0].innerHTML = "!"; //No I18N
		document.getElementById("error_space").setAttribute("resp",isRelogin.redirect_url)
		document.getElementById("error_space").addEventListener("click", reloginRedirect, isRelogin)
	} else {
		document.getElementById("error_space").classList.remove("success_space") //No I18N
		document.getElementsByClassName("error_icon")[0].classList.remove("verified-selected");//No I18N
		document.getElementById("error_space").classList.remove("warning_space") //No I18N
		document.getElementsByClassName("error_icon")[0].classList.remove("warning_icon");//No I18N
		document.getElementsByClassName("error_icon")[0].innerHTML = "!"; //No I18N
	}
	document.getElementById("error_space").classList.remove("show_error"); //No I18N
	document.getElementsByClassName('top_msg')[0].innerHTML = msg; //No I18N

	document.getElementById("error_space").classList.add("show_error");//No I18N
	setTimeout(function() {
		document.getElementById("error_space").classList.remove("show_error");//No I18N
		document.getElementById("error_space").removeEventListener("click", reloginRedirect);
	}, 5000);;
}
function classifyError(resp, siblingClassorID){
	if(resp.status_code && resp.status_code === 0){
		showErrMsg(I18N.get("IAM.PLEASE.CONNECT.INTERNET"));
	}else if(resp.code === "Z113"){//No I18N
		showErrMsg(I18N.get("IAM.ERROR.SESSION.EXPIRED"));
	}else if(resp.localized_message && siblingClassorID){
		show_error_msg(siblingClassorID, resp.localized_message)
	}else if(resp.localized_message){
		showErrMsg(resp.localized_message)
	}else{
		showErrMsg(I18N.get("IAM.ERROR.USER.ACTION"));
	}
}
	  
function checkEnable(e){
	if(!e.target.closest(".already-verified-recovery") && (e.target.classList.contains("mode-header") || e.target.classList.contains("verified-app-cont") ||  e.target.classList.contains("verified-checkbox") || e.target.classList.contains("verified-numb-cont"))){ //No I18N
		setTimeout(function(){
			if($(".modes-container .verified-selected:visible").length>0){
				$(".enable-mfa").removeAttr("disabled");
			}else{
				$(".enable-mfa").attr("disabled","");
			}
		}, 350);
	}else if(e.target.classList.contains("show-all-modes-but")){ //No I18N
		return;
	}else if(e.target.classList.contains("link-btn")){ //No I18N
		$(".enable-mfa").attr("disabled","");
	}
}

function enableMFA(e){
	e.target.setAttribute("disabled","");
	e.target.children[0].classList.add("loader");
	var selectedCheckbox =  $(".modes-container .verified-selected:visible")[0];
	if(selectedCheckbox.classList.contains("verified-checkbox")){
		if(selectedCheckbox.parentNode.classList.contains("verified-numb-cont")){
			var params = {"mode" : 0, "primary" : selectedCheckbox.dataset.enckey, "activate" : true, "makeprimary":true} //No I18N
		}else{
			var params = {"mode" : selectedCheckbox.dataset.pref, "primary" : selectedCheckbox.dataset.enckey, "activate" : true, "makeprimary":true} //No I18N
		}
	} else{
		if(selectedCheckbox.parentNode.classList.contains("already-yubikey-conf")){
			var params = {"mode" : 8, "activate" : true, "makeprimary":true} //No I18N
		}else {
			var params = {"mode" : 1, "activate" : true, "makeprimary":true} //No I18N
		}
	}
	var payload = Mfa.create(params);
	payload.PUT("self","self","mode").then(function(resp){ //No I18N
		if(resp.code === "MFA200"){
			e.target.children[0].classList.remove("loader");
			showSuccessMfapop();
		}else{
			e.target.removeAttribute("disabled");
			e.target.children[0].classList.remove("loader");
			classifyError(resp);
		}
	},
	function(resp){
		e.target.removeAttribute("disabled");
		e.target.children[0].classList.remove("loader");
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
			classifyError(resp);
		}
	})
}
function showSuccessMfapop(){
	$(".msg-popups").prop("onkeydown","");
	$(".popup-icon")[0].classList.add("icon-success");
	$(".popup-heading").html(I18N.get("IAM.MFA.ANNOUN.SUCC.HEAD")) //No I18N
	$(".pop-close-btn").hide();
	if(mfaData.bc_cr_time.allow_codes){
		if(mfaData.bc_cr_time.created_time_elapsed){
			$(".backup-codes-desc.old-codes").show();
			$(".backup-codes-desc.new-codes").hide();
			$("g-backup").text(I18N.get("IAM.GENERATE.BACKUP.CODES"));
		}
		$(".popup-body").html($(".generate-backup").html());
		if(mandatebackupconfig){
			$(".g-cancel").hide();
		}
	}else{
		$(".popup-body").html($(".no-backup-redirect").html());
	}

	popup_blurHandler(6);
	$(".msg-popups").slideDown(300);
	$(".msg-popups").focus();
}
function contSignin(){
	window.location.href = next;
}
function generateBackupCode(e){
	e.target.setAttribute("disabled","");
	e.target.children[0].classList.add("loader");
	var payload = BackupCodes.create();
	payload.PUT("self","self").then(function(resp){ //No I18N
		e.target.removeAttribute("disabled");
		e.target.querySelector("span").classList.remove("loader"); //No i18N
		show_backup(resp.backupcodes);
	},
	function(resp){
		e.target.removeAttribute("disabled");
		e.target.querySelector("span").classList.remove("loader"); //No i18N
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
			classifyError(resp);
		}
	});
}
function updateBackupStatus(mode){
	var params = {"status":mode}; //No I18N
	var payload = BackupCodesStatus.create(params);
	payload.PUT("self","self").then(function(resp){ //No I18N
	});
}
var pmail, userName;
function show_backup(resp){
	var codes = resp.recovery_code;
	var recoverycodes = codes.split(":");
	var createdtime = resp.created_date;
	pmail = resp.primary_email;
	userName = resp.user;
	var res ="<ol class='bkcodes'>"; //No I18N
	var recCodesForPrint = "";
	for(idx in recoverycodes){
		var recCode = recoverycodes[idx];
		if(recCode != ""){
			res += "<li><b><div class='bkcodes_cell'>"+recCode.substring(0, 4)+"</div><div class='bkcodes_cell'>"+recCode.substring(4, 8)+"</div><div class='bkcodes_cell'>"+recCode.substring(8) + "</div></b></li>"; //No I18N
			recCodesForPrint += recCode + ":";
		}
	}
	res += "</ol>";
	recCodesForPrint = recCodesForPrint.substring(0, recCodesForPrint.length -1); // Remove last ":"
	de('bk_codes').innerHTML = res; //No I18n
	$("#downcodes").attr('onclick', 'downloadCodes(\''+createdtime+'\',\''+recoverycodes+'\'); updateBackupStatus("save_text")'); //No I18N
	$("#printcodesbutton").attr('onclick','copy_code_to_clipboard(\''+createdtime+'\',\''+recoverycodes+'\'); updateBackupStatus("copy")'); //No I18N
	$(".popup-heading").html(I18N.get("IAM.TFA.BACKUP.ACCESS.CODES")); //No I18n
	$(".popup-icon")[0].classList.remove("icon-success");
	$(".popup-body").html($(".backup_code_container").html());
	$("body").css("overflow","auto")
	$(".msg-popups").css("position","absolute");
	if(isMobile){
		$(".msg-popups").css({"top":"0px", "border-top-left-radius":"0", "border-top-right-radius":"0"});
		$(".popup-header").css({"border-top-left-radius":"0", "border-top-right-radius":"0"});
	}
}
var recTxt;
function formatRecoveryCodes(createdtime, recoverycodes){
	recTxt  = I18N.get('IAM.TFA.BACKUP.ACCESS.CODES')+"\n"+pmail+"\n\n"; //No I18n
	recoverycodes = recoverycodes.split(",");
	for(var idx=0; idx < recoverycodes.length; idx++){
		var recCode = recoverycodes[idx];
		if(recCode != ""){
			recTxt += "\n "+(idx+1)+". "+recCode.substring(0, 4)+" "+recCode.substring(4, 8)+" "+recCode.substring(8); //No I18n
		}
	}
	recTxt += "\n\n"+ I18N.get('IAM.GENERATEDTIME') +" : " +createdtime; //No I18n
}
function copy_code_to_clipboard (createdtime, recoverycodes) {
	if(recTxt == undefined){
		formatRecoveryCodes(createdtime, recoverycodes);
	}
   	var elem = document.createElement('textarea');
   	elem.value = recTxt;
   	document.body.appendChild(elem);
   	elem.select();
   	document.execCommand('copy'); //No I18n
   	document.body.removeChild(elem);
   	$(".copy_to_clpbrd").hide();
   	$(".code_copied").show();
   	$("#printcodesbutton .tooltiptext").addClass("tooltiptext_copied");
	$(".down_copy_proceed").hide();
	$(".cont-signin").show();
}
function remove_copy_tooltip() {
	$(".copy_to_clpbrd").show();
	$(".code_copied").hide();
	$("#printcodesbutton .tooltiptext").removeClass("tooltiptext_copied");
}
function downloadCodes(createdtime, recoverycodes){
	if(recTxt == undefined){
		formatRecoveryCodes(createdtime, recoverycodes);
	}
	var filename = "RECOVERY-CODES-"+userName; //No I18N
	var element = document.createElement('a');
	element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(recTxt));
	element.setAttribute('download', filename);
	element.style.display = 'none';
	document.body.appendChild(element);
	element.click();
	$(".down_copy_proceed").hide();
	$(".cont-signin").show();
	document.body.removeChild(element);
}

function showOneauthPop(){
	$(".oneauth-container .mode-header").click();
	document.querySelector(".msg-popups").style.maxWidth = "660px"; //No I18N
	document.querySelector(".msg-popups .popup-icon").classList.remove("icon-success")  //No I18n
	document.querySelector(".msg-popups .popup-header").style.display = "none";
	
	//document.querySelector(".msg-popups .popup-heading").textContent = I18N.get("IAM.MFA.ANNOUN.ONEAUTH.SETUP.HEAD");  //No I18n
	document.querySelector(".msg-popups .popup-body").innerHTML = document.querySelector(".oneauth-popup").innerHTML;  //No I18n
	document.querySelector(".msg-popups .popup-body").classList.add("padding-oneauthpop");  //No I18n
	document.querySelector(".msg-popups .pop-close-btn").style.display = "block";
	
	if(isMobile){
		if(/Android/i.test(navigator.userAgent)){
			$(".msg-popups .appstore-icon").hide()
			$(".msg-popups .macstore-icon").hide()
		} else if(/iphone|ipad|ipod/i.test(navigator.userAgent)){
			$(".msg-popups .appstore-icon").css({"order":1});
			$(".msg-popups .playstore-icon").hide()
			$(".msg-popups .macstore-icon").hide()
		}
	}
	popup_blurHandler(6);
	$(".msg-popups").slideDown(300);
	$(".msg-popups").focus();
}
function showBioPop(){
	document.querySelector(".msg-popups .popup-icon").classList.remove("icon-success") //No I18N
	document.querySelector(".msg-popups .popup-heading").textContent = I18N.get("IAM.MFA.ANNOUN.ONEAUTH.BIO.POP.HEAD"); //No I18N
	document.querySelector(".msg-popups .popup-body").innerHTML = document.querySelector(".oneauth-bio").innerHTML;  //No I18n
	document.querySelector(".bio-steps .oneauth-step b").textContent = primDev; //No I18N
	document.querySelector(".msg-popups .pop-close-btn").style.display = "block"; //No I18N
	popup_blurHandler(6);
	$(".msg-popups").slideDown(300);
	$(".msg-popups").focus();
}
	
function showReloginPop(){
	document.querySelector(".msg-popups .popup-heading").textContent = I18N.get("IAM.MFA.ANNOUN.ONEAUTH.RELOGIN.HEAD");  //No I18n
	document.querySelector(".msg-popups .popup-body").innerHTML = document.querySelector(".oneauth-relogin").innerHTML;  //No I18n
	document.querySelector(".msg-popups .popup-body").classList.remove("padding-oneauthpop");  //No I18n
	document.querySelector(".msg-popups .pop-close-btn").style.display = "none";
	$(".msg-popups").focus();
}
function storeRedirect(url){
	window.open(url, '_blank');
}
function redirectSignin(){
	window.location.href = window.location.origin+"/signin"+window.location.search;
}
	
	/////////////////////////////////////////////////////////////////////////////////
	
	function setMobileNumPlaceholder(selectEle){
    if(showMobileNoPlaceholder){
		var mobInput = $(selectEle).siblings("input[type=tel]")[0];
		$(mobInput).unbind();
	    $(selectEle).change(function(){
	    	mobInput.value="";
	    	mobInput.placeholder =phoneData[$(selectEle).val()].example.replace(new RegExp(phoneData[$(selectEle).val()].pattern),phoneData[$(selectEle).val()].space);
	    	mobInput.maxLength = mobInput.placeholder.length;
	    });
	
	    mobInput.placeholder = phoneData[$(selectEle).val()].example.replace(new RegExp(phoneData[$(selectEle).val()].pattern),phoneData[$(selectEle).val()].space);
	    mobInput.maxLength = mobInput.placeholder.length;
	    var keycode;
	    var fromPaste = false;
	    mobInput.addEventListener('keydown', function(e){
	    	keycode = e.keyCode;
	    	fromPaste = false;
	    });
	    mobInput.addEventListener('paste', function(e){
	    	fromPaste = true;
	    });
	    mobInput.addEventListener('input', function (e) {
	        var curPosition = e.target.selectionStart;
	        if((e.target.placeholder[curPosition] == " " || e.target.placeholder[curPosition] == "-" || e.target.placeholder[curPosition] == ".") && (keycode == 46)){
	        	e.target.value = e.target.value.slice(0, curPosition) + e.target.value.slice(curPosition+1);
	        }
	        if((e.target.placeholder[curPosition] == " " || e.target.placeholder[curPosition] == "-" || e.target.placeholder[curPosition] == ".") && (keycode == 8)){
	        	e.target.value = e.target.value.slice(0, curPosition-1) + e.target.value.slice(curPosition);
	        }
	        e.target.value = e.target.value.slice(0, e.target.placeholder.length).replace(/[^0-9]/gi, "");
	        e.target.value = setSeperatedNumber(phoneData[$(selectEle).val()],e.target.value);
	        if(curPosition <= e.target.value.length){
	            if((e.target.value[curPosition-1] == " " || e.target.value[curPosition-1] == "-" || e.target.value[curPosition-1] == ".")&& (keycode != 8 && keycode != 46) && ((keycode >= 48 && keycode <= 57) || (keycode >= 96 && keycode <= 105))){
	                curPosition = curPosition+1;
	            }
	            else if(((e.target.placeholder[curPosition] == " " || e.target.placeholder[curPosition] == "-" || e.target.placeholder[curPosition] == ".") && (keycode == 8))){
	            	curPosition = curPosition-1;
	            }
	            else if((!(keycode >= 48 && keycode <= 57) && !(keycode >= 96 && keycode <= 105)) && (keycode != 8 && keycode != 46) && fromPaste == false){
	            	curPosition = curPosition-1;
	            }
	        }
	        else{
	            curPosition = e.target.value.length;
	        }
        	e.target.selectionStart = curPosition;
        	e.target.selectionEnd = curPosition;	        	
	    });
    }
}

function setSeperatedNumber(data,number){
    var value = data.example.replace(new RegExp(data.pattern),data.space).split("");
    var num_count = 0;
    for(var i=0;i<value.length;i++){
        if(value[i] != " " && value[i] != "-" && value[i] != "."){
            if(number[num_count]){
                value[i] = number[num_count];
            }
            else{
                num_count =i;
                break;
            }
            if(i==value.length-1){
                num_count =i;
            }
            num_count++;
        }
    }
    value = value.slice(0,num_count).join("");
    if(value[value.length-1] == " " || value[value.length-1] == "-" || value[value.length-1] == "."){
       value = value.slice(0,value.length-1);
    }
    return value;
}

function copyQrKey(element) {
  var copyText = element.querySelector("#skey"); //No I18n
  navigator.clipboard.writeText(copyText.textContent);
  var tickElement = document.createElement("span");
  tickElement.classList.add("tooltip-tick"); //No I18n
  element.querySelector(".tooltip-text").innerText = I18N.get("IAM.APP.PASS.COPIED"); //No I18n
  element.querySelector(".tooltip-text").prepend(tickElement); //No I18n
  return;
}

function resetTooltipText(element) {
	var tooltipHide = setInterval(function() {
		element.querySelector(".tooltip-text").innerText = I18N.get("IAM.MFA.COPY.CLIPBOARD"); //No I18n
		clearTimeout(tooltipHide);	
	}, 300);
	return;
}