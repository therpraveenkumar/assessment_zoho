<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<title><@i18n key="IAM.ANNOUNCEMENT.LOCALE.UPDATE"/></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="${za.config.v2_iam_css_url}/announcement_style.css" type="text/css"  rel="stylesheet" />
<style>
@font-face {
		    font-family: 'ZohoPuvi';
		    src:url('${za.config.v2_iam_img_url}/zohopuvi/zoho_puvi_medium.eot'); 
		    src:url('${za.config.v2_iam_img_url}/zohopuvi/zoho_puvi_medium.eot') format('embedded-opentype'),
		        url('${za.config.v2_iam_img_url}/zohopuvi/zoho_puvi_medium.woff') format('woff'),
		        url('${za.config.v2_iam_img_url}/zohopuvi/zoho_puvi_medium.ttf') format('truetype'); 
		        font-style: medium;
    		 	font-weight: 500;
    		 	text-rendering: optimizeLegibility;
		}
		
@font-face {
    font-family: 'ZohoPuvi';
    src: url('${za.config.v2_iam_img_url}/zohopuvi/zoho_puvi_regular.eot'); /* IE9 Compat Modes */
    src: url('${za.config.v2_iam_img_url}/zohopuvi/zoho_puvi_regular.eot') format('embedded-opentype'), /* IE6-IE8 */
         url('${za.config.v2_iam_img_url}/zohopuvi/zoho_puvi_regular.woff') format('woff'), /* Modern Browsers */
         url('${za.config.v2_iam_img_url}/zohopuvi/zoho_puvi_regular.ttf') format('truetype'); /* Safari, Android, iOS */
         font-style: regular;
    	 font-weight: 400;
    	 text-rendering: optimizeLegibility;
}

@font-face {
    font-family: 'ZohoPuvi';
    src: url('${za.config.v2_iam_img_url}/zohopuvi/zoho_puvi_bold.eot'); /* IE9 Compat Modes */
    src: url('${za.config.v2_iam_img_url}/zohopuvi/zoho_puvi_bold.eot') format('embedded-opentype'), /* IE6-IE8 */
         url('${za.config.v2_iam_img_url}/zohopuvi/zoho_puvi_bold.woff') format('woff'), /* Modern Browsers */
         url('${za.config.v2_iam_img_url}/zohopuvi/zoho_puvi_bold.ttf') format('truetype'); /* Safari, Android, iOS */
         font-style: semibold;
    	 font-weight: 600;
    	 text-rendering: optimizeLegibility;
}
	
@font-face {
  font-family: 'Announce';
  src:  url('${za.config.v2_iam_img_url}/fonts/Announcement.eot');
  src:  url('${za.config.v2_iam_img_url}/fonts/Announcement.eot') format('embedded-opentype'),
    url('${za.config.v2_iam_img_url}/fonts/Announcement.ttf') format('truetype'),
    url('${za.config.v2_iam_img_url}/fonts/Announcement.woff') format('woff'),
    url('${za.config.v2_iam_img_url}/fonts/Announcement.svg') format('svg');
  font-weight: normal;
  font-style: normal;
  font-display: block;
}

