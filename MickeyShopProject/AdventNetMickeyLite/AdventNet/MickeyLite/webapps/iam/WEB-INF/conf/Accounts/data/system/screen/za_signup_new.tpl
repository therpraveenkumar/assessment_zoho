<!DOCTYPE html>
<html>
<head>
<title><@i18n key="IAM.CREATE.ZACCOUNT" /></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script type="text/javascript" src="${za.iam_contextpath}/register/script?${signup.scriptParams}&loadcss=false&tvisit=true"></script>
<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")}" type="text/javascript"></script>
<link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
<link href="${SCL.getStaticFilePath("/accounts/css/signupnew.css")}" type="text/css" rel="stylesheet" />
<link href="${SCL.getStaticFilePath("/accounts/css/flagStyle.css")}" type="text/css" rel="stylesheet"/>
<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/select2.full.min.js")}" type="text/javascript"></script>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
</head>
<body <#if signup.isDarkmode == 1> class="darkmode"</#if> style="visibility: hidden;">
<#if signup.isEnabled>
	<div class="bg_one"></div>
	<div class="Alert"> <span class="tick_icon"></span> <span class="alert_message"></span> </div>
	<div align="center" class="main container">
		<div class="inner-container">
					<#if partner.isPartnerLogoExist>
						<div><img class="partnerlogo" src="/static/file?t=org&ID=${partner.partnerId}" /></div>
					<#else>
						<div class='zoho_logo'></div>
    				</#if>
    				<div class="signuptitle"><@i18n key="IAM.NEW.SIGNUP.TITLE"/></div>
    		<div id="formcontainer">		
				<form action="${za.contextpath}/register.ac" name="signupform" method="post" class="form">
					<section class="signupcontainer">
						<dl class="za-region-container">
							<dd>
								<span><@i18n key="IAM.NEW.SIGNUP.REGION.DATA.HEADER" /></span>	
							<dd>
						</dl>
						<dl class="za-fullname-container">
	     					<dd>
	     						<div class="name_division" style="margin-right: 5%">
	     							<input type="text" placeholder='<@i18n key="IAM.FIRST.NAME" />' name="firstname" maxlength="100" id="firstname" onblur="validateFirstName(this)" />
	     						</div>
	     						<div class="name_division">
	     							<input type="text" placeholder='<@i18n key="IAM.LAST.NAME" />' name="lastname" maxlength="100" id="lastname" onblur="validateLastName(this)" />
	     						</div>
	     					</dd>
	     				</dl>
	     				<dl class="za-username-container">
	     					<dd>
	     						<input type="text" placeholder='<@i18n key="IAM.GENERAL.USERNAME" />' name="username" maxlength="100" />
	     					</dd>
	     				</dl>
	     				<dl class="za-emailormobile-container">
	     					<dd>
	     						<div class="za-country_code-container">
									<select class="form-input1 countryCnt1 za-country-select-code" name="country_code" id="country-emailormobile" ></select>
								</div>
	     						<input type="text" placeholder='<@i18n key="IAM.EMAIL.ADDRESS.OR.MOBILE" />'onkeyup ="checking()" onkeydown="checking()" name="emailormobile" maxlength="100" id="phonenumber">
	     					</dd>
	     				</dl>	
	     				<dl class="za-mobile-container">
		     				<dd>
		     					<div class="za-country_code-container">
		     						<label for='country_code_select' class='select_country_code'></label>
									<select class="form-input1 countryCnt1 za-country-select-code" name="country_code" id="country-code" ></select>
								</div>
								<input type="text" placeholder='<@i18n key="IAM.PHONE.NUMBER" />' onkeyup ="checking()" onkeydown="checking()" name="mobile" id="mobilefield"  >
							</dd>
						</dl>	
						<dl class="za-rmobile-container">
							<dd>
		     					<div class="za-country_code-container">
									<select class="form-input1 countryCnt1 za-country-select-code" name="country_code" id="country-coderecovery" ></select>
								</div>
								<input type="text" placeholder='<@i18n key="IAM.PHONE.NUMBER" />' onkeyup ="checking()" name="rmobile" id="rmobilefield" >
							</dd>
						</dl>		
						<dl class="za-email-container">
							<dd>
								<#if signup.emailId?has_content>
									<input type="text" placeholder='<@i18n key="IAM.EMAIL.ADDRESS" />' name="email" class="form-input" id="emailfield"  value="${signup.emailId}" >
								<#else>
									<input type="text" placeholder='<@i18n key="IAM.EMAIL.ADDRESS" />' name="email" class="form-input" id="emailfield"  >
								</#if>
								<div class="za-orguser-container">
               						<div>
                       					<label for="orguser" class="orguser-check">
                              				<span class="icon-medium unchecked" id="signup-orguser"></span>
      										<span class="orguser_con"></span>
											<input class="za-orguser" type="checkbox" id="orguser" name="orguser" value="true" onclick="toggleOrgCheckField()"/>
										</label>
                 					</div>
       							</div>
							</dd>
						</dl>
						<dl class="za-password-container">
							<dd>
								<input type="password" placeholder='<@i18n key="IAM.PASSWORD" />' name="password" id="password" class="form-input" onblur="$('.pwderror').hide()" onkeyup="checkPasswordStrength()" >
								<span class="icon-hide show_hide_password"  id="show-password-icon" onclick=togglePasswordField(${signup.minpwdlen});></span>
								<div class="pwderror"></div>
							</dd>
						</dl>
						<dl class="za-country-container" style="display:none">
							<dd>
								<select class="form-input countryCnt za-country-select" name="country" id="country" onchange="changeDomainName(this.value);return false;"  placeholder='<@i18n key="IAM.TFA.SELECT.COUNTRY" />' ></select>
							</dd>
						</dl>
						<dl class="za-country_state-container" style="display:none">
							<dd>
								<select class="form-input countryCnt" name="country_state" id="country_state"></select>
							</dd>
						</dl>
						<dl class="za-captcha-container" style='position:relative;'>
							<dd>
								<input type="text" placeholder='<@i18n key="IAM.NEW.SIGNIN.ENTER.CAPTCHA" />' name="captcha" maxlength="10" class="form-input" id="captchafield"> 
								<div class="form-input" style="text-align:left">
								<div class='captcha_container'>
									<img src="${za.contextpath}/images/spacer.gif" class="za-captcha">
									<span class="za-refresh-captcha" onclick="changeHip(document.signupform)"></span></div>
								</div>
							</dd>
						</dl>
						<dl class="za-domain-container" style="display:none;">
							<dd>
								<div class='domain_text'>
									<span><@i18n key="IAM.NEW.SIGNUP.DOMAIN.CHANGE.DESC" /></span>
								</div>
							</dd>
						</dl>
						<dl class="za-tos-container">
								<dd>
									<label for="tos" class="tos-signup">
										<span class="icon-medium unchecked" id="signup-termservice"></span>
		                           	 	<span><@i18n key="IAM.SIGNUP.AGREE.TERMS.OF.SERVICE" arg0="${signup.termsOfServiceUrl}" arg1="${signup.privacyPolicyUrl}"/></span>
		                            	<input class="za-tos" type="checkbox" id="tos" name="tos" value="true" onclick="toggleTosField()"/>
		                       	 </label>
								</dd>
							</dl>
						<dl class="za-newsletter-container" style="display:none">
							<dd>
								<label for="newsletter" class="news-signup">
	                            	<input class="za-newsletter" type="checkbox" id="newsletter" name="newsletter" value="true" onclick="toggleNewsletterField()"/>
	                            	<span class="icon-medium icon-checkbox_on" id="signup-newsletter"></span>
	                           	 <span><@i18n key="IAM.TPL.ZOHO.NEWSLETTER.SUBSCRIBE1"/></span>
	                       	 </label>
							</dd>
						</dl>
						<div class="clearBoth"></div>
						<dl class="za-submitbtn">
							<dd>
								<button class="signupbtn" id="nextbtn" onclick="return validateInputFeilds();"><span><@i18n key="IAM.LINK.SIGNUP.SIGNUP"/></span></button>
								<div class="loadingImg"></div>
							</dd>
						</dl>
				</section>
				<div class="fed_2show_small" onclick="showMoreIdps();"></div>
				<div class="fed_2show">
					<div class="signin_fed_text"><@i18n key="IAM.NEW.SIGNUP.FEDERATED.LOGIN.TITLE"/></div>
					<div id="feddivparent"></div>
				</div>
				<section class="signupotpcontainer" style="display:none">
							<div class="verifytitle"><@i18n key="IAM.NEW.SIGNUP.VERIFY.TITLE"/></div>
							<div class="verifyheader"><@i18n key="IAM.NEW.SIGNUP.MOBILE.VERIFY.DESC"/></div>
							<div class="otpmobile">
								<span id="mobileotp"></span>
								<span class="change" onclick="gobacktosignup()"><@i18n key="IAM.PHOTO.CHANGE"/></span>
							</div>
							<dl class="za-otp-container">
								<dd>
									<input type="text" class="form-input" name="otp" id="otpfield" placeholder='<@i18n key="IAM.VERIFY.CODE" />' >
									<span onclick="resendOTP()" class="resendotp"><@i18n key="IAM.SIGNUP.RESEND.OTP" /></span>
								</dd>
							</dl>
							<dl class="za-submitbtn-otp">
								<dd>
									<input type="button" class="signupbtn"  value='<@i18n key="IAM.NEW.SIGNIN.VERIFY" />' onclick="validateOTP()" name="otpfield">
									<div class="loadingImg"></div>
								</dd>
							</dl>
				</section>
				</form>
			</div>
		</div>
	</div>
	<#include "footer.tpl">
