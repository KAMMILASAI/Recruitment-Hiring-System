import { LightningElement, wire } from 'lwc';

import getCandidate from '@salesforce/apex/JobBoardController.getCandidate';
import getOpenJobs from '@salesforce/apex/JobBoardController.getOpenJobs';
import getAppliedJobs from '@salesforce/apex/JobBoardController.getAppliedJobs';
import applyJob from '@salesforce/apex/JobBoardController.applyJob';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class JobBoard extends LightningElement {
    email;
    candidateId;
    jobs = [];
    appliedJobs = [];
    showJobs = false;
    handleEmailChange(event){
        this.email = event.target.value;
    }
    login(){
        getCandidate({
            email:this.email
        })
        .then(result => {
            this.candidateId = result.Id;
            this.loadJobs();
            this.showJobs = true;
        })
        .catch(error => {
            this.showToast(
                'Error',
                error.body.message,
                'error'
            );
        });
    }

    loadJobs(){
        getOpenJobs()
        .then(result => {
            getAppliedJobs({
                candidateId:this.candidateId
            })
            .then(applied => {
                this.appliedJobs = applied;
                this.jobs = result.map(job => {
                    return {
                        ...job,
                        buttonLabel:
                        applied.includes(job.Id)
                        ? 'Applied'
                        : 'Apply',

                        disabled:
                        applied.includes(job.Id)
                    };
                });
            });
        });
    }
    handleApply(event){
        let jobId = event.target.dataset.id;
        applyJob({
            candidateId:this.candidateId,
            jobId:jobId
        })
        .then(()=>{
            this.showToast(
                'Success',
                'Application submitted',
                'success'
            );
            this.loadJobs();
        })
        .catch(error=>{
            this.showToast(
                'Error',
                error.body.message,
                'error'
            );
        });
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