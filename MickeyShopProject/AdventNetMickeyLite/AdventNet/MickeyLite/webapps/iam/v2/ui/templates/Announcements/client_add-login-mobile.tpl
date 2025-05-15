<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><@i18n key="IAM.ADD.PRIMARY.NUMBER.TITLE"/></title>
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
        /*update "select2-search:after" class content also*/
        content: "\e9a7";
      }
      body {
        margin: 0;
        box-sizing: border-box;
        font-family: "ZohoPuvi";
      }
      .content_container {
        max-width: 540px;
        padding-top: 120px;
        padding-right: 4%;
        display: inline-block;
      }
      .rebrand_partner_logo {
        height: 30px;
        margin-bottom: 20px;
        background: url("${SCL.getStaticFilePath("/v2/components/images/Zoho_logo.png")}") no-repeat;
        background-size: auto 30px;
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
        background: url("${SCL.getStaticFilePath("/v2/components/images/ann_addmobilenumber.svg")}") no-repeat;
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
      
      .flag_AF {
        background-position: 0px 0px;
      }
      .flag_AL {
        background-position: -20px 0px;
      }
      .flag_DZ {
        background-position: -40px 0px;
      }
      .flag_AS {
        background-position: -60px 0px;
      }
      .flag_AD {
        background-position: -80px 0px;
      }
      .flag_AO {
        background-position: -100px 0px;
      }
      .flag_AI {
        background-position: -120px 0px;
      }
      .flag_AG {
        background-position: -140px 0px;
      }
      .flag_AR {
        background-position: -160px 0px;
      }
      .flag_AM {
        background-position: -180px 0px;
      }
      .flag_AW {
        background-position: -200px 0px;
      }
      .flag_AC {
        background-position: -220px 0px;
      }
      .flag_AU {
        background-position: -240px 0px;
      }
      .flag_AX {
        background-position: -260px 0px;
      }
      .flag_AT {
        background-position: 0px -14px;
      }
      .flag_AZ {
        background-position: -20px -14px;
      }
      .flag_BS {
        background-position: -40px -14px;
      }
      .flag_BH {
        background-position: -60px -14px;
      }
      .flag_BD {
        background-position: -80px -14px;
      }
      .flag_BB {
        background-position: -100px -14px;
      }
      .flag_BY {
        background-position: -120px -14px;
      }
      .flag_BE {
        background-position: -140px -14px;
      }
      .flag_BZ {
        background-position: -160px -14px;
      }
      .flag_BJ {
        background-position: -180px -14px;
      }
      .flag_BM {
        background-position: -200px -14px;
      }
      .flag_BT {
        background-position: -220px -14px;
      }
      .flag_BO {
        background-position: -240px -14px;
      }
      .flag_BA {
        background-position: -260px -14px;
      }
      .flag_BW {
        background-position: 0px -28px;
      }
      .flag_BR {
        background-position: -20px -28px;
      }
      .flag_VG {
        background-position: -40px -28px;
      }
      .flag_BN {
        background-position: -60px -28px;
      }
      .flag_BG {
        background-position: -80px -28px;
      }
      .flag_BF {
        background-position: -100px -28px;
      }
      .flag_BI {
        background-position: -120px -28px;
      }
      .flag_KH {
        background-position: -140px -28px;
      }
      .flag_CM {
        background-position: -160px -28px;
      }
      .flag_CA {
        background-position: -180px -28px;
      }
      .flag_CV {
        background-position: -200px -28px;
      }
      .flag_KY {
        background-position: -220px -28px;
      }
      .flag_CF {
        background-position: -240px -28px;
      }
      .flag_TD {
        background-position: -260px -28px;
      }
      .flag_CL {
        background-position: 0px -42px;
      }
      .flag_CN {
        background-position: -20px -42px;
      }
      .flag_CO {
        background-position: -40px -42px;
      }
      .flag_KM {
        background-position: -60px -42px;
      }
      .flag_CG {
        background-position: -80px -42px;
      }
      .flag_CK {
        background-position: -100px -42px;
      }
      .flag_CR {
        background-position: -120px -42px;
      }
      .flag_CI {
        background-position: -140px -42px;
      }
      .flag_HR {
        background-position: -160px -42px;
      }
      .flag_CU {
        background-position: -180px -42px;
      }
      .flag_CW {
        background-position: -100px -224px;
      }
      .flag_CY {
        background-position: -200px -42px;
      }
      .flag_CZ {
        background-position: -220px -42px;
      }
      .flag_CD {
        background-position: -240px -42px;
      }
      .flag_DK {
        background-position: -260px -42px;
      }
      .flag_DG {
        background-position: 0px -56px;
      }
      .flag_DJ {
        background-position: -20px -56px;
      }
      .flag_DM {
        background-position: -40px -56px;
      }
      .flag_DO {
        background-position: -60px -56px;
      }
      .flag_TL {
        background-position: -80px -56px;
      }
      .flag_EC {
        background-position: -100px -56px;
      }
      .flag_EG {
        background-position: -120px -56px;
      }
      .flag_SV {
        background-position: -140px -56px;
      }
      .flag_GQ {
        background-position: -160px -56px;
      }
      .flag_ER {
        background-position: -180px -56px;
      }
      .flag_EE {
        background-position: -200px -56px;
      }
      .flag_ET {
        background-position: -220px -56px;
      }
      .flag_FK {
        background-position: -240px -56px;
      }
      .flag_FO {
        background-position: -260px -56px;
      }
      .flag_FJ {
        background-position: 0px -70px;
      }
      .flag_FI {
        background-position: -20px -70px;
      }
      .flag_FR {
        background-position: -40px -70px;
      }
      .flag_GF {
        background-position: -60px -70px;
      }
      .flag_PF {
        background-position: -80px -70px;
      }
      .flag_GA {
        background-position: -100px -70px;
      }
      .flag_GM {
        background-position: -120px -70px;
      }
      .flag_GE {
        background-position: -140px -70px;
      }
      .flag_DE {
        background-position: -160px -70px;
      }
      .flag_GH {
        background-position: -180px -70px;
      }
      .flag_GI {
        background-position: -200px -70px;
      }
      .flag_GR {
        background-position: -220px -70px;
      }
      .flag_GL {
        background-position: -240px -70px;
      }
      .flag_GD {
        background-position: -260px -70px;
      }
      .flag_GP {
        background-position: 0px -84px;
      }
      .flag_GU {
        background-position: -20px -84px;
      }
      .flag_GT {
        background-position: -40px -84px;
      }
      .flag_GN {
        background-position: -60px -84px;
      }
      .flag_GW {
        background-position: -80px -84px;
      }preann_url
      .flag_GY {
        background-position: -100px -84px;
      }
      .flag_HT {
        background-position: -120px -84px;
      }
      .flag_HN {
        background-position: -140px -84px;
      }
      .flag_HK {
        background-position: -160px -84px;
      }
      .flag_HU {
        background-position: -180px -84px;
      }
      .flag_IS {
        background-position: -200px -84px;
      }
      .flag_IN {
        background-position: -220px -84px;
      }
      .flag_ID {
        background-position: -240px -84px;
      }
      .flag_IR {
        background-position: -260px -84px;
      }
      .flag_IQ {
        background-position: 0px -98px;
      }
      .flag_IE {
        background-position: -20px -98px;
      }
      .flag_IL {
        background-position: -40px -98px;
      }
      .flag_IT {
        background-position: -60px -98px;
      }
      .flag_JM {
        background-position: -80px -98px;
      }
      .flag_JP {
        background-position: -100px -98px;
      }
      .flag_JO {
        background-position: -120px -98px;
      }
      .flag_KZ {
        background-position: -140px -98px;
      }
      .flag_KE {
        background-position: -160px -98px;
      }
      .flag_KI {
        background-position: -180px -98px;
      }
      .flag_KW {
        background-position: -200px -98px;
      }
      .flag_KG {
        background-position: -220px -98px;
      }
      .flag_LA {
        background-position: -240px -98px;
      }
      .flag_LV {
        background-position: -260px -98px;
      }
      .flag_LB {
        background-position: 0px -112px;
      }
      .flag_LS {
        background-position: -20px -112px;
      }
      .flag_LR {
        background-position: -40px -112px;
      }
      .flag_LY {
        background-position: -60px -112px;
      }
      .flag_LI {
        background-position: -80px -112px;
      }
      .flag_LT {
        background-position: -100px -112px;
      }
      .flag_LU {
        background-position: -120px -112px;
      }
      .flag_MO {
        background-position: -140px -112px;
      }
      .flag_MK {
        background-position: -160px -112px;
      }
      .flag_MG {
        background-position: -180px -112px;
      }
      .flag_MW {
        background-position: -200px -112px;
      }
      .flag_MY {
        background-position: -220px -112px;
      }
      .flag_MV {
        background-position: -240px -112px;
      }
      .flag_ML {
        background-position: -260px -112px;
      }
      .flag_MT {
        background-position: 0px -126px;
      }
      .flag_MH {
        background-position: -20px -126px;
      }
      .flag_MQ {
        background-position: -40px -126px;
      }
      .flag_MR {
        background-position: -60px -126px;
      }
      .flag_MU {
        background-position: -80px -126px;
      }
      .flag_MX {
        background-position: -100px -126px;
      }
      .flag_FM {
        background-position: -120px -126px;
      }
      .flag_MD {
        background-position: -140px -126px;
      }
      .flag_MC {
        background-position: -160px -126px;
      }
      .flag_MN {
        background-position: -180px -126px;
      }
      .flag_ME {
        background-position: -200px -126px;
      }
      .flag_MS {
        background-position: -220px -126px;
      }
      .flag_MA {
        background-position: -240px -126px;
      }
      .flag_MZ {
        background-position: -260px -126px;
      }
      .flag_MM {
        background-position: 0px -140px;
      }
      .flag_NA {
        background-position: -20px -140px;
      }
      .flag_NR {
        background-position: -40px -140px;
      }
      .flag_NP {
        background-position: -60px -140px;
      }
      .flag_NL {
        background-position: -80px -140px;
      }
      .flag_AN {
        background-position: -100px -140px;
      }
      .flag_NC {
        background-position: -120px -140px;
      }
      .flag_NZ {
        background-position: -140px -140px;
      }
      .flag_NI {
        background-position: -160px -140px;
      }
      .flag_NE {
        background-position: -180px -140px;
      }
      .flag_NG {
        background-position: -200px -140px;
      }
      .flag_NU {
        background-position: -220px -140px;
      }
      .flag_KP {
        background-position: -240px -140px;
      }
      .flag_MP {
        background-position: -260px -140px;
      }
      .flag_NO {
        background-position: 0px -154px;
      }
      .flag_OM {
        background-position: -20px -154px;
      }
      .flag_PK {
        background-position: -40px -154px;
      }
      .flag_PW {
        background-position: -60px -154px;
      }
      .flag_PS {
        background-position: -80px -154px;
      }
      .flag_PA {
        background-position: -100px -154px;
      }
      .flag_PG {
        background-position: -120px -154px;
      }
      .flag_PY {
        background-position: -140px -154px;
      }
      .flag_PE {
        background-position: -160px -154px;
      }
      .flag_PH {
        background-position: -180px -154px;
      }
      .flag_PL {
        background-position: -200px -154px;
      }
      .flag_PT {
        background-position: -220px -154px;
      }
      .flag_PR {
        background-position: -240px -154px;
      }
      .flag_QA {
        background-position: -260px -154px;
      }
      .flag_RE {
        background-position: 0px -168px;
      }
      .flag_RO {
        background-position: -20px -168px;
      }
      .flag_RU {
        background-position: -40px -168px;
      }
      .flag_RW {
        background-position: -60px -168px;
      }
      .flag_SH {
        background-position: -80px -168px;
      }
      .flag_KN {
        background-position: -100px -168px;
      }
      .flag_LC {
        background-position: -120px -168px;
      }
      .flag_PM {
        background-position: -140px -168px;
      }
      .flag_VC {
        background-position: -160px -168px;
      }
      .flag_WS {
        background-position: -180px -168px;
      }
      .flag_SM {
        background-position: -200px -168px;
      }
      .flag_ST {
        background-position: -220px -168px;
      }
      .flag_SA {
        background-position: -240px -168px;
      }
      .flag_SN {
        background-position: -260px -168px;
      }
      .flag_RS {
        background-position: 0px -182px;
      }
      .flag_SC {
        background-position: -20px -182px;
      }
      .flag_SL {
        background-position: -40px -182px;
      }
      .flag_SG {
        background-position: -60px -182px;
      }
      .flag_SK {
        background-position: -80px -182px;
      }
      .flag_SI {
        background-position: -100px -182px;
      }
      .flag_SB {
        background-position: -120px -182px;
      }
      .flag_SO {
        background-position: -140px -182px;
      }
      .flag_ZA {
        background-position: -160px -182px;
      }
      .flag_KR {
        background-position: -180px -182px;
      }
      .flag_SS {
        background-position: -120px -224px;
      }
      .flag_ES {
        background-position: -200px -182px;
      }
      .flag_LK {
        background-position: -220px -182px;
      }
      .flag_SD {
        background-position: -240px -182px;
      }
      .flag_SR {
        background-position: -260px -182px;
      }
      .flag_SZ {
        background-position: 0px -196px;
      }
      .flag_SE {
        background-position: -20px -196px;
      }
      .flag_CH {
        background-position: -40px -196px;
      }
      .flag_SY {
        background-position: -60px -196px;
      }
      .flag_TW {
        background-position: -80px -196px;
      }
      .flag_TJ {
        background-position: -100px -196px;
      }
      .flag_TZ {
        background-position: -120px -196px;
      }
      .flag_TH {
        background-position: -140px -196px;
      }
      .flag_TG {
        background-position: -160px -196px;
      }
      .flag_TK {
        background-position: -180px -196px;
      }
      .flag_TO {
        background-position: -200px -196px;
      }
      .flag_TT {
        background-position: -220px -196px;
      }
      .flag_TN {
        background-position: -240px -196px;
      }
      .flag_TR {
        background-position: -260px -196px;
      }
      .flag_TM {
        background-position: 0px -210px;
      }
      .flag_TC {
        background-position: -20px -210px;
      }
      .flag_TV {
        background-position: -40px -210px;
      }
      .flag_UG {
        background-position: -60px -210px;
      }
      .flag_UA {
        background-position: -80px -210px;
      }
      .flag_AE {
        background-position: -100px -210px;
      }
      .flag_GB {
        background-position: -120px -210px;
      }
      .flag_US,
      .flag_UM {
        background-position: -140px -210px;
      }
      .flag_UY {
        background-position: -160px -210px;
      }
      .flag_VI {
        background-position: -180px -210px;
      }
      .flag_UZ {
        background-position: -200px -210px;
      }
      .flag_VU {
        background-position: -220px -210px;
      }
      .flag_VA {
        background-position: -240px -210px;
      }
      .flag_VE {
        background-position: -260px -210px;
      }
      .flag_VN {
        background-position: 0px -224px;
      }
      .flag_WF {
        background-position: -20px -224px;
      }
      .flag_YE {
        background-position: -40px -224px;
      }
      .flag_ZM {
        background-position: -60px -224px;
      }
      .flag_ZW {
        background-position: -80px -224px;
      }
      .flag_AQ {
        background-position: -160px -224px;
      }
      .flag_BV,
      .flag_SJ {
        background-position: -180px -224px;
      }
      .flag_IO {
        background-position: -200px -224px;
      }
      .flag_CX {
        background-position: -220px -224px;
      }
      .flag_CC {
        background-position: -240px -224px;
      }
      .flag_TF {
        background-position: -260px -224px;
      }
      .flag_GG {
        background-position: 0px -238px;
      }
      .flag_HM {
        background-position: -20px -238px;
      }
      .flag_JE {
        background-position: -40px -238px;
      }
      .flag_YT {
        background-position: -60px -238px;
      }
      .flag_NF {
        background-position: -80px -238px;
      }
      .flag_PN {
        background-position: -100px -238px;
      }
      .flag_GS {
        background-position: -120px -238px;
      }
      .flag_EH {
        background-position: -140px -238px;
      }
      .flag_IM {
        background-position: -160px -238px;
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
      .verified_tick{
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
      .white{
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
    <script>
      	var csrfParam= "${za.csrf_paramName}";
      	var csrfCookieName = "${za.csrf_cookieName}";
		var contextpath = <#if cp_contextpath??>"${cp_contextpath}"<#else> "" </#if>
      	var resendTimer, resendtiming , altered;
      	var countryDialCode = "${dcode}";
    	var countryCode = "${code}";
    	var mobile = "${mobile}";
    	var showMobileNoPlaceholder = ${mob_plc_holder?c};
    	<#if req_country??>var IPcountry = "${req_country}";</#if>
		var isMobile = ${is_mobile?c};
		var emailormobilevalue = "+" + countryDialCode+" "+mobile+countryCode;
		var mode = "mobile"; //since this is a mobile based annoucement .. else we dont need to set the mode.
		var isEdit = ${is_editable?c};
		var isEnforced = ${is_enforced?c};
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
	  	initMobileSelect();
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
        if(countryCode){
		reqCountry = "#"+countryCode.toUpperCase();
      	$('#countNameAddDiv option:selected').removeAttr('selected');
      	$("#countNameAddDiv "+reqCountry).prop('selected', true);
      	$("#countNameAddDiv "+reqCountry).trigger('change');
		}
        document.querySelector("#" + mode + "_input").value = mobile
        }
      }
	  
	  function sendOTP(mode, emailormobilevalue) {
      	$(".resend_otp").html("<div class='loader'></div>"+I18N.get('IAM.GENERAL.OTP.SENDING'));
        if (mode === "email") {
        	if (isEmailId(emailormobilevalue)) {
        		$("div.valueemailormobile").html(emailormobilevalue);
            	var params = { blockunconfirmeduser: { login_id: emailormobilevalue } };
            	sendRequestWithCallback("/webclient/v1/announcement/pre/loginmobile", JSON.stringify(params), true, handleOtpSent, "POST")
          	} else {
             show_error_msg("#email_input", I18N.get("IAM.ERROR.ENTER.VALID.EMAIL"));
          	}
        } else if (mode === "mobile") {
          	if (isPhoneNumber(mobile)) {
          		countryCode = emailormobilevalue.substring(emailormobilevalue.length-2);
          		emailormobilevalue = emailormobilevalue.substring(0,emailormobilevalue.length-2);
          		$("div.valueemailormobile").html(emailormobilevalue);
           		var params = { enforcedloginmobile: { mobile: mobile, countrycode: countryCode } };
           		sendRequestWithCallback("/webclient/v1/announcement/pre/loginmobile", JSON.stringify(params), true, handleOtpSent, "POST")
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
			if(isEdit){
			document.querySelector(".edit_option").style.display = "inline-block";
			}
			$(".enter_eml_mob_desc, .send_otp_btn, ."+ mode +"_input_container, .existing_numbers_container, .update_send_otp_btn").slideUp(200);
			$(".otp_input_container, .otp_sent_desc").slideDown(200);
				setTimeout(function(){
				$(".resend_otp").html("<div class='tick'></div>"+I18N.get('IAM.GENERAL.OTP.SUCCESS'));
				setTimeout(function(){
				resendOtpChecking();
				}, 1000);
				}, 800);
				if(resp.enforcedloginmobile.encryptedMobile){
					cryptData = resp.enforcedloginmobile.encrypted_data;
				}
			}
			else{
				if(mode === "email"){
					show_error_msg("#email_input", resp.localized_message);
				}else if(mode === "mobile"){
					if($("#select2-verfied_phnnum-container").is(":visible")){
          			show_error_msg(".select2-container--already_numbers .select2-selection", resp.localized_message);
          		} else {
					show_error_msg("#mobile_input", resp.localized_message);
				}}
			}
		}
	  }
	  
	  function resendOTP(){
	  $(".resend_otp").html("<div class='loader'></div>"+I18N.get('IAM.GENERAL.OTP.SENDING'));
	  	var params= {};
	  	sendRequestWithCallback("/webclient/v1/announcement/pre/loginmobile/"+cryptData, "", true, handleOtpResent, "PUT");
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
          var login_id = $("#mobile_input").val();
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
      
      function verifyCode() {
        var Code = document.querySelector("#otp_split_input_full_value").value;
        if($(".error_msg").length<1){
        if(isValidCode(Code)){
        clearError('#otp_split_input');
        $(".verify_btn span").html("<div class='loader white'></div>");
        $(".verify_btn").prop("disabled", true);
        var params = { enforcedloginmobile : { code: Code } };
        sendRequestWithCallback("/webclient/v1/announcement/pre/loginmobile/"+cryptData, JSON.stringify(params), true, handleVerifyCode, "PUT")
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
				window.location.href = next;
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
      
      function selectAlreadyNumbers(){
      	$(".mobile_input_container, .enter_eml_mob_desc, .send_otp_btn").slideUp(200);
      	$(".existing_numbers_container, .update_send_otp_btn").slideDown(200);
      	$(document.confirm_form2.verified_nums).select2({
      		minimumResultsForSearch: Infinity,
      		theme: "already_numbers",
    		templateResult: function(option){
    		if (!option.id) { return option.text; }
    		var string_code = $(option.element).attr("value");
    		var number_val = $(option.element).text();
    		var ob = '<div class="pic flag_'+string_code.toUpperCase()+'"></div><span class="cn">'+number_val+"</span>";
    		return  ob;
    		},templateSelection: function (option) {
		    	selectFlag($(option.element));
		            return option.text;
		    },escapeMarkup: function (m) {
			  return m;
			}
    	}).on("select2:open", function () {
            	clearError(".select2-container--already_numbers .select2-selection");
          	}).on("select2:close", function () {
            	$(document.confirm_form2.hidden_input).focus();
          	});
    	$(".existing_numbers_container .select2-selection").append("<span id='selectFlag' class='selectFlag'></span>");
		selectFlag($(document.confirm_form2.verified_nums).find("option:selected"));
		$(".select2-selection__rendered").attr("title", "");
      }
	  function addNewNumber(){
	  $(".mobile_input_container, .enter_eml_mob_desc, .send_otp_btn").slideDown(200);
	  	$(".existing_numbers_container, .update_send_otp_btn").slideUp(200);
	  	document.querySelector("#" + mode + "_input").focus();
	  }
		            
      function updateAlreadyMblValue(){
      	var countryCode = $('#verfied_phnnum option:selected').attr("value");
      	var dialCodeMobile =  $('#verfied_phnnum option:selected').text();
      	mobile = dialCodeMobile.split(" ")[1];
      	emailormobilevalue = dialCodeMobile + countryCode;
      	sendOTP(mode, emailormobilevalue);
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
	  
	  
      function allowSubmit(e) {
        if (mode === "email" && emailormobilevalue === e.target.value || emailormobilevalue === "") {
          altered=false;
          if (!resendtiming == 0) {
            $(".send_otp_btn").prop("disabled", true);
          }
        }
        else if(mode === "mobile" && mobile === e.target.value || mobile === ""){
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
      
      function setMobileNumPlaceholder(selectEle) {
        if (showMobileNoPlaceholder) {
          var mobInput = $(selectEle).siblings("input[type=tel]")[0];
          $(mobInput).unbind();
          $(selectEle).change(function () {
            mobInput.value = "";
            mobInput.placeholder = phoneData[$(selectEle).val()].example.replace(
              new RegExp(phoneData[$(selectEle).val()].pattern),
              phoneData[$(selectEle).val()].space
            );
            mobInput.maxLength = mobInput.placeholder.length;
          });
          mobInput.placeholder = phoneData[$(selectEle).val()].example.replace(
            new RegExp(phoneData[$(selectEle).val()].pattern),
            phoneData[$(selectEle).val()].space
          );
        }
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
		$(ele).css({'opacity':'0','width':'60px','height':'42px'});
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
			}};
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
	  function caseCheck(){
	  		document.querySelector(".enter_eml_mob_desc").style.display = "block";
	  		document.querySelector(".mobile_input_container").style.display = "block";
	  		document.querySelector(".send_otp_btn").style.display = "block";
	  		initMobileSelect();
			if(countryCode){
			$(document.confirm_form1.countrycode).val(countryCode);
			$(document.confirm_form1.countrycode).trigger('change');
			}
			document.querySelector("#" + mode + "_input").value = mobile;
			if(!isEdit){
				$(document.confirm_form1.mobile_no).attr("readonly",true);
				$(".select2-container").css("pointer-events", "none");
				$(".select2-selection__arrow").remove();
				document.querySelector("#mobile_input").style.backgroundColor = "#f9f9f9";
				document.querySelector("#mobile_input").style.textIndent = "72px";
				document.querySelector("#mobile_input").classList.remove("textindent66");
			    if(document.querySelector(".already_added")){
					document.querySelector(".already_added").style.display = "none";
				}
			}
			if( mobile == "" && countryCode == ""){
				$(document.confirm_form1.countrycode).val(IPcountry);
				$(document.confirm_form1.countrycode).trigger('change');
			}
	  }
	  
	  function initMobileSelect(){
	  	if (mode === "mobile") {
	  		if(!isMobile) {
        	$(document.confirm_form1.countrycode)
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
          	})
          	.on("select2:open", function () {
            	$(".select2-search__field").attr("placeholder", "<@i18n key="IAM.SEARCHING"/>");
          	});
        	$("#select_phonenumber .select2-selection").append("<span id='selectFlag' class='selectFlag'></span>");
        	selectFlag($(document.confirm_form1.countrycode).find("option:selected"));
        	$(".select2-selection__rendered").attr("title", "");
        	$(document.confirm_form.countrycode).on("select2:close", function (e) {
          		$(e.target).siblings("input").focus();
        	});
        	setMobileNumPlaceholder(document.confirm_form1.countrycode);
        	 $(".phone_code_label").css("visibility" ,"hidden")
      		} else {
       		phonecodeChangeForMobile(document.confirm_form1.countrycode);
      		}
    	}
	  }
	  </script>
    </head>
    <body>
    <div id="error_space">
		<span class="error_icon">&#33;</span> <span class="top_msg"></span>
	</div>
    <div class="flex-container container">
    	<div class="content_container">
        	<div class="cp_display_name">${Encoder.encodeHTML(app_display_name)}</div>
       		<#if is_enforced>
        	<div class="announcement_header"><@i18n key="IAM.ADD.YOUR.MOBILE.NUMBER.TITLE"/></div>
        	<div class="account_verify_desc"><@i18n key="IAM.ADD.LOGIN.NUMBER.ORG.POLICY.DESC"/></div>
			<#else>
        	<div class="announcement_header"><@i18n key="IAM.VERIFY.PRIMARY.NUMBER.TITLE"/></div>
        	<div class="account_verify_desc"><@i18n key="IAM.ADD.LOGIN.VERIFY.PRIMARY.NO.DESC"/></div>
        	</#if>	
        		<div class="otp_sent_desc" style="display: none">
        		<@i18n key="IAM.DIGIT.VER.CODE.SENT.MOBILE"/>
          		<span class="emailormobile">
            	<div class="valueemailormobile">${country_dialcode}-${mobile}</div> 
            	<#if edit_mobile?? && edit_mobile>
            	<span class="edit_option" onclick="handleEditOption(mode)"><@i18n key="IAM.EDIT"/></span>
            	<#else>
            	<span class="edit_option" onclick="handleEditOption(mode)" style="display: none"><@i18n key="IAM.EDIT"/></span>
            	</#if>
          		</span>
        	</div>
        	
        	<form name="confirm_form" onsubmit="return false">
        		<div class="otp_input_container" style="display: none">
              		<label for="otp_input" class="emolabel"><@i18n key="IAM.VERIFICATION.CODE"/></label>
              		<div id="otp_split_input" class="otp_container"></div>
              		<div class="resend_otp" onclick="resendOTP()"><span></span><@i18n key="IAM.TFA.RESEND.OTP"/></div>
              		<button class="verify_btn" onclick="verifyCode()"><span></span><@i18n key="IAM.VERIFY"/></button>
            	</div>
        	</form>
        	<form name="confirm_form1" onsubmit="return false">
        		<div class="enter_eml_mob_desc" style="display: none">
				<#if edit_mobile?? && edit_mobile>
					<@i18n key="IAM.MOBILE.SEND.OTP.VERIFY"/>
				<#else>
					<@i18n key="IAM.ADD.LOGIN.SEND.OTP.ENFORCED.VERIFY"/>
				</#if>
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
                	name="mobile_no"
                	id="mobile_input"
                	maxlength="15"
                	data-type="phonenumber"
                	type="tel"
					oninput="allowSubmit(event)"
              	/>
              	<#if mobiles?size gt 0>
              		<div class="already_added" onclick="selectAlreadyNumbers()"><@i18n key="IAM.MFA.ADD.VERIFIED.MOBILE.NUMBER"/></div>
              	</#if>
            	</div>
            	<button class="send_otp_btn" onclick="updateEmlMblValue()" style="display: none"><@i18n key="IAM.SEND.OTP"/><span style="margin:0"></span></button>
        	</form>
        	<#if mobiles?size gt 0>
        	<form name="confirm_form2" onsubmit="return false">
            	<div class="existing_numbers_container field" style="display:none;">
            		<div class="already_existing_desc"><@i18n key="IAM.ADD.ALREADY.VERIFIED.NUMBER.DESC"/></div>
            		<input type="hidden" name="hidden_input" style="width:0;height:0;padding:0;margin:0;border:none;"/>
              		<select class="profile_mode" id="verfied_phnnum" data-validate="zform_field" name="verified_nums"> 
		        	<#list mobiles as x>
		        	<option value="${x.code}" id="${x?index}">${x.mobile}</option>
		        	</#list>
		        	</select>
		        	<div class="add_new_number" onclick="addNewNumber()"><@i18n key="IAM.MFA.ADD.NEW.MOBILE.NUMBER"/></div>
              	</div>
              	<button class="update_send_otp_btn" onclick="updateAlreadyMblValue()" style="display: none"><@i18n key="IAM.SEND.OTP"/></button>
        	 </form>
        	 </#if>
    	</div>
    	<div class="illustration-container">
        	<div class="illustration"></div>
      	</div>
    </div>
    </body>
    <script>
    	window.onload = function () {
    		caseCheck();
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
      		setFooterPosition();
      	}
	</script>
</html>