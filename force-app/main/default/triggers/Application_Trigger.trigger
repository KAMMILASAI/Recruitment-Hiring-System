trigger Application_Trigger on Application__c (after insert, after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            ApplicationTriggerHandler.afterInsert(Trigger.new);
        }
        if(Trigger.isUpdate){
            ApplicationTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}