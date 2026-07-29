public with sharing class RecruiterDashboardController {

    @AuraEnabled(cacheable=true)
    public static Integer getTotalApplications() {
        return [
            SELECT COUNT()
            FROM Application__c
        ];
    }
    @AuraEnabled(cacheable=true)
    public static Map<String,Integer> getApplicationStatusCount() {
        Map<String,Integer> result = new Map<String,Integer>();
        for(AggregateResult ar : [
            SELECT Status__c status, COUNT(Id) total
            FROM Application__c
            GROUP BY Status__c
        ]) {
            result.put(
                (String)ar.get('status'),
                (Integer)ar.get('total')
            );
        }
        return result;
    }
    @AuraEnabled(cacheable=true)
    public static List<Application__c> getRecentApplications(){
        return [
            SELECT Id,
                   Name,
                   Candidate__r.Name,
                   Job__r.Name,
                   Status__c,
                   Score__c,
                   CreatedDate
            FROM Application__c
            ORDER BY CreatedDate DESC
            LIMIT 10
        ];
    }
    @AuraEnabled(cacheable=true)
    public static Integer getUpcomingInterviews(){

        return [
            SELECT COUNT()
            FROM Interview__c
            WHERE Interview_Date__c >= TODAY
        ];
    }
}