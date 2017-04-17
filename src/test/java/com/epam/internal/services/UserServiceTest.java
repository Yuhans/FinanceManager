package com.epam.internal.services;

import com.epam.internal.daos.UserDao;
import com.epam.internal.models.User;
import com.epam.internal.models.UserInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.testng.AbstractTestNGSpringContextTests;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import static org.testng.Assert.*;

@ContextConfiguration("classpath:common-mvc-config.xml")
public class UserServiceTest extends AbstractTestNGSpringContextTests {

    @Autowired
    private UserService userService;

    private static User user;

    @BeforeMethod
    public void setUp() throws Exception {
        user = new User("user@email", "password", new UserInfo("name", "surname"));
        userService.createUser(user);
    }

    @AfterMethod
    public void tearDown() throws Exception {
        User reload = userService.findByEmail(user.getEmail());
        if (reload != null) {
            userService.deleteUser(user);
        }
    }

    @Test
    public void testGetUserByEmail() throws Exception {
        Assert.assertEquals(user.getEmail(), userService.findByEmail("user@email").getEmail());
    }

}