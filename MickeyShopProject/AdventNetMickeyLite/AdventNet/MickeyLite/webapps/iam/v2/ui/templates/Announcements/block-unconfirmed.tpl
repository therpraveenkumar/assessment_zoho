<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><@i18n key="IAM.BLOCK.UNCONFIRMED.TITLE"/></title>
    <script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")}"></script>
    <script src="${SCL.getStaticFilePath("/v2/components/js/splitField.js")}" type="text/javascript"></script>
    <script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/select2.full.min.js")}"></script>
    <script src="${SCL.getStaticFilePath("/v2/components/js/phonePatternData.js")}" type="text/javascript"></script>
    <script src="${SCL.getStaticFilePath("/v2/components/js/common_unauth.js")}" type="text/javascript"></script>
    <link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
    <style>
      @font-face {
        font-family: "AccountsUI";
        src: url("${SCL.getStaticFilePath("/v2/components/images/fonts/AccountsUI.eot")}");
        src: url("${SCL.getStaticFilePath("/v2/components/images/fonts/AccountsUI.eot")}") format("embedded-opentype"),
          url("${SCL.getStaticFilePath("/v2/components/images/fonts/AccountsUI.ttf")}") format("truetype"), 
          url("${SCL.getStaticFilePath("/v2/components/images/fonts/AccountsUI.woff")}") format("woff"),
          url("${SCL.getStaticFilePath("/v2/components/images/fonts/AccountsUI.svg")}") format("svg");
        font-weight: normal;
        font-style: normal;
        font-display: block;
      }
      [class^="icon-"],
      [class*=" icon-"] {
        font-family: "AccountsUI" !important;
        font-style: normal;
        font-weight: normal;
        font-variant: normal;
        text-transform: none;
        line-height: 1;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
      }
      .icon-search:before,
      .select2-search:after {
        content: "\e9a7";
      }
      body {
        margin: 0;
        box-sizing: border-box;
      }
      .content_container {
        max-width: 540px;
        padding-top: 120px;
        padding-right: 4%;
        display: inline-block;
      }
      .rebrand_partner_logo {
        height: 40px;
        margin-bottom: 20px;
        background: url("${SCL.getStaticFilePath("/v2/components/images/newZoho_logo.svg")}") no-repeat;
        background-size: auto 40px;
      }
      .announcement_header {
        font-size: 24px;
        font-weight: 600;
        margin-bottom: 20px;
        cursor: default;
      }
      .account_verify_desc,
      .otp_sent_desc,
      .already_existing_desc {
        font-size: 16px;
        line-height: 24px;
        margin-bottom: 20px;
        cursor: default;
      }
      .otp_sent_desc,
      .enter_eml_mob_desc {
      	line-height: 24px;
        margin-bottom: 30px;
      }
      .valueemailormobile{
      	display:inline-block;
      }
      .emolabel {
        font-size: 12px;
        line-height: 14px;
        display: block;
        margin-bottom: 4px;
        font-weight: 600;
        letter-spacing: 0px;
        color: #000000b3;
      }
      .otp_input_container,
      .email_input_container,
      .mobile_input_container {
        width: 300px;
        margin-bottom: 30px;
      }
      .emailormobile {
        font-weight: 600;
      }
      .resend_otp {
        font-size: 14px;
        line-height: 26px;
        margin:12px 0 20px 0;
        cursor: pointer;
        font-weight: 500;
        color: #0093ff;
        width: max-content;
      }
      #email_input,
      #mobile_input {
        height: 44px;
        padding: 12px 15px;
        line-height: 30px;
        width: 288px;
        border: 1px solid #0f090933;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 14px;
      }
      #email_input:focus-visible, #mobile_input:focus-visible{
      	outline: none;
      }
      input#otp_input {
        margin-bottom: 0px;
        padding: 14px 15px;
      }
      .edit_option {
        font-size: 16px;
        line-height: 24px;
        margin-left: 10px;
        color: #0093ff;
        cursor: pointer;
      }
      .send_otp_btn,
      .verify_btn,
      .update_send_otp_btn {
        font: normal normal 600 14px/30px sans-serif;
        padding: 5px 30px;
        border-radius: 4px;
        color: white;
        border: none;
        background: #1389e3 0% 0% no-repeat padding-box;
        cursor: pointer;
      }
      .send_otp_btn:hover,
      .verify_btn:hover,
      .update_send_otp_btn:hover{
      	background-color: #0779CF;
      }
      .send_otp_btn span{
	   	margin-left: 10px;
	  	font-size: 10px;
	  }
      .nonclickelem {
        color: #626262;
        pointer-events: none;
        cursor: none;
      }
      button:disabled {
        opacity: 0.4;
      }
      .illustration {
        width: 350px;
        height: 350px;
        display: inline-block;
        background: url("${SCL.getStaticFilePath("/v2/components/images/ann_blockunconfirmed.svg")}") no-repeat;
      }
      .flex-container {
        display: flex;
        max-width: 1200px;
        gap: 50px;
        margin: auto;
      }
      .illustration-container {
        padding-top: 120px;
        padding-right: 10%;
      }
      .content_container {
        padding-left: 10%;
      }
      .otp_input_container {
        position: relative;
      }
      .otp_container {
        display: flex;
        justify-content: space-around;
        width: 100%;
        height: 44px;
        box-sizing: border-box;
        border-radius: 4px;
        font-size: 16px;
        outline: none;
        padding: 0px 15px;
        transition: all 0.2s ease-in-out;
        background: #ffffff;
        border: 1px solid #dddddd;
        text-indent: 0px;
      }
      .otp_container::after {
        content: attr(placeholder);
        height: 44px;
        line-height: 44px;
        font-size: 14px;
        position: absolute;
        color: #b9bcbe;
        left: 15px;
        z-index: 1;
        cursor: text;
      }
      .customOtp {
        border: none;
        outline: none;
        background: transparent;
        height: 100%;
        font-size: 14px;
        text-align: left;
        width: 22px;
        padding: 0px;
      }
      .hidePlaceHolder::after {
        z-index: -1 !important;
      }
      #otp_split_input input::placeholder {
        color: #b9bcbe;
      }
	  .error_msg {
        font-size: 14px;
        font-weight: 500;
        line-height: 18px;
        margin-top: 4px;
        margin-bottom: 10px;
        color: #e92b2b;
        display: none;
        white-space: normal;
      }
      .errorborder {
        border: 2px solid #ff8484 !important;
      }
      .already_added, .add_new_number {
      	color: #0093ff;
      	font-weight: 500;
      	font-size: 14px;
      	margin-top: 12px;
      	margin-bottom:20px;
      	cursor: pointer;
      	width:max-content;
	  }
      #mobile_input {
        text-indent: 60px;
        width: 300px;
        line-height: 40px;
        letter-spacing: 0.5px;
        height: 42px;
        outline: none;
        box-sizing: border-box;
        font-size: 14px;
        font-family: "ZohoPuvi";
        display: inline-block;
        box-sizing: border-box;
        outline: none;
        border-radius: 4px;
        border: 1px solid #dddddd;
        padding: 12px 15px 12px 6px;
      }
      #select_phonenumber .select2-container {
        position: absolute;
        height: 44px;
      }
      #select_phonenumber .select2-container--default .select2-selection--single {
        border: none;
        display:inline-block;
        position: relative;
      }
      #select_phonenumber .select2-container--default .select2-selection--single .select2-selection__rendered {
        line-height: 42px;
        letter-spacing: 0.5px;
      }
      #select_phonenumber .select2-container--default .select2-selection--single .select2-selection__arrow b {
        border-width: 3px;
      }
      #select2-countNameAddDiv-container {
        display: inline-block;
        margin-left: 42px;
        margin-right: 13px;
        padding: 0px;
        width: auto;
        font-size: 14px;
      }
      .select2-search {
        display: block;
        padding: 10px;
        position: relative;
      }
      .select2-search__field {
        height: 32px;
        border: none;
        outline: none;
        border-radius: 4px;
        width: 100%;
        font-size: 13px;
        padding: 10.5px 8px;
        border: 1px solid #dfdfdf;
        text-indent: 21px;
      }
      .select2-results__option {
        list-style-type: none;
        height: auto;
        box-sizing: border-box;
        line-height: 16px;
        font-family: "ZohoPuvi", Georgia;
        font-size: 13px;
        overflow: hidden;
        padding: 12px 18px;
        word-break: break-word;
      }
      .field .select2-container--default .select2-selection--single .select2-selection__rendered {
        line-height: 40px;
        color: #000;
        background-color: transparent;
        font-size: 14px;
      }
      .field .select2-container--default .select2-selection--single .select2-selection__arrow {
        height: 40px;
      }
      .noindent {
        position: relative;
      }
      .textindent58 {
        text-indent: 76px !important;
      }
      .textindent66 {
        text-indent: 83px !important;
      }
      .textindent78 {
        text-indent: 92px !important;
      }
      b {
        font-weight: 500;
      }
      user agent stylesheet b {
        font-weight: bold;
      }
      span.select2-dropdown.select2-dropdown--below,
      span.select2-dropdown.select2-dropdown--above {
        background: #ffffff;
        border: 1px solid #e6e6e6;
        border-radius: 0px 0px 4px 4px;
        margin-top: 0px;
        box-sizing: border-box;
        position: relative;
        z-index: 5;
        border-top: transparent;
        overflow: hidden;
      }
      .noindent .select2-container .select2-selection--single {
        text-indent: 0px;
      }
      .field .select2-container .select2-selection--single {
        height: 42px;
        font-size: 14px;
      }
      .select2-container--open + #mobile_input{
        border: 1px solid #1389e3;
        border-radius: 4px 4px 0px 0px;
      }
      .select2-search--hide {
        display: none;
      }
      .select2-search__field::placeholder {
        color: #a7a7a7;
        opacity: 1;
      }
      .select2-dropdown {
        display: inline-block;
        min-width: 300px;
      }
      .select2-selection__rendered {
        max-width: calc(100% - 30px);
        overflow: hidden;
        display: block;
        text-overflow: ellipsis;
        font-size: 14px;
        color: #000000;
        line-height: 18px;
      }
      .select2-container--default .select2-selection--single .select2-selection__arrow {
        height: 26px;
        position: absolute;
        top: 1px;
        right: -6px;
        width: 20px;
      }
      .select2-container--default .select2-selection--single .select2-selection__arrow b {
        border-color: transparent #c6c6c6 #c6c6c6 transparent;
        border-style: solid;
        transform: rotate(45deg);
        border-width: 3.5px;
        height: 0px;
        width: 0px;
        position: relative;
        top: 8px;
        left: 6px;
        border-radius: 1px;
        display: inline-block;
        margin-top: 6px;
      }
      .select2-container .select2-selection--single .select2-selection__rendered {
        display: block;
        padding-left: 8px;
        padding-right: 30px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
      }
      .select2-container--open .select2-selection {
        border-radius: 4px 4px 0px 0px;
      }
      .select2-selection__arrow {
        float: right;
        height: 100%;
        width: 10px;
        position: relative;
        top: -18px;
      }
      .select2-search:after {
        font-family: "AccountsUI" !important;
        font-style: normal;
        font-weight: normal;
        font-variant: normal;
        text-transform: none;
        line-height: 1;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
        position: absolute;
        top: 19px;
        font-size: 14px;
        left: 20px;
        color: #00000080;
      }
      .select2-selection:hover {
        cursor: pointer;
      }
      .selection {
        display: block;
        white-space: nowrap;
        position: relative;
        height: 42px;
      }
      .select2-results__options {
        padding-left: 0px;
        max-height: 200px;
        overflow-y: auto;
        overflow-x: hidden;
        margin-top: 0px;
        margin-bottom: 0px;
        background: white;
      }
      .select2-results__option--highlighted {
        background-color: #f8f8f8;
        color: #000000;
        cursor: pointer;
      }
      .select2-container--open .select2-selection {
        z-index: 10;
        border-color: #1389e3 !important;
        border-bottom-right-radius: 0px !important;
    	border-bottom-left-radius: 0px !important;
      }
      .select2-container--focus .select2-selection {
        border-color: #1389e3 !important;
      }
      .select2-container--disabled.select2-container--focus .select2-selection {
        border: 1px solid #bfbfbf !important;
      }
      .select2-hidden-accessible {
        visibility: hidden;
        border: 0 !important;
        clip: rect(0, 0, 0, 0) !important;
        height: 0px !important;
        margin: -1px !important;
        overflow: hidden !important;
        padding: 0 !important;
        position: absolute !important;
        display: none;
      }
      .cc {
        float: right;
      }
      .cn {
        margin-left: 10px;
        float: left;
        max-width: 170px;
        overflow: hidden;
        text-overflow: ellipsis;
      }
      #error_space{
			position: fixed;
		    width: fit-content;
		    width: -moz-fit-content;
		    left: 0px;
		    right: 0px;
		    margin: auto;
		    border: 1px solid #FCD8DC;
		    display: inline-block;
		    padding: 18px 30px;
		    background: #FFECEE;
		    border-radius: 4px;
		    color: #000;
		    top: -100px;
		    transition: all .3s ease-in-out;
		    box-sizing: border-box;
	        max-width: 400px;
		}
		.top_msg
		{
			font-size: 14px;
			color: #000;
			line-height: 24px;
			float: left;
			margin-left: 10px;
		    font-weight: 500;
		    font-size: 14px;
			text-align: center;
			line-height: 24px;
		    max-width: 304px;
		}
		.error_icon
		{
		    position: relative;
		    background: #FD395D;
		    width: 24px;
		    height: 24px;
		    float: left;
		    box-sizing: border-box;
		    border-radius: 50%;
		    display: inline-block;
		    color: #fff;
		    font-weight: 700;
		    font-size: 16px;
		    text-align: center;
		    line-height: 24px;
		}
		.show_error{
			top:60px !important;
		}
      .phone_code_label
	  {
    	width: 60px;
    	height: 42px;
     	display: inline-block;
    	float: left;
    	position: absolute;
    	line-height: 42px;
    	text-align: center;
    	font-size:14px;
    	color:black;
	  }
	  .phone_code_label:after{
	    content: "";
    	border-color: transparent #E6E6E6 #E6E6E6 transparent;
    	border-style: solid;
    	transform: rotate(45deg);
    	border-width: 2px;
    	height: 5px;
   		width: 5px;
    	position: absolute;
    	right: 2px;
    	top: 14px;
    	border-radius: 1px;
    	display: inline-block;
	  }
      .pic {
        width: 20px;
        height: 14px;
        background-size: 280px 252px;
        background-image: url("../images/Flags.png");
        background-position: -180px -238px;
        float: left;
        margin-top: 1px;
      }
      .selectFlag {
        display: inline-block;
        width: 20px;
        height: 14px;
        position: absolute;
        top: 13px;
        left: 13px;
        background-size: 280px 252px;
        background-image: url("/images/Flags2x.png");
        background-position: -180px -238px;
      }
      .select2-container--already_numbers.select2-container--below{
      	display: inline-block;
      	height: 42px;
      }
      .field .select2-container--already_numbers .select2-container--focus .select2-selection{
      	border-color:#dcdcdc !important;
      }
      .field span#select2-verfied_phnnum-container{
      	box-sizing: border-box;
      	padding:12px 30px 12px 15px;
      	margin-left: 32px;
      }
      .field .select2-container--already_numbers .select2-selection--single{
     	height: 42px;
      	border: 1px solid #dcdcdc;
      	border-radius: 4px;
    	box-sizing: border-box;
    	width: 300px;
    	position: relative;
    	display: inline-block;
      }
      .field .select2-container--already_numbers .select2-selection--single .select2-selection__arrow{
      	height: 42px;
      	top: -42px;
      	margin-right: 6px;
      	width: 20px;
      }
      .field .select2-container--already_numbers .select2-selection--single .select2-selection__arrow b {
        border-color: transparent #C6C6C6 #C6C6C6 transparent;
    	border-style: solid;
    	transform: rotate(45deg);
    	border-width: 3.5px;
    	height: 0px;
    	width: 0px;
    	position: relative;
   		top: 8px;
    	left: -2px;
    	border-radius: 1px;
    	display: inline-block;
      }
      
      #select2-localeCn-results .flag_AX {
        background-position: -140px -224px;
      }
      #footer {
		    width: 100%;
		    height: 20px;
		    font-size: 14px;
		    color: #727272;
		    position: absolute;
		    margin: 20px 0px;
		    text-align: center;
	  }
	  #footer a{
		color:#727272;
	  }
	  
	  .loader,
	  .loader:after {
  		border-radius: 50%;
  		width: 10px;
  		height: 10px;
	  }	
	  .loader {
		display: inline-block;
  		font-size: 10px;
  		position: relative;
  		top: 2px;
  		margin-right: 10px;
  		text-indent: -9999em;
  		border: 2px solid rgba(255, 255, 255, 0.2);
  		border-left: 2px solid;
  		border-bottom: 2px solid;
  		transform: translateZ(0);
  		-webkit-animation: load 1s infinite linear;
  		animation: load 1s infinite linear;
	  }
	  @keyframes load {
  			0% {
    			-webkit-transform: rotate(0deg);
    			transform: rotate(0deg);
  			}
  			100% {
    			-webkit-transform: rotate(360deg);
    			transform: rotate(360deg);
  		}
	  }
	  .tick {
        display: inline-block;
        margin-right: 10px;
        width: 10px;
        height: 5px;
        border-left: 2px solid #0093ff;
        border-bottom: 2px solid #0093ff;
        transform: rotate(-45deg);
        position: relative;
        top: -4px;
      }
      .verified_tick {
       height:5px;
       width:0px;
       animation: 0.6s ease-in-out 0s 1 forwards running tick;
       margin-right: 0px;
       margin-left: 10px;
       left:-10px;
      }
	  @keyframes tick {
        0% {
          width: 0px;
        }
        100% {
          width: 10px;
        }
      }
      .white {
		border-bottom-color: #ffffff;
		border-left-color: #ffffff;
	  }
      @media only screen and (min-width: 435px) and (max-width: 980px) {
        .flex-container {
          padding: 50px 25px 0px 25px;
        }
        .illustration-container {
          display: none;
        }
        .content_container {
          padding: 0;
          margin: auto;
        }
        .countNameAddDiv,.phone_code_label+select
		{
			position:absolute;
		}
      }
      @media only screen and (max-width: 435px) {
        .flex-container {
          padding: 50px 20px 0px 20px;
        }
        .content_container {
          width: 100%;
          padding: 0;
        }
        .illustration-container {
          display: none;
        }
        .otp_input_container {
          width: 100%;
        }
        .mobile_input_container {
          width: 100%;
        }
        #mobile_input {
          width: 100%;
        }
        button {
          width: 100%;
        }
        .countNameAddDiv,.phone_code_label+select
		{
			position:absolute;
		}
      }
    </style>
    <link rel="stylesheet" href="${SCL.getStaticFilePath("/accounts/css/flagStyle.css")}" type="text/css"/>
    <script>
      var csrfParam= "${za.csrf_paramName}";
      var csrfCookieName = "${za.csrf_cookieName}";
      var contextpath = <#if context_path??>"${context_path}"<#else> "" </#if>;
      var resendTimer, resendtiming , altered;
      var isEdit = true;
      <#if email?has_content>
      	var mode = "email"; 
      	var emailormobilevalue = "${email}"; 
      <#else> 
      	var mode = "mobile"; 
      	var mobile = "${mobile}";
      	var countryCode = "${country_code}";
      	var showMobileNoPlaceholder = ${mob_plc_holder?c};
      	var isMobile = ${is_mobile?c};
      	var emailormobilevalue;
      	var countryDialCode;
      </#if>
      I18N.load({
      	"IAM.GENERAL.OTP.SENDING" : '<@i18n key="IAM.GENERAL.OTP.SENDING"/>',
      	"IAM.GENERAL.OTP.SUCCESS" : '<@i18n key="IAM.GENERAL.OTP.SUCCESS"/>',
      	"IAM.ERROR.ENTER.VALID.OTP" : '<@i18n key="IAM.ERROR.ENTER.VALID.OTP"/>',
      	"IAM.GENERAL.ERROR.INVALID.OTP" : '<@i18n key="IAM.GENERAL.ERROR.INVALID.OTP"/>',
      	"IAM.ERROR.ENTER.VALID.OTP" : '<@i18n key="IAM.ERROR.ENTER.VALID.OTP" />',
      	"IAM.ERROR.ENTER.VALID.EMAIL" : '<@i18n key="IAM.ERROR.ENTER.VALID.EMAIL"/>',
      	"IAM.PHONE.ENTER.VALID.MOBILE_NUMBER" : '<@i18n key="IAM.PHONE.ENTER.VALID.MOBILE_NUMBER"/>',
	  	"IAM.GENERAL.OTP.SENDING" : '<@i18n key="IAM.GENERAL.OTP.SENDING"/>',
	  	"IAM.GENERAL.OTP.SUCCESS" : '<@i18n key="IAM.GENERAL.OTP.SUCCESS"/>',
	  	"IAM.VERIFIED" : '<@i18n key="IAM.VERIFIED"/>',
	  	"IAM.TFA.RESEND.OTP.COUNTDOWN" : '<@i18n key="IAM.TFA.RESEND.OTP.COUNTDOWN"/>',
	  });
      var cryptData;
      <#if nxt_preann_url??>var next = "${nxt_preann_url}";</#if>
      function handleEditOption(mode) {
     	clearError("#"+ mode +"_input");
        $(".otp_input_container, .otp_sent_desc").slideUp(200);
        document.querySelector(".enter_eml_mob_desc").style.display = "block";
        document.querySelector(".send_otp_btn").style.display = "block";
        if (!resendtiming == 0) {
          $(".send_otp_btn").prop("disabled", true);
        }
        document.querySelector("." + mode + "_input_container").style.display = "block";
        document.querySelector("#" + mode + "_input").focus();
       	if(mode === "email"){
			document.querySelector("#" + mode + "_input").value = emailormobilevalue;
        }else{
			document.querySelector("#" + mode + "_input").value = setSeperatedNumber(phoneData[$("#countNameAddDiv").val()], mobile.toString());;
        }
      }
		
	  function showErrMsg(msg) 
	  {
		document.getElementById("error_space").classList.remove("show_error");
	    document.getElementsByClassName('top_msg')[0].innerHTML = msg; //No I18N
	    document.getElementsByClassName("error_icon")[0].classList.add("cross_mark_error");
	    document.getElementById("error_space").classList.add("show_error");  
	    setTimeout(function() {
	    	document.getElementById("error_space").classList.remove("show_error");
	    }, 5000);;
	
	  }
      function sendOTP(mode, emailormobilevalue) {
      $(".resend_otp").html("<div class='loader'></div>"+I18N.get('IAM.GENERAL.OTP.SENDING'));
        if (mode === "email") {
        	if (isEmailId(emailormobilevalue)) {
        		$("div.valueemailormobile").html(emailormobilevalue);
            	var params = { blockunconfirmeduser: { email_id: emailormobilevalue } };
            	sendRequestWithCallback("/webclient/v1/announcement/pre/blockunconfirm", JSON.stringify(params), true, handleOtpSent, "POST")
          	} else {
             show_error_msg("#email_input", I18N.get("IAM.ERROR.ENTER.VALID.EMAIL"));
          	}
        } else if (mode === "mobile") {
          	if (isPhoneNumber(mobile)) {
          		countryCode = emailormobilevalue.substring(emailormobilevalue.length-2);
          		$("div.valueemailormobile").html(emailormobilevalue.substring(0,emailormobilevalue.length-2));
          		emailormobilevalue = (emailormobilevalue.substring(0,emailormobilevalue.length-2)).split(" ")[1];
           		var params = { blockunconfirmeduser: { mobile: emailormobilevalue, countrycode: countryCode} };
          		sendRequestWithCallback("/webclient/v1/announcement/pre/blockunconfirm", JSON.stringify(params), true, handleOtpSent, "POST");
          	} else {
             show_error_msg("#mobile_input", I18N.get("IAM.PHONE.ENTER.VALID.MOBILE_NUMBER"));
          	}
        }
      }
      
	  function handleOtpSent(respStr){	
		if(respStr!="" && respStr!= undefined){
			var resp = JSON.parse(respStr);
			if(resp.status_code >= 200 && resp.status_code <= 299){
			clearError('#otp_split_input');
			if( isEdit!=undefined && isEdit ){
			document.querySelector(".edit_option").style.display = "inline-block";
			}
			$(".enter_eml_mob_desc, .send_otp_btn, ."+ mode +"_input_container").slideUp(200);
			$(".otp_input_container, .otp_sent_desc").slideDown(200);
				setTimeout(function(){
				$(".resend_otp").html("<div class='tick'></div>"+I18N.get('IAM.GENERAL.OTP.SUCCESS'));
				setTimeout(function(){
				resendOtpChecking();
				}, 1000);
				}, 800);
				if(resp.blockunconfirmeduser.encrypted_data){
					cryptData = resp.blockunconfirmeduser.encrypted_data;
				}
			}
			else{
			if($("#otp_split_input").is(":visible")){
				show_error_msg("#otp_split_input", resp.localized_message);
			}
			else {
				if(mode === "email"){
					show_error_msg("#email_input", resp.localized_message);
				}else if(mode === "mobile"){
					show_error_msg("#mobile_input", resp.localized_message);
				}
			}}
		}
	  }
	  
	  function resendOTP(){
	  	$(".resend_otp").html("<div class='loader'></div>"+I18N.get('IAM.GENERAL.OTP.SENDING'));
	  	var params= {};
	  	sendRequestWithCallback("/webclient/v1/announcement/pre/blockunconfirm/"+cryptData, "", true, handleOtpResent, "PUT")
	  }
	  
	  function handleOtpResent(respStr){
	  	if(respStr!="" && respStr!= undefined){
	  	var resp = JSON.parse(respStr);
			if(resp.status_code >= 200 && resp.status_code <= 299){
				setTimeout(function(){
				$(".resend_otp").html("<div class='tick'></div>"+I18N.get('IAM.GENERAL.OTP.SUCCESS'));
				setTimeout(function(){
				resendOtpChecking();
				}, 1000);
				}, 800);
			}
			else{
			show_error_msg("#otp_split_input", resp.localized_message);
			}
	  	}
	  }
	  
      function verifyCode() {
        var Code = document.querySelector("#otp_split_input_full_value").value;
        if($(".error_msg").length<1){
        if(isValidCode(Code)){
        clearError('#otp_split_input');
        $(".verify_btn span").html("<div class='loader white'></div>");
        $(".verify_btn").prop("disabled", true);
        var params = { blockunconfirmeduser : { code: Code } };
        sendRequestWithCallback("/webclient/v1/announcement/pre/blockunconfirm/"+cryptData, JSON.stringify(params), true, handleVerifyCode, "PUT")
        }
        else{
        $(".verify_btn span").html("");
        $(".verify_btn").prop("disabled", false);
        show_error_msg("#otp_split_input", I18N.get('IAM.ERROR.ENTER.VALID.OTP'));
        }
        }
      }
		
	  function handleVerifyCode(respStr){
		if(respStr!="" && respStr!= undefined){
			var resp = JSON.parse(respStr);
			if(resp.status_code >= 200 && resp.status_code <= 299){
			$(".resend_otp").css("visibility","hidden");
			setTimeout(function(){
			$(".verify_btn").prop("disabled", false);
			$(".verify_btn").html("<div class='tick verified_tick white'></div>"+I18N.get('IAM.VERIFIED'));
			setTimeout(function(){
				window.location.href=next;
			}, 1000);
			},1000);
			}
			else{
			$(".verify_btn span").html("");
        	$(".verify_btn").prop("disabled", false);
        	show_error_msg("#otp_split_input", resp.localized_message);
			}
		}
	  }
	  
      function updateEmlMblValue() {
      	clearError('#'+mode+'_input');
        var splitinput = document.querySelectorAll("input.splitedText");
        for (var x=0;x<splitinput.length;x++){
        	splitinput[x].value = "";
        }
        if (mode === "email") {
          var login_id = $("#email_input").val();
          if (isEmailId(login_id)) {
          	emailormobilevalue = login_id;
            sendOTP(mode, login_id);
          }else{
            show_error_msg("#email_input", I18N.get("IAM.ERROR.ENTER.VALID.EMAIL"));
          }
        }
        else if (mode === "mobile"){
          var login_id = $("#mobile_input").val().replace(/[+ \[\]\(\)\-\.\,]/g,'');
          if (isPhoneNumber(login_id)) {
          	mobile = login_id;
			var dialCode = $('#countNameAddDiv option:selected').attr("data-num");
          	var countryCode = $('#countNameAddDiv option:selected').attr("id");
          	emailormobilevalue=dialCode+" "+login_id+countryCode;
          	sendOTP(mode, emailormobilevalue);
          }else{
          show_error_msg("#mobile_input", I18N.get("IAM.PHONE.ENTER.VALID.MOBILE_NUMBER"));
          }
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
          $(".send_otp_btn span").html(resendtiming+"s");
          }
          if (resendtiming === 0) {
            clearInterval(resendTimer);
            $(".resend_otp").html("<@i18n key="IAM.TFA.RESEND.OTP"/>");
            $(".send_otp_btn span").html("");
            $(".send_otp_btn span").css("margin","0px");
            $(".resend_otp").removeClass("nonclickelem");
            $(".send_otp_btn").removeAttr("disabled");
          }
        }, 1000);
      }
      
      function allowSubmit(e) {
        if (mode === "email" && emailormobilevalue === e.target.value || emailormobilevalue === "") {
          altered=false;
          if (!resendtiming == 0) {
            $(".send_otp_btn").prop("disabled", true);
          }
        }
        else if(mode === "mobile" && mobile === (e.target.value).replace(/[+ \[\]\(\)\-\.\,]/g,'') || mode === "mobile" && mobile === ""){
        	altered=false;
          if (!resendtiming == 0) {
            $(".send_otp_btn").prop("disabled", true);
          }
        } 
        else {
        altered = true;
          $(".send_otp_btn span").html("");
          $(".send_otp_btn").prop("disabled", false);
        }
      }
      
	  function isValidCode(code){
		if(code.trim().length != 0){
			var codePattern = new RegExp("^([0-9]{7})$");
			if(codePattern.test(code)){
				return true;
			}
	  	}
		return false;
	  }

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

      
      function phoneSelectformat(option) {
        //use to country flag structure in select2
        var spltext;
        if (!option.id) {
          return option.text;
        }
        spltext = option.text.split("(");
        var num_code = $(option.element).attr("data-num");
        var string_code = $(option.element).attr("value");

        var ob =
          '<div class="pic flag_' +
          string_code +
          '" ></div><span class="cn">' +
          spltext[0] +
          "</span><span class='cc'>" +
          num_code +
          "</span>";
        return ob;
      }
      
      function selectFlag(e) {
        var flagpos = "flag_" + $(e).val().toUpperCase();
        $(".select2-selection__rendered").attr("title", "");
        e.parent().siblings(".select2").find("#selectFlag").attr("class", ""); 
        e.parent().siblings(".select2").find("#selectFlag").addClass("selectFlag"); 
        e.parent().siblings(".select2").find("#selectFlag").addClass(flagpos); 
      }
      
      function codelengthChecking(length_id, changeid) {
        var code_len = $(length_id).attr("data-num").length;
        var length_ele = $(length_id)
          .parent()
          .siblings("#" + changeid);
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
      
      function phonecodeChangeForMobile(ele)
	  {
		$(ele).css({'opacity':'0','width':'50px'});
		$(ele).siblings(".phone_code_label").html($(ele).children("option:selected").attr("data-num"));
		$(ele).change(function(){
			$(ele).siblings(".phone_code_label").html($(ele).children("option:selected").attr("data-num"));
	    })
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
					showErrMsg("<@i18n key="IAM.PLEASE.CONNECT.INTERNET"/>");
					$(".resend_otp").html("<@i18n key="IAM.TFA.RESEND.OTP"/>");
					$(".verify_btn").html("<@i18n key="IAM.VERIFY"/>");
					$(".verify_btn, .resend_otp, .send_otp_btn").prop("disabled", true);
					checkNetConnection();
					return false;
				}
				if(callback) {
					if(JSON.parse(objHTTP.responseText).code === "Z113"){
						showErrMsg("<@i18n key="IAM.ERROR.SESSION.EXPIRED"/>");
						return false;
					}
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

	  function checkNetConnection(){
	  	setInterval(function(){
	  		if(window.navigator.onLine){
	  			$(".verify_btn, .resend_otp, .send_otp_btn").prop("disabled", false);
	  		}
	  	}, 2000)
	  }

	  function show_error_msg(siblingClassorID, msg) {
        var errordiv = document.createElement("div");
        errordiv.classList.add("error_msg");
        $(errordiv).html(msg);
        $(errordiv).insertAfter(siblingClassorID);
        $(siblingClassorID).addClass("errorborder")
        $(".error_msg").slideDown(150);
      }
      
      function clearError(ClassorID){
      	$(ClassorID).removeClass("errorborder")
        $(".error_msg").remove();
      }
      
    </script>

  </head>
  <body>
 	<div id="error_space">
		<span class="error_icon">&#33;</span> <span class="top_msg"></span>
	</div>
    <div class="flex-container container">
      <div class="content_container">
        <div class="rebrand_partner_logo"></div>
        <div class="announcement_header"><@i18n key="IAM.REGISTER.ACCOUNT.CONFIRMATION"/></div>
        <div class="account_verify_desc">
          <#if email?has_content>
          	<@i18n key="IAM.BLOCK.UNCONFIRMED.EMAIL.DESC"/>
          <#else>
          	<@i18n key="IAM.BLOCK.UNCONFIRMED.MOBILE.DESC"/>
          </#if>
        </div>
        <div class="otp_sent_desc" style="display: none">
        	<#if email?has_content>
          		<@i18n key="IAM.DIGIT.VER.CODE.SENT.EMAIL"/>
          	<#else>
          		<@i18n key="IAM.DIGIT.VER.CODE.SENT.MOBILE"/>
         	</#if>
          <span class="emailormobile">
            <div class="valueemailormobile"><#if email?has_content>${email}<#else>${mobile}</#if></div> 
            <span class="edit_option" onclick="handleEditOption(mode)"><@i18n key="IAM.EDIT"/></span>
          </span>
        </div>
        <div class="form_container">
          <form name="confirm_form" onsubmit="return false">
            <div class="enter_eml_mob_desc">
              <#if email?has_content>
          		<@i18n key="IAM.EMAIL.SEND.OTP.VERIFY"/>
          	<#else>
          		<@i18n key="IAM.MOBILE.SEND.OTP.VERIFY"/>
         	</#if>
            </div>
            <div class="email_input_container" style="display: none">
              <label for="email_input" class="emolabel"><@i18n key="IAM.EMAIL.ADDRESS"/></label>
              <input type="text" id="email_input" autocomplete="email" onkeydown="clearError('#email_input')" oninput="allowSubmit(event)" />
            </div>
            <div class="mobile_input_container field" style="display: none" id="select_phonenumber">
  				<label for="mobile_input" class="emolabel"><@i18n key="IAM.MOBILE.NUMBER"/></label>
  				<label for="countNameAddDiv" class="phone_code_label"></label>
  				<select
    				id="countNameAddDiv"
    				data-validate="zform_field"
    				autocomplete="country-name"
    				name="countrycode"
    				class="countNameAddDiv"
    				style="width: 300px"
  				>
  					<#list country_list as dialingcode>
						<option data-num="${dialingcode.dialcode}" value="${dialingcode.code}" id="${dialingcode.code}" >${dialingcode.display}</option>
  					</#list>
  				</select>
  				<input
    				class="textbox mobile_input"
    				tabindex="0"
    				data-validate="zform_field"
    				autocomplete="phonenumber"
    				onkeydown="clearError('#mobile_input')"
					oninput="allowSubmit(event)"
    				name="mobile_no"
    				id="mobile_input"
    				maxlength="15"
    				data-type="phonenumber"
    				type="tel"
  				/>
			</div>
            <button class="send_otp_btn" onclick="updateEmlMblValue()"><@i18n key="IAM.SEND.OTP"/><span></span></button>
           </form>
           <form name="confirm_form1" onsubmit="return false">
             <div class="otp_input_container" style="display: none">
              <label for="otp_input" class="emolabel"><@i18n key="IAM.VERIFICATION.CODE"/></label>
              <div id="otp_split_input" class="otp_container"></div>
              <div class="resend_otp" onclick="resendOTP()"><span></span><@i18n key="IAM.TFA.RESEND.OTP"/></div>
              <button class="verify_btn" onclick="verifyCode()"><span></span><@i18n key="IAM.VERIFY"/></button>
            </div>
          </form>
        </div>
      </div>
      <div class="illustration-container">
        <div class="illustration"></div>
      </div>
    </div>
  </body>
  <footer id="footer">
  	<#include "../Unauth/footer.tpl">
  </footer>
  
  <script>
    window.onload = function () {

      if(mode === "email"){
        document.querySelector("#" + mode + "_input").value = emailormobilevalue;
      } else if(mode === "mobile"){
      	countryDialCode = $(document.confirm_form.countrycode).find("#"+countryCode).attr("data-num");
      	emailormobilevalue = countryDialCode + " " + mobile + countryCode;
        if(countryCode){
			reqCountry = "#"+(countryCode.toUpperCase());
			$('#countNameAddDiv option:selected').removeAttr('selected');
			$("#countNameAddDiv "+reqCountry).prop('selected', true);
			$("#countNameAddDiv "+reqCountry).trigger('change');
		}
		document.querySelector("#" + mode + "_input").value = setSeperatedNumber(phoneData[$("#countNameAddDiv").val()], mobile.toString());
      }
	  document.querySelector("." + mode + "_input_container").style.display = "block";

      splitField.createElement("otp_split_input", {
        splitCount: 7, 
        charCountPerSplit: 1, 
        isNumeric: true, 
        otpAutocomplete: true, 
        customClass: "customOtp", 
        inputPlaceholder: "&#9679;", 
        placeholder: "<@i18n key="IAM.ENTER.CODE"/>", 
      });
      $("#otp_split_input .splitedText").attr("onkeydown", "clearError('#otp_split_input')");
      if (mode === "mobile") {
      	if(!isMobile) {
        	$(document.confirm_form.countrycode)
          		.select2({
            		width: "82px",
            		templateResult: phoneSelectformat,
            		templateSelection: function (option) {
              						selectFlag($(option.element));
              						codelengthChecking(option.element, "mobile_input");
              						return $(option.element).attr("data-num");
            		},
            		language: {
              			noResults: function () {
                			return "<@i18n key="IAM.NO.RESULT.FOUND"/>"; 
              			},
            		},
            		escapeMarkup: function (m) {
              				return m;
            		},
          		}).on("select2:open", function () {
            		$(".select2-search__field").attr("placeholder", "<@i18n key="IAM.SEARCHING"/>");
          			});
        $("#select_phonenumber .select2-selection").append("<span id='selectFlag' class='selectFlag'></span>");
        selectFlag($(document.confirm_form.countrycode).find("option:selected"));
        $(".select2-selection__rendered").attr("title", "");
        $(document.confirm_form.countrycode).on("select2:close", function (e) {
          $(e.target).siblings("input").focus();
        });
        setMobileNumPlaceholder(document.confirm_form.countrycode);
        $(".phone_code_label").css("visibility" ,"hidden")
      } else {
        phonecodeChangeForMobile(document.confirm_form.countrycode);
      }
      }
      setFooterPosition();
    };
  </script>
</html>
