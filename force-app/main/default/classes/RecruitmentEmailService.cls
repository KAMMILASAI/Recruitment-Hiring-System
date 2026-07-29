public class RecruitmentEmailService {

    // Common method to send email
    private static void sendEmails(List<Messaging.SingleEmailMessage> emails){
        if(!emails.isEmpty()){
            Messaging.sendEmail(emails);
        }
    }

    // Shortlist Email
    public static void sendShortlistEmail(List<Id> appIds){

        List<Application__c> apps = [
            SELECT Candidate__r.Email__c, Candidate__r.Name, Job__r.Name
            FROM Application__c WHERE Id IN :appIds
        ];

        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for(Application__c app : apps){
            Messaging.SingleEmailMessage m = new Messaging.SingleEmailMessage();
            m.setToAddresses(new String[]{app.Candidate__r.Email__c});
            m.setSubject('Application Shortlisted');
            m.setPlainTextBody('Hello ' + app.Candidate__r.Name +
                ', Your application for ' + app.Job__r.Name + ' is shortlisted.');
            emails.add(m);
        }

        sendEmails(emails);
    }

    // Application Rejected
    public static void sendApplicationRejectedEmail(List<Id> appIds){

        List<Application__c> apps = [
            SELECT Candidate__r.Email__c, Candidate__r.Name
            FROM Application__c WHERE Id IN :appIds
        ];

        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for(Application__c app : apps){
            Messaging.SingleEmailMessage m = new Messaging.SingleEmailMessage();
            m.setToAddresses(new String[]{app.Candidate__r.Email__c});
            m.setSubject('Application Rejected');
            m.setPlainTextBody('Hello ' + app.Candidate__r.Name +
                ', We regret to inform you that your application was not selected.');
            emails.add(m);
        }

        sendEmails(emails);
    }

    // Interview Scheduled
    public static void sendInterviewScheduledEmail(List<Id> ids){

        List<Interview__c> listData = [
            SELECT Interview_Date__c,
                   Application__r.Candidate__r.Email__c,
                   Application__r.Candidate__r.Name,
                   Application__r.Job__r.Name
            FROM Interview__c WHERE Id IN :ids
        ];

        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for(Interview__c i : listData){
            Messaging.SingleEmailMessage m = new Messaging.SingleEmailMessage();
            m.setToAddresses(new String[]{i.Application__r.Candidate__r.Email__c});
            m.setSubject('Interview Scheduled');
            m.setPlainTextBody('Hello ' + i.Application__r.Candidate__r.Name +
                ', Interview for ' + i.Application__r.Job__r.Name +
                ' on ' + i.Interview_Date__c );
            emails.add(m);
        }

        sendEmails(emails);
    }

    //  Interview Rescheduled
    public static void sendInterviewUpdateEmail(List<Id> ids){
        sendInterviewScheduledEmail(ids);
    }

    //  Interview Failed
    public static void sendInterviewFailEmail(List<Id> ids){

        List<Interview__c> listData = [
            SELECT Application__r.Candidate__r.Email__c,
                   Application__r.Candidate__r.Name
            FROM Interview__c WHERE Id IN :ids
        ];

        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for(Interview__c i : listData){
            Messaging.SingleEmailMessage m = new Messaging.SingleEmailMessage();
            m.setToAddresses(new String[]{i.Application__r.Candidate__r.Email__c});
            m.setSubject('Interview Result');
            m.setPlainTextBody('Hello ' + i.Application__r.Candidate__r.Name +
                ', Unfortunately, you did not clear the interview.');
            emails.add(m);
        }

        sendEmails(emails);
    }

    // Offer Created
    public static void sendOfferCreatedEmail(List<Id> ids){

        List<Offer__c> listData = [
            SELECT Application__r.Candidate__r.Email__c,
                   Application__r.Candidate__r.Name
            FROM Offer__c WHERE Id IN :ids
        ];

        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for(Offer__c o : listData){
            Messaging.SingleEmailMessage m = new Messaging.SingleEmailMessage();
            m.setToAddresses(new String[]{o.Application__r.Candidate__r.Email__c});
            m.setSubject('Offer Created');
            m.setPlainTextBody('Hello ' + o.Application__r.Candidate__r.Name +
                ', Your offer has been created. Please login to Accept/Reject.');
            emails.add(m);
        }

        sendEmails(emails);
    }

    // Offer Accepted
    public static void sendOfferAcceptedEmail(List<Id> ids){
    
        List<Offer__c> offers = [
            SELECT Id,
                   Application__r.Candidate__r.Email__c,
                   Application__r.Candidate__r.Name,
                   Application__r.Job__r.Name
            FROM Offer__c
            WHERE Id IN :ids
        ];
    
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
    
        for(Offer__c offer : offers){
    
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    
            mail.setToAddresses(new String[]{
                offer.Application__r.Candidate__r.Email__c
            });
    
            mail.setSubject('Welcome to the Company 🎉');
    
            mail.setPlainTextBody(
                'Hello ' + offer.Application__r.Candidate__r.Name + ',\n\n' +
                'Congratulations! We are excited to welcome you to our organization.\n\n' +
                'Your offer for the position of ' + offer.Application__r.Job__r.Name + ' has been accepted successfully.\n\n' +
                'Our HR team will contact you shortly with onboarding details.\n\n' +
                'We look forward to working with you!\n\n' +
                'Best Regards,\nRecruitment Team'
            );
    
            emails.add(mail);
        }
    
        if(!emails.isEmpty()){
            Messaging.sendEmail(emails);
        }
     }

    // Offer Rejected
    public static void sendOfferRejectedEmail(List<Id> ids){

        List<Offer__c> offers = [
            SELECT Id,
                   Application__r.Candidate__r.Email__c,
                   Application__r.Candidate__r.Name,
                   Application__r.Job__r.Name
            FROM Offer__c
            WHERE Id IN :ids
        ];
    
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
    
        for(Offer__c offer : offers){
    
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    
            mail.setToAddresses(new String[]{
                offer.Application__r.Candidate__r.Email__c
            });
    
            mail.setSubject('Regarding Your Offer Decision');
    
            mail.setPlainTextBody(
                'Hello ' + offer.Application__r.Candidate__r.Name + ',\n\n' +
                'Thank you for considering our offer for the position of ' + offer.Application__r.Job__r.Name + '.\n\n' +
                'We respect your decision to decline the offer.\n\n' +
                'We truly appreciate your time and interest in our organization.\n\n' +
                'We wish you all the best in your future endeavors.\n\n' +
                'Regards,\nRecruitment Team'
            );
    
            emails.add(mail);
        }
    
        if(!emails.isEmpty()){
            Messaging.sendEmail(emails);
        }
    }

    // Offer (Interview Pass)
    public static void sendOfferEmail(List<Id> ids){

        List<Interview__c> listData = [
            SELECT Application__r.Candidate__r.Email__c,
                   Application__r.Candidate__r.Name
            FROM Interview__c WHERE Id IN :ids
        ];

        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for(Interview__c i : listData){
            Messaging.SingleEmailMessage m = new Messaging.SingleEmailMessage();
            m.setToAddresses(new String[]{i.Application__r.Candidate__r.Email__c});
            m.setSubject('Interview Passed');
            m.setPlainTextBody('Congratulations! You passed the interview.');
            emails.add(m);
        }

        sendEmails(emails);
    }
}