import { LightningElement, track } from 'lwc';
import USER_ID from '@salesforce/user/Id';
import getApplications from '@salesforce/apex/ApplicationController.getApplications';

export default class ApplicationHistory extends LightningElement {
    
    userId = USER_ID;

    @track applications = [];
    @track noData = false;

    columns = [
        { label: 'Application', fieldName: 'Name' },
        { label: 'Job', fieldName: 'jobName' },
        { label: 'Applied Date', fieldName: 'Applied_Date__c', type: 'date' },
        { label: 'Status', fieldName: 'Status__c' },
        { label: 'Score', fieldName: 'Score__c', type: 'number' }
    ];

    connectedCallback() {
        this.loadApplications();
    }

    loadApplications() {
        getApplications({ userId: this.userId })
            .then(result => {

                if(result.length > 0){

                    this.applications = result.map(app => ({
                        ...app,
                        jobName: app.Job__r ? app.Job__r.Name : ''
                    }));

                } else {
                    this.noData = true;
                }

            })
            .catch(error => {
                console.error(error);
            });
    }
}