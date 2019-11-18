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
    </style>
    <title><spring:message code="text.title.userTickets"/></title>
    <script type="text/javascript">
        <%@include file="/resources/js/jquery-3.4.1.min.js"%>
        <%@include file="/resources/js/bootstrap.min.js"%>
    </script>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-xs-6">
            <a href="<c:url value="/adminpanel/role"/>" class="btn btn-info" role="button"
               aria-pressed="true"><spring:message code="button.roles"/></a>
            <a href="<c:url value="/adminpanel/user"/>" class="btn btn-success" role="button"
               aria-pressed="true"><spring:message code="button.users"/></a>
        </div>
        <div class="col-xs-3"></div>
        <div class="col-xs-3">
            <div class="row">
                <a href="?lang=pl">PL</a>
                <a href="?lang=en">EN</a>
                <a href="?lang=ru">RU</a>
            </div>
            <div class="row">
                <a href="<c:url value="/logout"/>" type="button" class="btn btn-default"><spring:message
                        code="button.logout"/></a>
            </div>
            <div class="row">
                <sec:authorize access="hasAnyRole('ROLE_MEDIC','ROLE_PATIENT','ROLE_RECEPTIONIST')">
                    <a href="<c:url value="/welcome"/>"><spring:message code="button.changeRole"/></a>
                </sec:authorize>
            </div>
        </div>
    </div>
    <div class="row" style="margin-top: 10px">
        <div class="row">
            <div class="col-xs-4">
                <h3>
                    <spring:message code="text.header.ticketForUser"/> ${userDTO.username}
                </h3>
            </div>
            <div class="col-xs-4">
                <c:if test="${DTOList.size() != 0}">
                    <spring:message
                            code="text.info.shown"/> ${1+((pageNo-1)*pageSize)} - ${DTOList.size()+((pageNo-1)*pageSize)}
                    <spring:message code="text.info.from"/> ${elementsCount} <spring:message code="text.info.items"/>
                </c:if>
                <c:if test="${DTOList.size() == 0}">
                    <spring:message code="text.info.empty"/>
                </c:if>
            </div>
            <div class="col-xs-4">
                <spring:message code="button.dropdown.show"/>
                <div class="btn-group">
                    <button type="button" class="btn btn-default">${pageSize}</button>
                    <button type="button" data-toggle="dropdown" class="btn btn-default dropdown-toggle"><span
                            class="caret"></span></button>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="<c:url value="/adminpanel/ticket/${userId}/list?pageNo=${pageNo}&pageSize=${7}&desc${desc}&sort${sort}"/>">7</a>
                        </li>
                        <li>
                            <a href="<c:url value="/adminpanel/ticket/${userId}/list?pageNo=${pageNo}&pageSize=${15}&desc${desc}&sort${sort}"/>">15</a>
                        </li>
                        <li>
                            <a href="<c:url value="/adminpanel/ticket/${userId}/list?pageNo=${pageNo}&pageSize=${25}&desc${desc}&sort${sort}"/>">25</a>
                        </li>
                    </ul>
                </div>
                <spring:message code="text.info.items"/>
            </div>
        </div>
    </div>
    <table class="table">
        <thead>
        <tr>
            <th scope="col">
                <c:if test="${desc == false}">
                    <a href="<c:url value="/adminpanel/ticket/${userDataDTO.id}/list?pageNo=${pageNo}&pageSize=${pageSize}&desc=${true}&sort=id"/>"><spring:message
                            code="text.label.id"/></a>
                </c:if>
                <c:if test="${desc == true}">
                    <a href="<c:url value="/adminpanel/ticket/${userDataDTO.id}/list?pageNo=${pageNo}&pageSize=${pageSize}&desc=${false}&sort=id"/>"><spring:message
                            code="text.label.id"/></a>
                </c:if>
            </th>
            <th scope="col">
                <c:if test="${desc == false}">
                    <a href="<c:url value="/adminpanel/ticket/${userDataDTO.id}/list?pageNo=${pageNo}&pageSize=${pageSize}&desc=${true}&sort=doctor"/>"><spring:message
                            code="text.label.doctor"/></a>
                </c:if>
                <c:if test="${desc == true}">
                    <a href="<c:url value="/adminpanel/ticket/${userDataDTO.id}/list?pageNo=${pageNo}&pageSize=${pageSize}&desc=${false}&sort=doctor"/>"><spring:message
                            code="text.label.doctor"/></a>
                </c:if>
            </th>
            <th scope="col">
                <c:if test="${desc == false}">
                    <a href="<c:url value="/adminpanel/ticket/${userDataDTO.id}/list?pageNo=${pageNo}&pageSize=${pageSize}&desc=${true}&sort=patient"/>"><spring:message
                            code="text.label.patient"/></a>
                </c:if>
                <c:if test="${desc == true}">
                    <a href="<c:url value="/adminpanel/ticket/${userDataDTO.id}/list?pageNo=${pageNo}&pageSize=${pageSize}&desc=${false}&sort=patient"/>"><spring:message
                            code="text.label.patient"/></a>
                </c:if>
            </th>
            <th scope="col">
                <c:if test="${desc == false}">
                    <a href="<c:url value="/adminpanel/ticket/${userDataDTO.id}/list?pageNo=${pageNo}&pageSize=${pageSize}&desc=${true}&sort=datetime"/>"><spring:message
                            code="text.label.datetime"/></a>
                </c:if>
                <c:if test="${desc == true}">
                    <a href="<c:url value="/adminpanel/ticket/${userDataDTO.id}/list?pageNo=${pageNo}&pageSize=${pageSize}&desc=${false}&sort=datetime"/>"><spring:message
                            code="text.label.datetime"/></a>
                </c:if>
            </th>
            <th scope="col" style="width: 100px;">
                <c:if test="${desc == false}">
                    <a href="<c:url value="/adminpanel/ticket/${userDataDTO.id}/list?pageNo=${pageNo}&pageSize=${pageSize}&desc=${true}&sort=attendance"/>"><spring:message
                            code="text.label.attendance"/></a>
                </c:if>
                <c:if test="${desc == true}">
                    <a href="<c:url value="/adminpanel/ticket/${userDataDTO.id}/list?pageNo=${pageNo}&pageSize=${pageSize}&desc=${false}&sort=attendance"/>"><spring:message
                            code="text.label.attendance"/></a>
                </c:if>
            </th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${DTOList.size() != 0}">
            <c:forEach items="${DTOList}" var="ticket">
                <c:choose>
                    <c:when test="${ticket.attendance eq true}">
                        <tr style="background: rgba(0,255,52,0.58)">
                            <th scope="row">${ticket.id}</th>
                            <th scope="row">
                                <a href="<c:url value="/adminpanel/user/details/${ticket.doctor.id}"/>"
                                   class="btn-sm btn-primary"
                                   role="button"
                                   aria-pressed="true">${ticket.doctor.username}</a>
                            </th>
                            <th scope="row">
                                <a href="<c:url value="/adminpanel/user/details/${ticket.patient.id}"/>"
                                   class="btn-sm btn-primary"
                                   role="button"
                                   aria-pressed="true">${ticket.patient.username}</a>
                            </th>
                            <th scope="row">${ticket.datetime.format(formatter)}</th>
                            <th>
                                <a href="<c:url value="/adminpanel/ticket/${ticket.id}"/>" class="btn-sm btn-primary"
                                   role="button"
                                   aria-pressed="true"><spring:message code="button.details"/></a>

                                <a href="<c:url value="/adminpanel/ticket/delete/${ticket.id}"/>"
                                   class="btn-sm btn-danger" role="button"
                                   aria-pressed="true"><spring:message code="button.delete"/></a>
                            </th>
                        </tr>
                    </c:when>
                    <c:when test="${ticket.attendance eq false}">
                        <tr style="background: rgba(255,33,43,0.58)">
                            <th scope="row">${ticket.id}</th>
                            <th scope="row">
                                <a href="<c:url value="/adminpanel/user/details/${ticket.doctor.id}"/>"
                                   class="btn-sm btn-primary"
                                   role="button"
                                   aria-pressed="true">${ticket.doctor.username}</a>
                            </th>
                            <th scope="row">
                                <a href="<c:url value="/adminpanel/user/details/${ticket.patient.id}"/>"
                                   class="btn-sm btn-primary"
                                   role="button"
                                   aria-pressed="true">${ticket.patient.username}</a>
                            </th>
                            <th scope="row">${ticket.datetime.format(formatter)}</th>
                            <th>
                                <a href="<c:url value="/adminpanel/ticket/${ticket.id}"/>" class="btn-sm btn-primary"
                                   role="button"
                                   aria-pressed="true"><spring:message code="button.details"/></a>

                                <a href="<c:url value="/adminpanel/ticket/delete/${ticket.id}"/>"
                                   class="btn-sm btn-danger" role="button"
                                   aria-pressed="true"><spring:message code="button.delete"/></a>
                            </th>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <tr style="background: rgba(250,255,2,0.58)">
                            <th scope="row">${ticket.id}</th>
                            <th scope="row">
                                <a href="<c:url value="/adminpanel/user/details/${ticket.doctor.id}"/>"
                                   class="btn-sm btn-primary"
                                   role="button"
                                   aria-pressed="true">${ticket.doctor.username}</a>
                            </th>
                            <th scope="row">
                                <a href="<c:url value="/adminpanel/user/details/${ticket.patient.id}"/>"
                                   class="btn-sm btn-primary"
                                   role="button"
                                   aria-pressed="true">${ticket.patient.username}</a>
                            </th>
                            <th scope="row">${ticket.datetime.format(formatter)}</th>
                            <th>
                                <a href="<c:url value="/adminpanel/ticket/${ticket.id}"/>" class="btn-sm btn-primary"
                                   role="button"
                                   aria-pressed="true"><spring:message code="button.details"/></a>

                                <a href="<c:url value="/adminpanel/ticket/delete/${ticket.id}"/>"
                                   class="btn-sm btn-danger" role="button"
                                   aria-pressed="true"><spring:message code="button.delete"/></a>
                            </th>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </c:if>
        </tbody>
    </table>
    <div class="navbar-fixed-bottom row-fluid">
        <div class="navbar-inner">
            <div class="panel-footer">
                <div class="row">
                    <div class="col-xs-4"></div>
                    <div class="col-xs-4">
                        <div style="text-align: center">
                            <c:if test="${elementsCount != 0}">
                                <div class="row">
                                    <div class="col-xs-4">
                                        <c:if test="${pageNo > 1 && elementsCount > 0}">
                                            <a href="<c:url value="/adminpanel/ticket/${userId}/list?pageNo=${pageNo-1}&pageSize=${pageSize}&desc=${desc}"/>"
                                               class="btn btn-outline-primary" role="button"
                                               aria-pressed="true"><spring:message code="button.previously"/></a>
                                        </c:if>
                                        <c:if test="${pageCount != 0 && DTOList.size() == 0}">
                                            <a href="<c:url value="/adminpanel/ticket/${userId}/list?pageNo=1&pageSize=${pageSize}&desc=${desc}"/>"
                                               class="btn btn-outline-primary" role="button"
                                               aria-pressed="true"><spring:message code="button.previously"/></a>
                                        </c:if>
                                    </div>
                                    <div class="col-xs-4">
                                        <c:if test="${pageSize < elementsCount}">
                                            <c:forEach begin="1" end="${pageCount+1}" var="i">
                                                <c:choose>
                                                    <c:when test="${pageNo eq i}">
                                                        <td>${i}</td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td>
                                                            <a href="<c:url value="/adminpanel/ticket/${userId}/list?pageNo=${i}&pageSize=${pageSize}&desc=${desc}&sort=${sort}"/>">${i}</a>
                                                        </td>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </c:if>
                                    </div>
                                    <div class="col-xs-4">
                                        <c:if test="${(pageSize*pageNo)<elementsCount}">
                                            <a href="<c:url value="/adminpanel/ticket/${userId}/list?pageNo=${pageNo+1}&pageSize=${pageSize}&desc=${desc}&sort=${sort}"/>"
                                               class="btn btn-outline-primary" role="button"
                                               aria-pressed="true"><spring:message code="button.next"/></a>
                                        </c:if>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    <div class="col-xs-4"></div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>