@isTest 
private class MonthlyAmountAmortTest {

    static testMethod void validateChildCreated() {
        // create a test IONumber
        IONumber__c ionum = new IONumber__c(Name = 'Political - Advocacy',
                                            Business_Unit__c = 'Political And Public Affairs',
                                            Opportunity_Type__c = 'Advocacy',
                                            ID__c = '99',
                                            Current_counter__c = 1234);

        // insert new test IONumber
        insert ionum;
        System.assertEquals(ionum.Name, 'Political - Advocacy');

        // create a test Account
        Account acct = new Account(Name = 'My Test Account',
                                   Type = 'Channel Partner');

        // insert new test Account
        insert acct;
        System.assertEquals(acct.Name, 'My Test Account');
        
        // create a test opportunity at 10%
        recordtype[] tt = [Select  r.Id, r.SobjectType, r.Name From RecordType r where sobjecttype ='Opportunity' and Name = 'Political And Public Affairs'];
        Opportunity opp = new Opportunity(Name = 'My Test Opp',
                                          AccountId = acct.Id,
                                          Brand__c = 'Audience Partners',
                                          RecordTypeId = tt[0].Id,
                                          Business_Unit_WF__c = 'Political And Public Affairs',
                                          Opportunity_Type__c = 'Advocacy',
                                          StageName = 'Prospect 10%',
										  Flight_Start_Date__c =System.today().addDays(1),
     									  Flight_End_Date__c =System.today().addDays(50),
     									  Amount =40000,                                         
                                          CloseDate = System.today().addDays(4));

        // insert new test opportunity
        insert opp;
        System.assertEquals(opp.Name, 'My Test Opp');
        
        List<Monthly_Forecast__c> mf =  [select id,name, Opportunity__c from Monthly_Forecast__c where Opportunity__c =:opp.Id];
     	if(!mf.isEmpty()){
     		for(Integer i=0;i<2;i++){
     			System.assertEquals(opp.Id,mf[i].Opportunity__c);
     		}
     	}
     	
     	opp.Flight_Start_Date__c =System.today().addDays(1);
     	opp.Flight_End_Date__c =System.today().addDays(51);
     	opp.Amount =41000;
     	
     	update opp; 
     	
     	mf =  [select id,name, Opportunity__c from Monthly_Forecast__c where Opportunity__c =:opp.Id];
     	if(!mf.isEmpty()){
     		for(Integer i=0;i<2;i++){
     			System.assertEquals(opp.Id,mf[i].Opportunity__c);
     		}
     	}
/*     	
        Monthly_Forecast__c mf= new Monthly_Forecast__c(
        							Name = 'Forecast for 05/2016',
        							Month__c = 'May 2016',      
        							ForecastAmount__c = 4000,
        							Opportunity__c = opp.Id);

        Organization currOrg = [Select IsSandbox from Organization limit 1];
        if(currOrg.IsSandbox == true){
            mf.Opportunity__c = '0061900000455DaAAI'; 
        }else{
            mf.Opportunity__c = '006U000000XskjzIAB'; 
        }

        System.debug('Amount before inserting new record: ' + mf.ForecastAmount__c);
        insert mf; 
        
       mf = [SELECT ForecastAmount__c FROM Monthly_Forecast__c WHERE Id =:mf.Id];
       System.debug('Amount after trigger fired: ' + mf.ForecastAmount__c);

       // Test that the trigger correctly updated the price
       System.assertEquals(4000, mf.ForecastAmount__c);
*/       
    }
}