<%--$Id$--%>
<%@page import="com.zoho.accounts.internal.util.StaticContentLoader"%>
<%@page import="com.adventnet.iam.internal.PhoneUtil"%>
<%@page import="com.adventnet.iam.OrgDomain"%>
<%@page import="com.zoho.accounts.phone.SMSUtil"%>
<%@page import="java.util.Date"%>
<%@page import="com.zoho.accounts.AccountsProto.Account.Domain"%>
<%@page import="java.util.HashSet"%>
<%@page import="com.adventnet.iam.internal.Util"%>
<%@ include file="../static/includes.jspf"%>
<%@page import="org.json.*" %>
<%@page import="com.zoho.accounts.AccountsProto.Account.User.UserMobile"%>
<%@page import="com.zoho.iam2.rest.ProtoToZliteUtil"%>
<%@page import="com.zoho.accounts.webclient.handlers.account.DPAUtil"%>
<%@page import="com.zoho.accounts.AccountsInternal"%>
<%@page import="com.zoho.iam2.rest.ServiceOrgUtil"%>
<%@page import="com.zoho.resource.URI"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.adventnet.iam.UserEmail"%>
<%@page import="com.zoho.accounts.Accounts"%>
<%@page import="com.adventnet.iam.UserPhone"%>
<%@page import="com.zoho.accounts.internal.announcement.Announcement"%>
	<html>
	<head>
	 <meta charset="UTF-8" />
	 <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title><%=Util.getI18NMsg(request, "IAM.ZOHO.ACCOUNTS")%></title>  
	<link href="<%=StaticContentLoader.getStaticFilePath("/v2/components/css/zohoPuvi.css")%>" rel="stylesheet"type="text/css">
	<style>
