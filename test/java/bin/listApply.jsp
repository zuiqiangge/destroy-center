<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib prefix="fmt"
	uri="http://java.sun.com/jsp/jstl/fmt"%><!DOCTYPE html>
<html>
<head>
<title>历史申请</title>

<div id="custom_notifications" class="custom-notifications dsp_none">
	<ul class="list-unstyled notifications clearfix"
		data-tabbed_notifications="notif-group">
	</ul>
	<div class="clearfix"></div>
	<div id="notif-group" class="tabbed_notifications"></div>
</div>

<!-- chart js -->
<script src="js/chartjs/chart.min.js"></script>
<!-- bootstrap progress js -->
<script src="js/progressbar/bootstrap-progressbar.min.js"></script>
<script src="js/nicescroll/jquery.nicescroll.min.js"></script>
<!-- icheck -->
<script src="js/icheck/icheck.min.js"></script>
<script src="js/common-cud.js" type="text/javascript"></script>

<link type="text/css" rel="stylesheet" href="js/DataTables-1.10.13/media/css/jquery.dataTables.min.css" />
<script type="text/javascript" src="js/DataTables-1.10.13/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript">
	//弹出条件查询历史记录页面
	/* function showList() {
		window.parent
				.open('ListApplyCondition.do', 'newwindow',
						'height=300, width=750, top=300, left=500, toolbar=no, menubar=no');
	} */

	function nextPage() {
		$($(".applys").html()).appendTo($(".applys"));
	}

	//点击查询按钮---根据条件异步查询列表
	function queryByCondition() {
		var arr = $("#conditionForm").serializeArray();
		var data = $.param(arr);
		$.ajax({
			dataType : "json",
			type : "POST",
			url : "getListByCondition.do",
			data : data,
			success : function(msg) {
				//条件查询成功后,录入查询条件日志
				saveApplyCondition(data);
				writeLi(msg);
			}
		});
	}

	//查询时录入查询条件日志
	function saveApplyCondition(data) {
		$.ajax({
			type : "POST",
			url : "saveApplyCondition.do",
			data : data,
			success : function(msg) {
			}
		});
	}
	//导出excel
	function exportApplies() {
		var ids = [];
		$("input[name='id']").each(function() {
			ids.push($(this).val());
		});
		$.ajax({
			//async : false,
			dataType : "text",
			type : "POST",
			url : "exportApply.do",
			data : "ids=" + ids,
			success : function(msg) {
				if (msg == 1)
					alert("导出成功!文件已导出在c:根目录下");
				else
					alert("导出失败!请联系开发人员!");
			}
		});
	}

	//加载时执行方法
	$(function() {
		getList();
	});

	//获取列表方法
	function getList() {
		$.ajax({
			async :false,
			dataType : "json",
			type : "GET",
			url : "getUserApplyData.do",
			success : function(msg) {
				alert("初始化列表");
				writeLi(msg);
			}
		});
	}
	//通过异步加载数据
	function writeLi(applies) {
		var lis = "";
		$("#content").empty();
		for (var i = 0; i < applies.length; i++) {
			var apply = applies[i];
			var li = "<li>"
					+ "<input type='hidden' name='id' value='"+apply.id+"'>"
					+ "<div class='message_date'>"
					+ "<h3 class='date text-info'>"
					+ apply.date.date
					+ "日"
					+ "</h3>"
					+ "<p class='month'>"
					+ new Date(apply.date.time).getFullYear()
					+ "年"
					+ new Date(apply.date.time).getMonth()
					+ 1
					+ "月"
					+ "</p>"
					+ "</div>"
					+ "<div class='message_wrapper'>"
					+ "<h4 class='heading'>"
					+ apply.contactUnit
					+ "	,"
					+ apply.contacts
					+ "</h4>"
					+ "<blockquote class='message'>"
					+ "电话："
					+ apply.telephone
					+ "</blockquote>"
					+ "<blockquote class='message'>"
					+ "地址："
					+ apply.address
					+ "</blockquote>"
					+ "<blockquote class='message'>"
					+ "销毁物品简述："
					+ apply.articleDesc
					+ "</blockquote>"
					+ "<br>"
					+ "<p class='url'>";
			if (apply.sendType == 1) {
				li += "<span class='label label-warning'>需派车</span>";
			} else {
				li += "<span class='label label-success'>对方自送</span>";
			}

			if (apply.state == 0) {
				li += "<span class='label label-warning'>暂存</span> &nbsp;<a href='toUpdateApply.do?id=${apply.id}' class='btn btn-primary' >编辑</a>";
			} else if (apply.state == 1) {
				li += "<span class='label label-success'>等待领导批示</span>";
			} else {
				li += "<span class='label label-info'>申请完成</span>";
			}

			li += "</p>" + "</div>" + "</li>"
			lis = lis + li;
		}
		$("#content").append(lis);
	}
	
	//获取查询条件记录
 	function getData(){
 		$('#log').modal('show');
 		 $('#logTable').DataTable({
 	             "serverSide": true,
 	             "paging": true,
 	             "dom": 'tflip',
 	             //"info": false,
 	            "searchable":true,
 	             'searching':false,
 	             "lengthMenu":[2,4,6],
 	             "ordering": false,
 	             'retrieve': true,
 	             "columns": [
 	         				{"data": "submitName"},
 	         				{"data": "contactUnit"},
 	         				{"data": "contact"},
 	         				{"data": "telephone"},
 	         				{"data": "address"},
 	 						{
 	 							"data": "sendType",
 	 							"render": function (data,type, row, meta) {
 	 								var sendType="";
 	 								sendType+="<div id='gender' class='btn-group' data-toggle='buttons'>"
										+"<label class='btn btn-primary active'>"
											+"<input autocomplete='off' type='radio' name='sendType' value='1'";
												if(data.sendType==1)
													sendType+="checked='checked'"
											sendType+="> 派车"
										+"</label>"
										+"<label class='btn btn-default'>" 
											+"<input autocomplete='off' type='radio' name='sendType' value='0'";
												if(data.sendType==1)
													sendType+="checked='checked'"
											sendType+="> 自送"
										+"</label>"
									+"</div>"
									return sendType;
								}
 	 						},
 	 						{
 	 							"data": "nowDestory",
 	 							"render": function (data,type, row, meta) {
 	 								var nowDestory="";
 	 								nowDestory+="<div id='gender' class='btn-group' data-toggle='buttons'>"
										+"<label class='btn btn-primary active'>"
											+"<input autocomplete='off' type='radio' name='sendType' value='1'";
												if(data.nowDestory==1)
													nowDestory+="checked='checked'"
											nowDestory+="> 是"
										+"</label>"
										+"<label class='btn btn-default'>" 
											+"<input autocomplete='off' type='radio' name='sendType' value='0'";
												if(data.nowDestory==0)
													nowDestory+="checked='checked'"
											nowDestory+="> 否"
										+"</label>"
									+"</div>"
									return nowDestory;
								}
 	 						}
 	         			],
 	         			"ajax" :{
 	         	              'url':"ListApplyCondition.do"
 	         	        },
 	              	 'language': {  
 	                     'emptyTable': '没有数据',  
 	                     'loadingRecords': '加载中...',  
 	                     'processing': '查询中...',  
 	                     'lengthMenu': '每页 _MENU_行',  
 	                     'zeroRecords': '没有数据',  
 	                     'paginate': {  
 	                         'first':      '第一页',  
 	                         'last':       '最后一页',  
 	                         'next':       '下一页',  
 	                         'previous':   '上一页'  
 	                     },  
 	                    "info": "显示页 _PAGE_ of _PAGES_页_共 _TOTAL_ 项",
 	                      //"sInfo": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项", 
 	                     'infoEmpty': '没有数据'
 	                 } 
 	            
 	         });
 	}