[class^="icon-"], [class*=" icon-"] {
  /* use !important to prevent issues with browser extensions that change fonts */
  font-family: 'Announce' !important;
  font-style: normal;
  font-weight: normal;
  font-variant: normal;
  text-transform: none;
  line-height: 1;

  /* Better Font Rendering =========== */
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

.icon-Country:before {
  content: "\e907";
}
.icon-pebble:before {
  content: "\e90b";
}
.icon-Timezone:before {
  content: "\e910";
}
	
</style>

<script src="${za.config.iam_js_url_static}/jquery-3.6.0.min.js" type="text/javascript"></script>
<script src="${za.config.iam_js_url_static}/common.js" type="text/javascript"></script>
<script src="${za.config.iam_js_url_static}/chosen.jquery.js" type="text/javascript"></script>
<link href="${za.config.iam_css_url}/chosen.css" type="text/css"  rel="stylesheet" />
<script src="${za.config.v2_iam_tpkg_url}/select2.full.min.js"></script>
<script>
var csrfParam = '${za.config.csrfParam}='+getIAMCookie('${za.config.csrfCookie}');
var contextpath = '${za.iam_contextpath}';
var current_country_code, current_timezone_arr, current_country_name, current_timezone, current_state_name, user_country_val, user_timezone_val,user_state_val, user_country_code, timezone_gmt_id = "", countryStateList = [], is_state_needed = false, is_timezone_update_needed = false;

var Country_list = ${announcement.CountryList};	
var Country_codes = ${announcement.country_Codes};
var timezone_list = ${announcement.timezone_List};
var is_ccpa_true = "<#if announcement.is_StateUpdateRequired>true</#if>";
var isMobile = Boolean("<#if announcement.isMobile>true</#if>");
is_timezone_update_needed = timezone_list && timezone_list.length > 0;

		
var i18nkeys = {
	"IAM.ANNOUNCEMENT.LOCALE.SELECT.COUNTRY" : '<@i18n key="IAM.ANNOUNCEMENT.LOCALE.SELECT.COUNTRY" />',
	"IAM.ANNOUNCEMENT.LOCALE.SELECT.STATE" : '<@i18n key="IAM.ANNOUNCEMENT.LOCALE.SELECT.STATE" />',
	"IAM.ANNOUNCEMENT.LOCALE.SELECT.TIMEZONE" : '<@i18n key="IAM.ANNOUNCEMENT.LOCALE.SELECT.TIMEZONE" />',
	"IAM.US.STATE.SELECT" : '<@i18n key="IAM.US.STATE.SELECT" />',
	"IAM.TFA.SELECT.COUNTRY" : '<@i18n key="IAM.TFA.SELECT.COUNTRY" />',
	"IAM.ANNOUNCEMENT.TIMEZONE.SELECT" : '<@i18n key="IAM.ANNOUNCEMENT.TIMEZONE.SELECT" />',
	"IAM.ERROR.GENERAL" : '<@i18n key="IAM.ERROR.GENERAL" />',
	"IAM.ERROR.UPDATE.SUCCESS.MESSAGE" : '<@i18n key="IAM.ERROR.UPDATE.SUCCESS.MESSAGE" />',
	"IAM.SEARCHING" : '<@i18n key="IAM.SEARCHING" />',
	"IAM.NO.RESULT.FOUND" : '<@i18n key="IAM.NO.RESULT.FOUND" />',
};
		

function redirect(){
	window.location.href="${announcement.visited_url}";
}

function remind_later() {
	window.location.href="${announcement.remindme_url}";
}

function close_popup() {
		$("#result_popup_failure, .blur_screen").slideUp(150);
}

function remove_remindlater_link() {
	$(".remind_later_link").hide();
	edit_details();
}

function toggleCountryStates(selectCountryElement) {
	var select = $('#state_dropdown select[name=country_state]');
	var is_state_present = false;
	if(select.length > 0 && ZACountryStateDetails && ZACountryStateDetails.length > 0) {
		var countryOptionEle = selectCountryElement.options[selectCountryElement.selectedIndex];//.selectedOptions[0];
		var countryCode = countryOptionEle.value;
		var countryStates = ZACountryStateDetails[0];
		var stateOptios = countryStates[countryCode.toLowerCase()];
		if(stateOptios != undefined) {
			select[0].innerHTML = stateOptios;			
			for (i = 0; i < document.getElementById("state_dropdown_list").length; ++i) {
			    if (document.getElementById("state_dropdown_list").options[i].value.toLowerCase() == current_state_name.toLowerCase()){
			      is_state_present = true;
			      $('#state_dropdown_list option:eq('+i+')').prop('selected', true);
			    }
			}
			is_state_needed = true;
			$('#state_dropdown').css('display',''); //No I18N
		} else {
			select[0].innerHTML = "";
			is_state_needed = false;
			$('#state_dropdown').css('display','none'); //No I18N
		}
	}
}

function populate_states() {
     var countryStates = ${announcement.states};
     if(countryStates != null && countryStates != '') {
	     var stateJson = {};
     	 var stateCountries_len = Object.keys(countryStates).length;
     	 for(country_no = 0; country_no < stateCountries_len; country_no++) {
     	 	var stateCountry = Object.keys(countryStates)[country_no];
     	 	var states = countryStates[stateCountry];
     	 	var stateOptions = '';
     	 	for(state_no = 0; state_no < states.length; state_no++) {
     	 		stateOptions += "<option value=\"" + states[state_no] + "\">" + states[state_no] + "</option>";
     	 	}
			stateJson[stateCountry] = stateOptions.toString();
			countryStateList.push(stateCountry);
     	 }
     	 var countryStateDetails = [];
     	 countryStateDetails.push(stateJson);
     	 window.ZACountryStateDetails = countryStateDetails;
     }  
}

$(document).ready(function() {
		populate_states();
		$("#container").css("display", "block");
		 current_country_name = "${announcement.current_countryName}";
		 current_country_code = "${announcement.current_countryCode}";
		 current_timezone = "${announcement.current_timezone}";
		 current_state_name = "${announcement.current_stateName}";
		 user_country_val = "${announcement.user_country_name}";
		 user_timezone_val = "${announcement.user_timezone_val}";
		 user_state_val = "${announcement.user_statename}";
		 user_country_code = "${announcement.user_country_code}";
		 current_timezone_arr = get_timezone_arr(current_timezone);
		 
		 if(user_state_val != '' && countryStateList.indexOf(user_country_code.toLowerCase()) != -1) {
			 $(".current_country_box").append("<span class='current_locale_value'> (" + user_state_val + ") </span>");
		 }
		 
		 if(user_timezone_val != "") {
		  user_timezone_arr = get_timezone_arr(user_timezone_val);		//No I18N
		  if(user_timezone_arr[1] == "Etc/GMT+12") {
		 	var cont_timezone_val = user_timezone_val.replace(user_timezone_arr[0], "").trim();
		 	$(".timezone_value").text(cont_timezone_val);
		 } }
		 else if (current_timezone != "") {
		 	if(current_timezone_arr[1] == "Etc/GMT+12") {
			var cont_timezone_val = current_timezone.replace(current_timezone_arr[0], "").trim();
		 	$(".timezone_value").text(cont_timezone_val);
		 }}
		 
		content_for_form_container();
		if(is_ccpa_true) {
			$("#user_details_container").hide();
			edit_details();
		} else {
			$("#user_details_container").show();
		}
	
		$("#country_dropdown_list").select2({
			   placeholder: i18nkeys["IAM.TFA.SELECT.COUNTRY"],
			   language: { noResults: function(){ return i18nkeys["IAM.NO.RESULT.FOUND"];}}
		 }).on("select2:open", function() {
		       $(".select2-dropdown").css("margin-left", "-1px");  //No I18N
		       $("#country_dropdown").addClass("highlight_select"); 
		       $(".select2-search__field").attr("placeholder",  i18nkeys["IAM.SEARCHING"]);//No I18N
		 }).on("select2:close", function() {
		       $("#country_dropdown").removeClass("highlight_select");
		 }).on("change.select2", function(event) {
				   var value = $(event.currentTarget).find("option:selected").text();
				   current_country_code = $(event.currentTarget).find("option:selected").val();
				   toggleCountryStates(this);
				   $(".warn_msg").css("display", "none");
		  });	  
		 
		 $("#state_dropdown_list").select2({
			   placeholder: i18nkeys["IAM.US.STATE.SELECT"],
			   language: { noResults: function(){ return i18nkeys["IAM.NO.RESULT.FOUND"];}}
		 }).on("select2:open", function() {
		       $(".select2-dropdown").css("margin-left", "-1px");  //No I18N 
		       $(".warn_msg").css("display", "none"); 
		       $("#state_dropdown").addClass("highlight_select"); 
		       $(".select2-search__field").attr("placeholder", i18nkeys["IAM.SEARCHING"]);//No I18N
		 }).on("select2:close", function() {
		       $("#state_dropdown").removeClass("highlight_select"); 
		 });
		 
		 if(is_timezone_update_needed) {
		 	$("#timezone_dropdown_list").select2({
                placeholder: i18nkeys["IAM.ANNOUNCEMENT.TIMEZONE.SELECT"],
                language: { noResults: function(){ return i18nkeys["IAM.NO.RESULT.FOUND"];}}
		    }).on("select2:open", function() {
		        $(".select2-dropdown").css("margin-left", "-1px");  //No I18N
		        $(".select2-selection__rendered").css("max-width", "380px");   //NO I18N  
		        $("#timezone_dropdown").addClass("highlight_select");
		        $(".select2-search__field").attr("placeholder", i18nkeys["IAM.SEARCHING"]);//No I18N
		    }).on("select2:close", function() {
		     	$("#timezone_dropdown").removeClass("highlight_select"); 
		    });
		 }
	      
	     if(isMobile) { //To remove select2 for mobile 
		  	$('.select2-selection__arrow b').hide();
		  	$('.select2-container--default').hide();
		  	$('.profile_mode').removeClass().addClass(".profile_mode");
		  }
	      
		$("#cancel_btn").click(function() {
			$("#locale_dropdown_container").hide();
			$("#user_details_container, .remind_later_link").show();
			content_for_form_container();
		});				
});

function get_timezone_arr (timezone_val) {
	var timezone_id = timezone_val.split(" ");
	timezone_id = timezone_id[(timezone_id.length)-1];
	var regExp = /\(([^)]+)\)/;
	var matches = regExp.exec(timezone_id);
    return matches;
}

