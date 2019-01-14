<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsps/layout/base-header.jsp"%>
<!DOCTYPE>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>总览</title>
	<style type="text/css">
		body,ul,li,ol,p,h1,h2,h3{ list-style:none; padding:0; margin:0;}
    	.center_body{ width:100%; }
		.clear{ clear:both}
		.c_b_top{background:#e8e9ee; height:103px; border-radius:6px;width:99%; margin:0 auto; overflow:hidden; margin-top:12px;}
		.c_b_center{background:#e8e9ee; border-radius:6px; width:99%; margin:0 auto; overflow:hidden; margin-top:12px; padding-bottom:20px;}
		.c_b_center_tab{width:98%; margin:0 auto; margin-top:12px;}
		.c_b_center_tab ul li{ float:left; font-family:"微软雅黑"; text-align:center; font-size:14px; color:#333; width:111px; height:29px; line-height:29px; background:url(${statics}/img/repost_tab_bg.png) left no-repeat; cursor:pointer}
		.c_b_center_tab ul li.hover{ background:url(${statics}/img/repost_tab_bg_hover.png) left no-repeat;}
		.c_b_center_souy{width:40%; background:#fff; border:1px #d3d3db solid; margin-top: 12px; margin-left: 50px;}
		.licst{width: 99%; margin: 0 auto; overflow: hidden; background: #e8e9ee; margin-bottom: 10px; margin-top: 10px;}
	
		.licst ol li{ float:left; width:33.2%; text-align:center; font-family:"微软雅黑"; font-size:28px; color:#333; line-height:50px; color:#1b2352}
		.cb_tcent{ height:76px; width:98%; background:#fff; margin:0 auto; margin-top:12px;}
		.cb_tcent ul { border:1px #a0a0a0 solid;overflow:hidden}
		.cb_tcent ul li{ border-right:1px #a0a0a0 solid; float:left; height:76px; line-height:76px; color:white; text-indent:2em;font-family:"微软雅黑"; position:relative; font-size: 20px; font-weight: bold;}
		.cb_tcent ul li font{ color:white; font-weight:bold; font-size:30px; float: right; padding-right: 20px;}
		.cb_tcent ul li span{ display:block; float:left; background:#f65c5c; width:15%; color:#fff;text-align: center;text-indent: 0;}
		.cb_tcent ul li b{ float:left; display:block; background:#3993ff; width:10%; color:#fff; font-weight:normal;    text-align: center;text-indent: 0;}
		.cb_tcent ul li p{ float:left; z-index:1000}
    </style>
</head>

<body>
	<div class="center_body">
    	<div class="c_b_top">
        	<div class="cb_tcent">
            	<ul>
                	<li style="background-color: #ED5666; width:24.939%;">玩家总数: <font id="totalMembers">---- ----</font></li>
                	<li style="background-color: #3698DC; width:24.939%;">今日登录玩家数: <font id="dailyMembers">---- ----</font></li>
                	<li style="background-color: #8E45AD; width:24.939%;">今日注册玩家数: <font id="dailyRegisteredMembers">---- ----</font></li>
                	<li style="background-color: #24C6C8; width:24.78%;">在线玩家数: <font id="hourMembers">---- ----</font></li>
                </ul>
            </div>
        </div>
        <div class="c_b_top">
        	<div class="cb_tcent">
            	<ul>
                	<li style="background-color: #FF69B4; width:100%; float: none;">余额: <font id="totalBalance" style="float: none;">---- ----</font></li>
                </ul>
            </div>
        </div>
        <div class="c_b_top">
        	<div class="cb_tcent">
            	<ul>
                	<li style="background-color: #1AB394; width:49.935%;">今日存款次数: <font id="dailyDeposits">---- ----</font></li>
                	<li style="background-color: #F8AC5A; width:49.7%;">今日取款次数: <font id="dailyWithdrawals">---- ----</font></li>
                </ul>
            </div>
        </div>
        <!--综合报表菜单-->
        <div class="c_b_center">
<!--         	<div class="c_b_center_tab">
             	<ul>
                	<li id="repost1" onclick="setTab('repost',1,6)"  data-date="today" class="hover reportswithcard">今日</li>
                	<li id="repost2" onclick="setTab('repost',2,6)"  data-date="yesterday" class="reportswithcard" >昨日</li>
                	<li id="repost3" onclick="setTab('repost',3,6)"  data-date="thisweek" class="reportswithcard">本周</li>
                	<li id="repost4" onclick="setTab('repost',4,6)"  data-date="lastweek" class="reportswithcard">上周</li>
                	<li id="repost5" onclick="setTab('repost',5,6)"  data-date="thismonth" class="reportswithcard">本月</li>
                	<li id="repost6" onclick="setTab('repost',6,6)"  data-date="lastmonth" class="reportswithcard">上个月</li>
                </ul>
            </div> -->
            <!-- <div class="clear"></div> -->
            <div class="c_b_center_souy" style="position: absolute;">
		        <div id="depositReport" style="width: auto; height: 450px;"></div>
            </div>
           	<!-- <div class="clear"></div> -->
            <div class="c_b_center_souy" style="margin-left: 900px;">
            	<div id="withdrawalReport" style="width: auto; height: 450px;"></div>
            </div>
	        
        </div>
        <!--综合报表菜单End-->

<%--         <div class="c_b_top">
        	<div class="cb_tcent">
            	<ul>
                	<li style="background-color: #1AB394; width:24.939%;">
						<table>
							<thead>
								<tr>
									<th>#</th>
									<th>Account</th>
									<th>Count</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>egg</td>
									<td>25</td>
								</tr>
								<tr>
									<td>2</td>
									<td>egg</td>
									<td>20</td>
								</tr>
							</tbody>
						</table>
					</li>
                	<li style="background-color: #F8AC5A; width:24.939%;">
						<table>
							<thead>
								<tr>
									<th>#</th>
									<th>Account</th>
									<th>Amount</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>egg</td>
									<td>5000</td>
								</tr>
								<tr>
									<td>2</td>
									<td>egg</td>
									<td>4800</td>
								</tr>
							</tbody>
						</table>
					</li>
                	<li style="background-color: #1AB394; width:24.939%;">
						<table>
							<thead>
								<tr>
									<th>#</th>
									<th>Account</th>
									<th>Count</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>egg</td>
									<td>30</td>
								</tr>
								<tr>
									<td>2</td>
									<td>egg</td>
									<td>27</td>
								</tr>
							</tbody>
						</table>
					</li>
                	<li style="background-color: #F8AC5A; width:24.939%;">
						<table>
							<thead>
								<tr>
									<th>#</th>
									<th>Account</th>
									<th>Amount</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>egg</td>
									<td>5000</td>
								</tr>
								<tr>
									<td>2</td>
									<td>egg</td>
									<td>4800</td>
								</tr>
							</tbody>
						</table>
					</li>
                </ul>
            </div>
        </div> --%>
       
    </div>
<script type="text/javascript" src="${statics}/js/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="${statics}/js/g2/data-set.min.js"></script>
<script type="text/javascript" src="${statics}/js/g2/g2.min.js"></script>
<script type="text/javascript">
$(function(){
	$.ajax({
		url : '${ctx}/Pandect/ETotalMembers',
		dataType : 'json',
		success  : function(data) {
			if (data.status == 1) {
				var num = Number(data.data);
				$("#totalMembers").text(num.toLocaleString());
			} else {
				console.error(data.message);
			}
		},
		error : function() {
			console.error('请求失败');
		}
	});
	$.ajax({
		url : '${ctx}/Pandect/EDailyActiveMembers',
		dataType : 'json',
		success  : function(data) {
			if (data.status == 1) {
				var num = Number(data.data);
				$("#dailyMembers").text(num.toLocaleString());
			} else {
				console.error(data.message);
			}
		},
		error : function() {
			console.error('请求失败');
		}
	});
	$.ajax({
		url : '${ctx}/Pandect/EHoursActiveMembers',
		dataType : 'json',
		success  : function(data) {
			if (data.status == 1) {
				var num = Number(data.data);
				$("#hourMembers").text(num.toLocaleString());
			} else {
				console.error(data.message);
			}
		},
		error : function() {
			console.error('请求失败');
		}
	});
	$.ajax({
		url : '${ctx}/Pandect/EDailyRegisteredMembers',
		dataType : 'json',
		success  : function(data) {
			if (data.status == 1) {
				var num = Number(data.data);
				$("#dailyRegisteredMembers").text(num.toLocaleString());
			} else {
				console.error(data.message);
			}
		},
		error : function() {
			console.error('请求失败');
		}
	});
	$.ajax({
		url : '${ctx}/Pandect/EDailyDepositCount',
		dataType : 'json',
		success  : function(data) {
			if (data.status == 1) {
				var num = Number(data.data);
				$("#dailyDeposits").text(num.toLocaleString());
			} else {
				console.error(data.message);
			}
		},
		error : function() {
			console.error('请求失败');
		}
	});
	$.ajax({
		url : '${ctx}/Pandect/EDailyWithdrawal',
		dataType : 'json',
		success  : function(data) {
			if (data.status == 1) {
				var num = Number(data.data);
				$("#dailyWithdrawals").text(num.toLocaleString());
			} else {
				console.error(data.message);
			}
		},
		error : function() {
			console.error('请求失败');
		}
	});
	$.ajax({
		url : '${ctx}/Pandect/EBalance',
		dataType : 'json',
		success  : function(data) {
			if (data.status == 1) {
				var num = Number(data.message);
				$("#totalBalance").text(num.toLocaleString());
			} else {
				console.error(data.message);
			}
		},
		error : function() {
			console.error('请求失败');
		}
	});
	$.ajax({
		url : '${ctx}/Pandect/EDailyDepositReport',
		dataType : 'json',
		success  : function(data) {
			if (data.status == 1) {
				iniPie('depositReport', data.data);
			} else {
				console.error(data.message);
			}
		},
		error : function() {
			console.error('请求失败');
		}
	});
	$.ajax({
		url : '${ctx}/Pandect/EDailyWithdrawalReport',
		dataType : 'json',
		success  : function(data) {
			if (data.status == 1) {
				iniPie('withdrawalReport', data.data);
			} else {
				console.error(data.message);
			}
		},
		error : function() {
			console.error('请求失败');
		}
	});
});

function iniPie(containerId, jsonData) {
	var dataLength = jsonData.length;
	const { DataView } = DataSet;
	const data = jsonData;
	const dv = new DataView();
	dv.source(data).transform({
		type: 'percent',
		field: 'count',
		dimension: 'item',
		as: 'percent'
	});
	const chart = new G2.Chart({
		container: containerId,
		forceFit: true,
		height : 450 // 指定图表高度
	});
	chart.forceFit();
	chart.source(dv, {
		percent: {
			formatter: val => {
				val = (val * 100).toFixed() + '%';
				return val;
			}
		}
		});
	chart.coord('theta', {radius: 0.75});
	chart.tooltip({
		showTitle: false,
		itemTpl: '<li><span style="background-color:{color};" class="g2-tooltip-marker"></span>{name}: {value}</li>'
	});
	var colors = '';
	if (dataLength == 3)
		colors = '#F8AC5A-#1AB394-#ED5666';
	if (dataLength == 4)
		colors = '#F8AC5A-#1AB394-#ED5666-#969790';
	chart.intervalStack()
		.position('percent')
		.color('item', colors)
		.label('percent', {
			formatter: (val, item) => {
				return item.point.item + ' : ' + val;
			}
		})
		.tooltip('item*count', (item, count) => {
			return {
				name: item,
				value: count
			};
		})
		.style({
			lineWidth: 1,
			stroke: '#fff',
		});
	chart.render();
}
</script>
</body>
</html>