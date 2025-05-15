<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<body style="margin:0;padding:0;">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;max-width: 700px; min-width: 320px;width:100%;"> 
    <tr>
    <td align="left" style="padding:2% 2% 2% 2%;">
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr border="0">
	            <td>
	                <table border="0" cellpadding="0" cellspacing="0" width="100%">
	                    <tr>
		                    <td>
		                        <a href="<@i18n key="IAM.HOME.LINK" />" style="display:inline-block;"><img src="cid:23abc@pc27" style="display: block;height: 30px;width: 80px;" /></a>
		                    </td>
	                    </tr>
	                    <tr>
		                    <td style="padding:20px 0 0 0;font-size: 24px;line-height: 48px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
		                        <b><a href="#" rel="nofollow" style="text-decoration:none !important;cursor: default !important;color: #222 !important;"><@i18n key="IAM.NEW.HI.USERNAME" arg0="${ztpl.FIRST_NAME}"/></a></b>
		                    </td>
	                    </tr>	                   
	                    <tr>
		                    <td style="padding:20px 0 0 0;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
		                    	<@i18n key="IAM.NEW.TPL.VERIFY.MAIL.CODE" arg0="${ztpl.OTP_VALIDITY}" arg1="${ztpl.VALIDITY_TIME}"/>
		                    </td>
	                    </tr>
	                    <tr>
		                    <td style="padding:20px 0 0 0;font-size: 22px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
		                        <b>${ztpl.VERIFICATION_CODE}</b>
		                    </td>
	                    </tr>
	                     <tr>
		                    <td style="padding:20px 0 0 0;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
		                        <@i18n key="IAM.NEW.TPL.REGARDS"/>
		                    </td>
	                    </tr>
	                    <tr>
		                    <td style="font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
		                        <@i18n key="IAM.NEW.TPL.ZOHO.TEAM"/><br>
		                    </td>
	                    </tr>
	                    <tr>
		                    <td style="font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
		                        <a href="<@i18n key="IAM.HOME.LINK" />" style="color:#0091FF; text-decoration:none;"><@i18n key="IAM.NEW.HOME.LINK.TEXT"/></a> 
		                    </td>
	                    </tr>
	                    <tr>
		                    <td style="border-bottom: 3px solid #339e72;">
		                        <img src="<@image cid="23abc@pc28" img_path="${ztpl.IMG_PATH}/zohoRegionLogo.gif" />" style="display: block;width: 100%;height: auto !important;" /> 
		                    </td>
	                    </tr>
	                </table>
	            </td>
            </tr>           
        </table>
        <table> 
            <tr>
                <td style="padding:10px 0 10px 0;font-size: 12px;color:#333333;line-height: 22px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                    <@i18n key="${ztpl.OFFICE_ADDRESS_I18N_KEY}"/><br><@i18n key="IAM.NEW.TPL.SPAM.TEXT" arg0="${ztpl.ABUSE_ID}"/>
                </td>
            </tr>       
            
        </table>
    </td>
    </tr>
</table>
</table>
</body>
</html>


