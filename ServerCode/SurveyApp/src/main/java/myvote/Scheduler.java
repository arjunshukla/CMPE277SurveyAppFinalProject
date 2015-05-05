package myvote;

import java.text.ParseException;
import java.text.SimpleDateFormat;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import tables.Poll;

@Component
public class Scheduler {

	private static final SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
	SimpleProducer producer=new SimpleProducer();
	@Autowired
	Utility utility;
	Poll poll;

	@Scheduled(cron = " * * * * * ?")
	public void mailScheduler() throws ParseException {
		utility.pollLookUp();
		System.out.println("This is working!!!!");
		
	}

}


