package com.epam.internal.dao;

import com.epam.internal.data.entities.Account;
import com.epam.internal.data.entities.Outcome;

import java.util.List;

public interface OutcomeDao {
    void addOutcome(Outcome outcome);
    void deleteOutcome(Outcome outcome);
    void updateOutcome(Outcome outcome);
    List<Outcome> getAllOutcomesInAccount(Account account);
}