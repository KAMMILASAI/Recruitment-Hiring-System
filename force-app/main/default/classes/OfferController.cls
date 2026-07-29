public class OfferController {
    @AuraEnabled(cacheable=true)
    public static Offer__c getOfferDetails(Id offerId){
        return [SELECT Id,Salary__c,Offer_Status__c,Application__r.Job__r.Role__c FROM Offer__c WHERE Id = :offerId
        ];
    }
    @AuraEnabled
    public static void updateOfferStatus(
        Id offerId,
        String status
    ){
        Offer__c offer = [ SELECT Id, Offer_Status__c FROM Offer__c WHERE Id = :offerId ];
        offer.Offer_Status__c = status;
        update offer;
    }
}