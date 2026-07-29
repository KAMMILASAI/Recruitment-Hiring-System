public class OfferTriggerHandler {

    public static void afterInsert(List<Offer__c> newOffers){

        List<Id> ids = new List<Id>();

        for(Offer__c o : newOffers){
            ids.add(o.Id);
        }

        RecruitmentEmailService.sendOfferCreatedEmail(ids);
    }

    public static void afterUpdate(List<Offer__c> newList, Map<Id, Offer__c> oldMap){

        List<Id> acceptedIds = new List<Id>();
        List<Id> rejectedIds = new List<Id>();

        for(Offer__c o : newList){

            Offer__c oldO = oldMap.get(o.Id);

            if(o.Offer_Status__c == 'Accepted' && oldO.Offer_Status__c != 'Accepted'){
                acceptedIds.add(o.Id);
            }

            if(o.Offer_Status__c == 'Rejected' && oldO.Offer_Status__c != 'Rejected'){
                rejectedIds.add(o.Id);
            }
        }

        if(!acceptedIds.isEmpty()){
            RecruitmentEmailService.sendOfferAcceptedEmail(acceptedIds);
        }

        if(!rejectedIds.isEmpty()){
            RecruitmentEmailService.sendOfferRejectedEmail(rejectedIds);
        }
    }
}