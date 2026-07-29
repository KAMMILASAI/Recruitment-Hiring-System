public with sharing class JobBoardController {
    @AuraEnabled
    public static Candidate__c getCandidate(String email){
        List<Candidate__c> candidates = [
            SELECT Id, Name, Email__c
            FROM Candidate__c
            WHERE Email__c = :email
            LIMIT 1
        ];
        if(candidates.isEmpty()){
            throw new AuraHandledException('Candidate not found');
        }
        return candidates[0];
    }
    @AuraEnabled(cacheable=true)
    public static List<Job__c> getOpenJobs(){
        return [
            SELECT Id,
                   Name,
                   Role__c,
                   Experience__c,
                   Skills__c,Minimum_Salary__c,Maximum_Salary__c
            FROM Job__c
            WHERE Status__c = 'Open'
        ];
    }
    @AuraEnabled(cacheable=true)
    public static List<Id> getAppliedJobs(Id candidateId){
        List<Id> jobIds = new List<Id>();
        for(Application__c app : [
            SELECT Job__c
            FROM Application__c
            WHERE Candidate__c = :candidateId
        ]){
            jobIds.add(app.Job__c);
        }
        return jobIds;
    }
    @AuraEnabled
    public static void applyJob(Id candidateId, Id jobId){
        List<Application__c> existing = [
            SELECT Id
            FROM Application__c
            WHERE Candidate__c = :candidateId
            AND Job__c = :jobId
        ];
        if(!existing.isEmpty()){
            throw new AuraHandledException('Already applied for this job');
        }
        Application__c app = new Application__c();
        app.Candidate__c = candidateId;
        app.Job__c = jobId;
        app.Status__c = 'Applied';
        app.Applied_Date__c = Date.today();
        insert app;
    }

}