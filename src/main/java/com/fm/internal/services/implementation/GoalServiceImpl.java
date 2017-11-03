package com.fm.internal.services.implementation;


import com.fm.internal.dtos.GoalDto;
import com.fm.internal.models.Goal;
import com.fm.internal.models.User;
import com.fm.internal.repository.GoalRepository;
import com.fm.internal.services.CurrencyService;
import com.fm.internal.services.GoalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class GoalServiceImpl implements GoalService{
    @Autowired
    private GoalRepository goalRepository;
    @Autowired
    private CurrencyService currencyService;

    @Override
    public List<Goal> getGoalsByUser(User user) {
        return goalRepository.findByUser(user);
    }

    @Override
    public List<Goal> getGoalsWithoutIncomeForMonth(User user) {
        return goalRepository.findWithNoIncomesByMonth(user).stream().filter(account -> account instanceof Goal && !((Goal) account).isFinished() && !((Goal) account).isOverdue()).map(account -> (Goal) account).collect(Collectors.toList());
    }

    @Override
    public void addGoal(Goal goal) {
        goalRepository.save(goal);
    }

    @Override
    public void updateGoal(Goal goal) {
        goalRepository.save(goal);
    }

    @Override
    public void deleteGoal(Goal goal) {
        goalRepository.delete(goal);
    }

    @Override
    public void addGoal(GoalDto goalDto, User user) {
        Goal goal = new Goal(goalDto.getName(), new BigDecimal(0), new BigDecimal(goalDto.getGoalAmount()), null,
                user, currencyService.findCurrencyByCharCode(goalDto.getCurrency()), LocalDate.parse(goalDto.getDate()));
        goalRepository.save(goal);
    }

    @Override
    public Goal getGoalById(long id){
        return goalRepository.findOne(id);
    }
}
