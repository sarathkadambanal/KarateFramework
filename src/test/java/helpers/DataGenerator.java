package helpers;

import com.github.javafaker.Faker;

import net.minidev.json.JSONObject;

public class DataGenerator {

    public static String getRandomEmail(){
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com";
        return email;
    }

    public static String getRandomUsername(){
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }
    
    public String getRandomUsername2()  // check signup to see how its called there
    {     //this function i created to show for non static functions we can create a object in feature file (signup) and call this function 
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }
    

    public static JSONObject getRandomArticleValues(){
        Faker faker = new Faker();
        String title = faker.name().title();
        System.out.println(title +" title ---");
        String description  = faker.relationships().parent();
        System.out.println(description +" description ---");
        String body = faker.address().cityName();
        System.out.println(body +" body ---");
        JSONObject json = new JSONObject();
        json.put("title", title);
        json.put("description", description);
        json.put("body", body);
        System.out.println(json.toString());
        return json;
    }
	
}
