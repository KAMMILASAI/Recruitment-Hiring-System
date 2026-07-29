public with sharing class CandidateController {

    @AuraEnabled(cacheable=true)
    public static Candidate__c getCandidate(Id userId) {
        List<Candidate__c> candidates = [
            SELECT Id, Name
            FROM Candidate__c
            WHERE User__c = :userId
            LIMIT 1
        ];
        if(!candidates.isEmpty()){
            return candidates[0];
        }
        return null;
    }
}