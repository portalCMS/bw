<%@page import="com.maven.util.JSONUnit"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsps/layout/bui-header.jsp"%>
<body style="padding: 10px;">
<div class="demo-content">
<!-- 搜索页 ================================================== -->
  <form id="searchForm" class="form-horizontal" style="outline: none;" method="post">
    <input name="end_hidden" type="hidden" />
    <input name="employeecode" type="hidden" value="${employeecode}"/>
    <div class="row well" style="margin-left: 0px;position: relative;">
    <div style="position: relative;display: inline-block;">
      <div style="float: left;margin-right: 96px;">
           <div style="float: left;margin-right: 96px;">
                <div class="control-group span14">
                <label class="control-label">游戏时间：</label>
                <div class="bui-form-group" data-rules="{dateRange : true}">
                  <input name="startDate"  type="text"   class="calendar calendar-time" value="${param.startDate }"  placeholder="起始时间" />
                  <span>&nbsp;-&nbsp;</span>
                  <input  name="endDate" type="text"    class="calendar calendar-time" value="${param.endDate }"   placeholder="结束时间" />
                </div>
                <div style="margin-right: auto;margin: -30px 425px;">
                     <select onchange="changeFormatDate(this,'startDate','endDate')" id="quiklychoicetime"  style="width:85px;">
                                <option value="">请选择</option>
                                <option value="1">今天</option>
                                <option value="2">昨天</option>
                                <option value="3">三天</option>
                                <option value="4">本周</option>
                                <option value="5">上周</option>
                                <option value="6">半月</option>
                                <option value="7">本月</option>
                                <option value="8">上月</option>
                                <option value="9">半年</option>
                                <option value="10">本年</option>
                              </select>
                </div>
            </div>
            <div class="control-group span7">
              <label class="control-label">用户账号：</label>
                <input name="loginaccount"  type="text" data-tip='{"text":"用户账号"}' value="${param.loginaccount }" class="control-text"  placeholder="用户名称"/>
            </div>
            <!-- <div class="control-group span7">
              <label class="control-label">上级账号：</label>
                <input name="parentName"  type="text" data-tip='{"text":"上级账号"}' class="control-text"  placeholder="上级账号"/>
            </div> -->
           <div class="control-group span7">
              <label class="control-label">投注单号：</label>
                <input name="bettingId"  type="text" data-tip='{"text":"投注单号"}' class="control-text" placeholder="投注单号"/>
            </div>
            <div class="control-group span7">
              <label class="control-label">局号：</label>
                <input name="gamblingCode"  type="text" data-tip='{"text":"局号"}' class="control-text" placeholder="局号"/>
            </div>
            <!-- 
            <div class="control-group span7">
              <label class="control-label">游戏类型：</label>
                <select name="gameType">
                    <option value="">--请选择--</option>
                    <option value="1">百家乐</option>
                    <option value="2">龙虎</option>
                    <option value="3">番摊</option>
                    <option value="4">轮盘</option>
                    <option value="5">骰宝</option>
                    <option value="6">极速百家乐</option>
                </select>
            </div>
             -->
            <div class="control-group span7">
              <label class="control-label">企业：</label>
                <select id="enterprisecode" name="enterprisecode" >
                         <option value="" selected="selected">请选择</option>
                         <c:forEach var="item" varStatus="status" items="${listEnterprise}">
	                    	<option value="${item.enterprisecode }">${item.enterprisename }</option>
	                    </c:forEach>
                 </select>
          	</div>
            <div class="control-group span7 toggle-display">
              <label class="control-label">投注金额：</label>
              <input name="bettingCredits"  type="text" data-tip='{"text":"投注金额"}' class="control-text" placeholder="投注金额"/>
            </div>
          </div>  
      </div>
      ${getJKeyType}
      	 <div style="position: absolute;right: 128px;top: 3px;">
         	 <button id="btnSearch" type="submit"  class="button button-primary"> 搜 索 </button>
        </div>
        </div>
    </div> 
     </form>
  <div class="search-grid-container well">
    <div id="grid"><font color="red">AG真人时差12小时，例如查询AG游戏2018年1月1号的数据，游戏时间应设为：2018-01-01 12:00:00 到 2018-01-02 11:59:59，以此类推！</font></div>
  </div>
