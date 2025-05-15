<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN" "http://www.w3.org/TR/REC-html40/frameset.dtd">
 <script type="text/javascript">

 var i18nConnectedAppskeys = {
	    		"IAM.VIEWMORE.APPLICATION" : '<@i18n key="IAM.VIEWMORE.APPLICATION" />',
				"IAM.VIEWMORE.APPLICATIONS" : '<@i18n key="IAM.VIEWMORE.APPLICATIONS" />'
		};
 </script>

		<div class=" hide popup" tabindex="1" id="Connected_apps_pop">
		
			<div class="device_div on_popup">
				<span class="device_pic"></span>
				<span class="device_details">
					<span class="device_name range_name"></span>					
					<span class="device_time"></span>
					
				</span>
			</div>
			
			<div class="close_btn" onclick="closeview_selected_connected_apps_view()"></div>

			<div id="connected_app_current_info">
			</div>
			
		</div>





		<div class="box big_box" id="Connected_apps_box">
		
			<div class="box_blur"></div>
			<div class="loader"></div>
	
			 <div class="box_info">
				<div class="box_head"><@i18n key="IAM.CONNECTEDAPPS" /><span class="icon-info"></span></div>
				<div class="box_discrption"><@i18n key="IAM.CONNECTEDAPPS.DESCRIPTION" /> </div>
			</div>
			
			 
			<div id="show_connected_apps">
			
				<div id="no_connected_apps" class="box_content_div hide">
					<div class="no_data no_data_SQ"></div>
					<div class="no_data_text" id="nodata_withTFA"><@i18n key="IAM.CONNECTEDAPPS.NOT_PRESENT" /></div>
				</div>
				
				<div id="display_connected_apps" class="hide">
				
				</div>
				
			</div>
			
			<div class="view_more hide" id="connected_apps_view" onclick="show_all_connnected_apps();" ><span><@i18n key="IAM.VIEWMORE.INFO" /></span></div>	
		
		</div>
		
		
		
		<div class="hide viewall_popup popupshowanimate_2" tabindex="1" id="connected_apps_web_more" >
	
			
			<div class="box_info">
				<div class="expand_closebtn" onclick="closeview_connected_apps_view()"></div>
				<div class="box_head"><@i18n key="IAM.CONNECTEDAPPS" /><span class="icon-info"></span></div>
				<div class="box_discrption"><@i18n key="IAM.CONNECTEDAPPS.DESCRIPTION" /> </div>
			</div>
						
			<div id="view_all_connected_apps" class="all_elements_space"></div>
		</div>
		
		
		
		
		
		
		
		<div id="empty_connected_apps_format" class="hide">
			
			<div class="Field_session" id="connected_apps_entry">

				<div class="info_tab">	
					<div class="device_div">
						<div class="select_holder hide">
							<input data-validate="zform_field" id="ter_all" name="signoutfromweb" class="checkbox_check" type="checkbox">
							<span class="checkbox">
								<span class="checkbox_tick"></span>
							</span>
						</div>							
						
						<span class="device_pic"></span>
						<span class="device_details">
							<span class="device_name field_value"></span>
							<span class="device_time"></span>
						</span>
					</div>
					
					<div class="activesession_entry_info">
						
						<div class="asession_location location_unavail">
							<span class="DC_detail"></span> <@i18n key="IAM.DC"/>
							<span class="icon-info" onmouseover="showToopTip(this,'<@i18n key="IAM.CONNECTEDAPPS.TOOLTIP.CONTENT.ABOUT.LOCATION" />')" onmouseout="hideTooltip()"></span>
						</div>

						<div class="asession_action connected_app_delete" onclick=""><@i18n key="IAM.AUTHORIZED.WEBSITES.REVOKEACCESS" /></div>
					</div>
					
				</div>
				
				<div class="aw_info" id="connected_apps_info">
					<span class="app_details">
					<div class="info_div">
						<div class="info_lable"><@i18n key="IAM.CONNECTEDAPPS.LABEL.APP.DC" /> </div>
						<div class="info_value" id="pop_up_app_DC">
							<span class="DC_text"></span> <@i18n key="IAM.DC"/>
							<span class="icon-info" onmouseover="showToopTip(this,'<@i18n key="IAM.CONNECTEDAPPS.TOOLTIP.CONTENT.ABOUT.LOCATION" />')" onmouseout="hideTooltip()"></span>
						</div>
					</div>
					
					<div class="info_div">
						<div class="info_lable"><@i18n key="IAM.CONNECTEDAPPS.LABEL.APPROVED.ON" /> </div>
						<div class="info_value" id="pop_up_time"></div>
					</div>
					
					<div class="info_div">
						<div class="info_lable"><@i18n key="IAM.CONNECTEDAPPS.LABEL.APPROVED.IP" /> </div>
						<div class="info_value" id="pop_up_ip"></div>
					</div>

					<div class="info_div">
						<div class="info_lable"><@i18n key="IAM.CONNECTEDAPPS.LABEL.APPROVED.LOCATION" /> </div>
						<div class="info_value unavail" id="pop_up_location"><@i18n key="IAM.SESSIONS.LOCATION.UNAVAILABLE" /> </div>
					</div>
					
					<button class="primary_btn_check negative_btn_red" id="delete_current_app"><span><@i18n key="IAM.AUTHORIZED.WEBSITES.REVOKEACCESS" /></span></button>
					</span>
					<span class="deleteConfirmFromViewAll" style="display:block;">
						<div class="confirm_text dlt_confirm_text"><@i18n key="IAM.CONNECTEDAPPS.CONFIRM.POPUP.TEXT"/></div>
						<button class="primary_btn_check negative_btn_red" id="delete_connected_app"><span><@i18n key="IAM.SIGNOUT.BUTTON.PROCEED" /></span></button>
						<button class="primary_btn_check cancel_btn" id="cancel_action" onclick="closeRevokeConfirm()"><span><@i18n key="IAM.CANCEL" /></span></button>
					</span>
				</div>
				
			</div>
				
		</div>
		