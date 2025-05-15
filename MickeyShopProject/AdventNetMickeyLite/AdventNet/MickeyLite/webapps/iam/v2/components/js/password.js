//$Id$

function show_resetpassword_security()// not currently used
{
	//close_security_question();
	//close_password_change();
	//close_deleteaccount()
	if($("#popup_deleteaccount_close").is(":visible")){
		$("#popup_deleteaccount_close").removeClass("pop_anim");
		$("#popup_deleteaccount_close").fadeOut(200);
		$(".blue").unbind();
	}
	else if($("#popup_password_change").is(":visible")){
		$("#popup_password_change").removeClass("pop_anim");
		$("#popup_password_change").fadeOut(200,function(){
			$("#pass_esc_devices").hide();
		});
		remove_error();
		$("#passform").trigger('reset'); 
		$("#popup_password_change a").unbind();
	}
	else if($("#popup_security_question").is(":visible")){
		$("#popup_security_question").removeClass("pop_anim");
		$("#popup_security_question").fadeOut(200,function(){
			$("#sq_answer .textbox").val("");
			$("#custom_question_input").val("");
		});
	}
	setTimeout(show_resetpassword,250);
	$("#pop_action .primary_btn_check").focus();
	closePopup(close_popupscreen,"common_popup");//No I18N
}

/***************************** password change *********************************/

function load_passworddetails(policies,password_detail)
{
	
	//font icon small is used here.....google:4 denotes , google font icon is created by using 4 span tags and same facebook:0 is denotes the no span 
	var idps_icons_obj={
			google:4,
			azure:4,
			linkedin:0,
			facebook:0,
			twitter:0,		
			yahoo:0,
			intuit:0,
			slack:5,
			douban:0,
			apple:0,
			adp:0,
			qq:8,
			wechat:0,
			weibo:5,
			baidu:0,
			feishu:3,
			github:0
	};
    var idp_name;
    var expiry_color_percentage=[10,30];
	
	if(de("password_exception"))
	{
		$("#password_exception").remove();
		$("#password_box .box_content_div").removeClass("hide");
	}
	if(password_detail.exception_occured!=undefined	&&	password_detail.exception_occured)
	{
		$( "#password_box .box_info" ).after("<div id='password_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#password_exception #reload_exception").attr("onclick","reload_exception(PASSWORD,'password_box')");
		$("#password_box .box_content_div").addClass("hide");
		return;
	}

	if(!jQuery.isEmptyObject(password_detail))
	{
		$("#password_box .box_discrption").hide();
		$("#password_box .no_data_text").hide();
		if(password_detail.isPasswordChangeBlocked!=undefined && password_detail.isPasswordChangeBlocked ){ //org blocking change password
			if(password_detail.password_exists != undefined && !password_detail.password_exists){
				$("#NO_password_def").show();
				$("#passwordbutton").html(i18nPasswordKeys["IAM.PASSWORD.SET"]);//no i18n
			}
			else{
				$("#no_pp").text(password_last_changed+" "+password_detail.PasswordInfo.last_changed_time).show();
				$("#org_policy_password_change_blocked > .password_usecases_info").text(i18nPasswordKeys["IAM.PASSWORD.ORG.RESTRICTION.HAVING.PASSWORD"]);//no i18n
			}
			
			$("#org_policy_password_change_blocked").show().children(".idp_font_icon").addClass("icon-warningfill").addClass("alert_icon_medium");
			$("#passwordbutton.primary_btn_check").addClass("no_after_before");
			$("#passwordbutton").css({"background-color":"#EBEBEB","color":"#ADADAD"}).prop("disabled","true");
			$("#password_box > .box_content_div").addClass("alert_password_sync_block");
			$("#password_head").addClass("no_bottom_border_radius");
			return false;
		}
		else if(password_detail.password_exists!=undefined && !password_detail.password_exists)
		{
			//for getting bgcolor of idp , so you can add (ex: .idp_azure) class to an element and get color of it and removeclass after you got 
			if(password_detail.idpname != undefined && password_detail.idpname.toLowerCase() != "zoho" && password_detail.idpname !=""){
				var color;
				var duplicateObj={};
				var idpContent="";
				password_detail.idpname.toLowerCase().split("/").forEach(function(idp){
					if(idp != "" && idp != null && idp != undefined){
						duplicateObj[idp] == undefined ? duplicateObj[idp]= 1 : duplicateObj[idp]++;
					}
				});
				if(Object.keys(duplicateObj).length>3){
					var element=document.createElement("div");
					$(element).addClass("more_idp_list").attr("id","more_idp");//no i18n
				}
				for(var key in duplicateObj){
					var idpElement=document.createElement("div");
					$(idpElement).addClass("idp_font_icon");
					$("#IDP_password > .password_usecases_info").before(idpElement);
					$("#IDP_password > .idp_font_icon:last").removeClass("hide").addClass("idp_"+key);
					color=$(".idp_"+key).css("background-color");
					$("#IDP_password > .idp_font_icon:last").removeClass("idp_"+key).addClass("icon-"+key+"_small").text("").css("color",color);
					for(var j=0;j<idps_icons_obj[key];j++){
						var span_element=document.createElement("span");
						$("#IDP_password > .idp_font_icon:last").append(span_element);
						span_element.className='path'+(j+1);
					}
					if(Object.keys(duplicateObj).length>3){
						var cloneNode=document.importNode($("#IDP_password > .idp_font_icon:last")[0],true);
						var div=document.createElement("div");
						div.className="more_idp_list_row";
						if(key == "adp" || key == "intuit"){
							$(div).addClass("intuitAndAdp");
						}
						if(key == "qq"){
							$(div).css("text-transform","uppercase");//no i18n
						}
						div.appendChild(cloneNode);
						var idpNameElement=document.createElement("span");
						if(key == "adp" || key == "intuit"){
							var textNode=document.createTextNode(duplicateObj[key] > 1 ? " ("+duplicateObj[key]+")" : "");
						}
						else{
							if(key == "azure"){
								var textNode=document.createTextNode("microsoft" + ( duplicateObj[key] > 1 ? " ("+duplicateObj[key]+")" : ""));//no i18n
							}
							else{
								var textNode=document.createTextNode(key + ( duplicateObj[key] > 1 ? " ("+duplicateObj[key]+")" : ""));
							}
						}
						idpNameElement.append(textNode);
						div.append(idpNameElement);
						$(element).append(div);
					}
						if(key == "qq"){
							key = "QQ";//no i18n
						}
						if(key == "adp"){
							key = "ADP";//no i18n
						}
						if(key == "azure"){
							idpContent+="microsoft" + ( duplicateObj[key.toLowerCase()] > 1 ? "("+duplicateObj[key.toLowerCase()]+")" : "") + ( Object.keys(duplicateObj).length > 1 && Object.keys(duplicateObj)[Object.keys(duplicateObj).length-1] != key ? ", " : "") ;//no i18n
						}
						else{
							idpContent+=key + ( duplicateObj[key.toLowerCase()] > 1 ? "("+duplicateObj[key.toLowerCase()]+")" : "") + ( Object.keys(duplicateObj).length > 1 && Object.keys(duplicateObj)[Object.keys(duplicateObj).length-1] != key ? ", " : "") ;
						}	
					}
					if(Object.keys(duplicateObj).length>3){
						for(var i=0;i<Object.keys(duplicateObj).length-3;i++){
							$("#IDP_password > .idp_font_icon:last").remove();
						}
						$("#IDP_password > .idp_font_icon:last").removeClass().html("").text('+'+(Object.keys(duplicateObj).length-2)).addClass("number_idp").css("color","rgb(0,0,0,0.5)").append(element);
						var linked_account_element=document.createElement("div");
						linked_account_element.className="linked_accounts";
						$("#IDP_password .more_idp_list").append(linked_account_element).css({"top":"30px","left":"-30px"});//no i18n
						$("#IDP_password .linked_accounts").text(i18nPasswordKeys["IAM.PASSWORD.GO.TO.LINKED.ACCOUNTS"]).attr("onclick",'document.getElementById("linkedaccounts").click();');//no i18n
						var span=document.createElement("span");
						span.className="icon-rightarrow";
						linked_account_element.append(span);
					}
					$("#no_pp").hide();
					$("#NO_password_def").show();
					$("#password_box > .box_content_div").show().addClass("alert_password_idp");
					$("#IDP_password .password_usecases_info").html(formatMessage(i18nPasswordKeys["IAM.PASSWORD.IDPUSER.DESC"],idpContent));//no i18n
					$("#IDP_password").show();
					$("#passwordbutton").html(i18nPasswordKeys["IAM.PASSWORD.SET"]).attr('onclick','goToForgotPwd()'); //No I18N
					$(".password_usecases_content .idp_font_icon").addClass("idp");
					$("#password_head").addClass("no_bottom_border_radius");
			}
			else{
				$("#no_pp").hide();
				$("#NO_password_def").show();		
				$("#password_head").addClass("no_bottom_border_radius");
				$("#passwordbutton").html(i18nPasswordKeys["IAM.PASSWORD.SET"]).attr('onclick','goToForgotPwd()'); //No I18N
			}			
		}
		else if(password_detail.isZohoBlocked!=undefined && password_detail.isZohoBlocked) //org user using saml authentication and not super admin
		{
			$("#contact_superadmin_def").show();
			$("#contact_superadmin_msg").show();
			$("#contact_superadmin_msg > .idp_font_icon").addClass("icon-warningfill").addClass("alert_icon_medium");
			$("#passwordbutton.primary_btn_check").addClass("no_after_before");
			$("#passwordbutton").css({"background-color":"#EBEBEB","color":"#ADADAD"}).prop("disabled","true");
			$("#password_box > .box_content_div").addClass("alert_password_sync_block");
			$("#password_head").addClass("no_bottom_border_radius");
		}
		else if(security_data.Password.PasswordPolicy.password_age_remaining!=undefined	&&	security_data.Password.PasswordPolicy.password_age_warning!=undefined)
		{
			$("#passwordbutton.primary_btn_check").addClass("no_after_before");
			$("#passwordbutton").css({"background-color":"#EBEBEB","color":"#ADADAD"}).removeAttr("onclick");
			$("#tip_password_reset").html(security_data.Password.PasswordPolicy.password_age_warning);
			$("#password_head").addClass("no_bottom_border_radius");
			$("#passwordbutton").hover(function(){
				$("#tip_password_reset").addClass("password_reset_hover");
			},function(){
				$("#tip_password_reset").removeClass("password_reset_hover");
			});
			
			if(password_detail.PasswordInfo.last_changed_time_millis!=-1)
			{
				$("#no_pp").text(password_last_changed+" "+password_detail.PasswordInfo.last_changed_time);
			}
			else
			{
				$("#no_pp").text(password_last_changed);
			}
			$("#no_pp").show();
			password_expiration(idps_icons_obj,idp_name,expiry_color_percentage,password_detail,policies)
		}
		else
		{
			password_expiration(idps_icons_obj,idp_name,expiry_color_percentage,password_detail,policies);
			$("#passwordbutton").attr("onclick", "show_password_change_popup()");
			
		}
		if(password_detail.PasswordPolicy!=undefined)
		{
			$("#newPassword").attr("onkeyup","check_pp("+password_detail.PasswordPolicy.mixed_case+","+password_detail.PasswordPolicy.min_spl_chars+","+password_detail.PasswordPolicy.min_numeric_chars+","+password_detail.PasswordPolicy.min_length+")");
			$("#change_password_call").attr("onclick","changepassword(document.passform,"+password_detail.PasswordPolicy.min_length+","+password_detail.PasswordPolicy.max_length+",'"+security_data.Password.login_name+"')");
		}	
	}
}

function password_expiration(idps_icons_obj,idp_name,expiry_color_percentage,password_detail,policies){
	$("#previous_modified_time").show();
	$("#password_def").hide();
	if(password_detail.PasswordInfo.last_changed_time_millis!=-1)
	{
		$("#no_pp").text(password_last_changed+" "+password_detail.PasswordInfo.last_changed_time);
	}
	else
	{
		$("#no_pp").text(password_never_changed);
	}
	
	if(password_detail.PasswordPolicy!=undefined	&&	 (password_detail.PasswordPolicy.expiry_days!=undefined	&& 	password_detail.PasswordPolicy.expiry_days!=-1 && password_detail.PasswordInfo.days_remaining!=undefined)	)
	{
		var str = null;
		if(password_detail.PasswordInfo.days_remaining > 0){
			if(password_detail.PasswordInfo.days_remaining < (password_detail.PasswordPolicy.expiry_days*(expiry_color_percentage[0]/100))){
				$("#password_expiration .password_usecases_info").html(i18nPasswordKeys["IAM.PASSWORD.CHANGE.ATTENTION"]);//No I18N
			}
			else if(password_detail.PasswordInfo.days_remaining < (password_detail.PasswordPolicy.expiry_days*(expiry_color_percentage[1]/100))){
				$("#password_expiration .password_usecases_info").html(i18nPasswordKeys["IAM.PASSWORD.CHANGE.MEDIUM"]);//No I18N
			}
			else{
				$("#password_expiration .password_usecases_info").html(i18nPasswordKeys["IAM.PASSWORD.CHANGE.NORMAL"]);//No I18N
			}
			str =$("#password_expiration").html();
			str=formatMessage(str,password_detail.PasswordInfo.org_name,(password_detail.PasswordPolicy.expiry_days).toString(),(password_detail.PasswordInfo.days_remaining).toString());
			$("#password_expiration").html(str);
			
			//password expiration attention status color
			if(password_detail.PasswordInfo.days_remaining < (password_detail.PasswordPolicy.expiry_days*(expiry_color_percentage[0]/100))){
				password_expiry_alerts_variation("high","medium","normal");	//No I18N
			}
			else if(password_detail.PasswordInfo.days_remaining < (password_detail.PasswordPolicy.expiry_days*(expiry_color_percentage[1]/100))){
				password_expiry_alerts_variation("medium","high","normal");	//No I18N
			}
			else{
				password_expiry_alerts_variation("normal","medium","high"); //No I18N
			}
			$("#password_expiration > .idp_font_icon").addClass("icon-warningfill");
			$("#password_head").addClass("no_bottom_border_radius");
			$("#password_expiration").show();
		} else {
			$("#password_expired .password_usecases_info").html(i18nPasswordKeys["IAM.PASSWORD.EXPIRED"]);//No I18N
			str = $("#password_expired").html();
			str=formatMessage(str,password_detail.PasswordInfo.org_name,(password_detail.PasswordPolicy.expiry_days),(password_detail.PasswordInfo.days_remaining));
			$("#password_expired").html(str).addClass("password_alert_high_attention").show();
			$("#password_expired > .idp_font_icon").addClass("icon-warningfill").addClass("alert_icon_high");
			$("#password_expired span").addClass("alert_days_high");
			$("#password_expiration").removeClass("password_alert_medium_attention").removeClass("password_alert_normal_attention");
			$("#password_expiration > .idp_font_icon").removeClass("alert_icon_medium").removeClass("alert_icon_normal");
			$("#password_expiration  span").removeClass("alert_days_medium").removeClass("alert_days_normal");
			$("#password_head").addClass("no_bottom_border_radius");
		}
		$("#no_pp").show();
	}
	else
	{
		var getDiffDays=Math.floor((new Date().getTime() - password_detail.PasswordInfo.last_changed_time_millis)/(1000*24*60*60));
		$("#no_pp").show();
		if(getDiffDays>80){
			$("#password_recommendation > .idp_font_icon").addClass("icon-warningfill").addClass("alert_icon_medium");
			$("#password_recommendation").addClass("password_alert_medium_attention").show();		
		}
	}
}

