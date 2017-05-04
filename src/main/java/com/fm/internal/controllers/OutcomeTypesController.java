package com.fm.internal.controllers;

import com.fm.internal.dtos.OutcomeTypeDto;
import com.fm.internal.dtos.PaginationDto;
import com.fm.internal.models.Outcome;
import com.fm.internal.models.OutcomeType;
import com.fm.internal.models.User;
import com.fm.internal.services.OutcomeTypeService;
import com.fm.internal.services.StatusBarService;
import com.fm.internal.services.UserService;
import com.fm.internal.services.implementation.PaginationServiceImpl;
import com.fm.internal.validation.OutcomeTypeValidator;
import com.fm.internal.validation.util.ValidErrors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/outcometype")
public class OutcomeTypesController {

    @Autowired
    private OutcomeTypeService typeService;
    @Autowired
    private UserService userService;
    @Autowired
    private OutcomeTypeValidator validator;
    @Autowired
    private PaginationServiceImpl paginationService;
    @Qualifier("messageSource")
    @Autowired
    private MessageSource messages;
    @Autowired
    private StatusBarService statusBarService;

    @RequestMapping(value = "/page", method = RequestMethod.GET)
    public ModelAndView showOutcomeType(Long itemId, Integer pageId) {
        if (pageId == null) {
            pageId = 1;
        }
        OutcomeType outcomeType = typeService.findTypeById(itemId);
        long sizeOutcomesOfType = typeService.getSizeOutcomesOfType(outcomeType);
        int pageSize = 5;
        PaginationDto paginationDto = paginationService.createPagination(itemId, pageId, pageSize, sizeOutcomesOfType, "/outcometype/page");
        List<Outcome> outcomes = typeService.getOutcomesOfType(outcomeType, paginationDto.getFirstItem(), pageSize);

        OutcomeTypeDto outcomeTypeDto = new OutcomeTypeDto(itemId, outcomeType.getName(), outcomeType.getLimit().toString(), outcomes);
        ModelAndView modelAndView = new ModelAndView("outcometype", "outcomeTypeDto", outcomeTypeDto);
        modelAndView.addObject("paginationDto", paginationDto);
        User loggedUser = userService.getLoggedUser();
        modelAndView.addObject("user", loggedUser);
        modelAndView.addObject("statusBarDto", statusBarService.getStatusBar(loggedUser));

        return modelAndView;
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Object addOutcomeType(@Valid @RequestBody OutcomeTypeDto outcomeTypeDto, BindingResult result) {
        validator.validate(outcomeTypeDto, result);
        User loggedUser = userService.getLoggedUser();
        if (!result.hasErrors() && loggedUser != null) {
            typeService.addOutcomeType(outcomeTypeDto, loggedUser);
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            Map<String, String> errors = ValidErrors.getMapOfMessagesAndErrors(result, messages);
            return new ResponseEntity<>(errors, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/delete/all", method = RequestMethod.POST)
    public ModelAndView deleteOutcomeTypeWithOutcomes(Long currentOutcomeTypeId) {
        OutcomeType outcomeType = typeService.findTypeById(currentOutcomeTypeId);
        typeService.deleteOutcomeType(outcomeType);
        return new ModelAndView("redirect:" + "/index");
    }

    @RequestMapping(value = "/delete/move", method = RequestMethod.POST)
    public ModelAndView deleteOutcomeTypeAndMoveOutcomes(Long currentOutcomeTypeId, Long newOutcomeTypeId) {
        OutcomeType currentOutcomeType = typeService.findTypeById(currentOutcomeTypeId);
        OutcomeType newOutcomeType = typeService.findTypeById(newOutcomeTypeId);
        typeService.deleteTypeAndUpdateOutcomes(currentOutcomeType, newOutcomeType);
        return new ModelAndView("redirect:" + "/index");
    }
}
