<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="modal fade" id="outcomeAdd" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal">×</button>
                <h4 class="modal-title">Новый расход</h4>
            </div>
            <form class="form-horizontal" method="POST" id="outcomeForm" role="form" action="<c:url value="/outcome/add"/>">
                <div class="modal-body">
                    <div class="form-group">
                        <select name="outcomeTypeId" class="form-control">
                            <option disabled>--- Select ---</option>
                            <c:forEach items="${types}" var="type">
                                <option value="${type.id}">${type.name}</option>
                            </c:forEach>
                        </select><br/>
                    </div>
                    <div class="form-group">
                        <input type="text" id="outcomeNote" name="note" placeholder="Note" class="form-control"
                               maxlength="256"/><br/>
                        <div class="help-block with-errors"></div>
                    </div>
                    <div class="form-group">
                        <input type="text" id="outcomeAmount" name="amount" placeholder="Amount" class="form-control"
                               pattern="^[+-]?[0-9]{1,3}(?:,?[0-9]{3})*(?:\.[0-9]{2})?$" required/><br/>
                        <div class="help-block with-errors"></div>
                    </div>
                    <div class="form-group">
                        <label for="outcomeDate">Дата расхода:<br/></label>
                        <input id="outcomeDate" name="date" type="date" required/><br/>
                        <div class="help-block with-errors"></div>
                    </div>
                    <div class="form-group" id="currExchangeOutcome" hidden>
                        <div class="form-group">
                            <input type="hidden" value="${account.currency.nominal}" id="fromNominalOutcome">
                            <input type="hidden" value="${account.currency.curs}" id="fromCursOutcome">
                            <input type="hidden" value="${user.info.currency.nominal}" id="toNominalOutcome">
                            <input type="hidden" value="${user.info.currency.curs}" id="toCursOutcome">
                            <input type="hidden" value="${user.info.currency.characterCode}" id="userCurOutcome">
                            <input type="hidden" value="${account.currency.characterCode}" id="accountCurOutcome">
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    <input id="checkboxOutcome" type="checkbox"/>
                                </div>
                                <input type="text" id="customCursOutcome" class="form-control" disabled/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">${user.info.currency.characterCode}</div>
                                <input type="text" id="defaultAmountOutcome" name="defaultAmount" class="form-control"
                                       readonly/>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" id="accountId" name="accountId" value="${account.id}">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-success btn-block" type="submit">Добавить</button>
                    <br>
                    <button class="btn btn-default btn-block" type="button" data-dismiss="modal">Отмена</button>
                </div>
            </form>
        </div>
    </div>
</div>