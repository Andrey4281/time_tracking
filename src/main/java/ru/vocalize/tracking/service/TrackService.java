package ru.vocalize.tracking.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import ru.vocalize.tracking.model.User;
import ru.vocalize.tracking.model.Track;
import ru.vocalize.tracking.repository.StatusRepository;
import ru.vocalize.tracking.repository.TrackRepository;
import ru.vocalize.tracking.repository.UserRepository;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class TrackService {

    private final TrackRepository trackRepository;
    private final UserRepository userRepository;
    private final StatusRepository statusRepository;

    public TrackService(TrackRepository trackRepository, UserRepository userRepository, StatusRepository statusRepository) {
        this.trackRepository = trackRepository;
        this.userRepository = userRepository;
        this.statusRepository = statusRepository;
    }

    public List<Track> findByUser(User user) {
        return trackRepository.findByUserId(user.getId());
    }

    @Transactional(isolation = Isolation.SERIALIZABLE, propagation = Propagation.REQUIRES_NEW)
    public boolean cameUser(User user) {
        if (user.getCurrentTrack() != null) {
            return false;
        }
        Track track = new Track();
        track.setCame(LocalDateTime.now());
        track.setUser(user);
        trackRepository.save(track);

        user.setStatus(statusRepository.findById(2).get());
        user.setCurrentTrack(track);
        userRepository.save(user);
        return true;
    }

    @Transactional(isolation = Isolation.SERIALIZABLE, propagation = Propagation.REQUIRES_NEW)
    public boolean goneUser(User user) {
        if (user.getCurrentTrack() == null) {
            return false;
        }
        Track track = user.getCurrentTrack();
        track.setGone(LocalDateTime.now());
        trackRepository.save(track);

        user.setStatus(statusRepository.findById(1).get());
        user.setCurrentTrack(null);
        userRepository.save(user);
        return true;
    }
}
