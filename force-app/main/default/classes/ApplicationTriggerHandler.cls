public class ApplicationTriggerHandler {

    public static void afterInsert(List<Application__c> newApps){

        List<Id> shortlistedIds = new List<Id>();

        for(Application__c app : newApps){
            if(app.Status__c == 'Shortlisted'){
                shortlistedIds.add(app.Id);
            }
        }

        if(!shortlistedIds.isEmpty()){
            RecruitmentEmailService.sendShortlistEmail(shortlistedIds);
        }
    }

    public static void afterUpdate(List<Application__c> newApps, Map<Id, Application__c> oldMap){

        List<Id> shortlistedIds = new List<Id>();
        List<Id> rejectedIds = new List<Id>();

        for(Application__c app : newApps){
            Application__c oldApp = oldMap.get(app.Id);

            if(app.Status__c == 'Shortlisted' && oldApp.Status__c != 'Shortlisted'){
                shortlistedIds.add(app.Id);
            }

            if(app.Status__c == 'Rejected' && oldApp.Status__c != 'Rejected'){
                rejectedIds.add(app.Id);
            }
        }

        if(!shortlistedIds.isEmpty()){
            RecruitmentEmailService.sendShortlistEmail(shortlistedIds);
        }

        if(!rejectedIds.isEmpty()){
            RecruitmentEmailService.sendApplicationRejectedEmail(rejectedIds);
        }
    }
}