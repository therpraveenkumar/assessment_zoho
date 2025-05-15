/**
 * SELLVehicle json parser
 * @author praveen-22566
 */
package com.praveen.parser;

import java.util.HashMap;
import java.util.Map;

public class JsonParse {
	/**
	 * Method to create customer
	 * @param {@code String} json
	 * @return {@codeMap<String, String>} 
	 * */
    public static Map<String, String> parseJson(String json) {
        Map<String, String> map = new HashMap<>();

        // Basic parsing logic
        json = json.trim().replaceAll("[{}\"]", ""); // Remove braces and quotes
        String[] pairs = json.split(","); // Split into key-value pairs

        for (String pair : pairs) {
            String[] keyValue = pair.split(":");
            if (keyValue.length == 2) {
                map.put(keyValue[0].trim(), keyValue[1].trim());
            }
        }

        return map;
    }
}
