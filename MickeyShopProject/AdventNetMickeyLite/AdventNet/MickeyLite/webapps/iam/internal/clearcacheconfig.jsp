<%-- $Id$ --%>
<%@page import="com.adventnet.iam.security.SecurityUtil"%>
<%@page import="com.adventnet.iam.internal.Util"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.zoho.resource.AuthHeader"%>
<%@page import="com.zoho.zat.guava.common.net.HostAndPort"%>

<%
	String[] ip = request.getParameterValues("ips");
	if (ip != null) {
		String actionUrl = "internal/clearcacheconfig.jsp?action=clear"; //No I18n
		String iscSignature = SecurityUtil.sign();
		//Pass ISCSignature in Header
		Map<String, String> headers = new HashMap<String, String>();
		headers.put(AuthHeader.SYSTEM_AUTHORIZATION, "SystemAuth "+ iscSignature); // No I18N
		if(Util.isParamIscSignatureEnabled()) {
			actionUrl = actionUrl + "&iscsignature="+iscSignature; // No I18N
		}
		String pool = request.getParameter("pool");
		if (pool != null && !"".equals(pool)) {
			actionUrl += "pool=" + pool;  //No I18n
		}
		for (String i : ip) {
			i = i.trim();
			if (i.endsWith("/")) {
				i = i.substring(0,i.length()-1);
			}
			HostAndPort hostPort = HostAndPort.fromString(i).withDefaultPort(8080);
			i = hostPort.toString() + "/";
			com.adventnet.iam.internal.Util.clearCache();
			response.getWriter().println(i + "::::" + com.adventnet.iam.internal.Util.getResponseAsProperties("http://" + i + actionUrl, 30000, headers)); //NO OUTPUTENCODING //No I18N
			response.getWriter().println("<br>"); //No I18N //NO OUTPUTENCODING
		}
	} else {
		String pool = request.getParameter("pool");
		if (pool == null || "".equals(pool)) {
			com.zoho.accounts.cache.IAMCacheFactory.clearCache();
		} else {
			com.zoho.accounts.cache.IAMCacheFactory.clearCache(pool);
		}
		out.println("cleared"); //No I18N
	}
%>
