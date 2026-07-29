import { LightningElement, api, wire } from 'lwc';
import updateResult from '@salesforce/apex/InterviewController.updateResult';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord } from 'lightning/uiRecordApi';

import RESULT_FIELD from '@salesforce/schema/Interview__c.Result__c';

export default class InterviewPanel extends LightningElement {

    @api recordId;
    result;

    @wire(getRecord, { recordId: '$recordId', fields: [RESULT_FIELD] })
    wiredRecord({ data, error }) {
        if (data) {
            this.result = data.fields.Result__c.value;
        } else if (error) {
            console.error(error);
        }
    }

    handlePass() {
        this.updateInterview('Pass');
    }

    handleFail() {
        this.updateInterview('Fail');
    }

    updateInterview(result) {
        updateResult({ interviewId: this.recordId, result: result })
            .then(() => {
                this.result = result; // update UI instantly
                this.showToast('Success', 'Updated successfully', 'success');
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
            });
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({ title, message, variant })
        );
    }

    get isPending() {
        return !this.result || this.result === 'Pending';
    }

    get isPass() {
        return this.result === 'Pass';
    }

    get isFail() {
        return this.result === 'Fail';
    }
}