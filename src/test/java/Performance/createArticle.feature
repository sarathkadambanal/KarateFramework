
Feature: articles


		Background: Define URL
			* url apiBaseURL
			* def dataGenerator = Java.type('helpers.DataGenerator')
			* def articleRequestBody = read('classpath:json/newArticleRequest.json')
			
			* def generatedArticleValues = dataGenerator.getRandomArticleValues()
			
			* set articleRequestBody.article.title = generatedArticleValues.title
			* set articleRequestBody.article.description = generatedArticleValues.description
			* set articleRequestBody.article.body = generatedArticleValues.body
			
			
			* print articleRequestBody.article.title

  Scenario: Create and Delete Article 
    Given path 'articles'
    And request articleRequestBody   
    When method Post
    Then status 200
    * def articleId = response.article.slug
    
    Given path 'articles',articleID
    When method Delete
    Then status 200

    
    
    
    