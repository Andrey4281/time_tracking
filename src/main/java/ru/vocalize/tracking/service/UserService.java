package ru.vocalize.tracking.service;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import ru.vocalize.tracking.model.User;
import ru.vocalize.tracking.repository.UserRepository;

import java.util.List;

@Service
public class UserService {

    private final UserRepository users;

    public UserService(UserRepository users) {
        this.users = users;
    }

    public void save(User user) {
        users.save(user);
    }

    public List<User> findByUsername(String name) {
        return users.findByUsername(name);
    }

    public User getCurrentUser() {
        return (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    }
}
