package features;

import org.junit.jupiter.api.Test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import static org.junit.Assert.assertTrue;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;


class UsersRunner {
    
//    @Karate.Test
//    Karate testUsers() {
//        return Karate.run().tags("@articles").relativeTo(getClass());
//    }    

	
	@Test
    public void testParallel() {
		
		
			
		    Results results = Runner.path("classpath:features").outputCucumberJson(true).tags("~@ignore").parallel(1);
		   
		    generateReport(results.getReportDir());
	        assertTrue(results.getErrorMessages(), results.getFailCount() == 0); 
	        
		
//        Results results = Runner.path("classpath:features").tags("@articles").parallel(1);
//        assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
    }
	
	 public static void generateReport(String karateOutputPath) {        
	        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
	        List<String> jsonPaths = new ArrayList(jsonFiles.size());
	        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
	        Configuration config = new Configuration(new File("target"), "Interac");
	        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
	        reportBuilder.generateReports();        
	    }

} 
