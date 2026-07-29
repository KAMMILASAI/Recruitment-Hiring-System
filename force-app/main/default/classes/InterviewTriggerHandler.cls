public class InterviewTriggerHandler {
    public static void afterInsert(List<Interview__c> newInterviews){
        List<Id> ids = new List<Id>();
        for(Interview__c i : newInterviews){
            ids.add(i.Id);
        }
        RecruitmentEmailService.sendInterviewScheduledEmail(ids);
    }
    public static void afterUpdate(List<Interview__c> newList, Map<Id, Interview__c> oldMap){
        List<Id> rescheduledIds = new List<Id>();
        List<Id> passedIds = new List<Id>();
        List<Id> failedIds = new List<Id>();
        for(Interview__c i : newList){
            Interview__c oldI = oldMap.get(i.Id);

            if(i.Interview_Date__c != oldI.Interview_Date__c){
                rescheduledIds.add(i.Id);
            }

            if(i.Result__c == 'Pass' && oldI.Result__c != 'Pass'){
                passedIds.add(i.Id);
            }

            if(i.Result__c == 'Fail' && oldI.Result__c != 'Fail'){
                failedIds.add(i.Id);
            }
        }
        if(!rescheduledIds.isEmpty()){
            RecruitmentEmailService.sendInterviewUpdateEmail(rescheduledIds);
        }
        if(!passedIds.isEmpty()){
            RecruitmentEmailService.sendOfferEmail(passedIds);
        }
        if(!failedIds.isEmpty()){
            RecruitmentEmailService.sendInterviewFailEmail(failedIds);
        }
    }
}