function password_expiry_alerts_variation(){
	$("#password_expiration").addClass("password_alert_"+arguments[0]+"_attention");				
	$("#password_expiration > .idp_font_icon").addClass("alert_icon_"+arguments[0]);
	$("#password_expiration  span").addClass("alert_days_"+arguments[0]);
	//removing classes needs when change color without reloading pages(when it happens : user change password)
	$("#password_expiration").removeClass("password_alert_"+arguments[1]+"_attention").removeClass("password_alert_"+arguments[2]+"_attention");
	$("#password_expiration > .idp_font_icon").removeClass("alert_icon_"+arguments[1]).removeClass("alert_icon_"+arguments[2]);
	$("#password_expiration  span").removeClass("alert_days_"+arguments[1]).removeClass("alert_days_"+arguments[2]);
}

function check_pp(cases,spl,num,minlen) {
	validatePasswordPolicy().validate('#new_password input'); //No i18N
}

function show_password_change_popup()
{
	$("#popup_password_change").show(0,function(){
		validatePasswordPolicy().init('#new_password input');//No I18N
		$("#popup_password_change").addClass("pop_anim");
	});
	$("#popup_password_change .popuphead_details .popuphead_text").html($("#change_password_desc .heading").html());
	$("#popup_password_change .popuphead_define").html($("#change_password_desc .description").html());
	$("#passform").show();
	$("#pass_esc_devices").hide();
	popup_blurHandler('6');
	control_Enter("#popup_password_change a");//No i18N
	$("#popup_password_change input:first").focus();
	closePopup(close_password_change,"popup_password_change");//No I18N
}

function togglePass(ele){
	if($(ele).siblings("#newPassword").attr("type")=="password"){
		$(ele).siblings("#newPassword").attr("type","text");//No I18N
		$(ele).addClass("pass_hide");
	}	
	else{
		$(ele).siblings("#newPassword").attr("type","password"); //No I18N
		$(ele).removeClass("pass_hide");
	}
}

function close_password_change()
{
	popupBlurHide('#popup_password_change',function(){ //No I18N
		$("#pass_esc_devices").hide();
		if($(".oneAuthLable").is(":visible")){
			$(".oneAuthLable").slideUp();
		}
		$("#terminate_mob_apps").removeClass("displayBorder");
		$("#terminate_session_weband_mobile_desc").show();
	});
	remove_error();
	$("#passform").trigger('reset'); 
	$("#popup_password_change a").unbind();
}

function changepassword(f,min_Len,max_Len,login_name) 
{
	remove_error();
    var currentpass = f.currentPass.value.trim();
    var newpass = f.newPassword.value.trim();
    var confirmpass = f.cpwd.value.trim();
    var passwordErr = validatePasswordPolicy().getErrorMsg(newpass);
    if(isEmpty(currentpass)) 
    {
    	$('#curr_password').append( '<div class="field_error">'+err_enter_currpass+'</div>' );
    	f.currentPass.value="";
    	f.currentPass.focus();
    } else 
    if(isEmpty(newpass)) 
    {
    	$('#new_password').append( '<div class="field_error">'+err_enter_newpass+'</div>' );
        f.newPassword.value="";
        f.cpwd.value="";
        f.newPassword.focus();
    } else 
	if(passwordErr) 
    {
        f.newPassword.focus();
    } else 
    if(newpass == login_name) 
    {
    	$('#new_password').append( '<div class="field_error">'+err_loginName_same+'</div>' );
    	f.newPassword.focus();
    } else 
    if(isEmpty(confirmpass) || newpass != confirmpass) 
    {
    	$('#new_repeat_password').append( '<div class="field_error">'+err_wrong_pass+'</div>' );
        f.cpwd.value="";
        f.cpwd.focus();
    }
    else if(validateForm(f))
    {
    		disabledButton(f);
    		var parms=
    		{
    			"currpwd":$('#'+f.id).find('input[name="currentPass"]').val(),//No I18N
    			"pwd":$('#'+f.id).find('input[name="newPassword"]').val(),//No I18N
    			"incpwddata":true //No I18N
    		};


    		var payload = Password.create(parms);
    		payload.PUT("self","self").then(function(resp)	//No I18N
    		{
    			SuccessMsg(getErrorMessage(resp));
    			//change the modified time
				security_data.Password.PasswordInfo.last_changed_time=resp.password.last_changed_time;
				$("#ter_mob").removeClass("show_oneauth");
				if(security_data.Password.PasswordInfo.org_name!==undefined)
    			{
    				security_data.Password.PasswordInfo.org_name=resp.password.org_name;
    				security_data.Password.PasswordInfo.days_remaining=resp.password.days_remaining;
    			}
				load_passworddetails(security_data.Policies,security_data.Password);
				if(resp.password.sess_term_tokens!=undefined &&	resp.password.sess_term_tokens.length>0)
				{
					if(resp.password.sess_term_tokens.indexOf("rmwebses")==-1)
					{
						$("#terminate_web_sess").hide();
					}
					if(resp.password.sess_term_tokens.indexOf("rmappses")==-1)
					{
						$("#terminate_mob_apps").hide();
					}
					else if(resp.password.sess_term_tokens.indexOf("inconeauth")==-1)
					{
						$("#ter_mob").removeClass("show_oneauth");
					}
					else
					{
						$("#ter_mob").addClass("show_oneauth");
					}
					if(resp.password.sess_term_tokens.indexOf("rmapitok")==-1)
					{
						$("#terminate_api_tok").hide();
					}
					changeToDevice();
				}
				else
				{
					close_password_change()
				}
       			removeButtonDisable(f);    
    		},
    		function(resp)
    		{
    			showErrorMessage(getErrorMessage(resp));
    			removeButtonDisable(f)
    		});	
    }

    
    return false;
    
}

function changeToDevice()
{
	$("#popup_password_change .popuphead_details .popuphead_text").html($("#quit_session_desc .heading").html());
	$("#popup_password_change .popuphead_define").html($("#quit_session_desc .description").html());
	$("#popup_password_change .checkbox_check").prop("checked",false);
	$(".showOneAuthLable").removeClass("showOneAuthLable");
	$("#passform").hide();
	$(".oneAuthLable").hide();
	$("#pass_esc_devices").show();
	if(isMobile){
		var heightForCheckBox=window.innerHeight-($("#popup_password_change .popup_header ").outerHeight(true) + $("#popup_password_change .form_description").outerHeight(true) + $("#pass_esc_devices .primary_btn_check").outerHeight(true)+parseInt($("#pass_esc_devices .primary_btn_check").css("margin-top").replace("px",''))+parseInt($(".change_pass_cont.popup_padding").css("padding-Top").replace("px",''))+parseInt($("#change_second").css("margin-top").replace("px",'')));
		var tem=0;
		if($("#popup_password_change").innerHeight() <= window.innerHeight){
			tem=heightForCheckBox-$("#change_second").innerHeight();
		}
		$("#change_second").css("overflow","auto");
		$("#change_second").css("height",heightForCheckBox-tem+"px");
	}
}

function signout_devices(f,callback)
{
	var terminate_web=$("#terminate_web_sess").is(":visible")	&&	$('#'+f.id).find('input[name="clear_web"]').is(":checked");
	var terminate_mob=$("#terminate_mob_apps").is(":visible")	&&	$('#'+f.id).find('input[name="clear_mobile"]').is(":checked");
	var terminate_api=$("#terminate_api_tok").is(":visible")	&&	$('#'+f.id).find('input[name="clear_apiToken"]').is(":checked");
	var include_oneAuth=$(".oneAuthLable").is(":visible")	&&	$('#'+f.id).find('#include_oneauth').is(":checked");
	if(terminate_mob||terminate_web||terminate_api)
	{	
		if(validateForm(f))
	    {
				disabledButton(f);
	    		var parms=
	    		{
	    			"rmwebses":terminate_web,//No I18N
	    			"rmappses":terminate_mob,//No I18N
	    			"inconeauth":include_oneAuth,//No I18N
	    			"rmapitok":terminate_api//No I18N
	    		};
	
	
	    		var payload = SessionTerminateObj.create(parms);
	    		payload.PUT("self","self").then(function(resp)	//No I18N
	    		{
	    			SuccessMsg(getErrorMessage(resp));
	    			callback==undefined?close_password_change():callback();
	    			removeButtonDisable(f)
	    		},
	    		function(resp)
	    		{
	    			showErrorMessage(getErrorMessage(resp));
	    			removeButtonDisable(f);
	    		});	
	    }
	}
	else
	{
		callback==undefined?close_password_change():callback();
	}
	return false;
	
}

/***************************** Allowed IPs *********************************/
function gen_random_num(){
	var pre_random = undefined;
	do{
		var ran = Math.floor(Math.random() * (10));
		pre_random=ran;
	}
	while(ran!=pre_random)
	return ran;
}

