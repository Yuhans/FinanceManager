package com.epam.internal.service;

import com.epam.internal.dao.AccountDao;
import com.epam.internal.data.entities.Account;
import com.epam.internal.data.entities.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service("accountService")
public class AccountServiceImpl implements AccountService {

    @Autowired
    private AccountDao dao;

    @Override
    public List<Account> findAllUserAccounts(User user) {
        return dao.findAllUserAccounts(user);
    }

    @Override
    public void createAccount(Account account) {
        dao.saveAccount(account);
    }

    @Override
    public void updateAccount(Account account) {
        dao.updateInfo(account);
    }


}
