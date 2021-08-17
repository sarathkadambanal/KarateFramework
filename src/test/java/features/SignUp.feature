
Feature: sign up new user


		Background: pre conditions
			* def dataGenerator = Java.type('helpers.DataGenerator')
			* def timeValidator = read('classpath:helpers/timeValidator.js')
			* def randomEmail = dataGenerator.getRandomEmail()
			* print randomEmail + "random email"
			* def randomUserName = dataGenerator.getRandomUsername()
			* url apiBaseURL
		
				
		Scenario: New user sign up Scenario
			
			#Given def userData = {"email":"karateusersignup1@test.com", "username":"sarathprasad1234"}
			
				#below code is to show how non static java funtions called in feature file to get the values 
				# create java script function here 
				
		#		* def jsFunction =
		#		"""
		#				function() {
						
		#						var DataGenerator = Java.type('helpers.DataGenerator')
		#						var generator = new DataGenerator()
		#						return generator.getRandomUsername2()
						
						
		#				}
				
		#		"""
		#		* def randomUserName2 = call jsFunction
				# above one finished here 
				
				
			Given path "users"
			And request
			"""
				{
					"user": {
						"email": #(randomEmail),
						"password": "karate123", 
						"username": #(randomUserName)
						}
				
				} 
			
			"""
			
			When method Post
			Then status 200
			And match response == 
			"""
				{
    	"user": {
        	"id": "#number",
        	"email": #(randomEmail),
       	 	"createdAt": "#? timeValidator(_)",
        	"updatedAt": "#? timeValidator(_)",
       		"username": #(randomUserName),
     	    "bio": null,
      	  "image": null,
       	  "token": "#string"
    }
}
			
			"""
@signup
Scenario Outline: Validate sign up error messages
			
						
		
			
			Given path "users"
			And request
			"""
				{
					"user": {
						"email": "<email>",
						"password": "<password>", 
						"username": "<username>"
						}
				
				} 
			
			"""
			When method Post
			Then status 422
			And match response == <errorResponse> 
			Examples:
				|email|password|username|errorResponse|
				| #(randomEmail) | karate123 | Karate1234445 | {"errors": {"username": ["has already been taken"]}} | 
				| KarateUser1@test.com | karate123 | #(randomUserName) | {"errors": {"email": ["has already been taken"]}} |
				
				
