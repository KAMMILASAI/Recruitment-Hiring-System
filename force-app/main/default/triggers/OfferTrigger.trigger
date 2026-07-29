trigger OfferTrigger on Offer__c (after insert, after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            OfferTriggerHandler.afterInsert(Trigger.new);
        }
        if(Trigger.isUpdate){
            OfferTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}