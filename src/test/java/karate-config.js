function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiBaseURL: 'https://conduit.productionready.io/api/'
  }
  if (env == 'dev') {
    config.userEmail = 'karate@testaccount.com'
	config.userPassword = 'karate123'
  } else if (env == 'qa') {
    // customize
  }

	var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
	karate.configure('headers', {Authorization: 'Token ' + accessToken })

  return config;
}