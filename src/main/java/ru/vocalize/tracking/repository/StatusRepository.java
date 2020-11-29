package ru.vocalize.tracking.repository;

import org.springframework.data.repository.CrudRepository;
import ru.vocalize.tracking.model.Status;

public interface StatusRepository extends CrudRepository<Status, Integer> {
}