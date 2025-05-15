package service;

import java.util.ArrayList;
import java.util.List;

import com.praveen.praveen_pagination_rest.User;


public class UserService {
	private static List<User> users = new ArrayList<>();

    static {
        for (int i = 1; i <= 100; i++) {
        	User user = new User();
        	user.setUser_id(i);
        	user.setCountry("country_"+i);
        	user.setUser_name("name_"+i);
            users.add(user);
        }
    }

    public List<User> getUsers(int page, int pageSize) {
        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, users.size());
        return users.subList(start, end);
    }

    public int getTotalCount() {
        return users.size();
    }
}