@font-face {
  font-family: "accountsicon";
  src: url("<%=StaticContentLoader.getStaticFilePath("/v2/components/images/fonts/emailphonenewtabpebbledomain.eot")%>");
  src: url("<%=StaticContentLoader.getStaticFilePath("/v2/components/images/fonts/emailphonenewtabpebbledomain.eot")%>") format("embedded-opentype"),
    url("<%=StaticContentLoader.getStaticFilePath("/v2/components/images/fonts/emailphonenewtabpebbledomain.ttf")%>") format("truetype"),
    url("<%=StaticContentLoader.getStaticFilePath("/v2/components/images/fonts/emailphonenewtabpebbledomain.woff")%>") format("woff"),
    url("<%=StaticContentLoader.getStaticFilePath("/v2/components/images/fonts/emailphonenewtabpebbledomain.svg")%>") format("svg");
  font-weight: normal;
  font-style: normal;
  font-display: block;
}
[class^="icon-"],
[class*=" icon-"] {
  /* use !important to prevent issues with browser extensions that change fonts */
  font-family: "accountsicon" !important;
  speak: never;
  font-style: normal;
  font-weight: normal;
  font-variant: normal;
  text-transform: none;
  line-height: 1;
  /* Better Font Rendering =========== */
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
.icon-Mail:before {
  content: "\e900";
}
.icon-Mobile:before {
  content: "\e901";
}
.icon-newtab:before {
  content: "\e902";
}
.mailicon:after {
  content: "\e903";
      position: absolute;
    left: 0px;
    opacity: 0.05;
    top: 1px;
    font-size: 30px;
}
.phoneicon:after{
 content: "\e903";
      position: absolute;
    opacity: 0.05;
    top: 1px;
    font-size: 30px;
    left:0px;
}
.mailicon {
  font-size: 10px;
  color: #18c063;
  padding: 6px;
  position: relative;
  top: -4px;
  font-size: 18px;
  margin-right: 10px;
}
.phoneicon {
  font-size: 10px;
  color: #1389e3;
  padding: 6px;
  position: relative;
  top: -4px;
  font-size: 18px;
  margin-right: 10px;
}
.newtablinkicon {
  margin-left: 5px;
  font-size: 10px;
}
body {
  margin: 0px;
  padding: 0px;
}
.logo {
 background: url('<%=StaticContentLoader.getStaticFilePath("/v2/components/images/Zoho_logo.png")%>');
  height: 100%;
  background-repeat: no-repeat;
  width: 78px;
  height: 27px;
  background-size: contain;
  margin-bottom: 20px;
}
.maincontainer {
  width: 500px;
  margin-bottom: 30px;
  font-family: 'ZohoPuvi', Georgia;
  margin: auto;
  margin-top: 120px;
}
.headermsg {
  width: 100%;
  font-size: 20px;
  line-height: 30px;
  font-weight: 600;
  color: #1d2842;
  margin-bottom: 10px;
  margin-top: 20px;
  text-align: left;
}
.msgcontainer {
  width: 100%;
  font-size: 14px;
  font-weight: 400;
  line-height: 24px;
  margin-bottom: 30px;
}
.emailphonedetailscontainer {
  width: 440px;
  border-radius: 16px;
  border: 1px solid #dcdcdc;
  margin-bottom: 24px;
}
.myccontainer {
  width: 440px;
  border-radius: 16px;
  border: 1px solid #dcdcdc;
  box-sizing: border-box;
  padding: 20px;
  margin-bottom: 30px;
}
.succbutton {
  text-decoration: none;
  color: #ffffff;
  font-family: 'ZohoPuvi', Georgia;
  font-weight: 600;
  font-size: 13px;
  margin-right: 20px;
  background-color: #1389e3;
  border-radius: 4px;
  padding: 12px 20px;
   display:inline-block;
}
.succbutton:hover{
background-color:#1177C5;
}
.failbutton {
  text-decoration: none;
  color: #8B8B8B;
  font-family: 'ZohoPuvi', Georgia;
  font-weight: 600;
  font-size: 12px;
  display:inline-block;
  float: right;
  position: relative;
  top: 12px;
  border-bottom: 1px dashed #ACACAC;
  padding-bottom: 3px;
}
.headercontainer {
  font-size: 14px;
  font-weight: 600;
  box-sizing: border-box;
  padding: 20px 20px;
  border-bottom: 1px solid #dcdcdc;
}
.editlink {
  color: #0091ff;
  font-size: 12px;
  font-weight: 700;
  float: right;
  text-decoration: none;
}
.mycdetails {
  width:440px;
  display: block;
  font-size: 12px;
  line-height:20px;
  margin-bottom: 30px;
  letter-spacing: -.2;
  color:black;
}
.spann {
  display: inline-block;
}
.emailphonecontainer {
  box-sizing: border-box;
  padding: 15px 20px;
  margin-top: 10px;
}
.detailscontainer {
  box-sizing: border-box;
  font-size: 14px;
  font-weight: 600;
  letter-spacing: 1px;
}
.detailsdatecontainer {
  font-size: 12px;
  line-height: 16px;
  font-weight: 500;
  color: #666666;
}
div .emailphonecontainer:last-child {
  margin-bottom: 20px;
}
@media screen and (min-width: 420px) and (max-width: 900px) {
  .maincontainer {
    margin: auto;
    margin-top: 50px;
    width: 440px;
  }
  .body {
    width: 100%;
  }
}
@media screen and (max-width: 419px) {
  .maincontainer {
    margin-left: 0px;
    width: 100%;
    margin-bottom: 0px;
    margin-top: 30px;
  }
  .msgcontainer{
  width:100%;
  }
  .emailphonedetailscontainer {
    width: 100%;
  }
  .mycdetails {
    width: 100%;
  }
  body {
    padding: 30px 20px;
  }
  .failbutton{
  margin-top:10px;
  }
}
	</style>
	<%! 
	public String replaceat(String emailormobile,char emailormobilecheck){
		StringBuilder sb=new StringBuilder();
		String s2=null;
		if(emailormobilecheck == 'e'){
		  String[] str=emailormobile.split("[@]");
		  for(int i=0;i<str[0].length()-1;i++){
				sb.append("*").toString();
			}
		  str[0]=str[0].substring(0,2)+sb;
		  sb=new StringBuilder();
		  int index=str[1].indexOf('.');
			 for(int i=0;i<index-2;i++){
				 sb.append("*").toString();
			 }
		  str[0]=str[0]+sb+str[1].substring(index-2,str[1].length());
		  return str[0];
		}
		else {
		for(int i=0;i<emailormobile.length()-4;i++){
			sb.append("*").toString();
		}
		s2=emailormobile.substring(0,2)+sb+emailormobile.substring(emailormobile.length()-2);
		return s2;
		}
	}
	 %>
	<%
		User user = IAMUtil.getCurrentUser();
		JSONArray jarry=new JSONArray();
		HttpServletRequest req = IAMUtil.getCurrentRequest();
		String contextPath=req.getContextPath(); 
		String emailphonePath=contextPath+"/home#profile/useremails"; //No I18N
		String mycPath=contextPath+"/home#privacy/myc"; //No I18N
		DateFormat dateFormat = Util.getDateFormat(req, user);
		List<UserEmail> emailIds=user.getEmails();
		String path=req.getContextPath();
		JSONObject dJson=null;
		if(emailIds != null) {
			List<OrgDomain> domains = Util.ORGAPI.getAllOrgDomain(user.getZOID());
			HashSet<String> verifiedDomains = new HashSet<String>(); 
			if(domains != null) {
				for(OrgDomain domain : domains) {
					if(domain.isVerified()) {
						verifiedDomains.add(domain.getDomainName());
					}
				}
			}
			for(UserEmail emailId : emailIds) {
				if(emailId.isEmailId()) {
					String orgDomainStr = emailId.getEmailId().split("@")[1];
					if(!verifiedDomains.contains(orgDomainStr)) {
						JSONObject eJson = new JSONObject();
						eJson.put("hidden_email",replaceat(emailId.getEmailId(),'e'));//No I18N
						Long millis=emailId.getCreatedTime();
						eJson.put("created_time_elapsed", WebClientUtil.returnDateString(dateFormat, millis, IAMUtil.getCurrentRequest())); //NO I18N
						jarry.put(eJson);
					}
				}
			}
		}
		 UserMobile ums[] = PhoneUtil.getUserVerifiedNumbers(user);
		 if(ums!=null){
			for(UserMobile um:ums){
				JSONObject jobj = new JSONObject();
				jobj.put("hidden_mobile", "+"+SMSUtil.getISDCode(um.getCountryCode())+" "+replaceat(um.getMobile() ,'m'));//No I18N
				Long millis=um.getCreatedTime();
				jobj.put("created_time_elapsed", WebClientUtil.returnDateString(dateFormat, millis, IAMUtil.getCurrentRequest())); //NO I18N
				jarry.put(jobj); 
		 	}	
		 }
		 %> 
	</head>
	<body>
	    <div class="maincontainer">
	      <div class="logo"></div>
	      <div class="headermsg"><%=Util.getI18NMsg(req, "IAM.USER.PROFILE.REVIEW.HEADER")%></div>
	      <div class="msgcontainer"><%=Util.getI18NMsg(req, "IAM.USER.PROFILE.REVIEW.HEADER.MSG")%>
	      </div>
	      
	      <div class="emailphonedetailscontainer">
	        <div class="headercontainer">
	          <span><%=Util.getI18NMsg(req, "IAM.USER.PROFILE.REVIEW.EMAIL.AND.MOBILE")%></span>
	          <a href="javascript:redirect()" class="editlink" 
	            ><%=Util.getI18NMsg(req, "IAM.USER.PROFILE.REVIEW.MANAGE")%><span class="newtablinkicon icon-newtab"></span
	          ></a>
	        </div>
	         <% for(int i=0;i<jarry.length();i++){
			 JSONObject objj=jarry.getJSONObject(i);	
		   	 if(objj.has("hidden_email")){
				 %>
	        <div class="emailphonecontainer">
	          <span class="mailicon icon-Mail icon-pebble"></span>
	          <span class="spann">
	            <div class="detailscontainer">
	            <%=IAMEncoder.encodeHTML(objj.getString("hidden_email"))%>
			 </div>
	            <div class="detailsdatecontainer">
	            <%=IAMEncoder.encodeHTML(objj.getString("created_time_elapsed"))%></div>  
	            </span>
	        </div>
			 <% }
			 else
			 { %>
	         <div class="emailphonecontainer">
	          <span class="phoneicon icon-Mobile icon-pebble"></span>
	          <span class="spann">
	          <div class="detailscontainer"><%=IAMEncoder.encodeHTML(objj.getString("hidden_mobile"))%></div>
	          <div class="detailsdatecontainer"><%=IAMEncoder.encodeHTML(objj.getString("created_time_elapsed"))%></div>
	          </span>
	        </div>
	        <%
			 }
		 }
		%>
		</div>
	      <div class="mycdetails"><%=Util.getI18NMsg(req, "IAM.USER.PROFILE.REVIEW.MYC.MSG",mycPath)%></div>
	      <a href="<%=IAMEncoder.encodeHTMLAttribute(Announcement.getVisitedNextURL(request))%>" class="succbutton"><%=Util.getI18NMsg(req, "IAM.USER.PROFILE.REVIEW.YES.PROCEED")%></a>
	      <a href="<%=IAMEncoder.encodeHTMLAttribute(Announcement.getRemindMeLaterURL(request))%>" class="failbutton"><%=Util.getI18NMsg(req, "IAM.USER.PROFILE.REVIEW.REMIND.LATER")%></a>
	    </div>
	    <script>
	    function redirect(){
	    	window.open("<%=IAMEncoder.encodeJavaScript(emailphonePath)%>" , "_blank");
	    	window.open("<%=IAMEncoder.encodeJavaScript(Announcement.getVisitedNextURL(request))%>" , "_self")
	    }
	    </script>
	  </body>
	</html>	