function content_for_form_container() {
	   var country_list_len = Country_list.length;
	   var country_dropdown_length = $("#country_dropdown_list").children().length;
	   for(var country_no = 0; country_no < country_list_len; country_no++) {
		   var countryName = Country_list[country_no];
		   var country_Code = Country_codes[country_no];
		   if(country_dropdown_length == 0) {
		       if(countryName.toLowerCase() !== current_country_name.toLowerCase()) {
				   $("#country_dropdown_list").append("<option value="+country_Code+">"+countryName+"</option>");
			   } else {
				   $("#country_dropdown_list").append("<option selected='selected' value="+country_Code+">"+countryName+"</option>");
			   }
		   } else {
		  	   if(countryName.toLowerCase() == current_country_name.toLowerCase()) {
		  	   	   $('#country_dropdown_list option:eq('+country_no+')').prop('selected', true).trigger( "change" );
			   }
		   }
	   }
	   
	   if(is_timezone_update_needed)
	   {
		   var timezone_list_len = timezone_list.length;
		   var timezone_dropdown_length = $("#timezone_dropdown_list").children().length;
		   var current_timezone_id = current_timezone_arr[1];
	       for(var timezone_no = 0; timezone_no < timezone_list_len; timezone_no++) {
	              var  timezone_val = timezone_list[timezone_no];
	              var timezone_val_arr = get_timezone_arr(timezone_val);
	              var timezone_val_id = timezone_val_arr[1];
	              if(timezone_dropdown_length == 0) {
	               	if(timezone_val_id !== current_timezone_id) {
		               if(timezone_val_id == "Etc/GMT+12") {
		               		timezone_gmt_id = timezone_val_id;
		              		timezone_val = timezone_val.replace(timezone_val_arr[0], "").trim();
		              }               	
		              $("#timezone_dropdown_list").append("<option>"+timezone_val+"</option>");
			          } else {
			          if(timezone_val_id == "Etc/GMT+12") {
			          	timezone_gmt_id = timezone_val_id;
	              		timezone_val = timezone_val.replace(timezone_val_arr[0], "").trim();
	                  }
			          $("#timezone_dropdown_list").append("<option selected='selected'>"+timezone_val+"</option>");
			          }
	              } else {
	              	 if(timezone_val_id == current_timezone_id) {
		                 $('#timezone_dropdown_list option:eq('+timezone_no+')').prop('selected', true).trigger( "change" );
			          }
	              } 	              
	     	}
	     	$("#timezone_dropdown").css("display", "block");
	     	 if(current_timezone == "") {
			   	  $('#timezone_dropdown_list option:eq(0)').prop('selected', true).trigger('change');
			 }
     	}
       
       if(current_country_name == "") {
	   	  $('#country_dropdown_list option:eq(0)').prop('selected', true).trigger('change');
	   }
}


