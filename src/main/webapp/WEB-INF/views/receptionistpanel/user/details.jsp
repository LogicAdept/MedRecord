<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <style>
        <%@include file="/resources/css/bootstrap.min.css"%>
        <%@include file="/resources/css/common.css"%>
        <%@include file="/resources/css/avatar.css"%>
    </style>
    <title><spring:message code="text.title.userDetails"/></title>
    <script>
        <%@include file="/resources/js/bootstrap.min.js"%>
        <%@include file="/resources/js/jquery-3.4.1.min.js"%>
    </script>
</head>
<body>
<div class="container">
    <%--START OF HEADER--%>
    <div class="row">
        <div class="col-xs-6">
            <a href="<c:url value="/receptionistpanel/user/profile"/>">
                <button type="button" class="btn btn-success"><spring:message
                        code="button.profile"/></button>
            </a>
            <a href="<c:url value="/receptionistpanel/user"/>">
                <button type="button" class="btn btn-info ml-3"><spring:message
                        code="button.users"/></button>
            </a>
        </div>
        <div class="col-xs-3"></div>
        <div class="col-xs-3">
            <div class="row">
                <a href="?lang=pl">PL</a>
                <a href="?lang=en">EN</a>
                <a href="?lang=ru">RU</a>
            </div>
            <div class="row">
                <a href="<c:url value="/logout"/>" type="button" class="btn btn-danger"><spring:message
                        code="button.logout"/></a>
            </div>
            <div class="row">
                <sec:authorize access="hasAnyRole('ROLE_MEDIC','ROLE_PATIENT','ROLE_ADMIN')">
                    <a href="<c:url value="/welcome"/>"><spring:message code="button.changeRole"/></a>
                </sec:authorize>
            </div>
        </div>
    </div>
    <%--END OF HEADER--%>
    <h3><spring:message code="text.header.userDetails"/> <b>${userDataDTO.username}</b></h3>
    <div class="container" style="background-color: #fff; margin-top: 20px; margin-bottom: 20px;">
        <div class="row">
            <div class="col-xs-3">
                <div class="row">
                    <div class="img-thumbnail" width="200" height="200"
                         style="margin-left: 10px; margin-top: 10px; background-image: url('/resources/img/emptyProfile.png');">
                        <img src="<c:url value="/resources/img/${userDataDTO.img}"/>" height="200" width="200"
                             style="border-radius: 10px; background-size: contain"
                             onerror="this.style.visibility = 'hidden'">
                    </div>
                </div>
            </div>
            <div class="col-xs-6">
                <div class="row"></div>
                <div class="row">
                    <h4><b><spring:message
                            code="text.label.fullname"/>: ${userDataDTO.surname} ${userDataDTO.name} ${userDataDTO.patronymic}</b>
                    </h4>
                </div>
                <div class="row">
                    <h4><b><spring:message code="text.label.telephone"/>: ${userDataDTO.telephone}</b></h4>
                </div>
                <div class="row">
                    <h4><b><spring:message code="text.label.birth"/>: ${formatter.format(userDataDTO.birth)}</b></h4>
                </div>
                <div class="row">
                    <c:if test="${userDataDTO.sex == true}">
                        <h4><b><spring:message code="text.label.sex"/>: <spring:message code="user.sex.male"/></b></h4>
                    </c:if>
                    <c:if test="${userDataDTO.sex == false}">
                        <h4><b><spring:message code="text.label.sex"/>: <spring:message code="user.sex.female"/></b>
                        </h4>
                    </c:if>
                </div>
                <div class="row">
                    <c:forEach items="${userDataDTO.roles}" var="role">
                        <c:if test="${role.name == 'ROLE_MEDIC'}">
                            <a href="<c:url value="/receptionistpanel/schedule/${userDataDTO.id}"/>"
                               class="btn btn-primary align-content-center" role="button"
                               aria-pressed="true"><spring:message code="button.editSchedule"/></a>
                            <br>
                        </c:if>
                    </c:forEach>
                </div>
                <br>
            </div>
            <div class="col-xs-3">
                <h4><b><spring:message code="text.label.roles"/>:</b></h4>
                <c:forEach items="${userDataDTO.roles}" var="role">
                    <h4><b><spring:message code="${role.name}"/></b></h4>
                </c:forEach>
                <br>
                <a href="<c:url value="/receptionistpanel/user/${userDataDTO.id}/update"/>"
                   class="btn btn-warning align-content-center" role="button"
                   aria-pressed="true"><spring:message code="button.edit"/></a>
                <a href="<c:url value="/receptionistpanel/user/${userDataDTO.id}/delete"/>"
                   class="btn btn-danger align-content-center" role="button"
                   aria-pressed="true"><spring:message code="button.delete"/></a>
            </div>
            <br>
        </div>
    </div>
</body>
</html>