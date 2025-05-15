package com.praveen.jersey_client_crud_operation;

import java.util.Scanner;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.ClientResponse;
import javax.ws.rs.core.MediaType;

public class RunCliedApi {
	private static final String BASE_URL = "http://localhost:8087/helloApp/webresources/users";

	public static void main(String[] args) {
		Client client = Client.create();
		Scanner scan = new Scanner(System.in);
		boolean flag = true;
		while (flag) {
			System.out.println("1. create\n2. get users\n3. update user\n4. delete user -1 to exit");
			try {
				int option = scan.nextInt();
				scan.nextLine();
				if (option == -1) {
					System.out.println("Thanks");
					break;
				}
				switch (option) {
				case 1: {

					System.out.println("Enter name");
					String name = scan.nextLine().trim();
					System.out.println("Enter country");
					String country = scan.nextLine().trim();
					if (name.isEmpty() || country.isEmpty()) {
						System.out.println("emtpy value is not accepted");
						continue;
					}
					createUser(client, name, country);
					break;
				}
				case 2: {
					getUser(client);
					break;
				}
				case 3: {
					System.out.println("Enter id");
					int id = scan.nextInt();
					scan.nextLine();
					System.out.println("Enter name to update");
					String name = scan.nextLine().trim();
					System.out.println("Enter country to update");
					String country = scan.nextLine().trim();
					if (name.isEmpty() || country.isEmpty()) {
						System.out.println("emtpy value is not accepted");
						continue;
					} else if (id < 1) {
						System.out.println("positive value only accepted for id");
						continue;
					}
					updateUser(client, id, name, country);
					break;
				}
				case 4: {
					System.out.println("Enter user id to delete");
					int id = scan.nextInt();
					deleteUser(client, id);
					break;
				}
				default: {
					System.out.println("wrong option");
				}

				}
			} catch (Exception exception) {
				System.out.println("numbers only accepted");
				scan.next();
			}
		}
	}

	// Create a new user (POST)
	public static void createUser(Client client, String name, String country) {
		WebResource webResource = client.resource(BASE_URL + "/create_user");

		String input = "{\"user_name\":\"" + name + "\", \"country\":\"" + country + "\"}";

		ClientResponse response = webResource.type(MediaType.APPLICATION_JSON).post(ClientResponse.class, input);

		if (response.getStatus() == 200) {
			System.out.println("User created successfully!");
		} else {
			System.out.println("Failed to create user. HTTP error code: " + response.getStatus());
		}

		response.close();
	}

	// Read a users (GET)
	public static void getUser(Client client) {
		WebResource webResource = client.resource(BASE_URL);

		ClientResponse response = webResource.accept(MediaType.APPLICATION_JSON).get(ClientResponse.class);

		if (response.getStatus() == 200) {
			String output = response.getEntity(String.class);
			System.out.println("User fetched: " + output);
		} else {
			System.out.println("Failed to fetch user. HTTP error code: " + response.getStatus());
		}

		response.close();
	}

	// Update a user by ID (PUT)
	public static void updateUser(Client client, int userId, String name, String country) {
		WebResource webResource = client.resource(BASE_URL + "/update_user");

		String input = "{\"user_id\":\"" + userId + "\", \"user_name\":\"" + name + "\", \"country\":\"" + country
				+ "\"}";

		ClientResponse response = webResource.type(MediaType.APPLICATION_JSON).put(ClientResponse.class, input);

		if (response.getStatus() == 200) {
			System.out.println("User updated successfully!");
		} else {
			System.out.println("Failed to update user. HTTP error code: " + response.getStatus());
		}

		response.close();
	}

	// Delete a user by ID (DELETE)
	public static void deleteUser(Client client, int userId) {
		WebResource webResource = client.resource(BASE_URL + "/delete_user");
		String input = "{\"user_id\":\"" + userId + "\"}";
		ClientResponse response = webResource.type(MediaType.APPLICATION_JSON).delete(ClientResponse.class, input);

		if (response.getStatus() == 200) {
			System.out.println("User deleted successfully!");
		} else {
			System.out.println("Failed to delete user. HTTP error code: " + response.getStatus());
		}

		response.close();
	}
}