function edit_details() {
	$("#user_details_container").css("display", "none");
	select = $('#country_dropdown select[name=country]')[0];
	if(current_country_name)
	toggleCountryStates(select);
	$("#locale_dropdown_container").css("display", "block");
}

function update_location_call(update_profile_data) {
	var params = JSON.stringify({"user" : update_profile_data}); //NO I18N
	var xhr=$.ajax({
		"beforeSend": function(xhr) { //NO I18N
			xhr.setRequestHeader("X-ZCSRF-TOKEN", csrfParam);
		},
		type: "PUT",// No I18N
		url: contextpath + "/webclient/v1/account/self/user/self", //NO I18N
		data: params,// No I18N
		dataType : "json", // No I18N
		success: function(obj) {
		if(obj.status_code == 200) {
			$("#result_popup_success, .blur_screen").slideDown(150);
		} else {
			$("#result_popup_failure, .blur_screen").slideDown(150);
		}
		}
	});
}

function update_profile_new_location() {
	var update_profile_data = {};
	if(user_country_val != "") {
		$.extend(update_profile_data, { "country" : user_country_code.toLowerCase() }); //NO I18N
		if(user_timezone_val != "") {
			$.extend(update_profile_data, { "timezone" : get_timezone_arr(user_timezone_val)[1] }); //NO I18N
		} else {
			update_profile_data = null;
		}
		if(user_state_val != "" && countryStateList.indexOf(user_country_code.toLowerCase()) != -1) {
			$.extend(update_profile_data, { "state" : user_state_val }); //NO I18N
		}
	} else {
		update_profile_data = null;
	}
	if(update_profile_data != null) {
		update_location_call(update_profile_data);
	} else {
		$("#result_popup_failure, .blur_screen").slideDown(150);
	}
}

