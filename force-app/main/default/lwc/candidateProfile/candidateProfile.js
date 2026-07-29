import { LightningElement, track } from 'lwc';
import USER_ID from '@salesforce/user/Id';
import getCandidate from '@salesforce/apex/CandidateController.getCandidate';

export default class CandidateProfile extends LightningElement {

    userId = USER_ID;
    @track candidateExists = false;
    @track recordId;
    @track isEditMode = false;
    connectedCallback() {
        this.loadCandidate();
    }

    loadCandidate() {
        getCandidate({ userId: this.userId })
            .then(result => {
                if(result){
                    this.candidateExists = true;
                    this.recordId = result.Id;
                }
            })
            .catch(error => {
                console.error(error);
            });
    }

    handleEdit() {
        this.isEditMode = true;
    }

    handleCancel() {
        this.isEditMode = false;
    }

    handleSuccess() {
        this.isEditMode = false;
    }

    handleCreateSuccess() {
        this.loadCandidate();
    }
}