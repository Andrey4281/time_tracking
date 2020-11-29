package ru.vocalize.tracking.repository;

import org.springframework.data.repository.CrudRepository;
import ru.vocalize.tracking.model.Track;

import java.util.List;

public interface TrackRepository extends CrudRepository<Track, Integer> {

    List<Track> findByUserId(int id);
}