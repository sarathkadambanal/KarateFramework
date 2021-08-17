package Performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class perfTest extends Simulation {

  val protocol = karateProtocol(
   
  )

  val createArticle = scenario("Create and Delete Article").exec(karateFeature("classpath:Performance/createArticle.feature"))
  

  setUp(
  
    create.inject(
    atOnceUsers(1)
    ).protocols(protocol)
    
  )

