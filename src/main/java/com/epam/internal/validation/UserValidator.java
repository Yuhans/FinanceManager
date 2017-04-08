package com.epam.internal.validation;

import com.epam.internal.dtos.RegistrationDto;
import com.epam.internal.models.User;
import com.epam.internal.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

public class UserValidator implements Validator{

    @Autowired
    UserService userService;

    @Override
    public boolean supports(Class<?> aClass) {
        return RegistrationDto.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        RegistrationDto registrationDto = (RegistrationDto) o;
        if(!registrationDto.getPassword().equals(registrationDto.getConfirm())) {
            errors.rejectValue("password", "error.passwordNotConfirm");
        }
    }
}
