<!DOCTYPE html>
<html>

	<head>
        <title><@i18n key="IAM.ZOHO.ACCOUNTS" /></title>
        <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    	<style>
    		@font-face {
    			font-family: 'Open Sans';
				font-weight: 300;
				font-style: normal;
				src :local('Open Sans'),url('${SCL.getStaticFilePath("/v2/components/images/opensans/font.woff")}') format('woff'); 
			}
        	body {
            	font-family: "Open sans";
        	}
        	.container-visible, .container-hidden {
            	max-width: 600px;
            	margin: auto;
            	margin-top: 80px;
        	}
        	.container-visible {
  				visibility: visible;
  				opacity: 1;
  				transition: opacity 2s linear;
			}
			.container-hidden {
 			 	visibility: hidden;
  				opacity: 0;
  				transition: visibility 0s 2s, opacity 2s linear;
			}
        	.zoho_logo {
            	display: block;
            	height: 30px;
            	width: auto;
            	background: url("${SCL.getStaticFilePath("/v2/components/images/zoho.png")}") no-repeat transparent; 
            	background-size: auto 100%;
            	background-position: center; 
        	}
        	.box {
            	display: block;
            	width: 90%;
            	height: auto;
            	box-sizing: border-box;
            	padding: 30px ;
            	padding-bottom: 20px;
            	background-color: #F9FCFF;
            	border: 2px solid #D8EEFF;
            	border-radius: 5px;
            	margin: auto;
            	margin-top: 20px;
        	}
        	.heading_text {
            	display: block;
            	text-align: center;
            	font-size: 18px;
            	font-weight: 600;
        	}
        	.sub_text {
            	display: block;
            	text-align: center;
            	font-size: 14px;
            	line-height: 24px;
            	margin: 10px 0px 5px 0px;
            	color: #717171;
        	}
        	.btncontainer {
        		padding-top:5px;
        	}
        	.btnbox {
            	color: #159AFF;
            	text-align: center;
        	}
        	.btn {
            	cursor: pointer;
            	font-size: 16px;
            	font-weight: 600;
        	}
    	</style>
    	<script type="text/javascript">
    		var _time;
    		var isAlreadyClicked = false;
    		window.onload = function() {
    			_time = setTimeout("redirect(false)", 0);
    			setTimeout(function() {
    				document.getElementById("banner_container").className = "container-visible";
    			}, 4000);
    		}
    		function redirect(isButtonClick) {
    			try{
    				clearTimeout(_time);
    			}catch(e){}
    			if(isButtonClick) {
    				if(!isAlreadyClicked) {
    					isAlreadyClicked = true;
    	    			window.location.href = '${redirect_to_oneauth}';
    	    			return false;
    				}
    			} else {
        			window.location.href = '${redirect_to_oneauth}';
        			return false;
    			}
    		}
    	</script>
    </head>
    <body>
        <div class="container-hidden" id="banner_container">
            <div class="zoho_logo"></div>
            <div class="box">
                <div class="heading_text"><@i18n key="IAM.WEBPAGE.REDIRECT.APPLICATION" /></div>
                <div class="btncontainer" id="btncontainer">
	                <div class="sub_text"><@i18n key="IAM.WEBPAGE.CLICK.CONTINUE.REDIRECT" /></div>
    	            <div class="btnbox"><span class="btn" onclick="redirect(true);"><@i18n key="IAM.CONTINUE" /></span></div>
                </div>
            </div>
        </div>
    </body>

</html>
