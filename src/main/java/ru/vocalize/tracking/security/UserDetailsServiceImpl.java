package ru.vocalize.tracking.security;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import ru.vocalize.tracking.model.User;
import ru.vocalize.tracking.service.UserService;

import java.util.List;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    private UserService userService;

    public UserDetailsServiceImpl(UserService userService) {
        this.userService = userService;
    }

    @Override
    public UserDetails loadUserByUsername(String name) throws UsernameNotFoundException {
        List<User> users = userService.findByUsername(name);
        if (users.isEmpty()) {
            throw new UsernameNotFoundException(name);
        }
        return users.get(0);
    }
}