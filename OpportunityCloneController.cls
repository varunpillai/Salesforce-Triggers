public with sharing class OpportunityCloneController {

    private ApexPages.StandardController standardController;
    public Boolean is90 {get;set;}

    public OpportunityCloneController(ApexPages.StandardController standardController) 
    {
        this.standardController = standardController;
        
        if (!Test.isRunningTest()) {
            // Fields being cloned
            this.standardController.addFields(new List<String> { 'AccountId', 'AccountId' });
            this.standardController.addFields(new List<String> { 'RecordTypeId', 'RecordTypeId' });
            this.standardController.addFields(new List<String> { 'Brand__c', 'Brand__c' });
            this.standardController.addFields(new List<String> { 'Opportunity_Type__c', 'Opportunity_Type__c' });
            this.standardController.addFields(new List<String> { 'Candidate_Type__c', 'Candidate_Type__c' });
            this.standardController.addFields(new List<String> { 'Channel_Partner__c', 'Channel_Partner__c' });
            this.standardController.addFields(new List<String> { 'Who_is_paying_us__c', 'Who_is_paying_us__c' });
            this.standardController.addFields(new List<String> { 'Other_Payer__c', 'Other_Payer__c' });
            this.standardController.addFields(new List<String> { 'Digital_Strategist__c', 'Digital_Strategist__c' });
            this.standardController.addFields(new List<String> { 'Digital_Analyst__c', 'Digital_Analyst__c' });
            this.standardController.addFields(new List<String> { 'Internal_I_O__c', 'Internal_I_O__c' });
            this.standardController.addFields(new List<String> { 'Owner', 'Owner' });
            this.standardController.addFields(new List<String> { 'Amount', 'Amount' });
            this.standardController.addFields(new List<String> { 'CloseDate', 'CloseDate' });
            this.standardController.addFields(new List<String> { 'StageName', 'StageName' });
            this.standardController.addFields(new List<String> { 'Probability', 'Probability' });
            this.standardController.addFields(new List<String> { 'Invoicing_Option__c', 'Invoicing_Option__c' });
            this.standardController.addFields(new List<String> { 'LeadSource', 'LeadSource' });
        }
    
        Opportunity currentOpp = (Opportunity)standardController.getRecord();
        System.Debug('opportunity: ' + currentOpp);

        is90 = currentOpp.StageName.equals('Verbal Agreement 90%') || currentOpp.StageName.equals('Closed Won');
    }

    public PageReference cloneOpportunity()
    {
        // Record being cloned
        Opportunity currentOpp = (Opportunity)standardController.getRecord();
        System.Debug('opportunity: ' + currentOpp);

        // Custom clone logic
        Opportunity clonedOpp = new Opportunity();
        
        clonedOpp.Name = currentOpp.Name;
        clonedOpp.AccountId = currentOpp.AccountId;
        clonedOpp.RecordTypeId = currentOpp.RecordTypeId;
        clonedOpp.Brand__c = currentOpp.Brand__c;
        clonedOpp.Opportunity_Type__c = currentOpp.Opportunity_Type__c;
        clonedOpp.Candidate_Type__c = currentOpp.Candidate_Type__c;
        clonedOpp.Channel_Partner__c = currentOpp.Channel_Partner__c;
        clonedOpp.Who_is_paying_us__c = currentOpp.Who_is_paying_us__c;
        clonedOpp.Other_Payer__c = currentOpp.Other_Payer__c;
        clonedOpp.Digital_Strategist__c = currentOpp.Digital_Strategist__c;
        clonedOpp.Digital_Analyst__c = currentOpp.Digital_Analyst__c;
        clonedOpp.Internal_I_O__c = null;
        clonedOpp.Owner = currentOpp.Owner;
        clonedOpp.Amount = null;
        clonedOpp.CloseDate = Date.today();
        clonedOpp.StageName = 'Prospect 10%';
        clonedOpp.Probability = 10;
        clonedOpp.Invoicing_Option__c = currentOpp.Invoicing_Option__c;
        clonedOpp.LeadSource = currentOpp.LeadSource;
        
        insert clonedOpp;

        // Redirect to the new cloned record
        return new PageReference('/' + clonedOpp.Id);
    }

    public PageReference extendOpportunity()
    {
        // Record being extended
        Opportunity currentOpp = (Opportunity)standardController.getRecord();
        System.Debug('opportunity: ' + currentOpp);

        // Custom clone logic
        Opportunity clonedOpp = new Opportunity();
        
        clonedOpp.Name = currentOpp.Name;
        clonedOpp.AccountId = currentOpp.AccountId;
        clonedOpp.RecordTypeId = currentOpp.RecordTypeId;
        clonedOpp.Brand__c = currentOpp.Brand__c;
        clonedOpp.Opportunity_Type__c = currentOpp.Opportunity_Type__c;
        clonedOpp.Candidate_Type__c = currentOpp.Candidate_Type__c;
        clonedOpp.Channel_Partner__c = currentOpp.Channel_Partner__c;
        clonedOpp.Who_is_paying_us__c = currentOpp.Who_is_paying_us__c;
        clonedOpp.Other_Payer__c = currentOpp.Other_Payer__c;
        clonedOpp.Digital_Strategist__c = currentOpp.Digital_Strategist__c;
        clonedOpp.Digital_Analyst__c = currentOpp.Digital_Analyst__c;
        clonedOpp.Internal_I_O__c = currentOpp.Internal_I_O__c.substring(0,6) + Character.getNextLetterInAlphabet(currentOpp.Internal_I_O__c.substring(6,7));
        System.Debug('clonedOpp.Internal_I_O__c: ' + clonedOpp.Internal_I_O__c);
        clonedOpp.Owner = currentOpp.Owner;
        clonedOpp.Amount = null;
        clonedOpp.CloseDate = Date.today();
        clonedOpp.StageName = 'Verbal Agreement 90%';
        clonedOpp.Probability = 90;
        clonedOpp.Invoicing_Option__c = currentOpp.Invoicing_Option__c;
        clonedOpp.LeadSource = currentOpp.LeadSource;
        
        insert clonedOpp;

        // Redirect to the new cloned record
        return new PageReference('/' + clonedOpp.Id);
    }
}