</script>
</head>
<body>
	<div class="col-md-12 col-sm-12 col-xs-12">
		<div class="x_panel">
			<div class="x_title">
				<h2>历史申请列表</h2>
				&nbsp;&nbsp;&nbsp;
				<button type="button" class="btn btn-default btn-sm"
					onclick="exportApplies()">
					<span class="glyphicon glyphicon-save"></span>导出
				</button>
				<!--条件输入框-->
				<!-- action="getListByCondition.do" -->
				<form class="form-inline" role="form" id="conditionForm">
					上报领导:<select class="form-control" name="submitUserId">
						<option value="-1">全部</option>
						<c:forEach var="user" items="${users}">
							<c:if test="${user.id!=currentUser.id}">
								<option value=${user.id}>${user.nickName}</option>
							</c:if>
						</c:forEach>
					</select> 单位名称:<input type="text" class="form-control" id="submitUserId"
						name="submitUserId"> 联系人:<input type="text"
						class="form-control" id="contactUnit" name="contactUnit">
					联系电话:<input type="text" class="form-control" id="telephone"
						name="telephone"> 单位地址:<input type="text"
						class="form-control" id="address" name="address"> <br />
					<br /> 送货方式:
					<div id="gender" class="btn-group" data-toggle="buttons">
						<label class="btn btn-primary active"> <input
							autocomplete="off" type="radio" name="sendType" value="1"
							checked="checked"> 派车
						</label> <label class="btn btn-default"> <input autocomplete="off"
							type="radio" name="sendType" value="0"> 自送
						</label>
					</div>

					是否监销:
					<div id="gender" class="btn-group" data-toggle="buttons">
						<label class="btn btn-primary active"> <input
							autocomplete="off" type="radio" name="nowDestroy" value="0"
							checked="checked">&nbsp; 否&nbsp;
						</label> <label class="btn btn-default"> <input autocomplete="off"
							type="radio" name="nowDestroy" value="1">&nbsp; 是&nbsp;
						</label>
					</div>
					<button type="reset" class="btn btn-default">重置</button>
					<button type="button" class="btn btn-default"
						onclick="queryByCondition()">检索</button>
				</form>

				<!--条件查询历史-->
				<button type="button" class="btn btn-default btn-sm"
					style="align:'right'" onclick="getData()">
					<span class="glyphicon glyphicon-list"></span>条件查询历史
				</button>


				<ul class="nav navbar-right panel_toolbox">

				</ul>
				<div class="clearfix"></div>
			</div>

			<div class="x_content">
				<ul id="content" class="messages applys">

				</ul>
			</div>
			<!-- <div class="row" style="text-align: center;">
				<button class="btn" onclick="nextPage()">加载下一页</button>
			</div> -->
		</div>
	</div>


	<!--条件记录模态框-->
	<div class="modal fade" id="log" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width:1100px">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">
					查询记录
				</h4>
				</div>
				<div class="modal-body">
					<div class="x_content" id="editContent">
						<table id="logTable" class="tabindex" width="100%" border="0"
							cellpadding="0" cellspacing="0">
							<thead>
								<tr>
									<th width="10%" bgcolor="#f8f8f8"><div align="left">上报领导</div></th>
									<th width="10%" bgcolor="#f8f8f8"><div align="left">单位名称</div></th>
									<th width="10%" bgcolor="#f8f8f8"><div align="left">联系人</div></th>
									<th width="10%" bgcolor="#f8f8f8"><div align="left">联系电话</div></th>
									<th width="10%" bgcolor="#f8f8f8"><div align="left">单位地址</div></th>
									<th width="10%" bgcolor="#f8f8f8"><div align="left">送货方式</div></th>
									<th width="10%" bgcolor="#f8f8f8"><div align="left">是否监销</div></th>
								</tr>
							</thead
        					<tbody></tbody> 
						</table>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>