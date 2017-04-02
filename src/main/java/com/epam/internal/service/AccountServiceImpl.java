package com.epam.internal.service;

import com.epam.internal.dao.AccountDao;
import com.epam.internal.data.entities.Account;
import com.epam.internal.data.entities.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service("accountService")
public class AccountServiceImpl implements IAccountService {

    @Autowired
    private AccountDao dao;

    @Override
    public Account findById(int id) {
        return dao.findById(id);
    }

    @Override
    public List<Account> findAllUserAccounts(User user) {
        return dao.findAllUserAccounts(user);
    }

    @Override
    public void createAccount(Account account) {
        dao.create(account);
    }

    @Override
    public void deleteAccountById(int id) {
        dao.deleteById(id);
    }

    @Override
    public void updateAccount(Account account) {
        dao.update(account);
    }


}
