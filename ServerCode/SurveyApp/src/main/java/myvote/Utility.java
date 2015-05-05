package myvote;

import java.text.DateFormat;
import java.text.ParseException;
import java.util.GregorianCalendar;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Repository;

import tables.Moderator;
import tables.Poll;

@Repository
@SpringBootApplication
public class Utility {

	@Autowired
	private ModeratorRepository moderatorRespository;
	@Autowired
	private PollRepository pollRepository;
	ArrayList<Poll> Ex_poll = new ArrayList<Poll>();

	public Moderator search_moderator_by_id(String id) {

		Moderator mod = moderatorRespository.findById(id);
		return mod;
	}
	
	//Search Moderator by email
	public boolean search_duplicate_moderator_by_email(String email){
		Moderator mod = new Moderator();
		mod = moderatorRespository.findByEmail(email);
		if(mod != null){
			return true;			
		}
		return false;
		
	}
	
	//Search Moderator by email and Password	
	public String[] search_moderator_by_email(String email, String password) {		
		String[] arr = new String[2];		
		Moderator mod = new Moderator();
		mod = moderatorRespository.findByEmail(email);
			System.out.println(mod + " " + email);
		if(mod != null)
		{
			if(mod.getEmail().equals(email) && mod.getPassword().equals(password))
			{
				arr[0]= mod.getId();
				arr[1]= "Valid";
			}
			else
			{
				arr[0] = "Email or Password is invalid";
				arr[1] = "Invalid Credentials";
			}
		}
			else
		{
				arr[0] = "No such moderator exists";
				arr[1] = "Invalid";
		}
		
		return arr;
	}


	public Moderator update_moderator_by_id(String id, String new_email,
			String new_password, String new_name) {
		Moderator mod = moderatorRespository.findById(id);
		if (mod != null) {
			if (!new_email.equalsIgnoreCase("")) {
				mod.setEmail(new_email);
			}
			if (!new_name.equalsIgnoreCase("")) {
				mod.setName(new_name);
			}
			if (!new_password.equalsIgnoreCase("")) {
				mod.setPassword(new_password);
			}

			moderatorRespository.save(mod);
			return mod;
		}
		return null;
	}
	
	public void update_poll(Poll p) {

		pollRepository.save(p);	
	}

	public Poll search_poll_by_id(String id) {

		Poll poll = pollRepository.findById(id);
		return poll;
	}

	public void update_result(Poll poll, int choice) {

	}

	public void addPoll(Poll poll) {
		pollRepository.save(poll);
	}

	public void addModerator(Moderator moderator) {
		moderatorRespository.save(moderator);
	}

	public Moderator getModerator(String moderatorId) {
		Moderator mod = moderatorRespository.findById(moderatorId);
		return mod;
	}

	public void removePoll(String pollId) {
		pollRepository.delete(pollId);
	}

	public void vote(Poll p) {
		pollRepository.save(p);
	}

	public ArrayList get_moderator_polls(Moderator moderator) {
		return pollRepository.findByModerator(moderator);

	}

	public String getISO_Date() {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.ms'Z'");
		String nowAsISO = df.format(new Date());
		return nowAsISO;
	}
	
	public void pollLookUp() throws ParseException{
		
		List<Poll> poll = pollRepository.findAll();
		for(int i=0; i<poll.size();i++){
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
			String d1 = poll.get(i).getExpired_at();
			//Date exp = sdf.parse(d1);
			System.out.println(d1);
			int d2 = (int) System.currentTimeMillis();
			String d3 = String.valueOf(d2);
			//Date curr = sdf.parse(d3);
			System.out.println(d3);
			//pollRepository.delete(poll.get(i));
					}
					
				}
			
		

	public List<Poll> getAllPolls() {
		List<Poll> allPolls = pollRepository.findAll();
		return allPolls;
	}
	
}
