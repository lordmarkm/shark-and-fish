package baldwin.sharkfish.repository;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.stereotype.Repository;

import baldwin.sharkfish.async.model.Tank;

@Repository
public class TankRepository {
	private Map<String, Tank> tanks = new HashMap<String, Tank>();
	
	public Tank newTank() {
		String id = RandomStringUtils.randomAlphabetic(5);
		while(null != tanks.get(id)) {
			id = RandomStringUtils.randomAlphabetic(5);
		}
		
		Tank tank = new Tank(id);
		tanks.put(id, tank);
		return tank;
	}

	public Tank get(String tankId) {
		Tank tank = tanks.get(tankId);
		return tank;
	}

	public Tank getWaitingTank() {
		for(Tank tank : tanks.values()) {
			if(tank.isLonely())
				return tank;
		}
		return null;
	}
}
