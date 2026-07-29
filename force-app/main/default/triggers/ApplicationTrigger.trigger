trigger ApplicationTrigger on Application__c (before insert, before update) {
    ApplicationHandler.calculateScore(Trigger.new);
    ApplicationHandler.updateStatus(Trigger.new);
}