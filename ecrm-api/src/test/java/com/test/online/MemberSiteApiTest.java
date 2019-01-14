package com.test.online;

import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import org.apache.xerces.impl.dv.util.Base64;

import com.hy.pull.common.util.RSAUtil;
import com.hy.pull.common.util.game.sa.XmlUtil;
import com.maven.payment.yee.utils.DigestUtil;
import com.maven.util.Encrypt;
import com.maven.util.RSACoder;
import com.maven.util.RSASignature;

import junit.framework.TestCase;


public class MemberSiteApiTest  extends TestCase {
	
	public static final  String URL = "http://li1549-211.members.linode.com:7070/ecrm-api";
	
	public static final String AES_KEY = "foT0LfqaqZv4jJt8";
	
	public static final String MD5_KEY = "Rwv0tmdzvGHYHnco";
	
	public static final String ENTERPRISECODE = "EN0045";
	
	public static final String ENTERPRISECODE_EN0044 = "EN0044";
	
	public static final String AES_KEY_EN0044 = "R71rtoQ2ZVAFui9Z";
	
	public static final String MD5_KEY_EN0044 = "Vsgnm4qai0473AGe";
	
	
	
	public static final String BRANDCODE = "EB0000AV";
	
	public static final String EMPLOYEECODE="E00000C3";
	
	
	public  void regesterAgent(){
		try {
			String url = URL+"/Agent/Register?enterprisecode="+ENTERPRISECODE;
			String params = "loginaccount=yijdaili6&loginpassword=111222333&domain=002y.redhat.com";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("注册代理:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void regesterMember(){
		try {
			String url = URL+"/User/register?enterprisecode="+ENTERPRISECODE;
			String params = "brandcode="+BRANDCODE+"&loginaccount=testuser4&loginpassword=111222333&fundpassword=88888&displayalias=秦始皇&domain=http://www.google.com";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("注册会员:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void login(){
		try {
			String url = URL+"/User/login?enterprisecode="+ENTERPRISECODE;
			String params = "loginaccount=testuser&loginpassword=123456789&loginip=169.36.59.48&browserversion=firefox/45.0&opratesystem=Windows 10";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("用户登陆:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	

	
	public  void getHYAccout(){
		try {
			String url = URL+"/Game/getLoginInfo?";
			String params = "user=bssnow&password=123456";
			String aesparams = Encrypt.AESEncrypt(params, "jnql6H9dX1PaLZGX");
			url += "signature="+Encrypt.MD5(params+"6mQegshJJKMH5j7P")+"&params="+aesparams;
			System.out.println("手机登陆:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void getPTAccout(){
		try {
			String url = URL+"/Game/PtLogin?enterprisecode="+ENTERPRISECODE;
			String params = "employeecode=E000IF1J";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("PT登陆:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void isRunGame(){
		try {
			String url = "http://192.168.1.207:9090/ecrm/Game/gamestatus?enterprisecode="+ENTERPRISECODE;
			String params = "gameType=PTGame&brandcode=EB00001L";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("游戏状态:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	public  void play(){
		try {
			String url = URL+"/Game/play?enterprisecode="+ENTERPRISECODE;
			String params = "employeecode=E000IF6Z&gametype=ZJGame&brandcode=EB000027";
			String aesparams= Encrypt.AESEncrypt(params, "FSmrFkJOrPzFRdO5");
			url += "&signature="+Encrypt.MD5(params+"aST5TdfmVokT35iJ")+"&params="+aesparams;
			System.out.println("进入游戏:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void phonePlay(){
		try {
			String url = URL+"/Game/GWakeUp?enterprisecode="+ENTERPRISECODE;
			String params = "employeecode=E0000000&gametype=AVGame&brandcode="+BRANDCODE+"&application=h5";
			String aesparams = Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("唤起登陆:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void tryPlay(){
		try {
			String url = URL+"/Game/tryPlay?enterprisecode=EN003B";
			String params = "gametype=ZJGame";
			String aesparams= Encrypt.AESEncrypt(params, "FSmrFkJOrPzFRdO5");
			url += "&signature="+Encrypt.MD5(params+"aST5TdfmVokT35iJ")+"&params="+aesparams;
			System.out.println("进入游戏:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public  void balances(){
		try {
			String url = URL+"/Game/balances?enterprisecode="+ENTERPRISECODE;
			String params = "employeecode=E000K4LL";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("所有游戏余额:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void balance(){
		try {
			String url = URL+"/Game/balance?enterprisecode="+ENTERPRISECODE;
			String params = "employeecode=E000K4LL&gameType=BET67GDSX";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("单个游戏余额:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void gameOrders(){
		try {
			String url = URL+"/GRecords/Records?enterprisecode="+ENTERPRISECODE;
			String params = "gametype=NHQGame&employeecode=E0000000&start=0&limit=10";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("游戏记录:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void takeEmployee(){
		try {
			String url = URL+"/User/takeEmployee?enterprisecode="+ENTERPRISECODE;
			String params = "employeecode=E00000C3";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("通过编号获取用户信息:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void updateLoginPassword(){
		try {
			String url = URL+"/User/updatepwd?enterprisecode="+ENTERPRISECODE;
			String params = "employeecode=E00000C3&oldloginpassword=111222333&newloginpassword=111222333";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("修改登陆密码:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void updateFunPassword(){
		try {
			String url = URL+"/User/updatefpwd?enterprisecode="+ENTERPRISECODE;
			String params = "employeecode=E00000C3&oldfundpassword=88888&newfundpassword=88888";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("修改资金密码:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void addBankCard(){
		try {
			String url = URL+"/User/AddUBankCard?enterprisecode="+ENTERPRISECODE;
			String params = "employeecode=E00000C3&paymentaccount=5646546546464646&accountname=王石&openningbank=龙山支行&bankcode=B004&fundpassword=88888";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("添加银行卡:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void editBankCard(){
		try {
			String url = URL+"/User/EditUBankCard?enterprisecode="+ENTERPRISECODE;
			String params = "employeecode=E00000C3&informationcode=EEI0001I&fundpassword=88888&paymentaccount=2222222222222222222&accountname=王岐山&openningbank=萨拉支行&qq=123456546&skype=21faaf&email=aaaa@son.com";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("添加银行卡:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void delBankCard(){
		try {
			String url = URL+"/User/DeleteUBankCard?enterprisecode="+ENTERPRISECODE;
			String params = "employeecode=E00000C3&informationcode=EEI0001I&fundpassword=888888";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("删除银行卡:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void sysMessage(){
		try {
			String url = URL+"/UserMessage/SysMessage?enterprisecode="+ENTERPRISECODE;
			String params = "employeecode=E00000C3";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("系统消息:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void agentMessage(){
		try {
			String url = URL+"/UserMessage/AgentMessage?enterprisecode="+ENTERPRISECODE;
			String params = "employeecode=E00000C3";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("用户消息:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void messageCount(){
		try {
			String url = URL+"/UserMessage/MessageCount?enterprisecode="+ENTERPRISECODE;
			String params = "employeecode=E00000C3";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("未读消息:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void employeeAllBankCard(){
		try {
			String url = URL+"/User/UBankCards?enterprisecode="+ENTERPRISECODE;
			String params = "employeecode=E00000C3";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("读取用户所有银行卡:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void employeeSingleBankCard(){
		try {
			String url = URL+"/User/UBankCards?enterprisecode="+ENTERPRISECODE;
			String params = "employeecode=E00000C3&informationcode=EEI0001I";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("读取用户单张银行卡:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void eThirdpartys(){
		try {
			String url = URL+"/TPayment/EThirdpartys?enterprisecode="+ENTERPRISECODE;
			String params = "enterprisecode="+ENTERPRISECODE;
//					+"&type=H5";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("读取企业第三方支付:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void enterpriseBankCard(){
		try {
			String url = URL+"/Funds/EBankCards?enterprisecode="+ENTERPRISECODE;
			String params = "enterprisecode="+ENTERPRISECODE;
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("读取企业收款银行卡:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void saving(){
		try {
			String url = URL+"/Funds/Saving?enterprisecode="+ENTERPRISECODE;
			String params = "brandcode="+BRANDCODE+"&employeecode=E00000C3&orderamount=200&enterpriseinformationcode=EI00001K&employeepaymentbank=B006&employeepaymentaccount=555555555555555555&employeepaymentname=马云&traceip=195.125.12.62&ordercomment=test";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("用户存款:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void getVerifycode(){
		try {
			String url = "http://192.168.1.187:8081/ecrm-api/User/getVerifycode?enterprisecode="+ENTERPRISECODE;
			String params = "brandcode=EB00001M&phoneno=18201602264&ip=10.46.50.134";
			String aesparams= Encrypt.AESEncrypt(params,AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("获取验证码:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void ESaving(){
		try {
			String url = URL+"/TPayment/ESaving?enterprisecode="+ENTERPRISECODE;
			String params = "brandcode="+BRANDCODE+"&bankcode=B034&employeecode=E000K4LL&orderamount=1&enterprisethirdpartycode=EP00008E&traceip=192.168.1.21";
			System.out.println("玩吧娱乐用户第三方即时存款params:"+params);
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("玩吧娱乐用户第三方即时存款:"+url);
			
			//巅峰会
			String url_EN0044 = URL+"/TPayment/ESaving?enterprisecode="+ENTERPRISECODE_EN0044;
			String params_EN0044 = "brandcode="+BRANDCODE+"&bankcode=B021&employeecode=E000K4N3&orderamount=300.03&enterprisethirdpartycode=EP000084&traceip=192.168.1.21";
			System.out.println("巅峰会用户第三方即时存款params:"+params_EN0044);
			String aesparams_EN0044= Encrypt.AESEncrypt(params_EN0044, AES_KEY_EN0044);
			url_EN0044 += "&signature="+Encrypt.MD5(params_EN0044+MD5_KEY_EN0044)+"&params="+aesparams_EN0044;
			System.out.println("巅峰会用户第三方即时存款:"+url_EN0044);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void testyeesign(){
		try {
			StringBuffer sValue = new StringBuffer();
			// 商户编号
			sValue.append("10001126856");
			// 业务类型
			sValue.append("Buy");
			// 支付结果
			sValue.append("1");
			// 易宝支付交易流水号
			sValue.append("2131458787aaa4478q5");
			// 支付金额
			sValue.append("200");
			// 交易币种
			sValue.append("RMB");
			// 商品名称
			sValue.append("A");
			// 商户订单号
			sValue.append("04A85CD7DDEC45359552DAAD8319AA0C");
			// 易宝支付会员ID
			sValue.append("12545778");
			// 商户扩展信息
			sValue.append("");
			// 交易结果返回类型
			sValue.append("1");
			String sNewString = null;
			sNewString = DigestUtil.hmacSign(sValue.toString(), "69cl522AV6q613Ii4W6u8K6XuW8vM1N6bFgyv769220IuYe9u37N4y7rI4Pl");
			System.out.println(sNewString);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void saveOrders(){
		try {
			String url = URL+"/Fetch/SaveOrder?enterprisecode="+ENTERPRISECODE;
			String params = "brandcode="+BRANDCODE+"&employeecode=E000IF1J&orderstatus=2&start=0&limit=10";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("用户存款记录:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void takeing(){
		try {
			String url = URL+"/Funds/Taking?enterprisecode="+ENTERPRISECODE;
			String params = "brandcode="+BRANDCODE+"&employeecode=E00000C3&orderamount=20&ordercomment=xfyladmin&informationcode=EEI0001I&traceip=195.36.69.78&fundpassword=88888";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("用户取款:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void takeOrders(){
		try {
			String url = URL+"/Fetch/TakeOrder?enterprisecode="+ENTERPRISECODE;
			String params = "brandcode="+BRANDCODE+"&employeecode=E000IF1I&orderstatus=2&start=0&limit=10";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("用户取款记录:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void takeAllDomainConfig(){
		try {
			String url = URL+"/Domain/TakeAllDomainConfig?enterprisecode="+ENTERPRISECODE;
			String params = "enterprisecode="+ENTERPRISECODE;
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("获取所有域名配置信息:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void takeDomainConfig(){
		try {
			String url = URL+"/Domain/TakeDomainConfig?enterprisecode="+ENTERPRISECODE;
			String params = "domain=www.baidu.com";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("获取单个域名配置信息:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void enterpriseInfo(){
		try {
			String url = URL+"/Domain/enterpriseInfo?";
			String params = "enterprisecode="+ENTERPRISECODE;
			String aesparams= Encrypt.AESEncrypt(params, "i9Q30JYMf06NmBCJ");
			url += "signature="+Encrypt.MD5(params+"XjvTLI6p0mOQK051")+"&params="+aesparams;
			System.out.println("获取企业KEY:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public  void takeNotic(){
		try {
			String url = URL+"/Notic/Notic?enterprisecode="+ENTERPRISECODE;
			String params = "enterprisecode=EN0000&brandcode="+BRANDCODE+"&start=0&limit=3";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("获取公告:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void eRegisterSave(){
		try {
			String url = URL+"/Statistics/ERegisterSave?enterprisecode="+ENTERPRISECODE;
			String params = "enterprisecode="+ENTERPRISECODE;
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("统计企业注册总数与充值总数:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  void contact(){
		try {
			String url = URL+"/Domain/Contact?enterprisecode="+ENTERPRISECODE;
			String params = "brandcode=EB00001L";
			String aesparams= Encrypt.AESEncrypt(params, AES_KEY);
			url += "&signature="+Encrypt.MD5(params+MD5_KEY)+"&params="+aesparams;
			System.out.println("品牌联系方式:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public  void eBGame(){
		try {
			String url = URL+"/EnterpriseBrand/EBrandGame?enterprisecode=EN0030";
			String params = "brandcode="+BRANDCODE;
			String aesparams= Encrypt.AESEncrypt(params, "1IMBHOq1sl3SxJIm");
			url += "&signature="+Encrypt.MD5(params+"6qe2lNoQC0c8kJ24")+"&params="+aesparams;
			System.out.println("企业游戏:"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public  void LePayment(){
		try {
//			String url = URL+"TPayment/ESaving?enterprisecode=EN003A";
			String url = "http://localhost:8080/ecrm-api/TPayment/ESaving?enterprisecode=EN003A";
			String params = "brandcode=EB0000B7&employeecode=E000IXX9&orderamount=10&enterprisethirdpartycode=EP00004U&paymenttypebankcode=ALIPAYQR&bankcode=B020&traceip=127.0.0.1";
			String aesparams= Encrypt.AESEncrypt(params, "7Tz0fh0LJYHBp8qR");
			url += "&signature="+Encrypt.MD5(params+"Mm1WabXtjIgfUUPB")+"&params="+aesparams;
			System.out.println("乐信付接口:\n"+url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static String buildSignStr(Map<String, Object> params) {
        StringBuilder sb = new StringBuilder();
        // 将参数以参数名的字典升序排序
        Map<String, Object> sortParams = new TreeMap<String, Object>(params);
        // 遍历排序的字典,并拼接"key=value"格式
        for (Map.Entry<String, Object> entry : sortParams.entrySet()) {
            if (sb.length()!=0) {
                sb.append("&");
            }
            sb.append(entry.getKey()).append("=").append(entry.getValue());
        }
        return sb.toString();
    }
	
	public static void main(String[] args) throws Exception {
//		http://li1549-211.members.linode.com:7070/ecrm-api/TPayment/EThirdpartys?enterprisecode=EN0044&signature=ceb9c0382acc3f39e043dc857e5114e9&params=Zd%2BsIclalEjI7F%2FdC0uKAIa3NDsqeSqjYejn5HSSZuE%3D
		MemberSiteApiTest a = new MemberSiteApiTest();
		a.eThirdpartys();
			String url = "http://localhost:8090/ecrm-api/GRecords/Records?enterprisecode=EN0045";
			String params = "employeecode=E00000C3&enterprisebrandactivitycode=23&start=0&limit=20&orderid=4444&gametype=BET67ABSX&StartDate=2018-01-09 12:22:00.0";
			String aesparams= Encrypt.AESEncrypt(params, "foT0LfqaqZv4jJt8");
			url += "&signature="+Encrypt.MD5(params+"Rwv0tmdzvGHYHnco")+"&params="+aesparams;
			//System.out.println(DigestUtils.sha("A"));
			//String md5Key = Encrypt.MD5("f8b1a683b6e514a0");
			//String bfbSige = "amt=1.5&notifyUrl=http://172.105.220.190:7070/ecrm-api/TPayment/ESaving&orderNo=linktest123456789&payType=3&requestTime=20180216222222&spId=bifubaotest01&version=1.0&key="+md5Key;
			String scanPay = "MERCHANT_ID=SP20180301180303&NO_URL=www.baidu.com&REMARK=test&SUBMIT_TIME=20180301201212&TRAN_AMT=300.03&TRAN_CODE=linktest12345678923&TYPE=3&VERSION=1f8b1a683b6e514a0";
			String bankPay = "BANK_ID=1006&MERCHANT_ID=SP20180301180956&NO_URL=www.baidu.com&REMARK=test&SUBMIT_TIME=20180301201212&TRAN_AMT=100&TRAN_CODE=linktest1234567894&VERSION=17bf1f31e12ce4e1a";
			System.out.println("必付宝扫码支付sign:"+Encrypt.MD5(scanPay));
			System.out.println("必付宝网银支付sign:"+Encrypt.MD5(bankPay));
			
			Long timestimp = new Date().getTime();
			String jiefuPayMd5Key = "95d2bf86cfaca11de45bd3f26601eaff";
			String paramsJF = "partner=17467&banktype=QQ&paymoney=1.12&ordernumber=A_"+timestimp+"&callbackurl=www.baidu.com";
			String jiefuPay = paramsJF+jiefuPayMd5Key;
			String jiefuSign = Encrypt.MD5(jiefuPay);
			String jiefuPay2 = paramsJF+"&isshow=0&sign="+jiefuSign;
			System.out.println("捷付支付URL:http://pay.6bpay.com/PayBank.aspx?"+jiefuPay2);
			
			
			//以下为速龙支付相关内容
			String str = "client_ip=130.105.220.28&interface_version=V3.1&merchant_code=103103125016&notify_url=www.baidu.com&order_amount=1.01&order_no=1525877251827&order_time=2013-11-01 12:34:58&product_name=DFHG750Y47JX-BL&service_type=tenpay_scan";
			String privateKey2 = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBANqVmZiNpLm4fuW0"
					+"FAGZKAacHMUQYbI1zszo3ShDDs+hGL4oOI9zAUmZ0M+SunGgjqUwXDGdBmtmolSP"
					+"SGAFyaBTYLlt1pExL7OJ9GhvI31WSs6NtjLUv9ENnd/nLIJn/nL7CCc+wKUlJ3fq"
					+"lHz3zd6xuohB0PtvuK6kIbsRMa0bAgMBAAECgYBmQn6tA/cAe/PB+tExPjmffgFn"
					+"oBZUjR/GdVqhr12KfU9aBu8PDTqY+EDcG0TmS7rwRQOcol2SeV2QOcgeRBbi8PoD"
					+"7Q3KiXe/qHk0k5CMFgaYm4/+4PEZjw4tWZmHHN5rMyZY6oD8ov+JqYYVGbAVesFP"
					+"i1EeJYGj5J6hkl4mQQJBAPleLnjSkW78wbU0kPVV4OeP5vQTFEC2tl7Kwu4/92+f"
					+"KCPFqrEHZoxiiDlcpE1DgZuHL3twF8PtMQ+lpgFUYkMCQQDgZdRGU6h1/29GMnTx"
					+"j6BRlYsI4f0SWV+dwpxjxn71yaqMTOgF6L6UhrWR5HYs/EJ6TmFi8gb8HsZeua8w"
					+"IThJAkEA1mdf1YpWePLhKgfUStxXz0Eu9dQhqbJvAvmauHZPLK3POVKO/D68sR9W"
					+"uNsqeTP9j9efv6YVCOQ7NpTaMnJ3OQJBALMPjrwvtZWzJtAVI0w/F+cCNdf4vUEP"
					+"IEV7LeBQXK81JWqfU+ajOrC6bdjlPYfYJBQEx6F1EC3PQOwFr83wNEECQBd1SwTj"
					+"ItusloP18dMINa37pMrhrUJH70HbYbpDOkZ0Sq7wBF6goSQqVst7Ibug56V7dlAZ"
					+"Lxp2hwI8RrZKc1o=";
			
			
			String suLongJsp = "client_ip=120.237.123.242&interface_version=V3.1&merchant_code=103103125016&notify_url=b1633e2216.iask.in:40405/ZHJL_Demos/Notify_Url.jsp&order_amount=0.01&order_no=20180510204239&order_time=2018-05-10 20:42:38&product_name=iPhone&service_type=ylpay_scan";			
			
			Map<String,Object> suLongParamsMap = new HashMap<String,Object>();
			suLongParamsMap.put("merchant_code", "103103125016");
			suLongParamsMap.put("service_type", "tenpay_scan");
			suLongParamsMap.put("notify_url", "www.baidu.com");
			suLongParamsMap.put("interface_version", "V3.1");
			suLongParamsMap.put("client_ip", "130.105.220.28");
			suLongParamsMap.put("order_no","1525877251827");
			suLongParamsMap.put("order_time", "2013-11-01 12:34:58");
			suLongParamsMap.put("order_amount", "1.01");
			suLongParamsMap.put("product_name", "DFHG750Y47JX-BL");
			final String suLongQQPayParams =  buildSignStr(suLongParamsMap);
			System.out.println("速龙，待签名的数据：" + suLongQQPayParams);	
			String sign =  RSASignature.sign(suLongJsp,privateKey2,"utf-8");
			
			System.out.println("速龙，签名后的数据sign：" + sign);
			System.out.println("速龙，签名后的数据：" +suLongQQPayParams+"&sign_type=RSA&sign="+sign);
			System.out.println("速龙，签名后的数据：" +suLongQQPayParams+"&sign_type=RSA&sign="+RSAUtil.rsaSign(suLongQQPayParams, privateKey2,  "UTF-8"));
			
			
			String publicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDalZmYjaS5uH7ltBQBmSgGnBzF"
					+"EGGyNc7M6N0oQw7PoRi+KDiPcwFJmdDPkrpxoI6lMFwxnQZrZqJUj0hgBcmgU2C5"
					+"bdaRMS+zifRobyN9VkrOjbYy1L/RDZ3f5yyCZ/5y+wgnPsClJSd36pR8983esbqI"
					+"QdD7b7iupCG7ETGtGwIDAQAB";
			System.out.println(RSASignature.doCheck(suLongQQPayParams, "eRl57SmKvkHbPhyMUJ2Kf0Vtp2Tg34OnWOxUtXy9ckARdevrKrM2uNgNrG8PYx7EmPXqbMrr5G28UHrEWuJjyl12MKzOaAi3BxXopLR56Irc7bQxxk1OXMX4KYY+qe6DgVGF3Brl10ZZZKOuTJPlAgxQ+neOVjI10IGobl6Pndg=", publicKey,"utf-8"));
			
			System.out.println(RSASignature.doCheck("client_ip=130.105.220.28&interface_version=V3.1&merchant_code=103103125016&notify_url=www.baidu.com&order_amount=1.01&order_no=1525877251827&order_time=2013-11-01 12:34:58&product_name=DFHG750Y47JX-BL&service_type=tenpay_scan", "eRl57SmKvkHbPhyMUJ2Kf0Vtp2Tg34OnWOxUtXy9ckARdevrKrM2uNgNrG8PYx7EmPXqbMrr5G28UHrEWuJjyl12MKzOaAi3BxXopLR56Irc7bQxxk1OXMX4KYY+qe6DgVGF3Brl10ZZZKOuTJPlAgxQ+neOVjI10IGobl6Pndg=", publicKey,"utf-8"));
			
			
			String xmlStr = " <dinpay><response><resp_code>FAIL</resp_code><respdesc>验签失败</respdesc><result_code>1</result_code></response></dinpay>";
			Map<String, String> mapString = XmlUtil.getQueryParams(xmlStr);
			System.out.println(mapString);
	}
	
}