function load_IPdetails(policies,IP_details)
{
	if(de("allowedIP_exception"))
	{
		$("#allowedIP_exception").remove();
		$("#AllowedIP_box #all_ip_show").removeClass("hide");
	}
	if(IP_details.exception_occured!=undefined	&&	IP_details.exception_occured)
	{
		$( "#AllowedIP_box .box_info" ).after("<div id='allowedIP_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#allowedIP_exception #reload_exception").attr("onclick","reload_exception(AllowedIP,'AllowedIP_box')");
		$("#AllowedIP_box #all_ip_show").addClass("hide");
		return;
	}
	var orgIPRestrict = IP_details.isUserIPRestrictionDisabled ? true: false;
	//var index = from_IP.indexOf("remote_ip");
	var count=0;
//	if(from_IP.length>1)
//	{
	if(!jQuery.isEmptyObject(IP_details.IPs))
	{
		var from_IPs=timeSorting(IP_details.IPs);
		if(orgIPRestrict){
			$(".iprestrict_msg").text(i18nIPkeys["IAM.ORG.IP.RESTRICT.EXIST.WARN"]); //no i18n
			$("#org_iprest_warn").show();
		}
		$("#no_ip_add_here").hide();
		$("#IP_content").show();
		var is_ip_within_range = ip_within_range(IP_details.IPs, IP_details.remote_ip);
		
		if(IP_details.IPs[IP_details.remote_ip]!=undefined && is_ip_within_range)
		{
			$("#current_ip").hide();
			$("#allowed_ip_entry0").hide();
		}
		else
		{
			
			$("#current_ip").show();
			$("#current_ip .ip_blue").html(IP_details.remote_ip);
			$("#cur_ip").val(IP_details.remote_ip);
			
			//warning msg that the current ip is not allowed
			if(!is_ip_within_range && !orgIPRestrict) {
			$("#allowed_ip_entry0").show();
			$("#IP_content .alone_current_ip").html(formatMessage("<div class='note_ip'>"+note+" </div><div class='ip_note_desc'>"+current_to_wanrning+"</div>",IP_details.remote_ip));
			$("#allowed_ip_entry0").attr("onclick","show_get_name('"+IP_details.remote_ip+"','"+IP_details.remote_ip+"',"+true+",0);");
			$("#allowed_ip_entry0 #ip_range_forNAME").html(IP_details.remote_ip);
			$("#allowed_ip_info0").attr("onclick","show_get_name('"+IP_details.remote_ip+"','"+IP_details.remote_ip+"',"+true+",0);");
			} else {
				$("#allowed_ip_entry0").hide();
			}
			
		}
//		if (index > -1) 
//		{
//			from_IP.splice(index, 1);
//		}
		$("#IPdisplay_others").html("");
		
		for(iter=0;iter<Object.keys(IP_details.IPs).length;iter++)
		{
			count++;
			var current_from_IP=IP_details.IPs[from_IPs[iter]];
			
			IPdisplay_format = $("#empty_ip_format").html();
			$("#IPdisplay_others").append(IPdisplay_format);
			
			$("#IPdisplay_others #allowed_ip_entry").attr("id","allowed_ip_entry"+count);
			$("#IPdisplay_others #allowed_ip_info").attr("id","allowed_ip_info"+count);
			//$("#IPdisplay_others #allowed_ip_info_rename").attr("id","allowed_ip_info_rename"+count);
			
			$("#allowed_ip_entry"+count).attr("onclick","show_selected_ip_info("+count+");");
		      
			if(count > 2)
			{
				$("#allowed_ip_entry"+count).addClass("allowed_ip_entry_hidden");  
			}

			$("#allowed_ip_entry"+count+" .range_name").html(current_from_IP.display_name);
			$("#allowed_ip_entry"+count+" #range_name").html(current_from_IP.display_name);
			$("#allowed_ip_entry"+count+" .device_time").html(current_from_IP.created_time_elapsed);
			//$("#allowed_ip_entry"+count+" #ip_pencil").attr("onclick","show_get_name('"+current_from_IP.from_ip+"','"+current_from_IP.to_ip+"',true,"+count+");");
			if(orgIPRestrict){
				$("#allowed_ip_entry"+count+" .device_pic").addClass("dp_disabled");
			}else{
				$("#allowed_ip_entry"+count+" .device_pic").addClass(color_classes[gen_random_value()]);
			}
			$("#allowed_ip_entry"+count+" .device_pic").html(current_from_IP.display_name.substr(0,2).toUpperCase());
			
			if(current_from_IP.from_ip==current_from_IP.to_ip||current_from_IP.to_ip==undefined)//Static IP check
			{
				$("#allowed_ip_entry"+count+" .IP_tab_info").html(current_from_IP.from_ip);
				$("#allowed_ip_info"+count+" .static").html(current_from_IP.from_ip);
				$("#allowed_ip_info"+count+" .range").hide();
				$("#allowed_ip_info"+count+" .static").show();
			}
			else
			{
				$("#allowed_ip_entry"+count+" .IP_tab_info").html(current_from_IP.from_ip+" - "+current_from_IP.to_ip);
				$("#allowed_ip_info"+count+" .range").html(current_from_IP.from_ip+" - "+current_from_IP.to_ip);
				$("#allowed_ip_info"+count+" .range").show();
				$("#allowed_ip_info"+count+" .static").hide();
			}
			$("#allowed_ip_info"+count+" #pop_up_time").html(current_from_IP.created_date);
			if(current_from_IP.location!=undefined)
			{
				$("#allowed_ip_entry"+count+" .asession_location").removeClass("location_unavail");
				$("#allowed_ip_entry"+count+" .asession_location").text(current_from_IP.location.toLowerCase());
				$("#allowed_ip_info"+count+" #pop_up_location").removeClass("unavail");
				$("#allowed_ip_info"+count+" #pop_up_location").text(current_from_IP.location.toLowerCase());
			}
			$("#allowed_ip_info"+count+" #current_session_logout").attr("onclick","deleteip('"+current_from_IP.from_ip+"','"+current_from_IP.to_ip+"')");
			
		}	 
		if(count<3)//less THAN 3
		{
			if(orgIPRestrict){
				$("#ip_justaddmore").hide();
			}else{
				$("#ip_justaddmore").show();
			}
			$("#IP_add_view_more").hide();
		}
		else
		{
			if(count>3){
				$("#IP_add_view_more .view_more").html(formatMessage(i18nIPkeys["IAM.VIEWMORE.IPs"],count-2)); //NO I18N
			} else {
				$("#IP_add_view_more .view_more").html(formatMessage(i18nIPkeys["IAM.VIEWMORE.IP"],count-2)); //NO I18N
			}
			if(orgIPRestrict){
				$("#IP_add_view_more .addnew").hide();
			}
			$("#ip_justaddmore").hide();
			$("#IP_add_view_more").show();
		}
	}
	else
	{
		if(orgIPRestrict){
			$(".no_ip").addClass("iprestrict_no_ip");
			$("#allowedip_change").hide();
			$(".iprestrict_msg").text(i18nIPkeys["IAM.ORG.IP.RESTRICT.EMPTY.WARN"]); //No i18n
			$("#org_iprest_warn").show();
		} else {
			$("#current_ip").show();
			$("#current_ip .ip_blue").html(IP_details.remote_ip);
			$("#cur_ip").val(IP_details.remote_ip);
		}
		$("#ip_justaddmore").hide();
		$("#IP_add_view_more").hide();
		$("#no_ip_add_here").show();
		$("#IP_content").hide();
		
	}
}


function ip_within_range(all_ips_details, remote_ip) {
	var valid_ips = 0;
	var from_IPs = timeSorting(all_ips_details);
	for(iter=0;iter<Object.keys(all_ips_details).length;iter++)
	{
		var from_IP = all_ips_details[from_IPs[iter]].from_ip;   
		var to_IP = all_ips_details[from_IPs[iter]].to_ip;
		if (ipRangeTest(remote_ip, from_IP, to_IP) ) { valid_ips += 1 };
	}
	return (valid_ips > 0) ? true: false;
}

function ip_To_Num(ip) {
   var ip_as_num=0;
   var ip_arr=ip.split('.');
   for(var i=0; i < 4; i++){
	   ip_as_num = (ip_as_num *256) + parseInt(ip_arr[i], 10);  // to convert ip to a number
   }
   return ip_as_num;
}

function ipRangeTest(remote_ip, from_ip, to_ip) {
	  if(to_ip == undefined){
	    return ipRangeTest(remote_ip, from_ip, from_ip);
	  }
	  var startip=ip_To_Num(from_ip);
	  var endip=ip_To_Num(to_ip);
	  var testip=ip_To_Num(remote_ip);
	  return ((testip <= endip) && (testip >= startip)) ? true : false;
}

function show_selected_ip_info(id)
{	
	if(!$(popup_ip_new).is(":visible")){
		$("#allowed_ip_pop .device_pic").addClass($("#allowed_ip_entry"+id+" .device_pic")[0].className);
		$("#allowed_ip_pop .device_pic").html($("#allowed_ip_entry"+id+" .device_pic").html());
		$("#allowed_ip_pop .device_name").html($("#allowed_ip_entry"+id+" .device_name").html()); //load into popuop
		$("#allowed_ip_pop #edit_ip_name").attr("onclick",$("#allowed_ip_entry"+id+" #ip_pencil").attr("onclick"));
		$("#allowed_ip_pop .device_time").html($("#allowed_ip_entry"+id+" .device_time").html()); //load into popuop
		
		$("#allowed_ip_pop #ip_current_info").html($("#allowed_ip_info"+id).html()); //load into popuop
		
		
		popup_blurHandler('6');
		$("#allowed_ip_pop").show(0,function(){
			$("#allowed_ip_pop").addClass("pop_anim");
		});
		control_Enter("a"); ///No I18N
		$("#current_session_logout").focus();
		closePopup(closeview_selected_ip_view,"allowed_ip_pop"); //No I18N
	}
		
}
function closeview_selected_ip_view()
{
	popupBlurHide("#allowed_ip_pop"); //No I18N
	$("#allowed_ip_pop #edit_ip_name").attr("onclick","");
	$("#allowed_ip_pop a").unbind();
}

function closeview_all_ip_view(callback)
{
	popupBlurHide('#allow_ip_web_more',function(){ //No I18N
		$("#view_all_allow_ip").html("");
		if(callback)
		{
			callback();
		}
		
	});
	$(".aw_info a").unbind();
}

function show_all_ip()
{

	$("#view_all_allow_ip").html($("#all_ip_show").html()); //load into popuop
	popup_blurHandler('6');
	
	$("#view_all_allow_ip .allowed_ip_entry_hidden").show();
	$("#view_all_allow_ip .authweb_entry").after( "<br />" );
	$("#view_all_allow_ip .authweb_entry").addClass("viewall_authwebentry");
	$("#view_all_allow_ip .allowed_ip_entry").removeAttr("onclick");
	if($("#view_all_allow_ip #allowed_ip_info0").length==1) 
	{ 
		$("#view_all_allow_ip #allowed_ip_info0").removeAttr("onclick"); 
		$("#view_all_allow_ip #allowed_ip_info0 #add_current_ip").attr("onclick","add_current_ip()"); 
		
	}
	
	$("#view_all_allow_ip .info_tab").show();

	//$("#view_all_allow_ip .asession_action").hide();

	//$("#view_all_allow_ip .asession_action").hide();

	//$("#view_all_allow_ip .ip_pencil").hide();
	
	$("#allow_ip_web_more").show(0,function(){
		$("#allow_ip_web_more").addClass("pop_anim");
	});
	
	
	
	$("#view_all_allow_ip .allowed_ip_entry").click(function(event){
		
		var id=$(this).attr('id');
		if($(event.target).hasClass("action_icon")){
			return;
		}

		if(id=="allowed_ip_entry0")
		{ 	
			if($("#view_all_allow_ip #"+id).hasClass("Active_ip_showall_hover"))
			{ 
				return; 
			} 
		}
	
		$("#view_all_allow_ip .allowed_ip_entry").addClass("autoheight");
		$("#view_all_allow_ip .aw_info").slideUp("fast");
		$("#view_all_allow_ip .activesession_entry_info").show();
		if($("#view_all_allow_ip #"+id).hasClass("Active_ip_showall_hover"))
		{

				$("#view_all_allow_ip #"+id+" .aw_info").slideUp("fast",function(){
					$("#view_all_allow_ip #"+id).removeClass("Active_ip_showall_hover");
					$("#view_all_allow_ip .allowed_ip_entry").removeClass("autoheight");
				});
				$("#view_all_allow_ip .activesession_entry_info").show();
		}
		else
		{
			
			$("#view_all_allow_ip .allowed_ip_entry").removeClass("Active_ip_showall_hover");
			$("#view_all_allow_ip #"+id).addClass("Active_ip_showall_hover");
			$("#view_all_allow_ip .aw_info").slideUp(300);
			$("#view_all_allow_ip #"+id+" .aw_info").slideDown("fast",function(){

				control_Enter(".aw_info a"); //No I18N
				$("#view_all_allow_ip .allowed_ip_entry").removeClass("autoheight");
				
			});
			$("#view_all_allow_ip #"+id+" .activesession_entry_info").hide();
		}

	});
	closePopup(closeview_all_ip_view,"allow_ip_web_more");//No I18N
	
	$("#allow_ip_web_more").focus();	
}





function add_new_ip_popup()
{

	document.addip.reset();
	remove_error();
	
	$("#popup_ip_new").show(0,function(){
		$("#popup_ip_new").addClass("pop_anim");
		if($("#current_ip").css("display")=="none"){
			$('#static_ip_sel').prop("checked", true);
	    	splitField.createElement('static_ip_field',{
	    		"isIpAddress": true,		// No I18N
	    		"separator":"&#xB7;",			// No I18N
	    		"separateBetween" : 1,		// No I18N
	    		"customClass" : "ip_address_field"	// No I18N
	    	});
	    	$("#static_ip_field .splitedText").attr("onkeypress","remove_error()");
			$("#range_ip").hide();
			$("#static_ip").show();	
			$("#static_ip_field .splitedText:first").focus();
		}
		else{
			$("#current_ip").css("display","flex");
			$('#current_ip_sel').prop("checked", true);
			$("#range_ip").hide();
			$("#static_ip").hide();	
			$("#popup_ip_new .real_radiobtn:first").focus();
		}
	});
	$("#ip_name_bak").show();
	$("#get_ip").show();
	$("#get_name").hide();
	popup_blurHandler('6');
	$("#ip_name_bak").show();
	$("#add_new_ip").show();
	$("#add_name_old_ip").hide();
	$("#back_name_old_ip").hide();
	$("#allowedipform").attr("onsubmit","return addipaddress(this)");
	$('input[name=ip_select]').change(function () {
        var val=$(this).val();
        remove_error();
        if(val=="1")
        {
        	$("#static_ip").slideUp(300);
        	$("#range_ip").slideUp(300);
        }
        else if(val=="2")
        {
        	splitField.createElement('static_ip_field',{
        		"isIpAddress": true,		// No I18N
        		"separator":"&#xB7;",			// No I18N
        		"separateBetween" : 1,		// No I18N
        		"customClass" : "ip_address_field"	// No I18N
        	});
        	$("#static_ip_field .splitedText").attr("onkeypress","remove_error()");
        	$("#static_ip").slideDown(300);
        	$("#range_ip").slideUp(300);
        	$("#static_ip_field .splitedText:first").focus();
        }
        else
        {
        	splitField.createElement('from_ip_field',{
        		"isIpAddress": true,		// No I18N
        		"separator":"&#xB7;",			// No I18N
        		"separateBetween" : 1,		// No I18N
        		"customClass" : "ip_address_field"	// No I18N
        	});
        	splitField.createElement('to_ip_field',{
        		"isIpAddress": true,		// No I18N
        		"separator":"&#xB7;",			// No I18N
        		"separateBetween" : 1,		// No I18N
        		"customClass" : "ip_address_field"	// No I18N
        	});
        	$("#from_ip_field .splitedText").attr("onkeypress","remove_error()");
        	$("#to_ip_field .splitedText").attr("onkeypress","remove_error()");
        	$("#static_ip").slideUp(300);
        	$("#range_ip").slideDown(300);////for inline block
        	$("#from_ip_field .splitedText:first").focus();
        }
    });

	closePopup(close_new_ip_popup,"popup_ip_new");//No I18N
}

function isNumberKey(evt)
{
	remove_error();
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
    {
    	return false;
    }
    return true;
}


