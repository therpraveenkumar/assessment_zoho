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
                    	<b><a href="#" rel="nofollow" style="text-decoration:none !important;cursor: default !important;color: #222 !important;"><@i18n key="IAM.HI.USERNAME.EXCLAMATION" arg0="${ztpl.first_name}"/></a></b>
                    </td>
                    </tr>
                    <#if ztpl.activated>
                    <tr>
                    <td style="font-size: 24px;line-height: 48px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                    <b><@i18n key="IAM.MYZOHO.DEVICE.LINKED.TITLE" /></b>
                    </td>
                    </tr>
                    <tr>
                    <td style="padding:20px 0 0 0;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                        <@i18n key="IAM.TPL.MFA.DEVICE_LINKED" arg0="${ztpl.device_name}" arg1="${ztpl.mode}"/>
                    </td>
                    </tr>
                    <#else>
                    <tr>
                    <td style="font-size: 24px;line-height: 48px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                    <b><@i18n key="IAM.MYZOHO.DEVICE.DELINKED.TITLE" /></b>
                    </td>
                    </tr>
                    <tr>
                    <td style="padding:20px 0 0 0;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                        <@i18n key="IAM.TPL.MFA.DEVICE_DELINKED" arg0="${ztpl.device_name}"/>
                    </td>
                    </tr>
                    </#if>
                    <#if ztpl.activated>
                    <tr>
                    <td style="padding:20px 0 0 0;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                        <b><@i18n key="IAM.TFA.AUTH.MODE"/></b>
                    </td>
                    </tr>                   
                    <#if ztpl.modepref == 0>                                     
                    <tr>
                    <td style="font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                        <@i18n key="IAM.PUSH.NOTIFICATION"/>
                    </td>
                    </tr>
                    <#elseif ztpl.modepref == 1>              
                    <tr>
                    <td style="font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                        <@i18n key="IAM.TOUCHID"/>
                    </td>
                    </tr>  
                    <#elseif ztpl.modepref == 2>                 
                    <tr>
                    <td style="font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                        <@i18n key="IAM.SCAN.QR"/>
                    </td>
                    </tr>                       
                    <#elseif ztpl.modepref == 3>                    
                    <tr>
                    <td style="font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                        <@i18n key="IAM.TIME.BASED.OTP"/>
                    </td>
                    </tr>
                    <#elseif ztpl.modepref == 4>                    
                    <tr>
                    <td style="font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                        <@i18n key="IAM.FACEID"/>
                    </td>
                    </tr>
                    </#if>
                    <tr>
                    <td style="padding:20px 0 20px 0;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                        <@i18n key="IAM.MFA.MANAGE.MAIL.LINK"/>
                    </td>
                    </tr>
                    <tr>
                       <td>
                          <a style="text-decoration:none;color: #ffffff;display: inline-block;border-top:12px solid #339E72;border-right:40px solid #339E72;border-bottom:12px solid #339E72;border-left:40px solid #339E72;font-size: 16px;font-weight: 600;font-family: 'Open Sans','Trebuchet MS',sans-serif;color: #ffffff;background-color:#339E72;" href="${ztpl.serverlink}"><@i18n key="IAM.MFA.SETTING"/></a>
                       </td>
                    </tr>
                    <tr>
                    <td style="padding:20px 0 0 0;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                        <@i18n key="IAM.TPL.MYZOHO.NOTE"/><@i18n key="IAM.MFA.HELP.DOCUMENT.MSG" arg0="${ztpl.helplink}"/>
                    </td>
                    </tr> 
                    <tr>
                    <td style="padding:20px 0 0 0;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                       <@i18n key="IAM.TPL.MYZOHO.NOT.OPTED.WARN.MESSAGE" arg0="${ztpl.support_mail}"/>
                    </td>
                    </tr>
                    </#if>
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