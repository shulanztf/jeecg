<#include "/ui/datatype.ftl"/>
<#include "/ui/dictInfo.ftl"/>
<#include "/ui/tag.ftl"/>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${ftl_description}</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Jquery组件引用 -->
<script src="https://cdn.bootcss.com/jquery/1.12.3/jquery.min.js"></script>

<!-- bootstrap组件引用 -->
<link href="https://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

<!-- icheck组件引用 -->
<link href="plug-in/icheck-1.x/skins/square/_all.css" rel="stylesheet">
<script type="text/javascript" src="plug-in/icheck-1.x/icheck.js"></script>

<!-- Validform组件引用 -->
<link href="plug-in/themes/bootstrap-ext/css/validform-ext.css" rel="stylesheet" />
<script type="text/javascript" src="plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js"></script>
<script type="text/javascript" src="plug-in/Validform/js/Validform_Datatype_zh-cn.js"></script>
<script type="text/javascript" src="plug-in/Validform/js/datatype_zh-cn.js"></script>
<script type="text/javascript" src="plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js"></script>
<!-- Layer组件引用 -->
<script src="plug-in/layer/layer.js"></script>
<script src="plug-in/laydate/laydate.js"></script>
<!-- 通用组件引用 -->
<link href="plug-in/bootstrap3.3.5/css/default.css" rel="stylesheet" />
<script src="plug-in/themes/bootstrap-ext/js/common.js"></script>
<#assign uploadFlag=0>
<#list pageColumns as po>
<#if po.showType=='file' || po.showType == 'image'>
<#assign uploadFlag=1>
<#break>
</#if>
</#list>
<#if uploadFlag==1>
<#assign fileName = "" />
<!-- 上传组件 -->
<link rel="stylesheet" type="text/css" href="plug-in/webuploader/custom.css"></link>
<script type="text/javascript" src="plug-in/webuploader/webuploader.min.js"></script>
</#if>
</head>
 <body style="overflow:hidden;overflow-y:auto;margin-top: 20px">
 <form id="formobj" action="${entityName?uncap_first}Controller.do?doAdd" class="form-horizontal validform" role="form"  method="post">
	<input type="hidden" id="btn_sub" class="btn_sub"/>
	<input type="hidden" id="id" name="id"/>
	<#list pageColumns as po>
	<div class="form-group">
		<label for="${po.fieldName}" class="col-sm-3 control-label">${po.content}：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
			<#if po.showType=='text'>
				<input id="${po.fieldName}" name="${po.fieldName}" type="text" maxlength="${po.length?c}" class="form-control input-sm" placeholder="请输入${po.content}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"  tableName="${po.table.tableName}" fieldName="${po.oldFieldName}"/>/>
			<#elseif po.showType=='password'>
				<input id="${po.fieldName}" name="${po.fieldName}" type="password" maxlength="${po.length?c}" class="form-control input-sm" placeholder="请输入${po.content}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />/>
			<#elseif po.showType=='radio' || po.showType=='checkbox'>
				<t:dictSelect field="${po.fieldName}" type="${po.showType?if_exists?html}" extendJson="{class:'i-checks'}" <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> hasLabel="false"  title="${po.content}"></t:dictSelect>		
			<#elseif po.showType=='select' || po.showType=='list'>
				<t:dictSelect field="${po.fieldName}" type="${po.showType?if_exists?html}" extendJson="{class:'form-control input-sm'}" <@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> hasLabel="false"  title="${po.content}"></t:dictSelect>     
			<#elseif po.showType=='date'|| po.showType=='datetime'>
      		   <input id="${po.fieldName}" name="${po.fieldName}" type="text" class="form-control input-sm" placeholder="请输入${po.content}" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
                   <span class="input-group-addon" >
                       <span class="glyphicon glyphicon-calendar"></span>
                   </span>
            <#elseif po.showType=='file' || po.showType == 'image'>
				<@webuploadtag po = po defval=""/>
	      	<#else>
	      		<input id="${po.fieldName}" name="${po.fieldName}" type="text" maxlength="${po.length?c}" class="form-control input-sm" placeholder="请输入${po.content}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"  tableName="${po.table.tableName}" fieldName="${po.oldFieldName}"/>/>
			</#if>
			</div>
		</div>
	</div>
	</#list>
	<#list pageAreatextColumns as po>
	<div class="form-group">
		<label for="${po.fieldName}" class="col-sm-3 control-label">${po.content}：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<textarea id="${po.fieldName}" name="${po.fieldName}" class="form-control" placeholder="请输入${po.content}" rows="4"></textarea>
			</div>
		</div>
	</div>
	</#list>
</form>
<script type="text/javascript">
	var subDlgIndex = '';
	$(document).ready(function() {
		<#list pageColumns as po>
			<#if po.showType=='date'|| po.showType=='datetime'>
				//${po.content} 日期控件初始化
			    laydate.render({
				   elem: '#${po.fieldName}'
				  ,type: '${po.showType}'
				  ,trigger: 'click' //采用click弹出
				  ,ready: function(date){
				  	 $("#${po.fieldName}").val(DateJsonFormat(date,this.format));
				  }
				});
			</#if>
		</#list>
		
		//单选框/多选框初始化
		$('.i-checks').iCheck({
			labelHover : false,
			cursor : true,
			checkboxClass : 'icheckbox_square-blue',
			radioClass : 'iradio_square-blue',
			increaseArea : '20%'
		});
		
		//表单提交
		$("#formobj").Validform({
			tiptype:function(msg,o,cssctl){
				if(o.type==3){
					validationMessage(o.obj,msg);
				}else{
					removeMessage(o.obj);
				}
			},
			btnSubmit : "#btn_sub",
			btnReset : "#btn_reset",
			ajaxPost : true,
			beforeSubmit : function(curform) {
			},
			usePlugin : {
				passwordstrength : {
					minLen : 6,
					maxLen : 18,
					trigger : function(obj, error) {
						if (error) {
							obj.parent().next().find(".Validform_checktip").show();
							obj.find(".passwordStrength").hide();
						} else {
							$(".passwordStrength").show();
							obj.parent().next().find(".Validform_checktip").hide();
						}
					}
				}
			},
			callback : function(data) {
				var win = frameElement.api.opener;
				if (data.success == true) {
					frameElement.api.close();
				    win.reloadTable();
				    win.tip(data.msg);
				} else {
				    if (data.responseText == '' || data.responseText == undefined) {
				        $.messager.alert('错误', data.msg);
				        $.Hidemsg();
				    } else {
				        try {
				            var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'), data.responseText.indexOf('错误信息'));
				            $.messager.alert('错误', emsg);
				            $.Hidemsg();
				        } catch (ex) {
				            $.messager.alert('错误', data.responseText + "");
				            $.Hidemsg();
				        }
				    }
				    return false;
				}
			}
		});
	});
	
</script>
</body>
</html>