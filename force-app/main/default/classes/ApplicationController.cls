public with sharing class ApplicationController {
    
    @AuraEnabled(cacheable=true)
    public static List<Application__c> getApplications(Id userId){
        Candidate__c candidate = [
            SELECT Id 
            FROM Candidate__c 
            WHERE User__c = :userId 
            LIMIT 1
        ];
        if(candidate == null){
            return new List<Application__c>();
        }
        return [
            SELECT Id, Name, Status__c, Score__c, Applied_Date__c,
                   Job__r.Name
            FROM Application__c
            WHERE Candidate__c = :candidate.Id
            ORDER BY Applied_Date__c DESC
        ];
    }
}