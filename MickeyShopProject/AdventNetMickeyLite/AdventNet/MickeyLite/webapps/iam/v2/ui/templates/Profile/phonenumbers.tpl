 <script type="text/javascript">
	    var i18nMobkeys = {
	    		"IAM.PROFILE.PHONENUMBERS.ADD.NUMBER.DESCRIPTION" : '<@i18n key="IAM.PROFILE.PHONENUMBERS.ADD.NUMBER.DESCRIPTION" />',
	    		"IAM.VIEWMORE.NUMBER" : '<@i18n key="IAM.VIEWMORE.NUMBER" />',
				"IAM.VIEWMORE.NUMBERS" : '<@i18n key="IAM.VIEWMORE.NUMBERS" />',
				"IAM.MFA.MOBILE.CANT.DELETE" : '<@i18n key="IAM.MFA.MOBILE.CANT.DELETE" />',
				"IAM.MFA.MOBILE.CANT.DELETE.DESC" : '<@i18n key="IAM.MFA.MOBILE.CANT.DELETE.DESC" />',
				"IAM.MFA.GO.TO.MFA.SETTINGS": '<@i18n key="IAM.MFA.GO.TO.MFA.SETTINGS" />',
				"IAM.PHONENUMBERS.CAPTCHA.DESC" : '<@i18n key="IAM.PHONENUMBERS.CAPTCHA.DESC" />',
				"IAM.MOBILE.OTP.REMAINING.COUNT" : '<@i18n key="IAM.MOBILE.OTP.REMAINING.COUNT" />',
				"IAM.MOBILE.OTP.REMAINING.SINGLE.COUNT" : '<@i18n key="IAM.MOBILE.OTP.REMAINING.SINGLE.COUNT" />',
				"IAM.MOBILE.OTP.MAX.COUNT.REACHED" : '<@i18n key="IAM.MOBILE.OTP.MAX.COUNT.REACHED" />',
				"IAM.SIGNIN.ERROR.CAPTCHA.REQUIRED" : '<@i18n key="IAM.SIGNIN.ERROR.CAPTCHA.REQUIRED" />',
				"IAM.CONFIRM.POPUP.PHONENUMBER": '<@i18n key="IAM.CONFIRM.POPUP.PHONENUMBER" />'
		};
	</script>
		
			
				<div class="hide" id="phonenumber_popup_contents">
				
					<form  method="post" class="zform" id="phoneNumberform" onsubmit="return false;" novalidate>

						<div class="field full hide" id="empty_phonenumber">
	                  		<label class="textbox_label"><@i18n key="IAM.MOBILE.NUMBER" /></label>
	                  		<input class="textbox" data-validate="zform_field" name="phone_input_code" autocomplete="phonenumber" id="empty_phonenumber_input_code" maxlength="15" data-type="phonenumber" type="tel" >
	                  		<input type="hidden" id="empty_phonenumber_input" data-validate="zform_field" name="phone_input">
						</div>
						
						<div class="field full hide noindent" id="select_phonenumber">
	                  		<label class="textbox_label"><@i18n key="IAM.MOBILE.NUMBER" /></label>
	                  		<label for="countNameAddDiv" class="phone_code_label"></label>
	                  		<select id="countNameAddDiv" data-validate="zform_field" autocomplete='country-name' name="countrycode" class="countNameAddDiv" style="width: 67px;">
	                  			<#list country_code as dialingcode>
                          			<option data-num="${dialingcode.dialcode}" value="${dialingcode.code}" id="${dialingcode.code}" >${dialingcode.display}</option>
                           		</#list>
							</select>
							<input class="textbox select_phonenumber_input" tabindex="0" data-validate="zform_field" autocomplete="phonenumber" onkeypress="remove_error()" name="mobile_no" id="select_phonenumber_input" maxlength="15" data-type="phonenumber" type="tel" >
						</div>
						
						<input type="hidden" id="old_mob" data-validate="zform_field" name="old_phone">
						
						<div class="field full hide otp_field" id="otp_phonenumber">
	                  		<label class="textbox_label"><@i18n key="IAM.VERIFY.LABEL" /></label>
	                  		<div class="split_otp_container" id="otp_phonenumber_input"></div>
	                  		<div class="resend_with_block">
	                  			<span class="desc_about_block_otp"></span>
		                  		<div id="emailOTP_resend" class="otp_resend" onclick="resendverifyOTP(this);"><a href="javascript:;"><@i18n key="IAM.TFA.RESEND.OTP" /></a></div>
								<div class="resend_text otp_sent" style="display:none;" id="otp_sent"><@i18n key="IAM.GENERAL.OTP.SENDING" /></div>
							</div>
						</div>
						
						<div class="field full hide noindent" id="select_existing_phone">
	                  		<label class="textbox_label"><@i18n key="IAM.PHONE.NUMBER" /></label>
	                  		<select class="select_field" data-validate="zform_field" autocomplete="off" name="editscreenname" id="editscreenname">
							</select>
						</div>
						
						<div class="field hide noindent" id="captcha_container">
							<div class='box_blur hide'></div>
							<div class='loader hide'></div>
							<div id="captcha_img" name="captcha">
								<img id="hip" onload="loadCircleAnimation(false)">
							</div>
							<span class="reloadcaptcha icon-reload" id="reload" onclick="reloadCaptcha();removeCaptchaError()"></span>
							<input id="captcha" placeholder="Enter CAPTCHA" type="text" name="captcha" class="textbox" required autocapitalize="off" autocomplete="off" autocorrect="off" maxlength="8">
							<div class="captcha_field_error"></div>
						</div>
						<button tabindex="0" class="primary_btn_check" id="popup_mobile_action"><span></span></button>
						<button class="primary_btn_check high_cancel hide" id="add_mobile_back" tabindex="0" onclick="cancelOTPVerify()"><span><@i18n key="IAM.BACK" /> </span></button>
					</form>
				
				</div>
				
				
				
				
				
				
				<div class="hide popup" tabindex="0" id="addToRecovery">
					<div class="popup_header">
						<div class="popuphead_details">
							<span class="popuphead_text"><@i18n key="IAM.PHONE.NUMBER" /></span>
							<span class="popuphead_define"><@i18n key="IAM.PROFILE.PHONENUMBERS.ADD.NUMBER.DESCRIPTION" /></span>
						</div>
						<div class="close_btn" onclick="close_converttfa_popup()"></div>
					</div>
							
					<div id="add_ph_form">
	    				<form method="post" name="backup_to_recovery" id="backup_to_recovery" onsubmit="return false;" novalidate>   				
	 
		    				<div class="field full " id="select_existing_backup">
		                  		<label class="textbox_label"><@i18n key="IAM.MOBILE.TFA.BACKUP.PHONE_NUMBERS" /></label>
		                  		<select class="select_field" data-validate="zform_field" name="backupnumber" id="backupnumber" >
								</select>
								<span class="blue" onclick="show_add_mobilescreen('<@i18n key="IAM.ADD.PHONE.NUMBER" />','<@i18n key="IAM.PROFILE.PHONENUMBERS.ADD.NUMBER.DESCRIPTION" />','<@i18n key="IAM.ADD" />','addphonenum');" title="<@i18n key="IAM.ADDNEW" />"><@i18n key="IAM.ADDNEW" /></span>
							</div>
		                  	
							
							
							<button type="submit" class="primary_btn_check" onclick="switchBackupNoForRecovery(document.backup_to_recovery,newRecovery)" id="popup_mobile_action"><@i18n key="IAM.TFA.RCOVERY.SWITCH" /></button>
	    				</form>
    				</div>
    				
    			</div>
    			
    			
    			
    			
    			
    			
    			<div class="box big_box"  id="phnum_box">
    			
    						<div class="box_blur"></div>
							<div class="loader"></div>
					
					<div class="box_info">
						<div class="box_head"><@i18n key="IAM.MY.PHONENUMBERS" /></div>
						<div class="box_discrption"><@i18n key="IAM.PHONENUMBERS.DEFINITION" /></div>
					</div>
				
					<div id="no_phnum_add_here" class="box_content_div">
						<div id="add_mob_number_state">
							<div class="no_data no_data_SQ"></div>
							<div class="no_data_text hide"><@i18n key="IAM.PHONENUMBER.LIST.EMPTY" /> </div>	
							
							<button class="primary_btn_check  center_btn " id="add_newnobackup" onclick="show_add_mobilescreen('<@i18n key="IAM.ADD.PHONE.NUMBER" />','<@i18n key="IAM.PROFILE.PHONENUMBERS.ADD.NUMBER.DESCRIPTION" />','<@i18n key="IAM.ADD" />','addphonenum');" ><span><@i18n key="IAM.ADD.PHONE.NUMBER" /></span></button>
							
							<button class="primary_btn_check  center_btn hide" id="addfrom_backup" onclick="show_tfa_switch_mobilescreen();" ><span><@i18n key="IAM.USE.TFA.BACKUP.NUMBER.TO.RECOVERY" /></span></button>
						</div>
						<div class="hide" id="disabled_add_recovery">
							<div class="no_data disabled_trustedbrowser"></div>
							<div class="no_data_text"><@i18n key="IAM.PHONENUMBERS.DISABLED.DEFINITION" /></div>
						</div>
					</div>
							
					<div class="phone_number_content">
						<div class="recovery_disabled_tag hide">
							<span class="icon-warningfill"></span> 
							<p><@i18n key="IAM.PHONENUMBERS.DISABLED.TOP.INFO"/></p>
						</div>
						<div class="phonenumber_prim hide">
					
							<div class="field_mobile primary" id="mobile_num_0" onclick="for_mobile_specific('mobile_num_0')">
								<span class="mobile_dp icon-call"></span>
								<span class="mobile_info">
									<div class="emailaddress_text" id="primary_mobid"></div>
									<div class="emailaddress_addredtime" id="prim_mob_time"></div>
							<!--		<div class="emailaddress_addredtime primary_dot" title="Primary"><@i18n key="IAM.EMAIL.PRIMARY.PHONE" /></div>    -->
								</span>
								<span class="profile_tags primary_tag icon-Primary">
									<span class=" tooltiptext tooltiptext1">
										<span class="profile_tags primary_tag icon-Primary profile_tags_tooltip_icon"></span>
										<span class="profile_tags_tooltip_heading"><@i18n key="IAM.PRIMARY.NUMBER" /></span>
										<span class="profile_tags_tooltip_desc"> <@i18n key="IAM.PROFILE.PRIMARY.NUMBER.DESCRIPTION" /></span>
										<span class="tooltip_cta_text remove_cta"><@i18n key="IAM.PROFILE.REMOVE.NUMBER" /></span>
									</span>
								</span>
								<span class="profile_tags mfa_tag icon-tfaNum hide">
									<span class="tooltiptext tooltiptext2">
										<span class="profile_tags mfa_tag icon-tfaNum profile_tags_tooltip_icon"></span>
										<span class="profile_tags_tooltip_heading"><@i18n key="IAM.PROFILE.MFA.NUMBER.TEXT" /></span>
										<span class="profile_tags_tooltip_desc"> <@i18n key="IAM.PROFILE.MFA.NUMBER.DESCRIPTION" /></span>
										<span class="tooltip_cta_text mfa_settings" onclick="loadTab('multiTFA','modes');"><@i18n key="IAM.MFA.SETTING" /></span>
										<span class="tooltip_cta_text set_as_recovery hide"><@i18n key="IAM.PROFILE.PHONENUMBER.MARK.AS.RECOVERY" /></span>
									</span>
								</span>
								<span class="profile_tags recovery_tag icon-recoveryNum hide">
									<span class="tooltiptext tooltiptext3">
										<span class="profile_tags recovery_tag icon-recoveryNum profile_tags_tooltip_icon"></span>
										<span class="profile_tags_tooltip_heading"><@i18n key="IAM.PROFILE.RECOVERY.NUMBER.TEXT" /></span>
										<span class="profile_tags_tooltip_desc"> <@i18n key="IAM.PROFILE.RECOVERY.NUMBER.DESCRIPTION" /></span>
									</span>
								</span>
								
								<div class="phnum_hover_show" id="phonenumber_info0">
									<span class="action_icons_div_ph">
									<span class="resendconfir action_icon icon-swapNum" id="swap_number" title="<@i18n key="IAM.PROFILE.PHONENUMBER.SWAP.NUMBER.TEXT" />" ></span>
									<span class="deleteicon action_icon icon-delete" id="ph_icon_delete_0" title="<@i18n key="IAM.DELETE" />" onclick="deleteMobile('<@i18n key="IAM.CONFIRM.POPUP.PHONENUMBER" />');"></span>
									</span>
								</div>
							</div>
							
						</div>
						
						<div class="phonenumber_sec"></div>
						
						<div class="phonenumber_unverfied"></div>
						
						<div class="phonenumber_tfa"></div>
					</div>
					
					
					<div id="phone_add_view_more" class="hide">
						<div class="view_more half" id="view_only" onclick="show_all_phonenumbers()"><span><@i18n key="IAM.VIEWMORE.NUMBER" /></span></div> 
						
						<div class="addnew half" id="addphone" onclick="show_add_mobilescreen('<@i18n key="IAM.ADD.PHONE.NUMBER" />','<@i18n key="IAM.PROFILE.PHONENUMBERS.ADD.NUMBER.DESCRIPTION" />','<@i18n key="IAM.ADD" />','addphonenum');"><@i18n key="IAM.ADD.PHONE.NUMBER" /></div>
						<div class="addnew half" id="addTFAphone" onclick="show_tfa_switch_mobilescreen();"><@i18n key="IAM.ADD.PHONE.NUMBER" />	</div>				
					</div>
					
					<div class="addnew separate_addnew hide" id="addphoneonly" onclick="show_add_mobilescreen('<@i18n key="IAM.ADD.PHONE.NUMBER" />','<@i18n key="IAM.PROFILE.PHONENUMBERS.ADD.NUMBER.DESCRIPTION" />','<@i18n key="IAM.ADD" />','addphonenum');"><@i18n key="IAM.ADD.PHONE.NUMBER" /></div>
					
					<div class="addnew separate_addnew hide" id="addTFAphoneonly" onclick="show_tfa_switch_mobilescreen();"><@i18n key="IAM.ADD.PHONE.NUMBER" /></div>					
					
				</div>
				
				
				
				
				
				<div id="empty_phone_format" class="hide">
					
					<div class="field_mobile secondary" id="sec_phoneDetails" onclick="for_mobile_specific('mobile_num_0000') ">
						
						<span class="mobile_dp icon-call"></span>   
						<span class="mobile_info">
							<div class="emailaddress_text"></div>
							<div class="emailaddress_addredtime"><@i18n key="IAM.UNVERIFIED" /></div>
						</span>
						<span class="profile_tags recovery_tag icon-recoveryNum">
							<span class=" tooltiptext tooltiptext1">
								<span class="profile_tags recovery_tag icon-recoveryNum profile_tags_tooltip_icon"></span>
								<span class="profile_tags_tooltip_heading"><@i18n key="IAM.PROFILE.RECOVERY.NUMBER.TEXT" /></span>
								<span class="profile_tags_tooltip_desc"> <@i18n key="IAM.PROFILE.RECOVERY.NUMBER.DESCRIPTION" /></span>
							</span>
						</span>
						<span class="profile_tags mfa_tag icon-tfaNum">
							<span class=" tooltiptext tooltiptext1">
								<span class="profile_tags mfa_tag icon-tfaNum profile_tags_tooltip_icon"></span>
								<span class="profile_tags_tooltip_heading"><@i18n key="IAM.PROFILE.MFA.NUMBER.TEXT" /></span>
								<span class="profile_tags_tooltip_desc"> <@i18n key="IAM.PROFILE.MFA.NUMBER.DESCRIPTION" /></span>
								<span class="tooltip_cta_text mfa_settings" onclick="loadTab('multiTFA','modes');"><@i18n key="IAM.MFA.SETTING" /></span>
								<span class="tooltip_cta_text set_as_recovery hide"><@i18n key="IAM.PROFILE.PHONENUMBER.MARK.AS.RECOVERY" /></span>
							</span>
						</span>
						
				<!--		<span class="profile_tags sec_mfa_tag icon-tfaNum">
							<span class=" tooltiptext tooltiptext1">
								<span class="profile_tags sec_mfa_tag icon-tfaNum profile_tags_tooltip_icon"></span>
								<span class="profile_tags_tooltip_heading">TFA Number</span>
								<span class="profile_tags_tooltip_desc"> <@i18n key="IAM.PROFILE.PRIMARY.NUMBER.DESCRIPTION" /></span>
							</span>
						</span> -->
						
						<div class="phnum_hover_show" id="phonenumber_infohover">   
							<span class="action_icons_div_ph">
							
								<span class="verify_icon resendconfirm Mob_resend_confirmation">
	                				<div class="icon-verify"></div>
	                				<div class="resend_options" style="display:none;">
		                				<div class="resend_space">
		                					<div class="resend_mob_text"></div>
		                					<div class="resend_grn_btn"><@i18n key="IAM.SEND.OTP" /></div>
		                				</div>
		                			</div>
	                			</span>

							<!--	<span class="resendconfir action_icon icon-makeprimary" id="icon-primary" title="<@i18n key="IAM.MYEMAIL.MAKE.PRIMARY" />" onclick="showmake_prim_mobilescreen('<@i18n key="IAM.MODIFY.LOGIN.NAME" />','<@i18n key="IAM.PROFILE.PHONENUMBERS.MAKE.PRIMARY.POPUP.DESCRIPTION" />','<@i18n key="IAM.UPDATE" />');"></span>
																
								<span class="action_icon icon-delete"  title='<@i18n key="IAM.REMOVE" />' onclick="deleteMobile('<@i18n key="IAM.CONFIRM.POPUP.PHONENUMBER" />');"></span> -->

								<span class="mkeprimary action_icon icon-Primary" id="icon-primary" onclick="showmake_prim_mobilescreen('<@i18n key="IAM.MODIFY.LOGIN.NAME" />','<@i18n key="IAM.PROFILE.PHONENUMBERS.MAKE.PRIMARY.POPUP.DESCRIPTION" />','<@i18n key="IAM.UPDATE" />');">
									<span class="set_signinNum_txt"><@i18n key="IAM.PROFILE.PHONENUMBER.SET.SIGNIN.NUMBER" /></span>
								</span>									
								<span class="resendconfir action_icon icon-swapNum" id="swap_number" title="<@i18n key="IAM.PROFILE.PHONENUMBER.SWAP.NUMBER.TEXT" />" ></span>							
								<span class="action_icon icon-delete"  title='<@i18n key="IAM.DELETE" />' onclick="deleteMobile('<@i18n key="IAM.CONFIRM.POPUP.PHONENUMBER" />');"></span>
							
							</span>
						</div>
					</div>
				
				</div>
				
				
				<div id="profile_popup" class="pp_popup common_center_popup hide" tabindex="1">
				<form method="post" class="zform" name="swapnumber" onsubmit="return false;" novalidate>
					<div class="popup_header common_center_popup">
						<div id="phn_details" class="top_popup_header">
							<span class="mobile_dp icon-call"></span>   
							<span class="mobile_info">
								<div class="emailaddress_text"></div>
								<div class="emailaddress_addredtime"><@i18n key="IAM.UNVERIFIED" /></div>
							</span>
						</div>
						<div class="profile_popup_body">
							<div class="popuphead_details">
							<!--	<span class="popuphead_text"><@i18n key="IAM.PROFILE.PHONENUMBER.SWAP.DESCRIPTION"/></span> -->
								<span class="popuphead_define"><@i18n key="IAM.PROFILE.PHONENUMBER.SWAP.DESCRIPTION"/></span>
							</div>
							
							<div class="radiobtn_div swapNum_radiobtn_div" id="recovery_div">
								<input class="real_radiobtn swapNum_radiobtn" type="radio" name="phnNum_type" id="recoveryNum" value="recoveryNum" checked="checked">
								<div class="outer_circle swapNum_outer_circle">
								<div class="inner_circle swapNum_inner_circle"></div></div>
								<label class="radiobtn_text swapNum_radiobtn_text recovery_heading" for="recoveryNum"><@i18n key="IAM.PROFILE.RECOVERY.NUMBER"/></label>
								<div></div>
								<div class="radiobtn_text swapNum_description swapNum_description_recovery"> <span class="recovery_desc"><@i18n key="IAM.PROFILE.RECOVERY.NUMBER.DESCRIPTION"/></span><span class="recovery_disabled_desc"><@i18n key="IAM.PHONENUMBERS.RECOVERY.DISABLE.CHECKBOX.TEXT"/></span> </div>
							</div>
							<div class="radiobtn_div swapNum_radiobtn_div" id="mfa_div">
								<input class="real_radiobtn swapNum_radiobtn" type="radio" name="phnNum_type" id="mfaNum" value="mfaNum" >
								<div class="outer_circle swapNum_outer_circle">
								<div class="inner_circle swapNum_inner_circle"></div></div>
								<label class="radiobtn_text swapNum_radiobtn_text mfa_heading" for="mfaNum"><@i18n key="IAM.PROFILE.MFA.NUMBER"/></label>
								<div></div>
								<div class="radiobtn_text swapNum_description swapNum_description_mfa"> <@i18n key="IAM.PROFILE.MFA.NUMBER.DESCRIPTION"/> </div>
							</div>
							
							<div class="phnNum_warning">
								<div class="recovery_warning"><@i18n key="IAM.PROFILE.RECOVERY.NUMBER.WARNING"/> <span class="mfa_settings" onclick="loadTab('multiTFA','modes');"><@i18n key="IAM.PROFILE.MFA.CONFIGURE.NOW"/></span></div>
								<div class="mfa_warning"><@i18n key="IAM.PROFILE.MFA.NUMBER.WARNING"/><span class="mfa_settings" onclick="loadTab('multiTFA','modes');"><@i18n key="IAM.MFA.SETTING"/></span></div>
							</div>
							
							<button type="submit" class="primary_btn_check" id="swap_mobile_action"><@i18n key="IAM.CONFIRM" /></button>
							<button tabindex="1" class="primary_btn_check  cancel_btn" id="swap_popup_close" onclick="close_profile_popupscreen()"><span><@i18n key="IAM.CANCEL"/></span></button>
							<div class="close_btn" onclick="close_profile_popupscreen()"></div>
						</div>
					</div>
					<div id="pop_action"></div>
					</form>
				</div>
			
				
				
				
				<div class="viewall_popup hide popupshowanimate_2" tabindex="1" id="phonenumber_web_more">
					
					<div class="box_info">
						<div class="expand_closebtn" onclick="closeview_all_phonenumber_view()"></div>
						<div class="box_head"><@i18n key="IAM.MY.PHONENUMBERS" /></div>
						<div class="box_discrption"><@i18n key="IAM.PHONENUMBERS.DEFINITION" /></div>
					</div>
					
					<div class="viewall_popup_content" id="view_all_phonenumber"></div>
					
				</div>