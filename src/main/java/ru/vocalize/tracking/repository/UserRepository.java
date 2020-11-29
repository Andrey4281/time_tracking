package ru.vocalize.tracking.repository;

import org.springframework.data.repository.CrudRepository;
import ru.vocalize.tracking.model.User;

import java.util.List;

public interface UserRepository extends CrudRepository<User, Integer> {

    List<User> findByUsername(String username);
}