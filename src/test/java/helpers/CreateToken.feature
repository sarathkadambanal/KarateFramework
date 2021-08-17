
Feature: Create token for which can be re use for all other calls


	Scenario: Create Token
		Given url apiBaseURL
		Given path 'users/login'
    And request {"user": {"email": "#(userEmail)","password": "#(userPassword)"}}
    When method Post 
    Then status 200
    * def authToken = response.user.token