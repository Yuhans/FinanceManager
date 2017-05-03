<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<t:master-page title="Главная">
    <script src="<c:url value="/resources/js/sendAccountFormViaAjax.js"/>"></script>
    <div class="container">
        <c:if test="${user == null}">
            <h2>Добрый день!</h2>
            <p>Вы можете войти в свой аккаунт или пройти регистрацию.</p>
            <a class="btn btn-success" href="<c:url value="/login"/>" type="submit">Войти в аккаунт</a>
            <a class="btn btn-default" href="<c:url value="/registration"/>" type="submit">Пройти регистрацию</a>
        </c:if>
        <c:if test="${user != null}">
            <div align="center">
                <div class="panel panel-collapse">
                    <span class="lead">
                        Баланс:  <fmt:formatNumber type="currency" value="${sumOfBalances}"/>
                        Расходы:  <fmt:formatNumber type="currency" value="${sumOfAllOutcomes}"/>
                        В планах:   <fmt:formatNumber type="currency" value="${plannedToSpend}"/>
                    </span>
                </div>
                <h2>Счета</h2>
                <div id="accountAdding">
                <form action="<c:url value="/account/add"/>" method="POST">
                    <button class="btn btn-default" type="button" data-toggle="modal" data-target="#accountAdd">
                        Добавить аккаунт
                    </button>
                    <jsp:include page="account-add.jsp"/>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
                </div>
                <br>
                <div class="container">
                    <div class="row">
                    <c:forEach var="account" items="${user.accounts}">
                        <div class="col-sm-3">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                <a href="<c:url value="/account/page?name=${account.name}"/>">
                                    <c:out value="${account.name}"/>
                                </a>
                                </div>
                                <div class="panel-body">
                                    <fmt:formatNumber type="currency" currencySymbol="${account.currency.characterCode}" value="${account.balance}"/>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    </div>
                </div>
                <h2>Категории расходов</h2>
                <div>
                    <button class="btn btn-default" type="button" data-toggle="modal" data-target="#outcometype-add">
                        Добавить категорию расходов
                    </button>
                    <jsp:include page="outcometype-add.jsp"/>
                </div>
                <br>
                <div class="container">
                    <div class="row">
                        <c:forEach var="outcomeType" items="${outcomeTypes}">
                            <div class="col-sm-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <c:url value="/outcometype/page" var="outcomeTypeUrl">
                                            <c:param name="itemId" value="${outcomeType.key.id}"/>
                                        </c:url>
                                        <a href="<c:out value="${outcomeTypeUrl}"/>"><c:out
                                                value="${outcomeType.key.name}"/></a>
                                    </div>
                                    <div class="panel-body">
                                        <c:choose>
                                            <c:when test="${outcomeType.value > outcomeType.key.limit}">
                                                <span style="color:red">
                                                    <fmt:formatNumber type="currency"
                                                                      value="${outcomeType.value}"/> / <fmt:formatNumber
                                                        type="currency" value="${outcomeType.key.limit}"/>
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatNumber type="currency" value="${outcomeType.value}"/> /
                                                <fmt:formatNumber type="currency" value="${outcomeType.key.limit}"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</t:master-page>