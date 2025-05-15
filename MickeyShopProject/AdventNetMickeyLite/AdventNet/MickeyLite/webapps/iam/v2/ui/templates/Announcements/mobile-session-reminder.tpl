<!DOCTYPE html>
<html>
<head>
	<title><@i18n key="IAM.ZOHO.ACCOUNTS" /></title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=2.0" />
    <link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
    <link href="${SCL.getStaticFilePath("/v2/components/css/product-icon.css")}" rel="stylesheet"type="text/css">
	 
	<style>
	   body {
           margin:0px;
           color:#000;
           padding: 0px;
           background-color: #fff;
       }
       
       
       
       @font-face {
		  font-family: 'NewDevices';
		  src:  url('/v2/components/images/fonts/NewDevices.eot');
		  src:  url('/v2/components/images/fonts/NewDevices.eot') format('embedded-opentype'),
		    url('/v2/components/images/fonts/NewDevices.woff2') format('woff2'),
		    url('/v2/components/images/fonts/NewDevices.ttf') format('truetype'),
		    url('/v2/components/images/fonts/NewDevices.woff') format('woff'),
		    url('/v2/components/images/fonts/NewDevices.svg') format('svg');
		  font-weight: normal;
		  font-style: normal;
		  font-display: block;
		}
		
		[class^="deviceicon-"], [class*=" deviceicon-"] {
		  /* use !important to prevent issues with browser extensions that change fonts */
		  font-family: 'NewDevices' !important;
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
		
		.deviceicon-vivo .path1:before {
		  content: "\e900";
		  color: rgb(105, 105, 105);
		}
		.deviceicon-vivo .path2:before {
		  content: "\e901";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-vivo .path3:before {
		  content: "\e902";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		  background: -webkit-linear-gradient(270deg, #FFE68B -0.09%, #3A8A9B 99.89%);
		  -webkit-background-clip: text;
		  -webkit-text-fill-color: transparent;
		}
		.deviceicon-vivo .path4:before {
		  content: "\e903";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-vivo .path5:before {
		  content: "\e904";
		  margin-left: -1em;
		  color: rgb(105, 105, 105);
		}
		.deviceicon-vivo .path6:before {
		  content: "\e905";
		  margin-left: -1em;
		  color: rgb(105, 105, 105);
		}
		.deviceicon-redmi .path1:before {
		  content: "\e906";
		  color: rgb(61, 61, 61);
		}
		.deviceicon-redmi .path2:before {
		  content: "\e907";
		  margin-left: -1em;
		  color: rgb(61, 61, 61);
		}
		.deviceicon-redmi .path3:before {
		  content: "\e908";
		  margin-left: -1em;
		  color: rgb(61, 61, 61);
		}
		.deviceicon-redmi .path4:before {
		  content: "\e909";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-redmi .path5:before {
		  content: "\e90a";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-redmi .path6:before {
		  content: "\e90b";
		  margin-left: -1em;
		  color: rgb(61, 61, 61);
		}
		.deviceicon-pixel .path1:before {
		  content: "\e90c";
		  color: rgb(82, 82, 82);
		}
		.deviceicon-pixel .path2:before {
		  content: "\e90d";
		  margin-left: -1em;
		  color: rgb(82, 82, 82);
		}
		.deviceicon-pixel .path3:before {
		  content: "\e90e";
		  margin-left: -1em;
		  color: rgb(82, 82, 82);
		}
		.deviceicon-pixel .path4:before {
		  content: "\e90f";
		  margin-left: -1em;
		  color: rgb(3, 3, 3);
		}
		.deviceicon-pixel .path5:before {
		  content: "\e910";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		  background: -webkit-linear-gradient(90deg, #D33C5F 37.61%, #FDC266 103.24%);
		  -webkit-background-clip: text;
		  -webkit-text-fill-color: transparent;
		}
		.deviceicon-pixel .path6:before {
		  content: "\e911";
		  margin-left: -1em;
		  color: rgb(3, 3, 3);
		}
		.deviceicon-oppo .path1:before {
		  content: "\e912";
		  color: rgb(67, 67, 67);
		}
		.deviceicon-oppo .path2:before {
		  content: "\e913";
		  margin-left: -1em;
		  color: rgb(67, 67, 67);
		}
		.deviceicon-oppo .path3:before {
		  content: "\e914";
		  margin-left: -1em;
		  color: rgb(67, 67, 67);
		}
		.deviceicon-oppo .path4:before {
		  content: "\e915";
		  margin-left: -1em;
		  color: rgb(67, 67, 67);
		}
		.deviceicon-oppo .path5:before {
		  content: "\e916";
		  margin-left: -1em;
		  color: rgb(116, 116, 116);
		}
		.deviceicon-oppo .path6:before {
		  content: "\e917";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-oppo .path7:before {
		  content: "\e918";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		  background: -webkit-linear-gradient(270deg, #FEBCC0 0.06%, #5C2C76 99.95%);
		  -webkit-background-clip: text;
		  -webkit-text-fill-color: transparent;
		}
		.deviceicon-oppo .path8:before {
		  content: "\e919";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-iphone-13 .path1:before {
		  content: "\e91a";
		  color: rgb(57, 57, 57);
		}
		.deviceicon-iphone-13 .path2:before {
		  content: "\e91b";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-iphone-13 .path3:before {
		  content: "\e91c";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-iphone-13 .path4:before {
		  content: "\e91d";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-iphone .path1:before {
		  content: "\e91e";
		  color: rgb(112, 112, 112);
		}
		.deviceicon-iphone .path2:before {
		  content: "\e91f";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-iphone .path3:before {
		  content: "\e920";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-iphone .path4:before {
		  content: "\e921";
		  margin-left: -1em;
		  color: rgb(112, 112, 112);
		}
		.deviceicon-iphone .path5:before {
		  content: "\e922";
		  margin-left: -1em;
		  color: rgb(112, 112, 112);
		}
		.deviceicon-iphone .path6:before {
		  content: "\e923";
		  margin-left: -1em;
		  color: rgb(112, 112, 112);
		}
		.deviceicon-iphone .path7:before {
		  content: "\e924";
		  margin-left: -1em;
		  color: rgb(112, 112, 112);
		}
		.deviceicon-iphone .path8:before {
		  content: "\e925";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-samsung .path1:before {
		  content: "\e926";
		  color: rgb(54, 54, 54);
		}
		.deviceicon-samsung .path2:before {
		  content: "\e927";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-samsung .path3:before {
		  content: "\e928";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		  background: -webkit-linear-gradient(90deg, #796CF9 49.54%, #96F6F9 100.12%);
		  -webkit-background-clip: text;
		  -webkit-text-fill-color: transparent;
		}
		.deviceicon-samsung .path4:before {
		  content: "\e929";
		  margin-left: -1em;
		  color: rgb(54, 54, 54);
		}
		.deviceicon-samsung .path5:before {
		  content: "\e92a";
		  margin-left: -1em;
		  color: rgb(54, 54, 54);
		}
		.deviceicon-oneplus .path1:before {
		  content: "\e92b";
		  color: rgb(64, 64, 64);
		}
		.deviceicon-oneplus .path2:before {
		  content: "\e92c";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-oneplus .path3:before {
		  content: "\e92d";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		  background: -webkit-linear-gradient(270deg, #67E1D7 1.02%, #3078BE 56.02%);
		  -webkit-background-clip: text;
		  -webkit-text-fill-color: transparent;
		}
		.deviceicon-oneplus .path4:before {
		  content: "\e92e";
		  margin-left: -1em;
		  color: rgb(64, 64, 64);
		}
		.deviceicon-oneplus .path5:before {
		  content: "\e92f";
		  margin-left: -1em;
		  color: rgb(64, 64, 64);
		}
		.deviceicon-oneplus .path6:before {
		  content: "\e930";
		  margin-left: -1em;
		  color: rgb(64, 64, 64);
		}
		.deviceicon-oneplus .path7:before {
		  content: "\e931";
		  margin-left: -1em;
		  color: rgb(61, 61, 61);
		}
		.deviceicon-samsungtab .path1:before {
		  content: "\e932";
		  color: rgb(54, 54, 54);
		}
		.deviceicon-samsungtab .path2:before {
		  content: "\e933";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-samsungtab .path3:before {
		  content: "\e934";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		  background: -webkit-linear-gradient(338.9deg, #E43E3E -0.08%, #FFF1C4 101.71%);
		  -webkit-background-clip: text;
		  -webkit-text-fill-color: transparent;
		}
		.deviceicon-samsungtab .path4:before {
		  content: "\e935";
		  margin-left: -1em;
		  color: rgb(54, 54, 54);
		}
		.deviceicon-samsungtab .path5:before {
		  content: "\e936";
		  margin-left: -1em;
		  color: rgb(54, 54, 54);
		}
		.deviceicon-samsungtab .path6:before {
		  content: "\e937";
		  margin-left: -1em;
		  color: rgb(54, 54, 54);
		}
		.deviceicon-ipad .path1:before {
		  content: "\e938";
		  color: rgb(54, 54, 54);
		}
		.deviceicon-ipad .path2:before {
		  content: "\e939";
		  margin-left: -1em;
		  color: rgb(54, 54, 54);
		}
		.deviceicon-ipad .path3:before {
		  content: "\e93a";
		  margin-left: -1em;
		  color: rgb(54, 54, 54);
		}
		.deviceicon-ipad .path4:before {
		  content: "\e93b";
		  margin-left: -1em;
		  color: rgb(54, 54, 54);
		}
		.deviceicon-ipad .path5:before {
		  content: "\e93c";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-ipad .path6:before {
		  content: "\e93d";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		  background: -webkit-linear-gradient(158.21deg, #31CCDB 7.76%, #1CBE78 100.06%);
		  -webkit-background-clip: text;
		  -webkit-text-fill-color: transparent;
		}
		.deviceicon-ipad .path7:before {
		  content: "\e93e";
		  margin-left: -1em;
		  color: rgb(34, 34, 34);
		}
		.deviceicon-lenovo .path1:before {
		  content: "\e93f";
		  color: rgb(60, 65, 91);
		}
		.deviceicon-lenovo .path2:before {
		  content: "\e940";
		  margin-left: -1em;
		  color: rgb(46, 46, 46);
		}
		.deviceicon-lenovo .path3:before {
		  content: "\e941";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-lenovo .path4:before {
		  content: "\e942";
		  margin-left: -1em;
		  color: rgb(40, 46, 65);
		}
		.deviceicon-lenovo .path5:before {
		  content: "\e943";
		  margin-left: -1em;
		  color: rgb(101, 108, 147);
		}
		.deviceicon-lenovo .path6:before {
		  content: "\e944";
		  margin-left: -1em;
		  color: rgb(101, 108, 147);
		}
		.deviceicon-dell .path1:before {
		  content: "\e945";
		  color: rgb(121, 121, 121);
		}
		.deviceicon-dell .path2:before {
		  content: "\e946";
		  margin-left: -1em;
		  color: rgb(83, 83, 83);
		}
		.deviceicon-dell .path3:before {
		  content: "\e947";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-dell .path4:before {
		  content: "\e948";
		  margin-left: -1em;
		  color: rgb(49, 49, 49);
		}
		.deviceicon-macbook .path1:before {
		  content: "\e949";
		  color: rgb(14, 14, 14);
		}
		.deviceicon-macbook .path2:before {
		  content: "\e94a";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-macbook .path3:before {
		  content: "\e94b";
		  margin-left: -1em;
		  color: rgb(14, 14, 14);
		}
		.deviceicon-macbook .path4:before {
		  content: "\e94c";
		  margin-left: -1em;
		  color: rgb(209, 209, 209);
		}
		.deviceicon-macbook .path5:before {
		  content: "\e94d";
		  margin-left: -1em;
		  color: rgb(247, 247, 247);
		}
		.deviceicon-macbook .path6:before {
		  content: "\e94e";
		  margin-left: -1em;
		  color: rgb(176, 176, 176);
		}
		.deviceicon-macbook .path7:before {
		  content: "\e94f";
		  margin-left: -1em;
		  color: rgb(176, 176, 176);
		}
		.deviceicon-windowsphone_uk .path1:before {
		  content: "\e950";
		  color: rgb(64, 64, 64);
		}
		.deviceicon-windowsphone_uk .path2:before {
		  content: "\e951";
		  margin-left: -1em;
		  color: rgb(64, 64, 64);
		}
		.deviceicon-windowsphone_uk .path3:before {
		  content: "\e952";
		  margin-left: -1em;
		  color: rgb(64, 64, 64);
		}
		.deviceicon-windowsphone_uk .path4:before {
		  content: "\e953";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-windowsphone_uk .path5:before {
		  content: "\e954";
		  margin-left: -1em;
		  color: rgb(64, 64, 64);
		}
		.deviceicon-windowsphone_uk .path6:before {
		  content: "\e955";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		  background: -webkit-linear-gradient(180deg, #384288 0%, #0D1232 97.4%);
		  -webkit-background-clip: text;
		  -webkit-text-fill-color: transparent;
		}
		.deviceicon-windowsphone_uk .path7:before {
		  content: "\e956";
		  margin-left: -1em;
		  color: rgb(61, 61, 61);
		}
		.deviceicon-windowsphone_uk .path8:before {
		  content: "\e957";
		  margin-left: -1em;
		  color: rgb(227, 227, 227);
		}
		.deviceicon-android_uk .path1:before {
		  content: "\e958";
		  color: rgb(64, 64, 64);
		}
		.deviceicon-android_uk .path2:before {
		  content: "\e959";
		  margin-left: -1em;
		  color: rgb(64, 64, 64);
		}
		.deviceicon-android_uk .path3:before {
		  content: "\e95a";
		  margin-left: -1em;
		  color: rgb(64, 64, 64);
		}
		.deviceicon-android_uk .path4:before {
		  content: "\e95b";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-android_uk .path5:before {
		  content: "\e95c";
		  margin-left: -1em;
		  color: rgb(64, 64, 64);
		}
		.deviceicon-android_uk .path6:before {
		  content: "\e95d";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		  background: -webkit-linear-gradient(180deg, #384288 0%, #0D1232 97.4%);
		  -webkit-background-clip: text;
		  -webkit-text-fill-color: transparent;
		}
		.deviceicon-android_uk .path7:before {
		  content: "\e95e";
		  margin-left: -1em;
		  color: rgb(61, 61, 61);
		}
		.deviceicon-android_uk .path8:before {
		  content: "\e95f";
		  margin-left: -1em;
		  color: rgb(227, 227, 227);
		}
		.deviceicon-iphone_uk .path1:before {
		  content: "\e960";
		  color: rgb(112, 112, 112);
		}
		.deviceicon-iphone_uk .path2:before {
		  content: "\e961";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-iphone_uk .path3:before {
		  content: "\e962";
		  margin-left: -1em;
		  color: rgb(112, 112, 112);
		}
		.deviceicon-iphone_uk .path4:before {
		  content: "\e963";
		  margin-left: -1em;
		  color: rgb(112, 112, 112);
		}
		.deviceicon-iphone_uk .path5:before {
		  content: "\e964";
		  margin-left: -1em;
		  color: rgb(112, 112, 112);
		}
		.deviceicon-iphone_uk .path6:before {
		  content: "\e965";
		  margin-left: -1em;
		  color: rgb(112, 112, 112);
		}
		.deviceicon-iphone_uk .path7:before {
		  content: "\e966";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		  background: -webkit-linear-gradient(180deg, #384288 0%, #0D1232 97.4%);
		  -webkit-background-clip: text;
		  -webkit-text-fill-color: transparent;
		}
		.deviceicon-iphone_uk .path8:before {
		  content: "\e967";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-iphone_uk .path9:before {
		  content: "\e968";
		  margin-left: -1em;
		  color: rgb(227, 227, 227);
		}
		.deviceicon-mobile_uk .path1:before {
		  content: "\e969";
		  color: rgb(64, 64, 64);
		}
		.deviceicon-mobile_uk .path2:before {
		  content: "\e96a";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-mobile_uk .path3:before {
		  content: "\e96b";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		  background: -webkit-linear-gradient(0deg, #0D1232 0%, #384288 96.88%);
		  -webkit-background-clip: text;
		  -webkit-text-fill-color: transparent;
		}
		.deviceicon-mobile_uk .path4:before {
		  content: "\e96c";
		  margin-left: -1em;
		  color: rgb(64, 64, 64);
		}
		.deviceicon-mobile_uk .path5:before {
		  content: "\e96d";
		  margin-left: -1em;
		  color: rgb(64, 64, 64);
		}
		.deviceicon-mobile_uk .path6:before {
		  content: "\e96e";
		  margin-left: -1em;
		  color: rgb(64, 64, 64);
		}
		.deviceicon-mobile_uk .path7:before {
		  content: "\e96f";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-androidtablet_uk .path1:before {
		  content: "\e970";
		  color: rgb(54, 54, 54);
		}
		.deviceicon-androidtablet_uk .path2:before {
		  content: "\e971";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		}
		.deviceicon-androidtablet_uk .path3:before {
		  content: "\e972";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		  background: -webkit-linear-gradient(0deg, #0D1232 0%, #384288 96.88%);
		  -webkit-background-clip: text;
		  -webkit-text-fill-color: transparent;
		}
		.deviceicon-androidtablet_uk .path4:before {
		  content: "\e973";
		  margin-left: -1em;
		  color: rgb(54, 54, 54);
		}
		.deviceicon-androidtablet_uk .path5:before {
		  content: "\e974";
		  margin-left: -1em;
		  color: rgb(54, 54, 54);
		}
		.deviceicon-androidtablet_uk .path6:before {
		  content: "\e975";
		  margin-left: -1em;
		  color: rgb(227, 227, 227);
		}
		.deviceicon-osunknown_uk .path1:before {
		  content: "\e976";
		  color: rgb(121, 121, 121);
		}
		.deviceicon-osunknown_uk .path2:before {
		  content: "\e977";
		  margin-left: -1em;
		  color: rgb(83, 83, 83);
		}
		.deviceicon-osunknown_uk .path3:before {
		  content: "\e978";
		  margin-left: -1em;
		  color: rgb(49, 49, 49);
		}
		.deviceicon-osunknown_uk .path4:before {
		  content: "\e979";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		  background: -webkit-linear-gradient(180deg, #384288 0%, #0D1232 97.4%);
		  -webkit-background-clip: text;
		  -webkit-text-fill-color: transparent;
		}
		.deviceicon-linux_uk .path1:before {
		  content: "\e97a";
		  color: rgb(121, 121, 121);
		}
		.deviceicon-linux_uk .path2:before {
		  content: "\e97b";
		  margin-left: -1em;
		  color: rgb(83, 83, 83);
		}
		.deviceicon-linux_uk .path3:before {
		  content: "\e97c";
		  margin-left: -1em;
		  color: rgb(49, 49, 49);
		}
		.deviceicon-linux_uk .path4:before {
		  content: "\e97d";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		  background: -webkit-linear-gradient(180deg, #384288 0%, #0D1232 97.4%);
		  -webkit-background-clip: text;
		  -webkit-text-fill-color: transparent;
		}
		.deviceicon-linux_uk .path5:before {
		  content: "\e97e";
		  margin-left: -1em;
		  color: rgb(255, 255, 255);
		}
		.deviceicon-windows_uk .path1:before {
		  content: "\e97f";
		  color: rgb(121, 121, 121);
		}
		.deviceicon-windows_uk .path2:before {
		  content: "\e980";
		  margin-left: -1em;
		  color: rgb(83, 83, 83);
		}
		.deviceicon-windows_uk .path3:before {
		  content: "\e981";
		  margin-left: -1em;
		  color: rgb(49, 49, 49);
		}
		.deviceicon-windows_uk .path4:before {
		  content: "\e982";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		  background: -webkit-linear-gradient(180deg, #384288 0%, #0D1232 97.4%);
		  -webkit-background-clip: text;
		  -webkit-text-fill-color: transparent;
		}
		.deviceicon-windows_uk .path5:before {
		  content: "\e983";
		  margin-left: -1em;
		  color: rgb(227, 227, 227);
		}
		.deviceicon-macbook_uk .path1:before {
		  content: "\e984";
		  color: rgb(209, 209, 209);
		}
		.deviceicon-macbook_uk .path2:before {
		  content: "\e985";
		  margin-left: -1em;
		  color: rgb(247, 247, 247);
		}
		.deviceicon-macbook_uk .path3:before {
		  content: "\e986";
		  margin-left: -1em;
		  color: rgb(176, 176, 176);
		}
		.deviceicon-macbook_uk .path4:before {
		  content: "\e987";
		  margin-left: -1em;
		  color: rgb(176, 176, 176);
		}
		.deviceicon-macbook_uk .path5:before {
		  content: "\e988";
		  margin-left: -1em;
		  color: rgb(14, 14, 14);
		}
		.deviceicon-macbook_uk .path6:before {
		  content: "\e989";
		  margin-left: -1em;
		  color: rgb(0, 0, 0);
		  background: -webkit-linear-gradient(180deg, #384288 0%, #0D1232 97.4%);
		  -webkit-background-clip: text;
		  -webkit-text-fill-color: transparent;
		}
		.deviceicon-macbook_uk .path7:before {
		  content: "\e98a";
		  margin-left: -1em;
		  color: rgb(14, 14, 14);
		}
		.deviceicon-macbook_uk .path8:before {
		  content: "\e98b";
		  margin-left: -1em;
		  color: rgb(227, 227, 227);
		}
		
		
		
		
		
       .session_parent{
           text-align: center;
           overflow: hidden;
       }
       #session_update{
       		padding: 20px 25px;
       }
       .success_img{
       		width: 50px;
       		margin: auto;
       		transition: all 0.3s ease-in-out;
       		background-image: url("/v2/components/images/tickicon.png");
       		background-size: 100%;
       }
       .logo_parent{
           font-size: 20px;
           font-weight: 400;
           align-items: center;
		   display: flex;
		   width: max-content;
		   gap: 10px;
		   margin: auto;
       }
       .session_img{
           width: 244px;
           height: 140px;
           margin: auto;
           margin-top: 26px;
           background-image: url("/v2/components/images/Applimit.svg");
       }
       .session_title{
           letter-spacing: 0px;
           font-size: 20px;
           font-weight: 600;
           margin-top: 30px;
           transition: margin 0.2s ease-in-out;
       }
       .session_desc{
           font-size: 14px;
           margin-top: 20px;
           line-height: 24px;
       }
       .canvas_board{
           transform: rotate(90deg);
           margin: 20px 10px 20px 12px;
       }
       .canvas_area{
           margin-top:30px;
           display:flex;
           border: 1px solid #D8D8D8;
           border-radius: 6px;
           text-align: left;
       }
       .session_count{
           font-size: 16px;
           font-weight: 400;
           margin-top: 30px;
           letter-spacing: 0px;
       }
       .remaining_count{
           margin-top: 6px;
           font-size: 13px;
           color: #F45B5B;
           font-weight: 400;
       }
       .btn {
           cursor: pointer;
           display: block;
           width: 100%;
           height: 44px;
           border-radius: 4px;
           letter-spacing: .5px;
           font-size: 14px;
           font-weight: 600;
           outline: none;
           border: none;
           margin: auto;
           margin-bottom: 30px;
           transition: all .2s ease-in-out;
           box-shadow: 0px 2px 2px #fff;
           background-color: #1389E3;
           color: #fff;
           margin-top: 30px;
       }
       .btn:disabled{
       		opacity: 0.6;
       }
       .do_later{
           color: #1389E3;
           cursor: pointer;
           letter-spacing: 0px;
           font-weight: 600;
           text-decoration: none;
       }
       .device_div{
           width: 100%;
           height: auto;
           text-align: left;
           padding: 17px 0px;
       }
       .device_pic{
           height: 50px;
           width: 50px;
           display: inline-block;
           float: left;
           margin-right: 10px;
           color: #000;
           font-size: 36px;
           box-sizing: border-box;
           line-height: 50px;
           text-align: center;
       }
       .device_details{
           display: inline-block;
           padding: 5px 0px;
       }
       .device_name{
           display: block;
           font-size: 16px;
           white-space: nowrap;
           overflow: hidden;
           text-overflow: ellipsis;
           line-height: 18px;
           color: #000000;
		   opacity: 0.8;
       }
       .device_time{
           display: inline-block;
           font-size: 12px;
           color: #777;
           margin-top: 5px;
       }
       .checckbox_container {
           display: inline-block;
           position: relative;
           padding-left: 28px;
           cursor: pointer;
           font-size: 22px;
           -webkit-user-select: none;
           -moz-user-select: none;
           -ms-user-select: none;
           user-select: none;
           text-align: left;
           letter-spacing: 0px;
           color: #9f9f9f;
           font-size: 14px;
       }
       #session_list_parent .checckbox_container{
       		padding: 5px 28px;
       		float: left;
       		width: auto;
       }
       #session_list_parent{
       		overflow-y: scroll;
       }
       .checckbox_container input {
           position: absolute;
           opacity: 0;
           cursor: pointer;
           height: 0;
           width: 0;
       }
       .checkmark {
           position: absolute;
           top: -2px;
           left: 0px;
           height: 18px;
           width: 18px;
           background: transparent;
           border: 1px solid #9f9fa0;
           border-radius: 5px;
       }
       #session_list_parent .checkmark{
       		margin-top: 8px;
       }
       .checckbox_container:hover input ~ .checkmark {
           background: transparent;
           border: 1px solid #9f9fa0;
       }
       .checckbox_container input:checked ~ .checkmark {
           background: #4CD042 0% 0% no-repeat padding-box;
           border: 1px solid #4CD042;
       }
       .checkmark:after {
           content: "";
           position: absolute;
           display: none;
       }
       .checckbox_container input:checked ~ .checkmark:after {
           display: block;
       }
       .checckbox_container .checkmark:after {
           left: 6px;
           top: 3px;
           width: 3px;
           height: 8px;
           border: solid white;
           border-width: 0 2px 2px 0;
           -webkit-transform: rotate(45deg);
           -ms-transform: rotate(45deg);
           transform: rotate(45deg);
       }
       .session_manage{
           text-align: left;
           background: #F8F8F8 0% 0% no-repeat;
           padding: 17px;
       }
       .device_set{
           text-align: right;
           letter-spacing: 0px;
           color: #9f9f9f;
           font-size: 14px;
           float: right;
       }
       .session_recommand{
           padding: 8px 17px;
           background: #FFF8D9 0% 0% no-repeat padding-box;
           text-align: left;
           display: flex;
		   align-items: center;
		   gap: 7px;
       }
       .esc_mark {
           height: 18px;
           min-width: 18px;
           background: transparent linear-gradient(180deg, #E69200 0%, #F8B644 100%) 0% 0% no-repeat padding-box;
           border-radius: 50%;
           display: inline-block;
           font-size: 14px;
           color: #fff;
           padding: 1px;
           box-sizing: border-box;
           text-align: center;
       }
       .esc_mark:before {
           content:'\0021';
       }
       .session_note{
           font-size: 12px;
       }
       .device_div .checkmark{
           top: 12px;
        }
        .back_option{
        	height: 44px;
        	margin-top: 30px;
        	padding: 12px 0px;
    		box-sizing: border-box;
        }
        .back_option,.dlt_btn{
        	width: 50%;
        	float: left;
        	margin-top:20px;
        	margin-bottom: 20px;
        }
        .appicon{
        	display: inline-flex !important;
        }
        #sessionlist{
        	visibility: hidden;
        }
        .transitionClass{
        	overflow: hidden;
        	transition: height 0.5s ease-in-out;
        }
        .device_div{
        	margin: 0px 17px;
        }
        #continueoption{
        	width: 100%;
		    height: auto;
		    position: fixed;
		    bottom: -200px;
		    padding: 0px 20px;
		    box-sizing: border-box;
		    border-top : 1px solid #f0f0f0;
		    transition: all 0.3s ease-in-out;
		    background: #fff;
        }
        .back_option{
        	color: #1389e3;
        	font-size: 14px;
    		font-weight: 600;
        }
        #primary_info{   	
		    height: auto;
		    position: fixed;
		    padding: 0px 20px;
		    box-sizing: border-box;
		    border-top : 1px solid #f0f0f0;
		    transition: all 0.3s ease-in-out;
		    background: #fff;
		    box-shadow: 0px 0px 0px 1px #00000029;
		    border-radius: 16px 16px 0px 0px;
		    text-align: left;
		    line-height: 24px;
		    bottom: -500px;
		    padding-top: 20px;
        }
        .primary_title{
        	margin-top: 28px;
		    font-size: 16px;
		    font-weight: 600;
        }
        .primary_desc{
		    margin-top: 16px;
		    font-size: 14px;	
        }
        .primary_con{
		    margin: 16px 0px 50px 0px;
		    font-size: 14px;
		    color: #E56000;	
        }
        .close_icon {
		    display: inline-block;
		    height: 30px;
		    width: 30px;
		    background-color: #F4F4F4;
		    border-radius: 50%;
		    background-size: 60px;
		    float: right;
		    position: relative;
		    cursor: pointer;
		    margin: 0px;
		}
        .close_icon:before, .close_icon:after {
		    position: absolute;
		    left: 14px;
		    top: 9px;
		    content: ' ';
		    height: 10px;
		    width: 2px;
		    background-color: #ABABAB;
		    transform: rotate(315deg);
		}
		.close_icon:after {
		    transform: rotate(-135deg);
		}
		..device_opt{
		    height: 9px;    
		    border-left: 1px solid;
		    margin-left: 5px;
		}
		.device_cont{
		    color: #0BB700;
		    margin-left: 3px;
		}
		.info_icon{
    		transform: rotate(180deg);
    		height: 14px;
    		min-width: 14px;
    		font-size: 10px;
    		margin-left: 3px;
    		background: transparent;
    		border: 1px solid #cccccc;
		}
		.info_icon::before{
			color: #cccccc;
			font-size: 9px;
			padding: 1px;
		}
		.primaryDevice .checkmark{
			opacity: 0.5;
		}
		.primarydesc{
			color: #E56000;
		}
		.Errormsg{
			display: block;
			margin: auto;
			height: auto;
			min-width: 200px;
			width: fit-content;
			width: -moz-fit-content;
			max-width:600px;
			background-color: #032239;
			border-radius: 6px;
			position: fixed;
			top: -100px;
			left: 0px;
			right: 0px;
			transition: all .2s ease;
			padding: 0px 20px;
			z-index:2;
			display:flex;
			align-items: center;
			max-width: 400px !important;
	        padding: 0px;
	        min-width: 300px;
		}
		.error_icon{
			background-color: #FF676F;	
		}
		.error_icon:before, .error_icon:after {
		    position: absolute;
		    left: 9px;
		    top: 5px;
		    content: ' ';
		    height: 10px;
		    width: 2px;
		    background-color: #FFFFFF;
		}
		.error_icon:before {
		  transform: rotate(45deg);
		}
		.error_icon:after {
		  transform: rotate(-45deg);
		}
		.error_icon{
			display: inline-block;
			height: 20px;
			width: 20px;
			background-color: #22C856;
			border-radius: 50%;
			background-size: 60px;
			margin: 15px;
			float: left;
			position: relative;
		}
		.error_message{
	        max-width: 300px;
	    	width: 75%;
			display: inline-block;
			font-size: 14px;
			color: #fff;
			line-height: 18px;
			margin: 16px 0px;
			margin-right: 20px;
		}
	</style> 
	
	<script>
		window.onload=function(){
			onAnnouceReady();
			return false;
	    }
		
		var tranConHeight,tranDeviceHeight,tranSucHeight;
		var deletedCount = 0;
		var sessions = ${sessions};
		var client_id = sessions[0].client_id;
		var producticon = "${appname}".toLowerCase();
		var threshold = parseInt("${threshold}");
		var sessions_count = parseInt("${sessions_count}");
		var csrfParam= "${za.csrf_paramName}";
		var csrfCookieName = "${za.csrf_cookieName}";
		var totalSessions = sessions_count;
		var productLogo = "${productLogo}";
		<#if (('${token}')?has_content)>
			var mdm_token = '${token}';
		</#if>
		
		function onAnnouceReady(){
			loadAppDevice();
			document.getElementsByClassName("product-icon")[0].classList.add("product-icon-"+productLogo.split("_")[0].toLowerCase().replace(/\s/g, ''), "product-icon-"+productLogo.split("_")[1].toLowerCase().replace(/\s/g, ''));
			document.getElementsByClassName("remaining_count")[0].childNodes[1].append(threshold - sessions_count);
			tranConHeight = document.getElementsByClassName('hidden_class')[0].clientHeight;
			tranSucHeight = document.getElementsByClassName('success_con')[0].clientHeight;
			document.getElementsByClassName('hidden_class')[0].style.height = tranConHeight+"px";
			tranDeviceHeight = document.getElementById('sessionlist').clientHeight + 20;
			document.getElementById('sessionlist').style = document.getElementsByClassName('success_con')[0].style = "height:0px;visibility: visible;";
	        document.getElementById("svg_circle").setAttribute("stroke-dasharray",(2 * Math.PI * 40 * (sessions_count / 20))+" "+(2 * Math.PI * 40));
	        transitionHeight = document.getElementsByClassName('hidden_class')[0].clientHeight;
	        document.getElementsByClassName('hidden_class')[0].style.height = transitionHeight+"px";
	        if(sessions_count >= threshold){
	        	document.getElementsByClassName('do_later')[0].style.display = "none";
	        }
	        return false;
		}
		
		function isValid(instr) {
			return instr != null && instr != "" && instr != "null";
		}
		
		function IsJsonString(str) {
		    try {
		        JSON.parse(str);
		    } catch (e) {
		        return false;
		    }
		    return true;
		}
		
		function xhr() {
		    var xmlhttp;
		    if (window.XMLHttpRequest) {
			xmlhttp=new XMLHttpRequest();
		    }
		    else if(window.ActiveXObject) {
			try {
			    xmlhttp=new ActiveXObject("Msxml2.XMLHTTP");
			}
			catch(e) {
			    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
			}
		    }
		    return xmlhttp;
		}
		
		function getCookie(cookieName) {
			var nameEQ = cookieName + "=";
			var ca = document.cookie.split(';');
			for(var i=0;i < ca.length;i++) {
				var c = ca[i].trim();
				if (c.indexOf(nameEQ) == 0){ 
					return c.substring(nameEQ.length,c.length)
				};
			}
			return null;
		}
		
		function handleRelogin(json, method) {
			var serviceurl = encodeURIComponent(window.location.href); 
	    	var redirecturl = json.redirect_url;
	    	var url = window.location.origin + redirecturl +'?serviceurl='+serviceurl;//No I18N
	    	if("post" == method) {
	    		window.open(url + "&post=true", "_blank");
	    	} else {
	    		window.location.href = url;
	    	}
	    	return;
		}
		
		function addDeviceIcon(device_info){
			var img = device_info.device_img;
			var os = device_info.os_img;
			const paths = new Map([
				  ["windows", 5],
				  ["linux", 5],
				  ["osunknown", 4],
				  ["macbook", 8],
				  ["iphone", 9],
				  ["ipad", 7],
				  ["windowsphone", 8],
				  ["samsungtab", 6],
				  ["samsung", 5],
				  ["android", 8],
				  ["pixel", 6],
				  ["oppo", 8],
				  ["vivo", 6],
				  ["androidtablet",6],
				  ["oneplus", 7],
				  ["mobile", 7]
				]);
			
			var no_of_paths;
			var icon_class;
			
			if(img == "personalcomputer"){
				os = os ? os : "osunknown"; //No I18N
				no_of_paths = paths.get(os);
				icon_class = os + "_uk"; //No I18N
			} else if (img == "macbook" || img == "iphone" || img == "windowsphone" || img == "androidtablet") { //No I18N
				no_of_paths = paths.get(img);
				icon_class = img + "_uk"; //No I18N
			} else if (img == "vivo" || img == "ipad" || img == "samsungtab" || img == "samsung" || img == "pixel" || img == "oppo" || img == "oneplus") { //No I18N
				no_of_paths = paths.get(img);
				icon_class = img;
			}else if (img == "googlenexus" || (img == "mobiledevice" && os == "android")) { //No I18N
				no_of_paths = paths.get("android");
				icon_class = "android_uk"; //No I18N
			} 
			else if (img == "mobiledevice") { //No I18N
				no_of_paths = paths.get("mobile");
				icon_class = "mobile_uk"; //No I18N
			} 
			
			return "deviceicon-"+ icon_class;
		}
		function loadAppDevice(){
			var device_con = "";
			
			sessions.forEach(function(devices){
				if(isValid(devices)){
					device_info = devices.device_info;
					var primaryDevice_con = primaryElemClass = "";
					var disabled_state= "";
					if(device_info.is_primary){
						primaryDevice_con ='<span class="device_time device_opt"></span>\
											<span class="device_time device_cont">Primary Device</span>\
											<span class="device_time" onclick="slidePopup(0)">\
											    <span class="esc_mark info_icon"></span>\
											</span>';
						primaryElemClass = "primaryDevice";
						disabled_state = "disabled";
					}
					device_con += '<label id="device'+device_info.device_name+'" class="checckbox_container '+primaryElemClass+' device_div" onclick="checkSeletedDevices()">\
						                <span class="device_pic '+addDeviceIcon(device_info)+'"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span></span><span class="path7"></span><span class="path8"></span><span class="path9"></span><span class="path10"></span>\
						                <span class="device_details">\
						                    <span class="device_name">'+device_info.device_name+'</span>\
						                    <span class="device_time">'+devices.created_time_elapsed+'</span>'+primaryDevice_con+'\
						                </span>\
						                <input type="checkbox" '+disabled_state+' value='+devices.refresh_token_hash+' name="device">\
						                <span class="checkmark"></span>\
						            </label>'
						            
						        
		        }
			});
			document.getElementById("session_list_parent").innerHTML = device_con;
			return false;
		}
		
		function showDeviceList(){
			document.getElementsByClassName("session_parent")[0].style.height = window.outerHeight +"px";
			document.getElementsByClassName('hidden_class')[0].style.height = "0px";
			document.getElementsByClassName('session_img')[0].style.height = "0px";
			document.getElementsByClassName('session_title')[0].style.marginTop = "0px";
			document.getElementById('sessionlist').style.height = tranDeviceHeight+"px";
			document.getElementById('continueoption').style.bottom = "0px";
			checkSeletedDevices();
			var sesssion_list_height = window.innerHeight - (document.getElementById("session_count_list").clientHeight + document.getElementsByClassName("session_title")[0].clientHeight+ document.getElementsByClassName("logo_parent")[0].clientHeight + document.getElementById("continueoption").clientHeight +66);
			document.getElementById("session_list_parent").style.height = sesssion_list_height + "px";			
			return false;
		}
		
		function hideDeviceList(){
			document.getElementsByClassName("remaining_count")[0].childNodes[1].textContent =threshold - totalSessions;
			document.getElementsByClassName('session_img')[0].style.height = "140px";
			document.getElementsByClassName('hidden_class')[0].style.height = tranConHeight+"px";
			document.getElementsByClassName('session_title')[0].style.marginTop = "30px";
			document.getElementById('sessionlist').style.height ="0px";
			document.getElementById('continueoption').style.bottom = "-200px";
			if(sessions_count > totalSessions){
				document.getElementsByClassName('do_later')[0].style.display = "block";
			}
			document.getElementsByClassName("session_parent")[0].style.height = "auto";
			return false;
		}
		
		function showConfirmationTemplate(){
			document.getElementsByClassName('success_img')[0].style = "height:50px;margin:50px auto 30px auto;";
			document.getElementsByClassName('session_desc')[1].childNodes[0].textContent = deletedCount +" "; 
			document.getElementsByClassName('session_title')[0].textContent = '<@i18n key="IAM.APP.SESSION.MAX.LIMIT.DELETED.HEADER" />';
			document.getElementsByClassName('success_con')[0].style.height = tranSucHeight+"px";
			document.getElementById('sessionlist').style.height ="0px";
			document.getElementById('continueoption').style.bottom = "-200px";
			document.getElementsByClassName("session_parent")[0].style.height = "auto";
			var validcount =  sessions_count - document.getElementsByClassName("primaryDevice").length
			if(deletedCount >= validcount) {
				document.getElementsByClassName('do_later')[1].style.display = "none";
			}
			var elem = document.getElementsByName("device");
			for (var i = 0; i < elem.length; i++) {
				if(elem[i].checked){
					elem[i].parentElement.remove();
				}
			}
			totalSessions = totalSessions - deletedCount;
			return false;
		}
		
		function backToDelete(){
			document.getElementsByClassName('success_img')[0].style = "height:0px;margin:0px auto;";
			document.getElementsByClassName('session_title')[0].textContent = '<@i18n key="IAM.APP.SESSION.MAX.LIMIT.HEADER" />';
			document.getElementsByClassName('success_con')[0].style.height = "0px";
			document.getElementById('sessionlist').style.height = tranDeviceHeight+"px";
			var elem = document.getElementsByName("device");
			for (var i = 0; i < elem.length; i++) {
				if(elem[i].checked){
					elem[i].parentElement.remove();
				}
			}
			document.getElementsByClassName("session_parent")[0].style.height = window.outerHeight +"px";
			document.getElementsByClassName('device_set')[0] ='<@i18n key="IAM.APP.SESSION.MAX.LIMIT.SELECT" />';
			document.getElementById('continueoption').style.bottom = "0px";
			checkSeletedDevices();
			deletedCount = 0;
			return false;
		}
		
		function toggleAllDevice(){
			var selected = document.getElementById("allDevice").checked;
 			var elem = document.getElementsByName("device");
			for (var i = 0; i < elem.length; i++) {
				if(!elem[i].parentElement.classList.contains("primaryDevice")){
					elem[i].checked = selected;
				}
			}
			checkSeletedDevices();
			return false;
		}
		
		function checkSeletedDevices(){
			var selectedDeviceCount = 0;
			var elem = document.getElementsByName("device");
			for (var i = 0; i < elem.length; i++) {
				if(elem[i].checked){
					selectedDeviceCount++;
				}
			}
			document.getElementsByClassName("checckbox_container")[0].childNodes[0].textContent = '<@i18n key="IAM.APP.SESSION.MAX.LIMIT.ALL" />' + '(' + totalSessions + ')';
			var elem = document.getElementsByClassName("device_set")[0];
			var dltBtn = document.getElementsByClassName("dlt_btn")[0];
			var selectedCon = '<@i18n key="IAM.APP.SESSION.MAX.LIMIT.SELECT" />';
			dltBtn.disabled = true;
			if(selectedDeviceCount > 0){
				selectedCon = selectedDeviceCount + " " +'<@i18n key="IAM.APP.SESSION.MAX.LIMIT.DEVICE.COUNT"/>';
				dltBtn.disabled = false;
			}
			elem.textContent = selectedCon;
		}
				
		function deleteDeviceList(){
			var elem = document.getElementsByName("device");
			var selectedHash = [];
			for (var i = 0; i < elem.length; i++) {
				if(elem[i].checked){
					selectedHash.push(elem[i].value);
				}
			}
			if(selectedHash.length > 0){
				deletedCount += selectedHash.length;
				var deleteurl = "/webclient/v1/account/self/user/self/applogins/"+client_id+"/devices/"+selectedHash.toString();
				if(selectedHash.length == 1){
					deleteurl = "/webclient/v1/account/self/user/self/applogins/"+selectedHash[0]+"/devices/"+client_id;
				}
				if(document.getElementById("allDevice").checked){
					deleteurl = "/webclient/v1/account/self/user/self/applogins/all/devices/"+client_id;
				}
				if(typeof mdm_token !== 'undefined'){
					deleteurl+= "?token="+mdm_token;
				}
				sendRequestWithCallback(deleteurl, "" ,true, handleDeletedDetails,"DELETE");//No I18N
			}
			return false;
		}
		
		function handleDeletedDetails(jsonStr){
			if(IsJsonString(jsonStr)) {
				jsonStr = JSON.parse(jsonStr);
			}
			var statusCode = jsonStr.status_code;
			document.getElementsByClassName("dlt_btn")[0].disabled = false;
			if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) { 
				showConfirmationTemplate();
				return false;
			}else{
				if("PP112" == jsonStr.code) {
					handleRelogin(jsonStr, "post"); //No I18N
					return;
				}
				showErrorNotfication(jsonStr.localized_message);
				return false;
			}
		}
		
		function showErrorNotfication(msg){
			$(".error_message").html(msg);
			$(".Errormsg").css("top","20px");//No i18N
			window.setTimeout(function(){$(".Errormsg").css("top","-100px")},5000);
		}
		
		function sendRequestWithCallback(action, params, async, callback,method) {
			if (typeof contextpath !== 'undefined') {
				action = contextpath + action;
			}
		    var objHTTP = xhr();
		    objHTTP.open(method?method:'POST', action, async);
		    objHTTP.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
		    objHTTP.setRequestHeader('X-ZCSRF-TOKEN',csrfParam+'='+encodeURIComponent(getCookie(csrfCookieName)));
		    if(async){
			objHTTP.onreadystatechange=function() {
			    if(objHTTP.readyState==4) {
			    	if (objHTTP.status === 0 ) {
						handleConnectionError();
						return false;
					}
					if(callback) {
					    callback(objHTTP.responseText);
					}
			    }
			};
		    }
		    objHTTP.send(params);
		    if(!async) {
			if(callback) {
		            callback(objHTTP.responseText);
		        }
		    }
		} 
		
		function redirectToApp(){
			window.open("${visited_url}", "_self");
		}
		
		function slidePopup(position){
			document.getElementById('primary_info').style.bottom = position+"px";
		}
	</script>
</head>
<body>	
	 <div class="Errormsg"> <div style="position:relative;display:flex;align-items:center;"> <span class="error_icon"></span> <span class="error_message"></span> </div> </div>
	 <div class="session_parent">
	 	<div id="session_update">
	 		 <div class="success_img"></div>
	         <div class="logo_parent">
	       		<i class="product-icon appicon">
					<span class="path1"></span>
					<span class="path2"></span>
					<span class="path3"></span>
					<span class="path4"></span>
					<span class="path5"></span>
					<span class="path6"></span>
					<span class="path7"></span>
					<span class="path8"></span>
					<span class="path9"></span>
					<span class="path10"></span>
				</i>
	             <span class="display_name">${appname}</span>
	         </div>
	         <div class="session_img transitionClass"></div>
	         <div class="session_title"><@i18n key="IAM.APP.SESSION.MAX.LIMIT.HEADER" /></div>
	         <div class='hidden_class transitionClass'>
		         <div class="session_desc"><@i18n key="IAM.APP.SESSION.MAX.LIMIT.DESC"  arg0="${appname}" arg1="${threshold}" arg2="${appname}" /></div>
		
		         <div class="canvas_area">
		             <svg class="canvas_board" id="canvas_board" style="background:#fff;display:block;" width="60px" height="60px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">
		                 <g transform="translate(50,50)">
		                     <circle cx="0" cy="0" fill="none" r="40" stroke="#efefef" stroke-width="20" stroke-dasharray="250 250">
		                     </circle>
		                     <circle id="svg_circle" cx="0" cy="0" fill="none" r="40" stroke="#F9B21D" stroke-width="20" stroke-dasharray="0 250">
		                     </circle>
		                 </g>
		             </svg>
		             <div style="overflow:auto">
		                 <div class="session_count"><@i18n key="IAM.APP.SESSION.MAX.LIMIT.APP.LIMIT"  arg0="${threshold}"/></div>
		                 <div class="remaining_count"><@i18n key="IAM.APP.SESSION.MAX.LIMIT.USER.LIMIT" /></div>
		             </div>
		         </div>
		         <button class="btn" onclick='showDeviceList()'><@i18n key="IAM.APP.SESSION.MAX.LIMIT.MANAGE" /></button>
		         <a href="${visited_url}" target='_self'class="do_later" ><@i18n key="IAM.APP.SESSION.MAX.LIMIT.LATER"/></a>
	         </div>
	         <div class="success_con transitionClass">
		     	<div class="session_desc"><@i18n key="IAM.APP.SESSION.MAX.LIMIT.DELETED.DESC"  arg0="${appname}" /></div>
		     	<button class="btn" onclick='redirectToApp()'><@i18n key="IAM.APP.SESSION.MAX.LIMIT.GO.TO" arg0="${appname}" /></button>
			    <span class="do_later" onclick='backToDelete()'><@i18n key="IAM.APP.SESSION.MAX.LIMIT.DELETE.MORE" /></span>
		     </div>
	     </div>
		<div id='sessionlist' class="transitionClass">
			<div id="session_count_list">
		         <div class="session_manage">
		             <label class="checckbox_container" id="totalcount" onclick="toggleAllDevice()"><@i18n key="IAM.APP.SESSION.MAX.LIMIT.ALL" />
		                 <input type="checkbox" id="allDevice">
		                 <span class="checkmark"></span>
		             </label>
		             <span class="device_set"><@i18n key="IAM.APP.SESSION.MAX.LIMIT.SELECT" /></span>
		         </div>
		         <div class="session_recommand">
		             <span class="esc_mark"></span>
		             <span class="session_note"><@i18n key="IAM.APP.SESSION.MAX.LIMIT.RECOMENDED" /></span>
		         </div>
	        </div>
	         <div id="session_list_parent"></div>
	         <div id='continueoption'>
	         	<span class="back_option" onclick="hideDeviceList()"><@i18n key="IAM.BACK" /></span>
	         	<button class="btn dlt_btn" onclick="deleteDeviceList()"><@i18n key="IAM.DELETE" /></button>	
	         </div>
	      </div>
	      <div id='primary_info'>
	      		<div>
	      			<span class='primary_title'><@i18n key="IAM.APP.SESSION.MAX.LIMIT.PRIMARY.INFO" /></span>
	      			<span class="close_icon" onclick='slidePopup("-600")'></span>
	      		</div>
	      		<div class='primary_desc'><@i18n key="IAM.APP.SESSION.MAX.LIMIT.PRIMARY.HEADER" /></div>
	      		<div class='primary_con'><@i18n key="IAM.APP.SESSION.MAX.LIMIT.PRIMARY.DESC" /></div>
	      </div>
     </div>
</body>
</html>