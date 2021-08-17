@debug
Feature: Home page tests 


		Background: Define URL
			Given url apiBaseURL

  Scenario: check the status code is 200
    Given path 'tags'
    When method Get
    Then status 200
    
 
  Scenario: Get all tags and verify data is present 
    Given path 'tags'
    When method Get
    #adding few assertions just to show how we can do assertion easily inside json body
    Then match response.tags contains ['HITLER','SIDA'] 
    Then match response.tags contains any ['meat','drink','Hu‌Man‌Ity'] 
    And match response.tags !contains "sarath"
    And match response.tags == "#array"   
    And match each response.tags == "#string"
   
    
    
  Scenario: Get 5 articles from the page      #url use is https://conduit.productionready.io/api/articles?limit=5&offset=0
  	* def timeValidator = read('classpath:helpers/timeValidator.js')
  	#Given param limit = 5
  	#Given param offset = 0
  	Given params {limit : 5, offset: 0}
  	Given path 'articles'
  	When method Get
  	Then status 200
  	 #check if array length is 5
  	And match response.articles == '#[5]'     
  	#checking if value of article count in response is 500
  	And match response.articlesCount == 500              
  	
  	#it checks all the objects not just first using *
  	#And match response.articles[*].favoritesCount contains 1
  	#check if some bio is null
  	And match response.articles[*].author.bio contains null
  	# we can do the same using  .. so we dont need to go to the exact child element in json object it will check entire json and take 
  	And match response..bio contains null
  	
  	#matching the schema validation, double hash is null or string
  	And match each response.articles == 
  	"""
  		{
            "title": "#string",
            "slug": "#string",
            "body": "#string",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "tagList": "#array",
            "description": "#string",
            "author": {
            "username": "#string",
            "bio": "##string",
            "image": "#string",
            "following": "#boolean"
            },
            "favorited": "#boolean",
            "favoritesCount": "#number"
        }
  	"""
  	
  	