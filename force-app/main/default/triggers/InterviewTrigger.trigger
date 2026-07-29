trigger InterviewTrigger on Interview__c (after insert, after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            InterviewTriggerHandler.afterInsert(Trigger.new);
        }
        if(Trigger.isUpdate){
            InterviewTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}