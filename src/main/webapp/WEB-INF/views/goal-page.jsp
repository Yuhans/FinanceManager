<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<t:master-page title="${goal.name}">
    <script src="<c:url value="/resources/js/editNotes.js"/>"></script>
    <style>
        [contenteditable]:focus {
            padding: 5px;
        }
    </style>
    <jsp:include page="../fragments/back-button.jsp"/>
    <div class="container">
        <div class="col-sm-11 col-sm-offset-1">
            <h2 align="center" class="page-header">Приходы</h2>
            <div class="article">
                <div class="row">
                    <form:form method="get" action="/goal/page" modelAttribute="rangeDto" id="rangeForm"
                               cssClass="form-inline col-md-7 col-sm-7">
                        <div class="input-daterange input-group col-sm-9 col-sm-pull-3" id="datepicker-range">
                            <form:input path="start" type="text" cssClass="form-control" name="start"
                                        id="start"
                                        readonly="true"/>
                            <span class="input-group-addon">to</span>
                            <form:input path="end" type="text" cssClass="form-control" name="end" id="end"
                                        readonly="true"/>
                        </div>
                        <button type="submit" class="btn btn-blue col-xs-12 col-sm-3 col-sm-push-9">Показать</button>
                        <input type="hidden" name="itemId" value="${rangeDto.id}">
                        <c:if test="${goalId != null}">
                            <input type="hidden" name="goalId" value="${goalId}"/>
                        </c:if>
                        <script>
                            $('#datepicker-range').datepicker({
                                format: "yyyy-mm-dd",
                                todayBtn: "linked",
                                clearBtn: true
                            });
                        </script>
                    </form:form>
                </div>
                <c:choose>
                    <c:when test="${not empty incomes}">
                        <br>
                        <div class="table-responsive">
                            <table id="incomes" class="table notes table-hover">
                                <thead>
                                <tr>
                                    <th>Редактировать заметку</th>
                                    <th>Заметка</th>
                                    <th>Хэштеги</th>
                                    <th>Сумма</th>
                                    <th>Дата</th>
                                    <th>Счет</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="income" items="${incomes}">
                                    <tr class="tableRow">
                                        <td>
                                            <div class="row editBar">
                                                <div>
                                                    <form action="<c:url value="/income/delete"/>" method="POST">
                                                        <input type="hidden" name="incomeId" value="${income.id}">
                                                        <button type="submit" class="btn-link">
                                                            <span class="glyphicon glyphicon-trash"></span>
                                                        </button>
                                                        <input type="hidden" name="${_csrf.parameterName}"
                                                               value="${_csrf.token}"/>
                                                    </form>
                                                </div>
                                                <div>
                                                    <button class="editBtn dark-grey btn-link">
                                                        <span class="glyphicon glyphicon-edit"></span>
                                                    </button>
                                                </div>
                                                <div>
                                                    <button class="cancelBtn red btn-link" hidden>
                                                        <span class="glyphicon glyphicon-remove-circle"></span>
                                                    </button>
                                                </div>
                                                <div>
                                                    <form class="saveNote" action="<c:url value="/income/update"/>"
                                                          method="POST">
                                                        <input type="text" hidden class="oldVal">
                                                        <input type="hidden" name="accountId" value="${income.account.id}">
                                                        <input type="hidden" name="incomeId" value="${income.id}">
                                                        <input type="hidden" name="note">
                                                        <input type="hidden" name="${_csrf.parameterName}"
                                                               value="${_csrf.token}"/>
                                                        <button type="submit" class="saveBtn dark-green btn-link" hidden>
                                                            <span class="glyphicon glyphicon-ok"></span>
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="note" data-name="tableNote" contenteditable="false">
                                                ${income.note}
                                        </td>
                                        <td>
                                            <c:forEach var="hashtag" items="${income.hashTags}">
                                                <c:url value="/income/all" var="hashtagUrl">
                                                    <c:param name="hashTag" value="${hashtag.text}"/>
                                                    <c:if test="${accountId != null}">
                                                        <c:param name="accountId" value="${accountId}"/>
                                                    </c:if>
                                                </c:url>
                                                <a class="badge" href="<c:out value="${hashtagUrl}"/>">${hashtag.text}</a>
                                            </c:forEach>
                                        </td>
                                        <td>
                                                ${income.amount}
                                        </td>
                                        <td>
                                                ${income.date} ${income.time}
                                        </td>
                                        <td>
                                                ${income.account.name}
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div align="center">
                            <jsp:include page="../fragments/pagination.jsp"/>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div>
                            <br>
                            <h3>Пока нет приходов на данную цель.</h3>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</t:master-page>