function close_new_ip_popup()
{
	popupBlurHide('#popup_ip_new',function(){ //No I18N
		closeview_selected_ip_view();
	});
	
	$( ".ip_field_cell").unbind( "keyup" );

	$("#ip_name_bak").show();
	$("#add_new_ip").show();
	
	$("#add_name_old_ip").hide();
	$("#back_name_old_ip").hide();
	
	$("#get_ip").show();
	$("#get_name").hide();
	
	$(".ip_impt_note").hide();
}



function addipaddress(f) 
{
	remove_error();
	var val= f.ip_select.value.trim();
	var fip;
    var tip;
	if(val==1)
	{
		fip=tip=f.cur_ip.value.trim();
	}
	else if(val==2)
	{
		fip=tip=$("#static_ip_field_full_value").val();
		tip=tip.trim();
		fip=fip.trim();
	}
	else if(val==3)
	{
		fip=$("#from_ip_field_full_value").val();
		tip=$("#to_ip_field_full_value").val();
		tip=tip.trim();
		fip=fip.trim();
	}
    if(isEmpty(fip)) 
    {
    	if($('input[name=ip_select]:checked').val()=="2")
    	{
    		$('#static_ip').append( '<div class="field_error">'+err_empty_static_ip+'</div>' );
    		$('#static_ip .splitedText:first').focus();
    	}
    	else
    	{
    		$('#range_ip').append( '<div class="field_error">'+err_empty_fromip+'<br /></div>' );  
    		$('#from_ip_field .splitedText:first').focus();
    	}
    }
    else if(!isIP(fip)) 
    {
    	if($('input[name=ip_select]:checked').val()=="2")
    	{
    		$('#static_ip').append( '<div class="field_error">'+err_enter_ip+'</div>' );
    		$('#static_ip .splitedText:last').focus();
    	}
    	else
    	{
    		$('#range_ip').append( '<div class="field_error">'+err_enter_ip+'<br /></div>' );  
    		$('#from_ip_field .splitedText:last').focus();
    	}
    }
    else if(isEmpty(tip) || !isIP(tip))  //invalid To ip address
    {
		$('#range_ip').append( '<div class="field_error field_error_right">'+err_enter_ip+'<br /></div>' );
		$('#to_ip_field .splitedText:first').focus();

    }
    else 
    {
    	show_get_name(fip,tip,false);
    	
    }
    closePopup(close_new_ip_popup,"popup_ip_new",true);//No I18N

    $("#ip_name").focus();
    return false;
}

function show_get_name(fip,tip,is_directly,id)
{
//	if($("#allow_ip_web_more").is(":visible"))
//	{
//		$("#allow_ip_web_more #allowed_ip_info_rename"+id).html($("#popup_ip_new").html());
//			$("#allow_ip_web_more #allowed_ip_info_rename"+id+" .close_btn").remove();
//
//			$("#view_all_allow_ip .allowed_ip_entry").addClass("autoheight");
//			$("#view_all_allow_ip .activesession_entry_info").show();
//			var vis_check=false;
//			if($("#view_all_allow_ip .aw_info").is(":visible")){
//				vis_check=true;
//			}
//			$("#view_all_allow_ip .aw_info_rename").slideUp(300);
//			
//			if($("#view_all_allow_ip #allowed_ip_entry"+id).hasClass("Active_ip_showall_hover"))
//			{
//				if(vis_check){
//					$(".aw_info a").unbind();
//					$("#view_all_allow_ip #allowed_ip_entry"+id+" .aw_info").slideUp("fast",function(){
//					//	$("#view_all_allow_ip #"+id).addClass("Active_ip_showall_hover");
//						$("#view_all_allow_ip #allowed_ip_entry"+id+" .aw_info_rename").slideDown(300,function(){
//							$("#view_all_allow_ip .allowed_ip_entry").removeClass("autoheight");
//						});
//					});
//					$("#view_all_allow_ip .activesession_entry_info").show();
//					$("#view_all_allow_ip #allowed_ip_entry"+id+" .activesession_entry_info").hide();
//				}
//				else{
//					$(".aw_info a").unbind();
//					$("#view_all_allow_ip #allowed_ip_entry"+id+" .aw_info_rename").slideUp("fast",function(){
//						$("#view_all_allow_ip #allowed_ip_entry"+id).removeClass("Active_ip_showall_hover");
//						$("#view_all_allow_ip .allowed_ip_entry").removeClass("autoheight");
//					});
//					$("#view_all_allow_ip .activesession_entry_info").show();
//				}
//			}
//			else
//			{
//
//				$("#view_all_allow_ip .allowed_ip_entry").removeClass("Active_ip_showall_hover");
//				$("#view_all_allow_ip #allowed_ip_entry"+id).addClass("Active_ip_showall_hover");
//				$("#view_all_allow_ip .aw_info_rename").slideUp(300);
//				$("#view_all_allow_ip .aw_info").slideUp(300);
//				$("#view_all_allow_ip #allowed_ip_entry"+id+" .aw_info_rename").slideDown("fast",function(){
//					$("#view_all_allow_ip .allowed_ip_entry").removeClass("autoheight");
//				});
//				$("#view_all_allow_ip #allowed_ip_entry"+id+" .activesession_entry_info").hide();
//			}
//				
//			closePopup(closeview_all_ip_view,"allow_ip_web_more");//No i18N
//
//			$("#allowed_ip_info_rename"+id+" #get_ip").hide();
//			$("#allowed_ip_info_rename"+id+" #get_name").show();
//			if(is_directly)
//			{
//				$("#allowed_ip_info_rename"+id+" #ip_name_bak").hide();
//				$("#allowed_ip_info_rename"+id+" #back_name_old_ip").hide();
//
//				$("#allowed_ip_info_rename"+id+" #add_new_ip").hide();
//				$("#allowed_ip_info_rename"+id+" #add_name_old_ip").show();
//			}
//			else
//			{
//				$("#allowed_ip_info_rename"+id+" .ip_impt_note").show();
//			}
//			if($("#allowed_ip_pop").is(":visible"))
//			{
//				$("#allowed_ip_info_rename"+id+" #back_name_old_ip").show();
//			}
//			
//			if(fip && tip)
//			{
//				$("#fip").val(fip);
//				$("#tip").val(tip);
//				if(fip==tip)
//				{
//					$("#allowed_ip_info_rename"+id+" #ip_range_forNAME").html(fip);
//				}
//				else
//				{
//					$("#allowed_ip_info_rename"+id+" #ip_range_forNAME").html(fip+" - "+tip);
//				}
//			}
//			$("#get_name #ip_name").val($("#allowed_ip_entry"+id+" #range_name").html());
//	}
//	else
//	{
		closeview_selected_ip_view();
		$("#popup_ip_new").show(0,function(){
			$("#popup_ip_new").addClass("pop_anim");
		});

		if(is_directly)
		{
			$("#ip_name_bak").hide();
		}
		$("#get_ip").hide();
		$("#get_name").show();
//		if(is_directly)
//		{
//			$("#ip_name_bak").hide();
//			$("#back_name_old_ip").hide();
//			if(id==0)
//			{
//				$("#add_new_ip").show();
//				$("#add_name_old_ip").hide();
//			}
//			else
//			{
//				$("#add_new_ip").hide();
//				$("#add_name_old_ip").show();
//			}
//		}
//		else
//		{
			$(".ip_impt_note").show();
//		}
		if($("#allowed_ip_pop").is(":visible"))
		{
			$("#back_name_old_ip").show();
		}
		
		if(fip && tip)
		{
			$("#fip").val(fip);
			$("#tip").val(tip);
			if(fip==tip)
			{
				$("#ip_range_forNAME").text(fip);
			}
			else
			{
				$("#ip_range_forNAME").text(fip+" - "+tip);
			}
		}
		$("#get_name #ip_name").val($("#allowed_ip_entry"+id+" #range_name").html());
		
		popup_blurHandler('6');
		$("#allowedipform").attr("onsubmit","return add_ip_with_name(this)");
		control_Enter("a");//No i18N
		closePopup(close_new_ip_popup,"popup_ip_new"); //No I18N
		$("#ip_name").focus();
		return false;
//	}

}

