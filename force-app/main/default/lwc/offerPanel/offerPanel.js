import { LightningElement, api, wire } from 'lwc';

import getOfferDetails 
from '@salesforce/apex/OfferController.getOfferDetails';

import updateOfferStatus 
from '@salesforce/apex/OfferController.updateOfferStatus';

import { ShowToastEvent } 
from 'lightning/platformShowToastEvent';

export default class OfferPanel extends LightningElement {
    @api recordId;
    jobName;
    salary;
    status;
    @wire(getOfferDetails, {
        offerId:'$recordId'
    })
    wiredOffer({data,error}){
        if(data){
            this.jobName =
            data.Application__r.Job__r.Role__c;
            this.salary =
            data.Salary__c;
            this.status =
            data.Offer_Status__c;
        }
        else if(error){
            console.error(error);
        }
    }
    handleAccept(){

        this.updateStatus('Accepted');

    }
    handleReject(){
        this.updateStatus('Rejected');

    }
    updateStatus(status){
        updateOfferStatus({
            offerId:this.recordId,
            status:status
        })
        .then(()=>{
            this.status=status;
            this.showToast(
                'Success',
                'Offer response submitted',
                'success'
            );
        })
        .catch(error=>{
            this.showToast(
                'Error',
                error.body.message,
                'error'
            );
        });

    }
    get isPending(){

        return !this.status || this.status === 'Pending';
    }
    get isAccepted(){
        return this.status === 'Accepted';

    }

    get isRejected(){

        return this.status === 'Rejected';

    }
    showToast(title,message,variant){

        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );

    }

}