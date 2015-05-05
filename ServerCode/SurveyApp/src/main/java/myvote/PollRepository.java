package myvote;

import java.awt.List;
import java.util.ArrayList;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import tables.Moderator;
import tables.Poll;

//@RepositoryRestResource(collectionResourceRel = "polls", path = "polls")
public interface PollRepository extends MongoRepository<Poll, String> {
	
	Poll findById(String id);
	ArrayList<Poll> findByModerator(Moderator moderator);
	
}