function update_profile_edited_loc() {	
	var new_country = $("#select2-country_dropdown_list-container").attr("title");	
	if(new_country != undefined) {
		var update_profile_data = {
				"country" : current_country_code.toLowerCase() //NO I18N
		}
		if(is_timezone_update_needed) {
			var new_timezone = $("#select2-timezone_dropdown_list-container").attr("title");
			if(new_timezone != undefined) {
				var new_timezone_arr = get_timezone_arr(new_timezone);
				if (new_timezone_arr == null && timezone_gmt_id != "") {
					new_timezone = timezone_gmt_id; 
				} else {
					new_timezone = new_timezone_arr[1];
				}
				$.extend(update_profile_data, { "timezone" : new_timezone }); //NO I18N
			} else {
				update_profile_data = null;
				$(".warn_msg").text(i18nkeys["IAM.ANNOUNCEMENT.LOCALE.SELECT.TIMEZONE"]);
			}
		} 
		if(is_state_needed) {
			var new_state = $("#select2-state_dropdown_list-container").attr("title");
			if(new_state != undefined) {
				$.extend(update_profile_data, { "state" : new_state }); //NO I18N
			} else {
				update_profile_data = null;
				$(".warn_msg").text(i18nkeys["IAM.ANNOUNCEMENT.LOCALE.SELECT.STATE"]);
			}
		}	
	} else {
		update_profile_data = null;
		$(".warn_msg").text(i18nkeys["IAM.ANNOUNCEMENT.LOCALE.SELECT.COUNTRY"]);
	}
	if(update_profile_data == undefined || update_profile_data == null) {
		$(".warn_msg").css("display", "block");
	} else {
		update_location_call(update_profile_data);
	}
}
</script>
</head>
<body>
<div class="container" id="container">
<div class="blur_screen"></div>

		<div class="blur hide"></div>
		<div class="result_popup hide" id="result_popup_success">
			<div class="success_pop_bg"></div>
			<div class="success_icon"></div>
			<div class="grn_text" id="result_content"><@i18n key="IAM.ANNOUNCEMENT.LOCALE.SUCCESS.MESSAGE.HEADER"/></div>
			<div class="defin_text"><@i18n key="IAM.ANNOUNCEMENT.LOCALE.SUCCESS.MESSAGE.TEXT"/></div>
			<button class="button center_btn" id="continue" onclick="redirect();"><@i18n key="IAM.CONTINUE"/></button>
		</div>

		<div class="result_popup hide" id="result_popup_failure">
			<div class="reject_pop_bg"></div>
			<div class="reject_icon"></div>
			<div class="grn_text" id="result_content"><@i18n key="IAM.ERROR.GENERAL"/></div>
			<div class="defin_text"><@i18n key="IAM.ANNOUNCEMENT.LOCALE.FAILURE.MESSAGE.TEXT"/></div>
			<button class="button center_btn" id="close_popup" onclick="close_popup();"><@i18n key="IAM.TRY.AGAIN"/></button>
		</div>
		<div class="box_container">
			<div class="announcement_content">			
				<div class="zoho_logo"></div>
				<div class="announcement_heading"> <@i18n key="IAM.ANNOUNCEMENT.LOCALE.TITLE" /> </div>
				<div class="announcement_description"> 
			    <#if announcement.is_StateUpdateRequired??>
			   	<@i18n key="IAM.ANNOUNCEMENT.LOCALE.DESCRIPTION" />
				<#else>
				<@i18n key="IAM.ANNOUNCEMENT.LOCALE.TIMEZONE.DESCRIPTION" arg0="${announcement.current_countryName}" />
				</#if>
				</div>
				
				<div id="user_details_container" class="hide">
				<div class="user_locale_container">
					<div class="container_header">
						<span><@i18n key="IAM.PERSONAL.LOCALEDETAILS" /></span>
						<span class="edit_text" onclick="remove_remindlater_link();"><@i18n key="IAM.EDIT" /></span>
					</div>
					
					<div class="container_body">
						<div class="current_country_box">
							<span class="current_locale_icon icon-Country"></span>
							<#if (announcement.user_country_name)?has_content>
								<span class="current_locale_value">${announcement.user_country_name}</span>
							<#else>
								<span class="current_locale_value">${announcement.current_countryName}</span>
							</#if>
						</div>
						<div class="current_timezone_box">
							<span class="current_locale_icon icon-Timezone"></span>
							<#if (announcement.user_timezone_val)?has_content>
								<span class="current_locale_value timezone_value">${announcement.user_timezone_val}</span>
							<#else>
								<span class="current_locale_value timezone_value">${announcement.current_timezone}</span>
							</#if>
						</div>
					</div>
					
					
				</div>
				<button class="update_profile" onclick="update_profile_new_location();"><@i18n key="IAM.UPDATE.NOW" /></button>
				</div>
				
				<div id="locale_dropdown_container" class="container hide">
				
				<div class="list_dropdown_box" id="country_dropdown">
					<label class="dropdown_label"><@i18n key="IAM.COUNTRY" /></label>
					<select class="profile_mode" name="country" id="country_dropdown_list"></select>
				</div>
				
				<div class="list_dropdown_box" id="state_dropdown" style="display: none;">
					<label class="dropdown_label"><@i18n key="IAM.ANNOUNCEMENT.LOCALE.STATE.TITLE" /></label>
					<select class="profile_mode" name="country_state" id="state_dropdown_list"></select>
				</div>
				
				<div class="list_dropdown_box list_dropdown_box_timezone" id="timezone_dropdown" style="display: none;" >
                       <label class="dropdown_label"><@i18n key="IAM.ANNOUNCEMENT.LOCALE.TIMEZONE.TITLE" /></label>
                       <select class="profile_mode long_div" id="timezone_dropdown_list"></select>
               </div>
			
			    <div class="warn_msg"><@i18n key="IAM.ANNOUNCEMENT.LOCALE.SELECT.COUNTRY" /></div>
			
				<#if announcement.is_StateUpdateRequired??>
			    <button class="update_profile" id="update_profile" onclick="update_profile_edited_loc();"><@i18n key="IAM.UPDATE.NOW" /></button>
				<#else>
				<button class="update_profile" id="update_profile" onclick="update_profile_edited_loc();"><@i18n key="IAM.PHOTO.CHANGE" /></button>
				<button class="cancel_btn" id="cancel_btn"><@i18n key="IAM.BACK" /></button>
				</#if>
				</div>
				
				<span class="grey_text remind_later_link" onclick="window.location.href='${announcement.remindme_url}'"><@i18n key="IAM.TFA.BANNER.REMIND.LATER" /></span>
			</div>
			<div class="announcement_img">
			</div>
		</div>	
</body>
</html>