function add_ip_with_name(form)
{
	
	if(validateForm(form))
    {
		disabledButton(form);
		var from = $("#fip").val();
		var to = $("#tip").val();
		var name=$("#get_name #ip_name").val();
		
    		var parms=
    		{
    				"f_ip":from,//No I18N
    				"t_ip":to,//No I18N
    				"ip_name":name//No I18N
    		};


    		var payload = AllowedIPObj.create(parms);
    		payload.POST("self","self").then(function(resp)	//No I18N
    		{
    			SuccessMsg(getErrorMessage(resp));

    			if(security_data.AllowedIPs.IPs==undefined)
    			{
    				security_data.AllowedIPs.IPs=[];
    			}
    			
    			security_data.AllowedIPs.IPs[resp.allowedip.from_ip]=resp.allowedip;
    			
    			load_IPdetails(security_data.Policies,security_data.AllowedIPs);
    			
    			$('#allowedipform')[0].reset();
    			close_new_ip_popup();
    			removeButtonDisable(form);
    		},
    		function(resp)
    		{
    			if(resp.cause && resp.cause.trim() === "invalid_password_token") 
    			{
    				relogin_warning();
    				var service_url = euc(window.location.href);
    				$("#new_notification").attr("onclick","window.open('"+contextpath + resp.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
    			}
    			else
    			{
    				showErrorMessage(getErrorMessage(resp));
    			}
    			removeButtonDisable(form); 
    		});	
    }
	return false;
}


function add_current_ip()
{
	var parms=
	{
			"f_ip":security_data.AllowedIPs.remote_ip,//No I18N
			"t_ip":security_data.AllowedIPs.remote_ip,//No I18N
			"ip_name":$("#view_all_allow_ip #allowed_ip_info0 #new_ip_name").val()//No I18N
	};


	var payload = AllowedIPObj.create(parms);
	payload.POST("self","self").then(function(resp)	//No I18N
	{
		SuccessMsg(getErrorMessage(resp));

		security_data.AllowedIPs.IPs[resp.allowedip.from_ip]=resp.allowedip;
		
		load_IPdetails(security_data.Policies,security_data.AllowedIPs);
		
		$('#allowedipform')[0].reset();
		if($("#allow_ip_web_more").is(":visible")==true)
		{
			var lenn=Object.keys(security_data.AllowedIPs.IPs).length;
			if(lenn > 1){
				closeview_all_ip_view(show_all_ip);
			}
			else{
				closeview_all_ip_view();
			}
		}
		else{
			closeview_all_ip_view();
		}
	},
	function(resp)
	{
		if(resp.cause && resp.cause.trim() === "invalid_password_token") 
		{
			relogin_warning();
			var service_url = euc(window.location.href);
			$("#new_notification").attr("onclick","window.open('"+contextpath + resp.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
		}
		else
		{
			showErrorMessage(getErrorMessage(resp));
		}
	});	
}

function deleteip(fip,tip)
{		    
			new URI(AllowedIPObj,"self","self",fip).DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				delete security_data.AllowedIPs.IPs[fip];
				load_IPdetails(security_data.Policies,security_data.AllowedIPs);
				closeview_selected_ip_view();
				if($("#allow_ip_web_more").is(":visible")==true){
					lenn=Object.keys(security_data.AllowedIPs.IPs).length;
					if(lenn > 1)
					{
						closeview_all_ip_view(show_all_ip);
					}
					else
					{
						closeview_all_ip_view();
					}
				}

			},
			function(resp)
			{
				if(resp.cause && resp.cause.trim() === "invalid_password_token") 
				{
					relogin_warning();
					var service_url = euc(window.location.href);
					$("#new_notification").attr("onclick","window.open('"+contextpath + resp.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
				}
				else
				{
					showErrorMessage(getErrorMessage(resp));
				}
			});
}

function change_ip_only_name()
{
	var from = $("#fip").val();
	var to = $("#tip").val();
	var name=$("#get_name #ip_name").val();
	
	var parms=
	{
			"t_ip":to,//No I18N
			"ip_name":name//No I18N
	};
	var payload = AllowedIPObj.create(parms);
	payload.PUT("self","self",from).then(function(resp)	//No I18N
	{
		SuccessMsg(getErrorMessage(resp));
		
		security_data.AllowedIPs.IPs.from_ip.display_name=name;
		
		load_IPdetails(security_data.Policies,security_data.AllowedIPs);
		$('#allowedipform')[0].reset();
		close_new_ip_popup();
	},
	function(resp)
	{
		if(resp.cause && resp.cause.trim() === "invalid_password_token") 
		{
			relogin_warning();
			var service_url = euc(window.location.href);
			$("#new_notification").attr("onclick","window.open('"+contextpath + resp.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
		}
		else
		{
			showErrorMessage(getErrorMessage(resp));
		}
		if($("#allow_ip_web_more").is(":visible")){
			closeview_all_ip_view(show_all_ip);
		}
		else{
			close_new_ip_popup();
		}
	});	
    return false;
}




function back_to_info()
{
	$("#popup_ip_new").hide();
	
}
function back_to_addip()
{
	$("#get_ip").show();
	$("#get_name").hide();
	$(".ip_impt_note").hide();
	$("#allowedipform").attr("onsubmit","return addipaddress(this)");
	return false;
}


/***************************** App Passwords *********************************/

function load_AppPasswords(Policies,AppPasswords)
{
	var isAppPwdAllowed = security_data.isAppPwdAllowed;
	if(de("App_Password_exception"))
	{
		$("#App_Password_exception").remove();
	}
	if(AppPasswords.exception_occured!=undefined	&&	AppPasswords.exception_occured)
	{
		$("#App_Password_box .box_info" ).after("<div id='App_Password_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#App_Password_exception #reload_exception").attr("onclick","reload_exception(AppPasswords,'App_Password_box')");
		return;
	}
	if(typeof isAppPwdAllowed !== "undefined" && !isAppPwdAllowed)
	{
		$("#app_password_restricted").css("display", "flex");
		$("#generate_app_pass").css("display","none");
	} else {
		$("#generate_app_pass").css("display","block");
		$("#nodata_withoutTFA").hide();
		$("#nodata_withTFA").show();
	}
//	if(Policies.is_tfa_activated)
//	{
		
		
//	}
//	else
//	{
//		$("#generate_app_pass").hide();
//		$("#nodata_withoutTFA").show();
//		$("#nodata_withTFA").hide();
//	}
	
	if(!jQuery.isEmptyObject(security_data.AppPasswords))
	{
		var count=0;
		$("#no_app_passwords").hide();
		$("#display_app_passwords").show();
		$("#display_app_passwords").html("");
		var passwords=timeSorting(AppPasswords);
		for(iter=0;iter<Object.keys(passwords).length;iter++)
		{
			count++;
			var current_password=AppPasswords[passwords[iter]];
			app_password_format = $("#empty_app_pass_format").html();
			$("#display_app_passwords").append(app_password_format);
			
			$("#display_app_passwords #app_password_entry").attr("id","app_password_entry"+count);
			$("#display_app_passwords #app_password_info").attr("id","app_password_info"+count);
			
			
			$("#app_password_entry"+count).attr("onclick","show_selected_app_password_info("+count+");");
			
			if(count > 3)
			{
				$("#app_password_entry"+count).addClass("allowed_ip_entry_hidden");  
			}
			$("#app_password_entry"+count+" .device_name").html(current_password.app_name);
			$("#app_password_entry"+count+" .device_time").html(current_password.created_time_elapsed);
			$("#app_password_entry"+count+" .device_pic").addClass(color_classes[gen_random_value()]);
			if(current_password.app_name.indexOf(" ")==-1)
			{
				$("#app_password_entry"+count+" .device_pic").html(current_password.app_name.substr(0,2).toUpperCase());
			}
			else
			{
				var name=current_password.app_name.split(" ");
				$("#app_password_entry"+count+" .device_pic").html((name[0][0]+name[1][0]).toUpperCase());
			}
			if(current_password.location!=undefined)
			{
				$("#app_password_entry"+count+" .asession_location").removeClass("location_unavail");
				$("#app_password_entry"+count+" .asession_location").html(current_password.location.toLowerCase());
				$("#app_password_info"+count+" #pop_up_location").removeClass("unavail");
				$("#app_password_info"+count+" #pop_up_location").html(current_password.location.toLowerCase());
			}
			$("#app_password_info"+count+" #pop_up_time").html(current_password.created_date);
			$("#app_password_info"+count+" #pop_up_ip").html(current_password.created_ip);
			
			$("#app_password_info"+count+" #delete_generated_password").attr("onclick","delete_app_pass('"+count+"','"+current_password.app_pass_id+"')");
		}
		if(count > 3)
		{
			if(typeof isAppPwdAllowed !== "undefined" && !isAppPwdAllowed)
			{	
				$("#app_pass_justviewmore").show();
				$("#app_pass_add_view_more").hide();				
			} else {
				$("#app_pass_add_view_more").show();				
			}
			$("#app_pass_justaddmore").hide();
			if(count>4)
			{
				$("#app_pass_add_view_more .view_more").html(formatMessage(i18nAppPwdkeys["IAM.VIEWMORE.PWDS"],count-3)); //NO I18N
				$("#app_pass_justviewmore").html(formatMessage(i18nAppPwdkeys["IAM.VIEWMORE.PWDS"],count-3)); //NO I18N
			}
			else
			{
				$("#app_pass_add_view_more .view_more").html(formatMessage(i18nAppPwdkeys["IAM.VIEWMORE.PWD"],count-3)); //NO I18N
				$("#app_pass_justviewmore").html(formatMessage(i18nAppPwdkeys["IAM.VIEWMORE.PWD"],count-3)); //NO I18N
			}
		}
		else
		{
			if(typeof isAppPwdAllowed !== "undefined" && !isAppPwdAllowed)
			{								
				$("#app_pass_justaddmore").hide();
			} else {				
				$("#app_pass_justaddmore").show();
			}			
			$("#app_pass_add_view_more").hide();
		}
	}
	else
	{
		$("#no_app_passwords").show();
		$("#display_app_passwords").hide();
		$("#app_pass_justaddmore").hide();
	}
	
}


function show_selected_app_password_info(id)
{
	
	$("#app_pass_pop .device_pic").addClass($("#app_password_entry"+id+" .device_pic")[0].className);
	$("#app_pass_pop .device_pic").html($("#app_password_entry"+id+" .device_pic").html());
	$("#app_pass_pop .device_name").html($("#app_password_entry"+id+" .device_name").html()); //load into popuop
	$("#app_pass_pop .device_time").html($("#app_password_entry"+id+" .device_time").html()); //load into popuop
	
	$("#app_pass_pop #app_current_info").html($("#app_password_info"+id).html()); //load into popuop
	
	popup_blurHandler('6');
	
	$("#app_pass_pop").show(0,function(){
		$("#app_pass_pop").addClass("pop_anim");
	});
	$("#delete_generated_password").focus();
	closePopup(closeview_selected_app_pass_view,"app_pass_pop"); //No I18N
}

function closeview_selected_app_pass_view()
{
	popupBlurHide('#app_pass_pop'); //No I18N
	$("#app_pass_pop a").unbind();
}


function delete_app_pass(count,pwdid)
{
	
	
	new URI(AppPasswordsObj,"self","self",pwdid).DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				delete security_data.AppPasswords[pwdid];
				load_AppPasswords(security_data.Policies,security_data.AppPasswords);			
				closeview_selected_app_pass_view();
				if($("#app_password_web_more").is(":visible")==true)
				{					
					var lenn=Object.keys(security_data.AppPasswords).length;
					if(lenn > 1)
					{
						$("#app_password_web_more").hide();
						$("#view_all_app_pass").html("");
						show_all_app_passwords();
					}
					else{
						$(".blur").css({"z-index":"6","opacity":".5"});
						closeview_all_app_view();
					}
				}


			},
			function(resp)
			{
				if(resp.cause && resp.cause.trim() === "invalid_password_token") 
				{
					relogin_warning();
					var service_url = euc(window.location.href);
					$("#new_notification").attr("onclick","window.open('"+contextpath + resp.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
				}
				else
				{
					showErrorMessage(getErrorMessage(resp));
				}
			});
	
	
}

function show_generate_popup()
{
	$("#popup_apppass_new").show(0,function(){
		$("#popup_apppass_new").addClass("pop_anim");
	});
	$("#generate_new_pass").show();
	$("#generated_passsword").hide();
	
	popup_blurHandler('6');
	control_Enter("#popup_apppass_new a");//No i18N
	$("#popup_apppass_new input:first").focus();
	closePopup(close_new_app_pass_popup,"popup_apppass_new");//No I18N	
}















function close_new_app_pass_popup()
{
	popupBlurHide('#popup_apppass_new',function(){	//No i18N
		$("#generate_new_pass").show();
		$("#generated_passsword").hide();		
	});
	remove_error();
	$("#popup_apppass_new input").val(''); 
}






function generateAppPassword()
{
	remove_error();
	var label = de('applabel').value.trim(); //No i18N
	if(label == "")
	{
		$("#gene_app_space").append( '<div class="field_error">'+empty_field+'</div>' );
		return;
	}
	if(validatelabel(label) != true) 
	{
		$("#gene_app_space").append( '<div class="field_error">'+err_invalid_label+'</div>' );
		return;
	}

	if(label.length > 45)
	{
		$("#gene_app_space").append( '<div class="field_error">'+err_invalid_label+'</div>' );//No i18N
		return;
	}
//	pass = de('passapp').value.trim(); //No i18N
//	if(pass=="")
//	{
//		$("#gene_app_pass_space").append( '<div class="field_error">'+err_invalid_password+'</div>' );
//		return;
//	}
	
	disabledButton($("#generate_new_pass"));
	var parms=
	{
//		"password":pass,//No I18N
		"keylabel":label//No I18N
	};
	
	
	var payload = AppPasswordsObj.create(parms);
	//$("#generate_new_pass .tfa_blur").show();
	//$("#generate_new_pass .loader").show();
	
	payload.POST("self","self").then(function(resp)	//No I18N
	{
		SuccessMsg(getErrorMessage(resp));
		//$("#generate_new_pass .tfa_blur").hide();
		//$("#generate_new_pass .loader").hide();
		security_data.AppPasswords[resp.apppasswords.app_info.app_pass_id]=resp.apppasswords.app_info;
		load_AppPasswords(security_data.Policies,security_data.AppPasswords);
		generate_appcallback(resp.apppasswords.password)
		removeButtonDisable($("#generate_new_pass"));
	},
	function(resp)
	{
		if(resp.cause && resp.cause.trim() === "invalid_password_token") 
		{
			relogin_warning();
			var service_url = euc(window.location.href);
			$("#new_notification").attr("onclick","window.open('"+contextpath + resp.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
		}
		else
		{
			showErrorMessage(getErrorMessage(resp));
		}
		//$("#generate_new_pass .tfa_blur").hide();
		//$("#generate_new_pass .loader").hide();
		removeButtonDisable($("#generate_new_pass"));
	});

	return false;
}

function generate_appcallback(password)
{	
	
	$("#generate_new_pass").hide();
	$("#generated_passsword").show();
	
	$("#app_name").html(de('applabel').value.trim()); //No i18N
	var displayPass = "<span>"+password.substring(0, 4)+"</span>"+"<span style='margin-left:5px'>"+password.substring(4, 8)+"</span>"+"<span style='margin-left:5px'>"+password.substring(8)+"</span>"; //No I18N
	$('.app_password').html(displayPass); //No i18N
	//$('.password_key').val(password); //No i18N
	$(".app_pasword_info .app_info").html(formatMessage(tfa_pass_msg,de('applabel').value.trim()));//No i18N
	$(".app_password_grid").attr("title",err_app_pass_click_text);//No i18N
	tippy(".app_password_grid",{//No I18N
    		trigger:"mouseenter",	//No I18N
    		arrow:true
	});
	$("#popup_apppass_new").focus();
}


function show_all_app_passwords()
{
	$("#view_all_app_pass").html($("#display_app_passwords").html()); //load into popuop
	popup_blurHandler('6');
	
	$("#view_all_app_pass .allowed_ip_entry_hidden").show();
	//$("#view_all_app_pass .authweb_entry").after( "<br />" );
	//$("#view_all_app_pass .authweb_entry").addClass("viewall_authwebentry");
	$("#view_all_app_pass .allowed_ip_entry").removeAttr("onclick");
	$("#view_all_app_pass .info_tab").show();

//	$("#view_all_allow_ip .asession_action").hide();

	//$("#view_all_allow_ip .asession_action").hide();

	
	$("#app_password_web_more").show(0,function(){
		$("#app_password_web_more").addClass("pop_anim");
	});
	
	
	
	$("#view_all_app_pass .allowed_ip_entry").click(function(){
		
		var id=$(this).attr('id');

		$("#view_all_app_pass .allowed_ip_entry").addClass("autoheight");
		$("#view_all_app_pass .aw_info").slideUp(300);
		$("#view_all_app_pass .activesession_entry_info").show();
		if($("#view_all_app_pass #"+id).hasClass("Active_ip_showall_hover"))
		{

			$("#view_all_app_pass #"+id).removeClass("Active_ip_showall_hover");
			$("#view_all_app_pass #"+id+" .aw_info").slideUp("fast",function(){
				$("#view_all_app_pass .allowed_ip_entry").removeClass("autoheight");
			});
			$("#view_all_app_pass .activesession_entry_info").show();
		}
		else
		{
			$("#view_all_app_pass .allowed_ip_entry").removeClass("Active_ip_showall_hover");
			$("#view_all_app_pass .allowed_ip_entry").removeClass("Active_ip_showcurrent");
			$("#view_all_app_pass #"+id).addClass("Active_ip_showall_hover");
			$("#view_all_app_pass #"+id+" .aw_info").slideDown(300,function(){
				$("#view_all_app_pass .allowed_ip_entry").removeClass("autoheight");
			});
			$("#view_all_app_pass #"+id+" .activesession_entry_info").hide();
	//		$("#view_all_allow_ip #"+id+" .primary_btn_check").focus();
		}
		
	});
	closePopup(closeview_all_app_view,"app_password_web_more");//No I18N
	
	$("#app_password_web_more").focus();

}


function closeview_all_app_view()
{
	popupBlurHide('#app_password_web_more',function(){	//No i18N
		$("#view_all_app_pass").html("");		
	});
}



/***************************** Device Logins *********************************/

 function load_DeviceLogins(Policies,Devicelogins)
 {
	if(de("Device_logins_exception"))
	{
		$("#Device_logins_exception").remove();
		$("#show_Device_logins #no_Devices").removeClass("hide");
	}
	if(Devicelogins.exception_occured!=undefined	&&	Devicelogins.exception_occured)
	{
		$("#Device_logins_box .box_info" ).after("<div id='Device_logins_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#Device_logins_exception #reload_exception").attr("onclick","reload_exception(Device_logins,'Device_logins_box')");
		$("#show_Device_logins #no_Devices").addClass("hide");
		return;
	}
	
//	if(!jQuery.isEmptyObject(security_data.DeviceLogins))
	$("#display_all_Devices").html("");
	var count=0,device_loc_count=0;
	var hideCount = security_data.DeviceLogins.client_apps?2:3;
	if(!jQuery.isEmptyObject(security_data.DeviceLogins.Platform_Logins))
	{
		var platform_logins=security_data.DeviceLogins.Platform_Logins;
		$("#show_Device_logins #no_Devices").hide();
		$("#display_all_Devices").show();
		var devices=Object.keys(platform_logins);
		var isCurrentBrowserDevice = false;
		for(var iter=0;iter<devices.length;iter++)
		{
			var current_device=platform_logins[devices[iter]];
			Device_logins_format = $("#empty_Device_logins_format").html();
			$("#display_all_Devices").append(Device_logins_format);
			$("#display_all_Devices #Device_logins_entry").attr("id","Device_logins_entry"+count);
			$("#display_all_Devices #Device_logins_info").attr("id","Device_logins_info"+count);
			$("#display_all_Devices #select_device_").attr("id","select_device_"+count);
			
			$("#Device_logins_entry"+count).attr("onclick","show_selected_devicelogins_info("+count+");");
			$("#Device_logins_entry"+count).addClass("devicelogin_list");
			$("#Device_logins_entry"+count+" .device_name").html(devices[iter]);
			
			$("#Device_logins_entry"+count+" .mail_client_logo").html(devices[iter].substr(0,2).toUpperCase());//No I18N
			$("#Device_logins_entry"+count+" .mail_client_logo").addClass(color_classes[gen_random_value()]);
				
			if(platform_logins[devices[iter]].length==1)
			{
				var platform_location = platform_logins[devices[iter]][Object.keys(platform_logins[devices[iter]])[0]].location
				if(platform_location!=undefined)
				{
					$("#Device_logins_entry"+count+" .asession_location").html(platform_location.toLowerCase());
				}
				
			}
			else
			{
				$("#Device_logins_entry"+count+" .asession_location").html(Object.keys(platform_logins[devices[iter]]).length+" "+Locations);
			}
			if(count >= hideCount)
			{
				$("#Device_logins_entry"+count).addClass("allowed_ip_entry_hidden");  
			}
			
			var locations_count=0;
			isCurrentBrowserDevice = false;
			var alignedsDeviceData = {};
			var device_keys = Object.keys(platform_logins[devices[iter]]);
			for(var key in device_keys)
			{
				locations_count++;
				var current_browser = platform_logins[devices[iter]][device_keys[key]];
				alignedsDeviceData[current_browser.device_id] = current_browser;
				Device__format = $("#empty_Devices_format").html();
				
				$("#display_all_Devices #Device_logins_info"+count).append(Device__format);
				
				$("#display_all_Devices #Device_logins_info"+count+" #Devices_entry").attr("id","Devices_entry"+locations_count);
				$("#display_all_Devices #Device_logins_info"+count+" #select_device_browser_").attr("id","select_device_browser_"+count+"_"+locations_count);
				$("#display_all_Devices #select_device_browser_"+count+"_"+locations_count+" .checkbox_check").attr("id",current_browser.device_id);
				
				$("#display_all_Devices #Device_logins_info"+count+" #Devices_entry"+locations_count+" #devicelogins_entry_info").attr("id","devicelogins_entry_info"+locations_count);
				
				$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .asession_browser").addClass("icon-"+current_browser.browser_info.browser_image);
				$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .asession_browser").html(fontIconBrowserToHtmlElement[current_browser.browser_info.browser_image]);
				$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .asession_browser").attr('title',current_browser.browser_info.browser_version);
				
				$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .device_name").html(current_browser.browser_info.browser_name);
				$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .device_login_tim").html(current_browser.last_accessed_elapsed);
				$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .devicelogins_entry_info .asession_os").addClass("os_"+current_browser.device_info.os_img);
				$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .devicelogins_entry_info .asession_os").attr('title',current_browser.device_info.os_name)
				
				if(current_browser.location!=undefined)
				{
					$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .devicelogins_entry_info .asession_location").html(current_browser.location.toLowerCase());
				}
				
				$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .deleteicon").attr("onclick","delete_current_trusted_entry(\'"+current_browser.device_id+"\',\'"+devices[iter]+"\',"+count+","+locations_count+");");
				if(current_browser.is_current_session){
					isCurrentBrowserDevice = true;
					$("#Device_logins_info"+count+" #Devices_entry"+locations_count).find(".deleteicon").remove();
					$("#Device_logins_info"+count+" #Devices_entry"+locations_count).find("input[type='checkbox']").remove();
					$("#Device_logins_info"+count+" #Devices_entry"+locations_count).find(".checkbox").addClass("disabled_checkbox");
					
					if(platform_logins[devices[iter]].length<2){
						$("#Device_logins_entry"+count+" .select_holder").find("input[type='checkbox']").remove();
						$("#Device_logins_entry"+count+" .select_holder").find(".checkbox").addClass("disabled_checkbox"); //No I18N
					}
				}
				else{
					$("#Device_logins_info"+count+" #Devices_entry"+locations_count).find(".current").remove();
				}
				device_loc_count++;
			}
			if(isCurrentBrowserDevice){
				$("#Device_logins_entry"+count+" .current").show();
				var current_devi_template = $("#Device_logins_entry"+count);
				current_devi_template.removeClass("allowed_ip_entry_hidden");
				$("#Device_logins_entry"+count).remove();
				$("#display_all_Devices").prepend(current_devi_template);
			}
			else{
				$("#Device_logins_entry"+count+" .current").remove();				
			}
			security_data.DeviceLogins.Platform_Logins[devices[iter]] = alignedsDeviceData;
			count++;
		}

	}
	if(!jQuery.isEmptyObject(security_data.DeviceLogins.client_apps))
	{
		$("#show_Device_logins #no_Devices").hide();
		$("#display_all_Devices").show();
		Device_logins_format = $("#empty_Device_logins_format").html();
		$("#display_all_Devices").append(Device_logins_format);
		$("#display_all_Devices #Device_logins_entry").attr("id","Device_logins_entry"+count);
		$("#display_all_Devices #Device_logins_info").attr("id","Device_logins_info"+count);
		$("#display_all_Devices #select_device_").attr("id","select_device_"+count);
		
		$("#Device_logins_entry"+count).attr("onclick","show_selected_devicelogins_info("+count+");");
		$("#Device_logins_entry"+count).addClass("mailclient_list");
		$("#Device_logins_entry"+count+" .device_name").html(mail_client);
		$("#Device_logins_entry"+count+" .mail_client_logo").html(mail_client.substr(0,2).toUpperCase());//No I18N
		$("#Device_logins_entry"+count+" .mail_client_logo").addClass(color_classes[gen_random_value()]);
		$("#Device_logins_entry"+count+" .current").remove();
		var mail_client_logins=security_data.DeviceLogins.client_apps;
		var client_APPS=Object.keys(mail_client_logins);
		
		if(client_APPS.length==1)
		{
			//$("#Device_logins_entry"+count+" .device_time").html(Devicelogins[devices[iter]][0].device_name);
			if(mail_client_logins[client_APPS[0]].location!=undefined)
			{
				$("#Device_logins_entry"+count+" .asession_location").html(mail_client_logins[client_APPS[0]].location.toLowerCase());
			}
		}
		else
		{
			$("#Device_logins_entry"+count+" .asession_location").html(client_APPS.length+" "+Locations);
		}
		if(count > 3)
		{
			$("#Device_logins_entry"+count).addClass("allowed_ip_entry_hidden");  
		}
		var locations_count=0;
		for(var client_iter=0;client_iter<client_APPS.length;client_iter++)
		{
			locations_count++;
			device_loc_count++;
			var current_client=mail_client_logins[client_APPS[client_iter]];
			Device__format = $("#empty_Devices_format").html();
			$("#display_all_Devices #Device_logins_info"+count).append(Device__format);
			$("#display_all_Devices #Device_logins_info"+count+" #Devices_entry").attr("id","Devices_entry"+locations_count);
			$("#display_all_Devices #Device_logins_info"+count+" #Devices_entry"+locations_count+" #devicelogins_entry_info").attr("id","devicelogins_entry_info"+locations_count);
			$("#display_all_Devices #Device_logins_info"+count+" #Devices_entry"+locations_count+" .checkbox_check").attr("id",current_client.device_id);
			
			$("#display_all_Devices #Device_logins_info"+count+" #select_device_browser_").attr("id","select_device_browser_"+count+"_"+locations_count);
			$("#display_all_Devices #select_device_browser_"+count+"_"+locations_count+" .checkbox_check").attr("id",current_client.device_id);
			
			$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .asession_browser").attr('class', '');
			
			$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .device_name").html(current_client.location);
			 
			$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .device_name").addClass("device_client_name");
			
			if(current_client.location!=undefined)
			{
				$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .device_name").html(current_client.location);
			}
			$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .device_login_tim").html(current_client.last_accessed_elapsed);
			
			$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .devicelogins_entry_info .asession_os").attr('class', '');
			$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .devicelogins_entry_info .asession_os").attr('title',"")
			

			$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .devicelogins_entry_info .asession_location").html("");
			
			$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .deleteicon").attr("onclick","delete_current_trusted_MailClient_entry("+count+","+locations_count+",\'"+client_APPS[client_iter]+"\',\'"+current_client.device_id+"\');");
			$("#Device_logins_info"+count+" #Devices_entry"+locations_count).find(".current").remove();
		}
		count++;
	}
	if(device_loc_count<2){
		$("#Device_logins_box .header_btn").hide();
	}else{
		$("#Device_logins_box .header_btn").show();
	}

	if(count>3)
	{
		$("#Device_logins_viewmore,#display_all_Devices .select_holder").show();
	}
	else if(count==0)
	{
		$("#display_all_Devices,#Device_logins_viewmore").hide();
		$("#display_all_Devices").html("");
		$("#show_Device_logins #no_Devices").show();
	}
	else{
		$("#Device_logins_viewmore").hide();
	}
	return;
	 
 }

 function  delete_current_trusted_MailClient_entry(platform_id,location_id,platform_name,device_id)
 {
	new URI(Mail_ClientLoginsObj,"self","self",device_id).DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				var deleted=false;
				if(security_data.DeviceLogins.client_apps!=undefined	&&	security_data.DeviceLogins.client_apps[platform_name]!=undefined)
				{
					if(security_data.DeviceLogins.client_apps[platform_name]!=undefined)
					{
						delete security_data.DeviceLogins.client_apps[platform_name];
						deleted=true;
					}
				}
				load_DeviceLogins(security_data.Policies,security_data.DeviceLogins);
				
				
				if($("#Device_logins_web_more").is(":visible")==true)
				{
					 $("#view_all_Device_logins").html("");
					show_all_device_logins();
					if(!deleted)
					{
						$("#view_all_Device_logins #Device_logins_entry"+platform_id).click();
					}
				}
				else
				{
					if(deleted)
					{
						closeview_selected_Device_logins_view();
					}
					else
					{
						$("#Device_logins_current_info #Devices_entry"+location_id).remove();
					}
				}
			},
			function(resp)
			{
				if(resp.cause && resp.cause.trim() === "invalid_password_token") 
				{
					relogin_warning();
					var service_url = euc(window.location.href);
					$("#new_notification").attr("onclick","window.open('"+contextpath + resp.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
				}
				else
				{
					showErrorMessage(getErrorMessage(resp));
				}
			});
	 
 }
 
 
 
function  delete_current_trusted_entry(device_id,platform_name,platform_id,location_id)
{
	new URI(DeviceLoginsObj,"self","self",device_id).DELETE().then(function(resp)	//No I18N
	{
		SuccessMsg(getErrorMessage(resp));
		var deleted=false;
		if(security_data.DeviceLogins.Platform_Logins!=undefined	&&	security_data.DeviceLogins.Platform_Logins[platform_name]!=undefined)
		{
			delete security_data.DeviceLogins.Platform_Logins[platform_name][device_id];
			if(Object.keys(security_data.DeviceLogins.Platform_Logins[platform_name]).length==0)
			{
				delete security_data.DeviceLogins.Platform_Logins[platform_name];
				deleted=true;
			}
		}
		load_DeviceLogins(security_data.Policies,security_data.DeviceLogins);
		
		
		if($("#Device_logins_web_more").is(":visible")==true)
		{
			 $("#view_all_Device_logins").html("");
			show_all_device_logins();
			if(!deleted)
			{
				$("#view_all_Device_logins #Device_logins_entry"+platform_id).click();
			}
		}
		else
		{
			if(deleted)
			{
				if(security_data.DeviceLogins.Platform_Logins[platform_name] == undefined){
					closeview_selected_Device_logins_view();
				}
			}
			else
			{
				$("#Device_logins_current_info #Devices_entry"+location_id).remove();
			}
		}
	},
	function(resp)
	{
		if(resp.cause && resp.cause.trim() === "invalid_password_token") 
		{
			relogin_warning();
			var service_url = euc(window.location.href);
			$("#new_notification").attr("onclick","window.open('"+contextpath + resp.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
		}
		else
		{
			showErrorMessage(getErrorMessage(resp));
		}
	});
}
function reflectPopupAction(for_location){
	if($("#Device_logins_pop").is(":visible")){
		$("#Device_logins_current_info .checkbox_check").each(function(index){
			var par_ID = $("#Device_logins_pop #device_select_all").attr("name");
			if($("#Device_logins_current_info .checkbox_check")[index].checked && !$("#Device_logins_current_info .checkbox_check")[index].indeterminate){
				$("#display_all_Devices #"+par_ID+" .aw_info").find(".checkbox_check")[index].checked = true;
			}
			else if($("#Device_logins_current_info .checkbox_check")[index].checked && $("#Device_logins_current_info .checkbox_check")[index].indeterminate){
				$("#display_all_Devices #"+par_ID+" .aw_info").find(".checkbox_check")[index].indeterminate = true;
			}
			else{
				$("#display_all_Devices #"+par_ID+" .aw_info").find(".checkbox_check")[index].checked = false;
			}
		});
	}
	else{
		$("#view_all_Device_logins .checkbox_check").each(function(index){
			var par_ID = $($("#display_all_Devices .checkbox_check")[index]).parents(".select_holder").attr("id"); //No I18N
			if($("#view_all_Device_logins .checkbox_check")[index].checked && !$("#view_all_Device_logins .checkbox_check")[index].indeterminate){
				$("#display_all_Devices #"+par_ID).find(".checkbox_check")[0].checked = true;
			}
			else if($("#view_all_Device_logins .checkbox_check")[index].checked && $("#view_all_Device_logins .checkbox_check")[index].indeterminate){
				$("#display_all_Devices #"+par_ID).find(".checkbox_check")[0].indeterminate = true;
			}
			else{
				$("#display_all_Devices #"+par_ID).find(".checkbox_check")[0].checked = false;
			}
		});
	}
}
function handleDeviceGroup(checking_ele){
	var selected_count = $(checking_ele).parents(".devicelogins_entry").find(".aw_info input").length+$("#view_all_Device_logins .aw_info input:checked").length;
	if(showLimitOnPopup(selected_count) && checking_ele.checked){
		if($("#view_all_Device_logins .aw_info input:checked").length < 50){
			checking_ele.indeterminate = true;
		}
		else{
			checking_ele.checked = false;			
		}
		$(checking_ele).parents(".devicelogins_entry").find(".aw_info input").slice(0,50 - $("#view_all_Device_logins .aw_info input:checked").length).prop('checked', true);
		if(!$("#Device_logins_web_more").is(":visible")){
			show_all_device_logins();
			$("#Device_logins_web_more #"+$(checking_ele).parents(".devicelogins_entry").attr("id")).click();
			$("#Device_logins_web_more .deleteicon").show();
			$("#Device_logins_web_more .all_elements_space").css("height",isMobile ? "calc(100% - 155px)" : "calc(100% - 189px)");
			$("#Device_logins_web_more #deleted_selected_sessions,#Device_logins_web_more .selected_count").hide();
		}
	}
	else{
		deviceGroupSelectCallback(checking_ele);
		reflectPopupAction();
		if(showLimitOnPopup($("#view_all_Device_logins .aw_info input:checked").length)){
			checking_ele.checked = false;
			deviceGroupSelectCallback(checking_ele);
		}
	}
	handleSelectAllFunction();
}
function deviceGroupSelectCallback(checking_ele){
	if(checking_ele.checked ){
		$(checking_ele).parents(".devicelogins_entry").find(".aw_info .checkbox_check").each(function(i,ele){
			$(checking_ele).parents(".devicelogins_entry").find(".aw_info .checkbox_check")[i].checked = true;
		});
		if(!$("#Device_logins_web_more").is(":visible")){
			show_all_device_logins();
			$("#Device_logins_web_more #"+$(checking_ele).parents(".devicelogins_entry").attr("id")).find(".aw_info .checkbox_check").each(function(i,ele){
				ele.checked = true;
			});
			$("#Device_logins_web_more #"+$(checking_ele).parents(".devicelogins_entry").attr("id")).click();
		}
	}
	else{
		$(checking_ele).parents(".devicelogins_entry").find(".aw_info .checkbox_check").each(function(i,ele){
			ele.checked = false;
		});
	}
}
function handleChildCheckbox(ele){
	handleChildCheckboxCallback(ele);
	reflectPopupAction();
    if(showLimitOnPopup($("#display_all_Devices .aw_info input:checked").length)){
    	ele.checked = false;
    	handleChildCheckboxCallback(ele);
    }
    handleSelectAllFunction();
}
function handleChildCheckboxCallback(ele){
	$("#show_Device_logins #"+$(ele).parent()[0].id).find(".checkbox_check")[0].checked = ele.checked;
	var childCheckbox = $(ele).parents(".aw_info").find(".checkbox_check");
    var parentCheckbox = $(ele).parents(".devicelogins_entry").find(".info_tab .checkbox_check")[0];
    var checkedChildCount = $(ele).parents(".aw_info").find(".checkbox_check:checked").length;
    if($("#Device_logins_pop").is(":visible")){
    	childCheckbox = $(ele).parents("#Device_logins_current_info").find(".checkbox_check");
    	parentCheckbox = $("#display_all_Devices #"+ele.id).parents(".devicelogins_entry").find(".info_tab .checkbox_check")[0];
    	checkedChildCount = $(ele).parents("#Device_logins_current_info").find(".checkbox_check:checked").length;
    }
    if(parentCheckbox){
	    parentCheckbox.checked = checkedChildCount > 0;
	    $("#display_all_Devices #"+$(ele).parent()[0].id).parents(".devicelogins_entry").find(".info_tab .checkbox_check")[0].checked = checkedChildCount > 0;
	    if(!$("#Device_logins_pop").is(":visible")){
	    	parentCheckbox.indeterminate = checkedChildCount > 0 && checkedChildCount < childCheckbox.length;
	    }
	    if($("#Device_logins_pop .select_all_div .checkbox_check")[0]){
	    	$("#Device_logins_pop .select_all_div .checkbox_check")[0].checked = checkedChildCount > 0;
	    	$("#Device_logins_pop .select_all_div .checkbox_check")[0].indeterminate =  checkedChildCount > 0 && checkedChildCount < childCheckbox.length;
	    }
	    $("#display_all_Devices #"+$(ele).parent()[0].id).parents(".devicelogins_entry").find(".info_tab .checkbox_check")[0].indeterminate =  checkedChildCount > 0 && checkedChildCount < childCheckbox.length;
	}
}
function handleSelectAllFunction(){
    if($("#view_all_Device_logins .info_tab .checkbox_check").length == $("#view_all_Device_logins .info_tab .checkbox_check:checked").length){
    	$("#Device_logins_web_more #device_select_all").prop('checked', true);
    }
    else{
    	$("#Device_logins_web_more #device_select_all").prop('checked', false);
    }
    if($("#view_all_Device_logins .checkbox_check:checked").length>0){
    	$("#Device_logins_web_more .delete_all_space,#Device_logins_web_more #deleted_selected_sessions").show();
    	$("#Device_logins_web_more .deleteicon").hide();
    	$("#Device_logins_web_more .all_elements_space").css("height", isMobile ? "calc(100% - 155px)" : "calc(100% - 189px)");
    }
    else{
    	$("#Device_logins_web_more .delete_all_space,#Device_logins_web_more #deleted_selected_sessions").hide();   
    	$("#Device_logins_web_more .deleteicon").show();
    	$("#Device_logins_web_more .all_elements_space").css("height",isMobile ? "calc(100% - 65px)" : "calc(100% - 100px)");
    }
    if($("#Device_logins_current_info .checkbox_check:checked").length>0){
    	$("#Device_logins_pop .delete_location,#Device_logins_pop #deleted_selected_locations").show();
    	$("#Device_logins_pop .deleteicon").hide();
    }
    else{
    	$("#Device_logins_pop .delete_location,#Device_logins_pop #deleted_selected_locations").hide();   
    	$("#Device_logins_pop .deleteicon").show();
    }
    reflectPopupAction();
    if($("#view_all_Device_logins").is(":visible")){
    	showLimitOnPopup($("#view_all_Device_logins .aw_info input:checked").length);
    }
    else{
    	showLimitOnPopup($("#display_all_Devices .aw_info input:checked").length);
    }
    
}
function showLimitOnPopup(count){
    var select_limit = 50;
    if(count > 0){
    	$("#Device_logins_pop .selected_count,#Device_logins_web_more .selected_count").html(count == 1 ? i18nSessionkeys["IAM.DEVICE.SIGNIN.DELETE.ONE.COUNT"] : formatMessage(i18nSessionkeys["IAM.DEVICE.SIGNIN.DELETE.COUNT"],count)).show();	//No I18N
    	count > select_limit - 5 ? $("#Device_logins_web_more .limit_reached_desc,#Device_logins_pop .limit_reached_desc").html(formatMessage(i18nSessionkeys["IAM.DEVICELOGINS.REMOVE.LIMIT"],select_limit)).show() : $("#Device_logins_web_more .limit_reached_desc,#Device_logins_pop .limit_reached_desc").hide();	//No I18N
    	//if($("#view_all_Device_logins .aw_info input").length == count){$("#Device_logins_pop .limit_reached_desc,#Device_logins_web_more .limit_reached_desc").hide()}
    }
    else{
    	$("#Device_logins_web_more .selected_count,#Device_logins_web_more .selected_count").hide();
    }
    return count > select_limit;
}
function deleteSelectedDevice(){
	var deviceLoginList = [];
	var mailClinetList = [];
	$('#view_all_Device_logins .devicelogin_list .aw_info input:checked').each(function() {
		deviceLoginList.push($(this).attr('id'));
	});
	$('#view_all_Device_logins .mailclient_list .aw_info input:checked').each(function() {
		mailClinetList.push($(this).attr('id'));
	});
	if(deviceLoginList.length != 0 && mailClinetList.length != 0){
		deviceLoginList = deviceLoginList.length == $('#view_all_Device_logins .devicelogin_list .aw_info input').length ? "" : deviceLoginList;
		mailClinetList = mailClinetList.length == $('#view_all_Device_logins .mailclient_list .aw_info input').length ? "" : mailClinetList;
		$.when( new URI(Mail_ClientLoginsObj,"self","self",mailClinetList).DELETE(), new URI(DeviceLoginsObj,"self","self",deviceLoginList).DELETE()).then(function(resp){	//No I18N
			SuccessMsg(getErrorMessage(resp));
			deletAllCallback(deviceLoginList,mailClinetList);
		},function(resp){
			deleteFailureCallback(resp);
		});
	}
	else if(deviceLoginList.length == 0){	
		mailClinetList = mailClinetList.length == $('#view_all_Device_logins .mailclient_list .aw_info input').length ? "" : mailClinetList;
		new URI(Mail_ClientLoginsObj,"self","self",mailClinetList).DELETE().then(function(resp){		//No I18N
			SuccessMsg(getErrorMessage(resp));
			deletAllCallback([],mailClinetList);
		},function(resp){
			deleteFailureCallback(resp);
		});
	}
	else if(mailClinetList.length == 0){
		deviceLoginList = deviceLoginList.length == $('#view_all_Device_logins .devicelogin_list .aw_info input').length ? "" : deviceLoginList;
		new URI(DeviceLoginsObj,"self","self",deviceLoginList).DELETE().then(function(resp)	//No I18N
				{
					SuccessMsg(getErrorMessage(resp));
					deletAllCallback(deviceLoginList,[]);
				},
				function(resp)
				{
					deleteFailureCallback(resp);
				});
	}
}

function deleteAllDeviceLocation(){
	if(security_data.DeviceLogins.client_apps && Object.keys(security_data.DeviceLogins.Platform_Logins).length>1){
		$.when( new URI(Mail_ClientLoginsObj,"self","self","").DELETE(), new URI(DeviceLoginsObj,"self","self","").DELETE()).then(function(resp){	//No I18N
			SuccessMsg(getErrorMessage(resp));
			deletAllCallback("","");
		},function(resp){
			deleteFailureCallback(resp);
		});
	}
	else if(security_data.DeviceLogins.client_apps == undefined){
		new URI(DeviceLoginsObj,"self","self","").DELETE().then(function(resp){	//No I18N
			SuccessMsg(getErrorMessage(resp));
			deletAllCallback('',[]);
		},function(resp){
			deleteFailureCallback(resp);
		});
	}
	else{
		new URI(Mail_ClientLoginsObj,"self","self","").DELETE().then(function(resp){	//No I18N
			SuccessMsg(getErrorMessage(resp));
			deletAllCallback([],'');
		},function(resp){
			deleteFailureCallback(resp);
		});
	}
	
}

function deleteFailureCallback(resp){
	if(resp.cause && resp.cause.trim() === "invalid_password_token") 
	{
		relogin_warning();
		var service_url = euc(window.location.href);
		$("#new_notification").attr("onclick","window.open('"+contextpath + resp.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
	}
	else
	{
		showErrorMessage(getErrorMessage(resp));
	}
}
function deletAllCallback(deviceList,mailList){
	if(deviceList === ""){
		deviceList = [];
		$('#display_all_Devices .devicelogin_list .aw_info').find("input").each(function() {
				deviceList.push($(this).attr('id'));
		});
	}
	if(Array.isArray(deviceList) && deviceList.length != 0){
		for(var index in deviceList){
			var platform_name = $("#show_Device_logins #"+deviceList[index]).parents(".devicelogins_entry").find(".device_platform_details").text().trim();
			if(security_data.DeviceLogins.Platform_Logins!=undefined	&&	security_data.DeviceLogins.Platform_Logins[platform_name]!=undefined)
			{
				delete security_data.DeviceLogins.Platform_Logins[platform_name][deviceList[index]];
				if(Object.keys(security_data.DeviceLogins.Platform_Logins[platform_name]).length==0)
				{
					delete security_data.DeviceLogins.Platform_Logins[platform_name];
				}
			}
		}
	}
	if(Array.isArray(mailList) && mailList.length != 0){
		for(var index in mailList){
			var platform_name = $("#show_Device_logins #"+mailList[index]).parents(".devicelogins_entry").find(".device_platform_details").text().trim();
			if(security_data.DeviceLogins.client_apps!=undefined	&&	security_data.DeviceLogins.client_apps[mailList[index]]!=undefined)
			{
					delete security_data.DeviceLogins.client_apps[mailList[index]];
			}
		}
		if(Object.keys(security_data.DeviceLogins.client_apps).length == 0){
			delete security_data.DeviceLogins.client_apps;
		}
	}
	else if(mailList === ""){
		delete security_data.DeviceLogins.client_apps;
	}
	load_DeviceLogins(security_data.Policies,security_data.DeviceLogins);
	if(!$("#Device_logins_pop").is(":visible")){
		if(Object.keys(security_data.DeviceLogins.Platform_Logins).length > 1)
		{
			$("#view_all_Device_logins").html("");
			show_all_device_logins();
		}
		else{
		 	popupBlurHide("#Device_logins_web_more",function(){		//No I18N
		 		$("#view_all_Device_logins").html("");
		 	});
		}
	}
}

function showDeleteAllDeviceLoginsConf(title,desc){
	show_confirm(title,desc,
		    function() 
		    {
				deleteAllDeviceLocation();
			},
		    function() 
		    {
		    	return false;
		    }
		);
}

 function show_selected_devicelogins_info(id)
 {
	 	if(event && $(event.target).parents().hasClass("select_holder")){return;}
	 	tooltip_Des("#Device_logins_current_info .action_icon");//No I18N
		tooltip_Des("#Device_logins_current_info .asession_os");	//No I18N
		$("#Device_logins_pop #platform_img").removeClass();
		$("#Device_logins_pop #platform_img").addClass($("#Device_logins_entry"+id+" .mail_client_logo:visible")[0].classList.value);
		$("#Device_logins_pop #platform_img").text($("#Device_logins_entry"+id+" .mail_client_logo:visible").text());
		$("#Device_logins_pop .device_name").html($("#Device_logins_entry"+id+" .device_name").html()); //load into popuop
		
		$("#Device_logins_pop #Device_logins_current_info").html($("#Device_logins_info"+id).html()); //load into popuop
		if($("#Device_logins_pop #Device_logins_current_info").children().length>2){
			$("#Device_logins_current_info .select_holder,#Device_logins_pop .select_all_div,#Device_logins_pop .select_all_div .select_holder").show();
			$("#Device_logins_pop .select_all_div input").attr("name","Device_logins_entry"+id);
			var location_type = $("#Device_logins_entry"+id).hasClass('mailclient_list') ? "mail_client" : "device";		//No I18N
			$("#Device_logins_pop #deleted_selected_locations").attr("onclick","deleteSelectedLocations('"+id+"','"+location_type+"')");		//No I18N
			$("#Device_logins_pop #device_select_all").prop('checked', $("#Device_logins_entry"+id).find("#device_check")[0].checked).prop('indeterminate', $("#Device_logins_entry"+id).find("#device_check")[0].indeterminate);
			if($("#Device_logins_entry"+id).find("#device_check")[0].checked && !$("#Device_logins_entry"+id).find("#device_check")[0].indeterminate){
				$("#Device_logins_pop .checkbox_check").prop('checked', true);
			}
			else{
				var checked_inputs = $("#Device_logins_entry"+id+" .aw_info .checkbox_check:checked");
				for(var index=0;index<checked_inputs.length;index++){
					$("#Device_logins_pop").find("#"+checked_inputs[index].id).prop('checked', true);
				}
			}
		    if($("#Device_logins_current_info .checkbox_check:checked").length>0){
		    	$("#Device_logins_pop .delete_location").show();
		    }
		    else{
		    	$("#Device_logins_pop .delete_location").hide();   
		    }
		}
		else{			
			$("#Device_logins_current_info .select_holder,#Device_logins_pop .delete_location").hide();
			$("#Device_logins_pop .select_all_div").hide();
		}
		
		popup_blurHandler('6');
		$("#Device_logins_pop").show(0,function(){
			$("#Device_logins_pop").addClass("pop_anim");
		});
		tooltipSet("#Device_logins_current_info .action_icon");//No I18N
		sessiontipSet("#Device_logins_current_info .asession_os");//No I18N
		closePopup(closeview_selected_Device_logins_view,"Device_logins_pop"); //No I18N
		$("#Device_logins_pop").focus();
 }
 
function deleteSelectedLocations(id,loc_type){
	var locationList = [];
	$('#Device_logins_current_info input:checked').each(function() {
		locationList.push($(this).attr('id'));
	});
	var locationObjType = loc_type == "mail_client" ? Mail_ClientLoginsObj : DeviceLoginsObj;	//No I18N
	if(locationList.length != 0){		
		disabledButton("#Device_logins_pop .delete_location");
		new URI(locationObjType,"self","self",locationList).DELETE().then(function(resp){		//No I18N
			SuccessMsg(getErrorMessage(resp));
			removeButtonDisable("#Device_logins_pop .delete_location");			//No I18N
			loc_type == "mail_client" ? deletAllCallback([],locationList) : deletAllCallback(locationList,[]);	//No I18N
			locationList.length != $("#Device_logins_current_info>div").length ? $("#Device_logins_entry"+id).click() : closeview_selected_Device_logins_view();
		},function(resp){
			removeButtonDisable("#Device_logins_pop .delete_location");			//No I18N
			if(resp.cause && resp.cause.trim() === "invalid_password_token") 
			{
				relogin_warning();
				var service_url = euc(window.location.href);
				$("#new_notification").attr("onclick","window.open('"+contextpath + resp.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
			}
			else
			{
				showErrorMessage(getErrorMessage(resp));
			}
		});
	}
 }
 
 function closeview_selected_Device_logins_view()
 {
	 $("#display_all_Devices .checkbox_check").prop('indeterminate', false).prop('checked', false);
	 popupBlurHide("#Device_logins_pop");	//No I18N
 }
 
 
 
 function show_all_device_logins()
 {
	 $("#view_all_Device_logins").html($("#display_all_Devices").html()); //load into popuop
	 tooltip_Des("#view_all_Device_logins .action_icon");//No I18N
	 tooltip_Des("#view_all_Device_logins .asession_os");	//No I18N
	 popup_blurHandler('6');
		//$("#view_all_app_pass .authweb_entry").after( "<br />" );
		//$("#view_all_app_pass .authweb_entry").addClass("viewall_authwebentry");
		$("#view_all_Device_logins .devicelogins_entry").removeAttr("onclick");
		$("#view_all_Device_logins .devicelogins_entry").show();
		
		$("#Device_logins_web_more").show(0,function(){
			$("#Device_logins_web_more").addClass("pop_anim");
		});
		
		$("#view_all_Device_logins .devicelogins_entry").click(function(event)
		{
			if($(event.target).parents().hasClass("select_holder")){
				if($(event.target).parents(".select_holder").find(".checkbox_check")[0].checked && $(event.target).parents(".devicelogins_entry").find(".aw_info").is(":visible") || $(event.target).parents().hasClass("aw_info")){					
					return;
				}
			}
			var id=$(this).attr('id');
			
			tooltip_Des(".devicelogins_entry .aw_info .action_icon");//No I18N
			
			$("#view_all_Device_logins .devicelogins_entry").addClass("autoheight");
			$("#view_all_Device_logins .aw_info").slideUp(300);
			$("#view_all_Device_logins .activesession_entry_info").show();
			if($("#view_all_Device_logins #"+id).hasClass("Active_ip_showall_hover"))
			{

				$("#view_all_Device_logins #"+id+" .aw_info").slideUp("fast",function(){
					$("#view_all_Device_logins #"+id).removeClass("Active_ip_showall_hover");
					$("#view_all_Device_logins .devicelogins_entry").removeClass("autoheight");
					$("#view_all_Device_logins #"+id+" .info_tab").find(".current").show();
				});
				$("#view_all_Device_logins .activesession_entry_info").show();
			}
			else
			{
				$("#view_all_Device_logins .devicelogins_entry").removeClass("Active_ip_showall_hover");
				$("#view_all_Device_logins .devicelogins_entry").removeClass("Active_ip_showcurrent");
				$("#view_all_Device_logins #"+id).addClass("Active_ip_showall_hover");
				$("#view_all_Device_logins #"+id+" .aw_info").slideDown(300,function(){
					$("#view_all_Device_logins .devicelogins_entry").removeClass("autoheight");
					tooltipSet(".devicelogins_entry .aw_info .action_icon");//No I18N
				});
				$("#view_all_Device_logins #"+id+" .info_tab").find(".current").hide();
				$("#view_all_Device_logins #"+id+" .activesession_entry_info").hide();
		//		$("#view_all_allow_ip #"+id+" .primary_btn_check").focus();
			}
			
		});
		tooltipSet("#view_all_Device_logins .action_icon");//No I18N
		sessiontipSet("#view_all_Device_logins .asession_os");//No I18N
		closePopup(closeview_Device_logins_view,"Device_logins_web_more");//No I18N
		$("#Device_logins_web_more .select_holder").show();
		$("#display_all_Devices .checkbox_check").each(function(index){
			var par_ID = $($("#display_all_Devices .checkbox_check")[index]).parents(".select_holder").attr("id"); //No I18N
		    if($("#display_all_Devices .checkbox_check")[index].checked && !$("#display_all_Devices .checkbox_check")[index].indeterminate){
		    	$("#view_all_Device_logins #"+par_ID).find(".checkbox_check")[0].checked = true;
		    }
		    else if($("#display_all_Devices .checkbox_check")[index].checked && $("#display_all_Devices .checkbox_check")[index].indeterminate){
		    	$("#view_all_Device_logins #"+par_ID).find(".checkbox_check")[0].indeterminate = true;
		    }
		    else{
		    	$("#view_all_Device_logins #"+par_ID).find(".checkbox_check")[0].checked = false;
		    }
		});
		handleSelectAllFunction();
		$("#Device_logins_web_more").focus();
 }
 
 function showOneAuthTerminate(ele)
 {
 	 $('#include_oneauth').prop('checked', false);
 	 if(ele.checked && $("#ter_mob").hasClass("show_oneauth")){
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
 function closeview_Device_logins_view()
 {
	reflectPopupAction();
	$("#display_all_Devices .checkbox_check").prop('indeterminate', false).prop('checked', false);
 	popupBlurHide("#Device_logins_web_more",function(){		//No I18N
 		$("#view_all_Device_logins").html("");
 	});
 }
 
 function selectAllLocation(ele){
	 var limit_reached = showLimitOnPopup($(ele).parents("#Device_logins_pop").find("#Device_logins_current_info input").length);
	 if(ele.checked && !limit_reached){
		 $("#Device_logins_current_info .checkbox_check,#display_all_Devices #"+ele.name+" #device_check").prop('indeterminate', false).prop('checked', true);
		 $("#Device_logins_pop .deleteicon").hide();
	 }
	 else if(limit_reached && $("#Device_logins_current_info .checkbox_check:checked").length < 50){
		 $("#Device_logins_current_info .checkbox_check").prop('checked', false).prop('indeterminate', false);
		 $("#Device_logins_current_info .checkbox_check").slice(0,50).prop('checked', true).prop('indeterminate', false);	//No I18N
		 $("#display_all_Devices #"+ele.name+" #device_check,#Device_logins_pop #device_select_all").prop('checked', false).prop('indeterminate', true);
		 $("#Device_logins_pop .limit_reached_desc").html(formatMessage(i18nSessionkeys["IAM.DEVICELOGINS.REMOVE.LIMIT"],50)).show();	//No I18N
		 $("#Device_logins_pop .selected_count").hide();
		 $("#Device_logins_pop .deleteicon").show();
		 $("#Device_logins_pop .delete_location,#Device_logins_pop #deleted_selected_locations").show();
	 }
	 else{
		 $("#Device_logins_current_info .checkbox_check,#display_all_Devices #"+ele.name+" #device_check").prop('checked', false).prop('indeterminate', false);
		 $("#Device_logins_pop #deleted_selected_locations,#Device_logins_pop .selected_count").show();
		 $("#Device_logins_pop .deleteicon").show();
		 $("#Device_logins_pop .delete_location").hide();
	 }
     if($("#Device_logins_pop .checkbox_check").length == $("#Device_logins_pop .checkbox_check:checked").length){
     	 $("#Device_logins_pop #device_select_all").prop('checked', true);
	   	 reflectPopupAction();
		 handleSelectAllFunction();
     }
     else{
    	 $("#Device_logins_pop #device_select_all").prop('checked', false);
     }
	 showLimitOnPopup($("#Device_logins_current_info .devicelogins_devicedetails input:checked").length);
 }
 
 function validatePasswordPolicy(passwordPolicy) {
	passwordPolicy = passwordPolicy || security_data.Password.PasswordPolicy;
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
	 							err_rules.push(callback(rules[i], isInit ? formatMessage(err_pp_min_max, passwordPolicy.min_length.toString(), passwordPolicy.max_length.toString()) : undefined));
	 						}
	 						break;
	 					case 'SPL': //No I18N
	 						if((passwordPolicy.min_spl_chars > 0) &&  (((value.match(new RegExp("[^a-zA-Z0-9]","g")) || []).length) < passwordPolicy.min_spl_chars)) {
	 							err_rules.push(callback(rules[i], isInit ? formatMessage(passwordPolicy.min_spl_chars === 1 ? err_pp_spl_sing : err_pp_spl, passwordPolicy.min_spl_chars.toString()) : undefined));
	 						}
	 						break;
	 					case 'NUM': //No I18N
	 						if((passwordPolicy.min_numeric_chars > 0) &&  (((value.match(new RegExp("[0-9]","g")) || []).length) < passwordPolicy.min_numeric_chars)){
	 							err_rules.push(callback(rules[i], isInit ? formatMessage(passwordPolicy.min_numeric_chars === 1 ? err_pp_num_sing: err_pp_num, passwordPolicy.min_numeric_chars.toString()) : undefined));
	 						}
	 						break;
	 					case 'CASE': //No I18N
	 						if((passwordPolicy.mixed_case) && !((new RegExp("[A-Z]","g").test(value))&&(new RegExp("[a-z]","g").test(value)))) {
	 							err_rules.push(callback(rules[i], isInit ? err_pp_case : undefined));
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
 			p.textContent = err_pp_heading;
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
 	 			    	$('.hover-tool-tip').css("z-index","9");
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
 	 			    	$('.hover-tool-tip').css("z-index","-1");
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
 }