</div>
</body>
</html>
   <script type="text/javascript">
   
   //var export_excel = (1 == 1); 
   var export_excel = false;
   var botton_arry = new Array();

   if(export_excel){
    botton_arry.push({
              btnCls:'button button-primary',
              text:'<span class="icon-file icon-white"></span>导出到EXCEL(当前条件)',
              handler:function(){
                searchForm.action = "${ctx}/BET67AGSX/exportExcel";
                searchForm.submit();
                searchForm.action = "${ctx}/BET67AGSX/data";
              }
    });
   }
   
   $(function(){
	   var begintime = $("input[name='startDate']");
	   var endtime = $("input[name='endDate']");
	   if(!begintime.val()&&!endtime.val()){
		   begintime.val(getDate("begintime"));
		   endtime.val(getDate("endtime"));
		   $("#quiklychoicetime option:eq(1)").attr("selected","selected");
	   }
	   
        var Grid = BUI.Grid,
          Store = BUI.Data.Store,
          columns = [
			{ title: '投注单号', width: '19%', sortable: false,  dataIndex: 'betId'},
			{ title: '局号', width: '11%', sortable: false,  dataIndex: 'gameCode'},
			{ title: '用户账号',width: '10%',  sortable: false,dataIndex:'userName'},
			{ title: '游戏类型',width: '6%',  sortable: false,  dataIndex: 'gameType',
				/**
				renderer:function(value,obj){
            	switch(value){
 				case '1':
 					return "百家乐";
 					break;
 				case '2':
 					return "龙虎";
 					break;
 				case '3':
 					return "番摊";
 				case '4':
 					return "轮盘";
 					break;
 				case '5':
 					return "骰宝";
 					break;
 				case '6':
 					return "极速百家乐";
 					break;
 				}
            }*/
			},
            
			/* { title: '游戏结果',   width: '15%',  sortable: false,dataIndex:'gameResult',renderer:function(value,obj){
				var gameType = obj.gameType;
				if(gameType =="1" || gameType =="6"){
					var tableHtml ="" ;
					var result = obj.gameResult.split(',');//HK,S4,H9,H4,DA,#
					 
					tableHtml +="<span style=color:green>闲：</span>";
					tableHtml += "<img src='${statics}/img/poker/"+ result[0].toUpperCase()+".png" + "' />";	
					tableHtml += "<img src='${statics}/img/poker/"+ result[1].toUpperCase()+".png" + "' />";	
					if(result[2] !="" && result[2] !="#"){
						tableHtml += "<img src='${statics}/img/poker/"+ result[2].toUpperCase()+".png" + "' />";	
					}
					
					
					tableHtml +="&nbsp;&nbsp;&nbsp&nbsp;<span style=color:red>庄：</span>";
					tableHtml += "<img src='${statics}/img/poker/"+ result[3].toUpperCase()+".png" + "' />";
					tableHtml += "<img src='${statics}/img/poker/"+ result[4].toUpperCase()+".png" + "' />";
					if(result[5] !="" && result[5] !="#"){
						tableHtml += "<img src='${statics}/img/poker/"+ result[5].toUpperCase()+".png" + "' />";
					}
					
					return tableHtml;
				}else if(gameType =="2"){
					var tableHtml ="" ;
					var result = obj.gameResult.split(',');
					tableHtml +="<span style=color:red>龙：</span>";
					if(result[0] !="" && result[0] !="#"){
						tableHtml += "<img src='${statics}/img/poker/"+ result[0].toUpperCase()+".png" + "' />";	
					}
					tableHtml +="&nbsp;&nbsp;&nbsp&nbsp;<span style=color:green>虎：</span>";
					if(result[1] !="" && result[1] !="#"){
						tableHtml += "<img src='${statics}/img/poker/"+ result[1].toUpperCase()+".png" + "' />";
					}else{
						return obj.gameResult;
					}
					return tableHtml;
				}else if(gameType =="3"){
					return obj.gameResult;
				}else if(gameType =="4"){
					return obj.gameResult;
				}else if(gameType =="5"){
					return obj.gameResult;
				}
            }}, */
            
            { title: '投注金额',   width: '7%',  sortable: false,  summary : true, dataIndex: 'betMoney', renderer:function(value){
        		return value.toFixed(2);
        	}},
            { title: '有效投注额',   width: '7%', sortable: false, summary : true,  dataIndex: 'okBetMoney', renderer:function(value){
            	return value.toFixed(2);
        	}},
            { title: '输赢金额',   width: '7%',  sortable: false, summary : true,  dataIndex: 'betResult' , renderer:function(value){
        		if(value>0){
        			return "<font color='green'>"+value.toFixed(2)+"</font>";
        		}else if(value<0){
        			return "<font color='red'>"+value.toFixed(2)+"</font>";
        		}else{
        			return value.toFixed(2);
        		}
        	}},
            { title: '投注时间',   width: '14%',  sortable: true,   dataIndex: 'betTime',renderer:BUI.Grid.Format.datetimeRenderer},
            //{ title: '结算时间',   width: '10%',  sortable: true,   dataIndex: 'billTime',renderer:BUI.Grid.Format.datetimeRenderer},
            //{ title: '下单项',   width: 100,  sortable: false,   dataIndex: 'betTypeName'},
            //{ title: '游戏结果',   width: 100,  sortable: false,   dataIndex: 'gameResult'},
			{ title: '桌号',  width: '8%', sortable: false,  dataIndex: 'tableCode'},
          /*   { title: '下单前余额',   width: 80,  sortable: false,   dataIndex: 'betBefore',
           		renderer:function(value){
            	return value.toFixed(2);
        	}},
            { title: '结算后余额',   width: 80,  sortable: false,   dataIndex: 'billAfter',
            	renderer:function(value){
            	return value.toFixed(2);
        	}}, */
          ];

        var store = new Store({
            url : '${ctx}/BET67AGSX/data',
            autoLoad : false, //自动加载数据
            pageSize:15,
            remoteSort: true,
            sortInfo : {
                field : 'betTime',
                direction : 'desc'
              }
          }),grid = new Grid.Grid({
            render:'#grid',
            autoRender:true,
            loadMask: true,
            width:'100%',
            columns : columns,
            store: store,
            plugins : [Grid.Plugins.CheckSelection, Grid.Plugins.Summary ],
            emptyDataTpl:'<div class="centered"><img alt="Crying" src="${statics }/img/dataisnull.png"/><font style="color:red;font-size:20px;"><h2>没有找到匹配的数据!</h2></font></div>',
            tbar : { items:botton_arry },
            // 顶部工具栏
            bbar : {
              pagingBar:true
            }
          }),datepicker = new BUI.Calendar.DatePicker({
              trigger:'.calendar-time',
              showTime:true,
              autoRender:true
           });
        
        $("#searchForm").submit(function(){
      	  var obj = BUI.FormHelper.serializeToObject(this);
            obj.start = 0;
            store.load(obj);
      	  return false;
        }).submit();
   })
    </script>