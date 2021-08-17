
Feature: articles page tests 


		Background: create article
			* url apiBaseURL
			* def dataGenerator = Java.type('helpers.DataGenerator')
			* def articleRequestBody = read('classpath:json/newArticleRequest.json')
			
			* def generatedArticleValues = dataGenerator.getRandomArticleValues()
			
			* set articleRequestBody.article.title = generatedArticleValues.title
			* set articleRequestBody.article.description = generatedArticleValues.description
			* set articleRequestBody.article.body = generatedArticleValues.body
			
			
			* print articleRequestBody.article.title
		
			#* def tokenResponse =  call read('classpath:helpers/CreateToken.feature')    
			# we can pass the parameter as well
		#	* def tokenResponse =  callonce read('classpath:helpers/CreateToken.feature')
		#	* def token = tokenResponse.authToken

  @smoke
  Scenario: Create a new article 
  #  Given header authorization = 'Token ' + token
    Given path 'articles'
    And request articleRequestBody   
    When method Post
    Then status 200
    And match response.article.title == articleRequestBody.article.title
 

	
	Scenario: Create an article and delete it 
	
		#Given header authorization = 'Token ' + token
    Given path 'articles'
    And request articleRequestBody
    When method Post
    Then status 200
    * def articleID = response.article.slug
    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title == articleRequestBody.article.title
    
   # Given header authorization = 'Token ' + token
    Given path 'articles',articleID
    When method Delete
    Then status 200
    
    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title != articleRequestBody.article.title
    
    
    
    