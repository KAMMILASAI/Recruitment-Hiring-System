import { LightningElement, wire } from 'lwc';
import getTotalApplications 
from '@salesforce/apex/RecruiterDashboardController.getTotalApplications';
import getApplicationStatusCount 
from '@salesforce/apex/RecruiterDashboardController.getApplicationStatusCount';
import getRecentApplications 
from '@salesforce/apex/RecruiterDashboardController.getRecentApplications';
import getUpcomingInterviews 
from '@salesforce/apex/RecruiterDashboardController.getUpcomingInterviews';
export default class RecruiterDashboard extends LightningElement {
totalApplications;
upcomingInterviews;
statusList=[];
applications=[];
columns=[
            {
            label:'Candidate',
            fieldName:'candidateName'
            },
            {
            label:'Job',
            fieldName:'jobName'
            },
            {
            label:'Status',
            fieldName:'Status__c'
            },
            {
            label:'Score',
            fieldName:'Score__c'
            }
];

@wire(getTotalApplications)
wiredTotal({data}){
    if(data){
    this.totalApplications=data;
    }
  }
        @wire(getUpcomingInterviews)
        wiredInterview({data}){
            if(data){
            this.upcomingInterviews=data;
        }
  }



@wire(getApplicationStatusCount)
wiredStatus({data}){

    if(data){

        this.statusList=
            Object.keys(data).map(key=>{
            return {
            status:key,
            count:data[key]
            }
            });
        }
    }

@wire(getRecentApplications)
wiredApplications({data}){
        if(data){
            this.applications=data.map(app=>({
            ...app,
            candidateName:
            app.Candidate__r.Name,
            jobName:
            app.Job__r.Name

            }));

        }

}


}