package demo;

import myvote.PollApplication;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = PollApplication.class)
public class SmsPollApplicationTests {

	@Test
	public void contextLoads() {
	}

}