</#if>
<script type="text/javascript">
	 	function onSignupReady() {
	 		var fedlist = ${signup.fedlist};
	 		var gVerify = parseInt(${signup.isGoogleVerifyNeeded});
	 		if(fedlist.indexOf("apple") != -1 && gVerify != 1){
	 			fedlist.splice(fedlist.indexOf("apple"), 1);
	 			fedlist.unshift("apple");
	 		}
	 		var fedElem = '';
	 		fedlist.forEach(function(fed,fedindex){
	 		var fontIconIdpNameToHtmlElement = {
	 		 	"GOOGLE":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>',
	 		 	"MICROSOFT":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>',
	 		 	"LINKEDIN":'', // no i18n
	 		 	"FACEBOOK":'', // no i18n
	 		 	"TWITTER":'', // no i18n
	 		 	"YAHOO":'', // no i18n
	 		 	"SLACK":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>',
	 		 	"DOUBAN":'', // no i18n 
	 		 	"QQ":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span>',
	 		 	"WECHAT":'', // no i18n
	 		 	"WEIBO":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span>',
	 		 	"BAIDU":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span>',
	 		 	"APPLE":'', // no i18n
	 		 	"INTUIT":'', // no i18n
	 		 	"ADP":'', // no i18n
	 		 	"FEISHU":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span>',
	 		 	"ZOHO_FS":'',//no i18n
	 		 	"GITHUB":''//no i18n
	 		 }
	 			if(fed == 'google'){
	 			fedElem += "<div class='"+fed+"_fed fed_div small_box' onclick=FederatedSignIn.GO('"+fed+"') title='<@i18n key="IAM.FEDERATED.SIGNUP.TITLE" arg0='"+fed+"' />'><div style='width:max-content;margin:auto'><span class='fed_google_large'><span class='"+fed+"_fed_icon fed_icon icon2-"+fed+"_small'>"+fontIconIdpNameToHtmlElement[fed.toUpperCase()]+"</span></span></span><span class='"+fed+"_text fed_text largeGoogleText'>"+"<@i18n key="IAM.FEDERATED.SIGNIN.WITH.GOOGLE"/>"+"</span><span class='"+fed+"_text fed_text smallGoogleText'>"+"<@i18n key="IAM.IDENTITY.PROVIDER.NAME.GOOGLE"/>"+"</span></div></div>"
	 			}
	 			else if(fed == 'slack'||fed == 'apple'||fed == 'microsoft'||fed == 'twitter'||fed == 'apple'||fed == 'yahoo'){
	 			fedElem += "<div class='"+fed+"_fed fed_div small_box' onclick=FederatedSignIn.GO('"+fed+"') title='<@i18n key="IAM.FEDERATED.SIGNUP.TITLE" arg0='"+fed+"' />'><div style='width:max-content;margin:auto'><span class='"+fed+"_fed_icon fed_icon icon2-"+fed+"_small'>"+fontIconIdpNameToHtmlElement[fed.toUpperCase()]+"</span></span><span class='"+fed+"_text fed_text'>"+"<@i18n key="IAM.NEW.SIGNIN.SAML.TITLE"  arg0='"+fed+"'/>"+"</span></div></div>"
	 			}
	 			else if(fed == 'facebook'){
	 			fedElem += "<div class='"+fed+"_fed fed_div small_box' onclick=FederatedSignIn.GO('"+fed+"') title='<@i18n key="IAM.FEDERATED.SIGNIN.WITH.FACEBOOK" arg0='"+fed+"' />'><div style='width:max-content;margin:auto'><span class='"+fed+"_fed_icon fed_icon icon2-"+fed+"_small'>"+fontIconIdpNameToHtmlElement[fed.toUpperCase()]+"</span></span><span class='"+fed+"_text fed_text'>"+"<@i18n key="IAM.FEDERATED.SIGNIN.WITH.FACEBOOK"/>"+"</span></div></div>"
	 			}
	 			else if(fed == 'github'){
	 			fedElem += "<div class='"+fed+"_fed fed_div small_box' onclick=FederatedSignIn.GO('"+fed+"') title='<@i18n key="IAM.FEDERATED.SIGNIN.WITH.GITHUB" arg0='"+fed+"' />'><div style='width:max-content;margin:auto'><span class='"+fed+"_fed_icon fed_icon icon2-"+fed+"_small'>"+fontIconIdpNameToHtmlElement[fed.toUpperCase()]+"</span></span><span class='"+fed+"_text fed_text'>"+"<@i18n key="IAM.FEDERATED.SIGNIN.WITH.GITHUB"/>"+"</span></div></div>"
	 			}
	 			else if(!fed.includes('_fs')){
	 			fedElem += "<div class='"+fed+"_fed fed_div small_box' onclick=FederatedSignIn.GO('"+fed+"') title='<@i18n key="IAM.FEDERATED.SIGNUP.TITLE" arg0='"+fed+"' />'><div style='width:max-content;margin:auto'><span class='"+fed+"_fed_icon fed_icon icon2-"+fed+"_small'>"+fontIconIdpNameToHtmlElement[fed.toUpperCase()]+"</span><span class='"+fed+"_text fed_text'>"+fed+"</span></div></div>"
	 			}
	 		});
	 		fedElem += '<span class="fed_div more" id="showIDPs" title="<@i18n key="IAM.FEDERATED.SIGNIN.MORE"/>" onclick="showMoreIdps();"> <span class="morecircle"></span> <span class="morecircle"></span> <span class="morecircle"></span></span><div class="zohosignin" onclick="showZohoSignin()"><@i18n key="IAM.NEW.SIGNUP.USING.ZOHO"/><span class="fedarrow"></span></div>'
	 		$('#feddivparent').html(fedElem);
	 		if(fedlist.indexOf("apple") != -1 && gVerify != 1){
	 			$(".google_text").hide();
	 			$(".google_icon").css("margin-left","3px");
	 			$(".google_fed_icon").addClass("google_small_icon show_small_icon");
	 		}
	 		fedCheck();
			$(document.body).css("visibility", "visible");
			$(document.signupform).zaSignUp();
			var countrySelect = $(".za-rmobile-container").is(":visible") ? "country-coderecovery" : $(".za-mobile-container").is(":visible") ? "country-code": $(".za-emailormobile-container").is(":visible") ? "country-emailormobile":"";
			 if(countrySelect){
				$("#"+countrySelect).select2({
			        allowClear: true,
			        templateResult: format,
			        searchInputPlaceholder: '<@i18n key="IAM.SEARCH"/>',
			        templateSelection: function (option) {
			        	  selectFlag($("#"+countrySelect).find("option:selected"));
			              return option.text;
			        },
			        language: {
				        noResults: function(){
				            return '<@i18n key="IAM.NO.RESULT.FOUND"/>';
				        }
				    },
			        escapeMarkup: function (m) {
			          return m;
			        }
			      });
			      $("#"+countrySelect+"+.select2 .select2-selection").append("<span id='selectFlag' class='selectFlag'></span>");
			      selectFlag($("#"+countrySelect).find("option:selected"));
			      $("#"+countrySelect).addClass("select2_used_tag");
			      $("#select2-"+countrySelect+"-container").html($("#"+countrySelect+" option:selected").attr("data_number"));
	      		 $(".select_"+countrySelect).html($("#"+countrySelect+" option:selected").attr("data_number"));
	      		 $("#"+countrySelect).change(function(){
			        $(".country_code").html($("#"+countrySelect+" option:selected").attr("data_number"));
			        $("#select2-"+countrySelect+"-container").html($("#"+countrySelect+" option:selected").attr("data_number"));
			     	setIndent($("#"+countrySelect).parent().siblings("input"));
		      });
		     }
		     if($(".za-country-container").is(":visible") || (typeof isDataCenterChangeNeeded !=="undefined" && isDataCenterChangeNeeded == 1)){
		     	$("#country").select2({
		     		templateResult: function(option){
				        var spltext;
				    	if (!option.id) { return option.text; }
				    	spltext=option.text.split("(");
				    	var string_code = $(option.element).attr("value");
				    	var ob = '<div class="pic flag_'+string_code.toUpperCase()+'" ></div><span class="cn">'+spltext[0]+"</span>" ;
				    	return ob;
				    },
				    searchInputPlaceholder: '<@i18n key="IAM.SEARCH"/>',//no i18n
				    templateSelection: function (option) {
				    	selectFlag($(option.element));
	   		            return option.text;
				    },
				    language: {
				        noResults: function(){
				            return '<@i18n key="IAM.NO.RESULT.FOUND"/>';
				        }
				    },
				    escapeMarkup: function (m) {
				       return m;
				    }
		     	});
		     	$("#country+.select2 .select2-selection").append("<span id='selectFlag' class='selectFlag'></span>");
		     	selectFlag($('#country').find("option:selected"));
		     	$("#country_state").select2();
		     }
			if(typeof isDataCenterChangeNeeded !=="undefined" && isDataCenterChangeNeeded == 1 && typeof loadCountryOptions !=="undefined" && loadCountryOptions !== 'false'){
				changeDomainName(ZADefaultCountry);
			}else{
				var selectElem = $('.za-country-container select[name=country]')[0];
				handleNewsletterField(selectElem);
				if(ZADefaultCountry === 'IN'){
					$(".za-country-select").show();
					$("#za-domain-container").hide();
				}
				checking();
			}
		 }
		function fedCheck(){
		    $(".fed_div").hide();
		    $(".fed_2show").show();
		    if(document.getElementsByClassName('fed_div').length > 0){
				document.getElementsByClassName('fed_div')[0].style.display = "inline-block";
				document.getElementsByClassName('fed_div')[0].classList.add("show_fed"); // no i18n
				var googleVisible = $('.google_fed').is(":visible") || $('.google_fed').length > 0;
			    var fed_all_width = googleVisible ? $('.inner-container').width() - $('.google_fed').outerWidth() : $('.inner-container').width();
			    var show_fed_length = Math.floor(fed_all_width / 50) - 1;
			    if($('.fed_div').length -1 > show_fed_length){
			    	for(var i= 0; i < show_fed_length; i++){
			    		document.getElementsByClassName('fed_div')[i].style.display = "inline-block";
			    		document.getElementsByClassName('fed_div')[i].classList.add("show_fed"); // no i18n
			    	}
			        $('.more').show();
			    }else{
			    	$('.fed_div').show();
			    	$('.more').hide()
			    }
				if($('.fed_div').length <= 1){
					$('.fed_2show').hide();
				}
		    
		    }
		}
		function showMoreIdps(){
			$(".small_box").removeClass("small_box");
			$(".fed_div").addClass("large_box");
			$(".zohosignin").css("display","inline-block");
			$(".fed_div,.fed_2show").show();
			$("#showIDPs").hide();
			$(".signupcontainer").hide();
			$(".signin_fed_text").addClass("signin_fedtext_bold");
			$(".signuptitle,.fed_2show_small").hide();
			$(".google_fed_icon").removeClass("google_small_icon");
			$(".google_text").show();
			$(".linkedin_fed_icon").removeClass("icon2-linkedin_small");
			$(".linkedin_fed_icon").addClass("icon2-linkedin_L");
			$(".baidu_fed_icon").removeClass("icon2-baidu_small");
			$(".baidu_fed_icon").addClass("icon2-baidu_L");
			$(".qq_text").show();
			$(".douban_text").show();
			$(".intuit_fed_icon").removeClass("icon2-intuit_small");
			$(".intuit_fed_icon").addClass("icon2-intuit_L");
			$(".wechat_text").show();
			$(".twitter_text").show();
			$(".microsoft_text").show();
			$(".feishu_text").show();
			$(".weibo_text").show();
			$(".facebook_text").show();
		}
		function showZohoSignin(){
			$(".large_box").removeClass("large_box");
			$(".fed_div").addClass("small_box");
			$(".zohosignin,.fed_2show").css("display","none");
			$(".signupcontainer").show();
			$(".signin_fed_text").removeClass("signin_fedtext_bold");
			$(".signuptitle").show();
			if($(".google_fed_icon").hasClass("show_small_icon"))
			{
				$(".google_fed_icon").addClass("google_small_icon");
			}
			fedCheck();
			var gVerify = parseInt(${signup.isGoogleVerifyNeeded});
			var fedlist = ${signup.fedlist};
			if(gVerify != 1 && fedlist.indexOf("apple") != -1){
				$(".google_text").hide();
			}
			$(".linkedin_fed_icon").removeClass("icon2-linkedin_L");
			$(".linkedin_fed_icon").addClass("icon2-linkedin_small");
			$(".baidu_fed_icon").removeClass("icon2-baidu_L");
			$(".baidu_fed_icon").addClass("icon2-baidu_small");
			$(".qq_text").hide();
			$(".douban_text").hide();
			$(".intuit_fed_icon").removeClass("icon2-intuit_L");
			$(".intuit_fed_icon").addClass("icon2-intuit_small");
			$(".wechat_text").hide();
			$(".twitter_text").hide();
			$(".microsoft_text").hide();
			$(".feishu_text").hide();
			$(".weibo_text").hide();
			$(".facebook_text").hide();
		}	
	</script>
</body>
</html>