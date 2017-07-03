@isTest
private class OpportunityCloneControllerTest {
 
  static testMethod void testSave() {
    // This code runs as the system user
    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
    User u = new User(Alias = 'spagjoe1', Email='spaghetti.joe@aloia.com',
        EmailEncodingKey='UTF-8', LastName='Aloia', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles', UserName='spaghetti.joe@aloia.com');

    System.runAs(u) {
        // The following code runs as user 'u'
        System.debug('Current User: ' + UserInfo.getUserName());
        System.debug('Current UserId: ' + UserInfo.getUserId());
        
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
           
        // create a test opportunity
        recordtype[] tt = [Select  r.Id, r.SobjectType, r.Name From RecordType r where sobjecttype ='Opportunity' and Name = 'Political And Public Affairs'];
        Opportunity opp = new Opportunity(Name = 'My Test Opp',
                                          AccountId = acct.Id,
                                          Brand__c = 'Audience Partners',
                                          RecordTypeId = tt[0].Id,
                                          Business_Unit_WF__c = 'Political And Public Affairs',
                                          Opportunity_Type__c = 'Advocacy',
                                          StageName = 'Verbal Agreement 90%',
                                          CloseDate = System.today().addDays(4),
                                          Internal_I_O__c = '100446A');
    
        // insert new test opportunity
        insert opp;
        System.assertEquals(opp.Name, 'My Test Opp');
    
        // retrieve the new opportunity
        Opportunity testOpp = [SELECT Id, OwnerId, Name FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals(testOpp.Name, 'My Test Opp');
        System.debug('ownerID: ' + testOpp.OwnerId);
    
        PageReference ref = new PageReference('/apex/OpportunityClone?id=' + testOpp.Id);
        Test.setCurrentPage(ref);
     
        Test.startTest();
        
        // This will run the constructor of the controller
        ApexPages.StandardController sc = new ApexPages.StandardController(opp);
        OpportunityCloneController myController = new OpportunityCloneController(sc);
        
        // Now we can test our action function on the controller
        PageReference ref2 = myController.cloneOpportunity();
    
        PageReference ref3 = myController.extendOpportunity();
        
        Test.stopTest();
     
        //system.assertNotEquals(ref2.getUrl(), '');
    }
  }
}