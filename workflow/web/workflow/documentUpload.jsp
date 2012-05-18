<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/fenix-renderers.tld" prefix="fr" %>

<%@page import="module.workflow.presentationTier.WorkflowLayoutContext"%>
<%@page import="myorg.presentationTier.actions.ContextBaseAction"%>

<h2><bean:message key="title.uploadFile" bundle="WORKFLOW_RESOURCES"/></h2>

<bean:define id="process" name="process" toScope="request"/>
<bean:define id="processOID" name="process" property="externalId" toScope="request" type="java.lang.String"/>

<bean:define id="selectedInstance" name="bean" property="selectedInstance.simpleName"/>

<bean:define id="schema" value="<%= "addDocument-" + selectedInstance%>" toScope="request"/>


<%
	final WorkflowLayoutContext layoutContext = (WorkflowLayoutContext) ContextBaseAction.getContext(request);
%>

<jsp:include page='<%= layoutContext.getWorkflowShortBody() %>'/>

<logic:messagesPresent property="message" message="true">
	<div class="error1">
		<html:messages id="errorMessage" property="message" message="true"> 
			<span><fr:view name="errorMessage"/></span>
		</html:messages>
	</div>
</logic:messagesPresent>

<logic:equal name="bean" property="defaultUploadInterfaceUsed" value="true">
	<bean:define id="urlView">/workflowProcessManagement.do?method=viewProcess&amp;processId=<bean:write name="process" property="externalId"/></bean:define>
	<bean:define id="urlPostBack">/workflowProcessManagement.do?method=uploadDocumentPostBack&amp;processId=<bean:write name="process" property="externalId"/></bean:define>
	<bean:define id="urlInvalid">/workflowProcessManagement.do?method=invalidDocumentUpload&amp;processId=<bean:write name="process" property="externalId"/></bean:define>
	
	<fr:edit name="bean" id="uploadFile" action='<%= "workflowProcessManagement.do?method=documentUpload&processId=" + processOID %>' schema="<%= schema %>">
		<fr:layout name="tabular">
			<fr:property name="classes" value="form"/>
			<fr:property name="columnClasses" value=",,tderror"/>
		</fr:layout>
		<fr:destination name="cancel" path="<%= urlView %>" />
		<fr:destination name="postBack"  path="<%= urlPostBack %>"/>
		<fr:destination name="invalid" path="<%= urlInvalid %>"/>
	</fr:edit>
</logic:equal>

<logic:equal name="bean" property="defaultUploadInterfaceUsed" value="false">
	<bean:define id="jspToInclude" name="interface" type="java.lang.String"/>
	<jsp:include page="<%= jspToInclude %>"/>
</logic:equal>