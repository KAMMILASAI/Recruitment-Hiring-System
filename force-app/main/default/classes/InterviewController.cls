public with sharing class InterviewController {
    
    @AuraEnabled
    public static void updateResult(Id interviewId, String result){
        Interview__c i = [SELECT Id, Application__c FROM Interview__c WHERE Id = :interviewId];
        i.Result__c = result;
        update i;
        Application__c app = [SELECT Id FROM Application__c WHERE Id = :i.Application__c];
        app.Status__c = (result == 'Pass') ? 'Selected' : 'Rejected';
        update app;
    }
}