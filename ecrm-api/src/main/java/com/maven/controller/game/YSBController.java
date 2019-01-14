package com.maven.controller.game;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Writer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.w3c.dom.Document;

import com.hy.pull.common.util.AESUtil2Net;
import com.maven.cache.SystemCache;
import com.maven.controller.BaseController;
import com.maven.entity.EmployeeApiAccout;
import com.maven.game.enums.GameEnum;
import com.maven.logger.LoggerManager;
import com.maven.util.StringUtils;
import com.maven.util.XMLUtil;

@Controller
@RequestMapping("/ysbgame")
public class YSBController extends BaseController {

	private static Logger logger = LoggerFactory.getLogger(YSBController.class);

	@Override
	public LoggerManager getLogger() {
		return null;
	}

	/**
	 * YSB体育认证
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/check")
	@ResponseBody
	public String ysbCheck(HttpServletRequest request, HttpServletResponse response) throws IOException {
		InputStreamReader reader = null;
		BufferedReader br = null;
		Writer write = null;
		String param = "";
		StringBuilder data = new StringBuilder("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		try {
			StringBuffer sb = new StringBuffer();
			reader = new InputStreamReader(request.getInputStream());
			br = new BufferedReader(reader);
			while ((param = br.readLine()) != null) {
				sb.append(param);
			}
			param = sb.toString();
			// <?xml version='1.0' encoding='utf-8'?><request
			// action='clogin'><element id='id001'><properties
			// name='UN'>E05_qb8888</properties><properties
			// name='VID'>PLAY8</properties><properties
			// name='SG'>d85d2e1474cd3a1d77572c5e394ee271</properties><properties
			// name='SN'>a3ab40e4-6504-4a6f-8a9a-13e6675c6389</properties></element></request>
			logger.info("YSB验证回调信息：" + param);
			if (org.springframework.util.StringUtils.isEmpty(param)) {
				data.append("<response action=\"clogin\">");
				data.append("<element id=\"id001\">");
				data.append("<properties name=\"S\">1</properties>");
				data.append("<properties name=\"ED\">Missing parameter</properties>");
				data.append("</element>");
				data.append("</response>");
				param = data.toString();
				write = response.getWriter();
				write.write(param);
				write.flush();
			} else {
				Document doc = XMLUtil.string2Doc(param);
				String userName = doc.getDocumentElement().getElementsByTagName("properties").item(0).getTextContent();
				String sign = doc.getDocumentElement().getElementsByTagName("properties").item(2).getTextContent();
				byte[] decryptFrom = AESUtil2Net.parseHexStr2Byte(sign);
				sign = AESUtil2Net.decryptAES(new String(decryptFrom, "utf-8"), AESUtil2Net.key, AESUtil2Net.iv);
				EmployeeApiAccout eaa = SystemCache.getInstance().getEmployeeGameAccount(sign.split(",")[1],
						GameEnum.Enum_GameType.YSB体育.gametype);
				if (eaa == null) {
					data.append("<response action=\"clogin\">");
					data.append("<element id=\"id001\">");
					data.append("<properties name=\"S\">1</properties>");
					data.append("<properties name=\"ED\">user not exist</properties>");
					data.append("</element>");
					data.append("</response>");
					param = data.toString();
				} else {
					if (sign.split(",")[0].equals(userName)) {
						data.append("<response action=\"clogin\">");
						data.append("<element id=\"id001\">");
						data.append("<properties name=\"UN\">%s</properties>");
						data.append("<properties name=\"UID\">%s</properties>");
						data.append("<properties name=\"CC\">0</properties>");
						data.append("<properties name=\"S\">0</properties>");
						data.append("<properties name=\"ED\"></properties>");
						data.append("</element>");
						data.append("</response>");
						param = String.format(data.toString(), userName, eaa.getEmployeecode());
					} else {
						data.append("<response action=\"clogin\">");
						data.append("<element id=\"id001\">");
						data.append("<properties name=\"S\">1</properties>");
						data.append("<properties name=\"ED\">user not exist</properties>");
						data.append("</element>");
						data.append("</response>");
						param = data.toString();
					}
				}
				logger.info("验证返回信息：" + param);
				write = response.getWriter();
				write.write(param);
				write.flush();
			}
		} catch (Exception e) {
			logger.error("YSB验证失败", e);
		} finally {
			write.close();
			br.close();
			reader.close();
		}
		return null;
	}
}
