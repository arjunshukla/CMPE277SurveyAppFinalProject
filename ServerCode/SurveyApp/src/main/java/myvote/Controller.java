package myvote;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicInteger;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import tables.Moderator;
import tables.Poll;
import tables.View;
import ch.qos.logback.core.net.SyslogOutputStream;

import com.fasterxml.jackson.annotation.JsonView;

@RestController
@RequestMapping("/api/v1")
//@EnableWebSecurity
public class Controller {

	ArrayList moderator_list = new ArrayList();
	ArrayList poll_list = new ArrayList();
	HashMap<String, String> credentials = new HashMap<String,String>();

	@Autowired
	Utility utility;

	private final AtomicInteger moderator_counter = new AtomicInteger();
	private final AtomicInteger poll_counter = new AtomicInteger();

	// 1) Create a moderator
	@RequestMapping(value = "/moderators", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public ResponseEntity<Moderator> createModerator(
			@RequestBody @Validated({ Validation.ValidateAll.class }) Moderator moderator) {

		Moderator m = new Moderator(generateID(), moderator.getName(),
				moderator.getEmail(), moderator.getPassword(),
				utility.getISO_Date());
		if(utility.search_duplicate_moderator_by_email(m.getEmail()))		
			return new ResponseEntity<Moderator>(m, HttpStatus.CONFLICT);		
		else{
			utility.addModerator(m);
			return new ResponseEntity<Moderator>(m, HttpStatus.CREATED);
		}

	}

	private String generateID() {
		int n = (int) (Math.random()*100);
		String id = String.valueOf(n);
		return id;

	}


	// 2) View a Moderator
	@RequestMapping(value = "/moderators/{moderatorId}", method = { RequestMethod.GET })
	public @ResponseBody ResponseEntity<Moderator> getModerator(
			@PathVariable String moderatorId) throws Exception {
		System.out.println("get Moderator" + moderatorId);
		Moderator mod = utility.getModerator(moderatorId);
		return new ResponseEntity<Moderator>(mod, HttpStatus.OK);
	}



	// 3) Moderator Login		
	@RequestMapping(value = "/moderators/login", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public HashMap<String,String> verifyLogin(
			@RequestBody @Validated({ Validation.ValidateAll.class }) Moderator moderator) {
		System.out.println("login success"+ moderator.getEmail()+ " :: " + moderator.getPassword());
		credentials.put(moderator.getEmail(),moderator.getPassword());
		String arr[] = new String[2];
		arr = utility.search_moderator_by_email(moderator.getEmail(), moderator.getPassword());

		//System.out.println(isValid);
		HashMap<String, String> tempHM = new HashMap<String,String>();

		if(arr[1].equals("Valid"))
		{
			tempHM.put("success", "valid");
			tempHM.put("moderatorID", arr[0]);
			System.out.println(arr[0]);
		}
		else
		{
			if(arr[1].equals("Invalid Credentials"))			
				tempHM.put("success", "invalid credentials");			
			else			
				tempHM.put("success", "invalid");			 
		}
		return tempHM;
	}


	//4) Update an existing moderator

	@RequestMapping(value = "/moderators/{moderatorId}", method = { RequestMethod.PUT })
	@ResponseStatus(value = HttpStatus.CREATED)
	public ResponseEntity<Moderator> updateModerator(
			@PathVariable String moderatorId,
			@RequestBody @Validated({ Validation.ValidateFields.class }) Moderator moderator) {
		System.out.println("Updating Moderator " + moderatorId);
		if (moderatorId != null) {
			Moderator mod = utility.update_moderator_by_id(moderatorId,
					moderator.getEmail(), moderator.getPassword(),
					moderator.getName());
			if (mod != null)
				return new ResponseEntity<Moderator>(mod, HttpStatus.OK);
		}

		return new ResponseEntity<Moderator>(HttpStatus.BAD_REQUEST);

	}

	// 5) Create a poll for a particular moderator

	@JsonView(View.WithoutResult.class)
	@RequestMapping(value = "/moderators/{moderatorId}/polls", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public ResponseEntity<Poll> createPoll(@PathVariable String moderatorId,
			@RequestBody @Valid Poll poll) {
		Poll p = null;
		Moderator m = utility.search_moderator_by_id(moderatorId);
		if (m != null) {

			String pollId = generateNewPollId();
			p = new Poll(pollId,
					poll.getQuestion(), poll.getStarted_at(),
					poll.getExpired_at(),poll.getPollCategory(),poll.getPollName(), poll.getChoice());
			// mapping pole to moderator
			p.setModerator(m);
			System.out.println("*****Added a Poll*****"+p.getPollCategory()+" Name "+p.getPollName());
			System.out.println(p); 
			utility.addPoll(p);
			return new ResponseEntity<Poll>(p, HttpStatus.CREATED);
		}
		return new ResponseEntity<Poll>(p, HttpStatus.BAD_REQUEST);
	}

	private String generateNewPollId() {
		int id = (int)(Math.random()*100000);
		String pollId = String.valueOf(id);
		System.out.println(pollId);
		return pollId;
	}

	// 6) View a specific poll

	@JsonView(View.WithoutResult.class)
	@RequestMapping(value = "/polls/{pollId}", method = { RequestMethod.GET })
	public @ResponseBody ResponseEntity<Poll> getPoll_without_result(
			@PathVariable String pollId) throws Exception {
		if (!pollId.equals("")) {
			Poll p = utility.search_poll_by_id(pollId);
			if (p != null)
				return new ResponseEntity<Poll>(p, HttpStatus.OK);
		}

		return new ResponseEntity<Poll>(HttpStatus.BAD_REQUEST);

	}



	// 7) View all the polls for a specified moderator

	@RequestMapping(value = "/moderators/{moderatorId}/polls", method = { RequestMethod.GET })
	public @ResponseBody ResponseEntity<ArrayList<Poll>> getList_Polls(
			@PathVariable String moderatorId) throws Exception {
		Moderator m = utility.search_moderator_by_id(moderatorId);
		if (m != null) {

			ArrayList<Poll> pollList = utility.get_moderator_polls(m);
			if (pollList != null) {
				return new ResponseEntity<ArrayList<Poll>>(pollList,
						HttpStatus.OK);
			}

		}
		return new ResponseEntity<ArrayList<Poll>>(HttpStatus.BAD_REQUEST);

	}


	// 8) View a particular poll for a specified moderator

	@RequestMapping(value = "/moderators/{moderatorId}/polls/{pollId}", method = { RequestMethod.GET })
	public @ResponseBody ResponseEntity<Poll> getPoll_with_result(
			@PathVariable String moderatorId, @PathVariable String pollId)
					throws Exception {
		Moderator mod = utility.search_moderator_by_id(moderatorId);
		if (mod != null) {
			if (!pollId.equals("")) {
				Poll p = utility.search_poll_by_id(pollId);
				if (p != null && p.getModerator().getId().equals(mod.getId()))
					return new ResponseEntity<Poll>(p, HttpStatus.OK);
			}
		}
		return new ResponseEntity<Poll>(HttpStatus.BAD_REQUEST);

	}


	// 9) Delete a poll

	@RequestMapping(value = "/moderators/{moderatorId}/polls/{pollId}", method = { RequestMethod.DELETE })
	public @ResponseBody ResponseEntity<String> delete_Polls(
			@PathVariable String moderatorId, @PathVariable String pollId)
					throws Exception {

		if (!moderatorId.equals("")) {
			Moderator m = utility.search_moderator_by_id(moderatorId);
			if (m != null) {

				if (!pollId.equals("")) {
					Poll p = utility.search_poll_by_id(pollId);
					if (p != null && p.getModerator().getId().equals(m.getId())) {
						utility.removePoll(pollId);
						return new ResponseEntity<String>("Record Deleted!!",
								HttpStatus.NO_CONTENT);
					} else {
						return new ResponseEntity<String>(
								"You dont have access to Delete this record!!",
								HttpStatus.NO_CONTENT);
					}
				}
			}
		}
		return new ResponseEntity<String>("No Record Found/Deleted!!",
				HttpStatus.NO_CONTENT);

	}

	// 10) Vote for a poll

	@RequestMapping(value = "/polls/{pollId}", method = { RequestMethod.PUT })
	public ResponseEntity<String> vote(@PathVariable String pollId,
			@RequestParam Integer choice) {
		if (!pollId.equals("")) {
			Poll p = utility.search_poll_by_id(pollId);
			if (p != null && choice < p.getResults().length) {
				p.getResults()[choice]++;
				utility.vote(p);
				return new ResponseEntity<String>("Voting Completed!!",
						HttpStatus.NO_CONTENT);
			}
		}
		return new ResponseEntity<String>("No Voting don!!",
				HttpStatus.NO_CONTENT);

	}

	// 11) View all polls
	@JsonView(View.WithoutResult.class)
	@RequestMapping(value = "/polls", method = { RequestMethod.GET })
	public @ResponseBody List<Poll> getAllPolls() throws Exception {

		List<Poll> allPolls = utility.getAllPolls();
		if (allPolls != null){
			return allPolls;
		}

		return allPolls;

	}

}
