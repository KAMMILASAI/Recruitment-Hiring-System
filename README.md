
## 🚀 Key Features

- End-to-End Recruitment System
- Automated Email Notifications
- Role-Based Access (Admin, Recruiter, Candidate)
- Real-time Application Tracking
- Interview Scheduling & Results
- Offer Management System

## ⚙️ Automation & Business Logic

The Recruitment & Hiring System automates the complete hiring lifecycle using Salesforce Flow, Apex Triggers, Apex Classes, and Lightning Web Components.

### 🔄 End-to-End Recruitment Automation

- Application score is calculated automatically based on candidate details.
- Based on the score, application status is updated automatically:
  - High Score → Shortlisted
  - Low Score → Rejected

- When an application status becomes **Shortlisted**:
  - Interview record is created automatically.
  - Candidate receives shortlist notification email.

- When an interview is created:
  - Interview details are shared with the candidate through email.

- When interview date or time is updated:
  - Candidate receives interview reschedule notification.

- When interview result is updated:
  - Pass:
    - Application status automatically changes to **Selected**
    - Offer record is created automatically
    - Candidate receives offer notification email

  - Fail:
    - Application status is updated
    - Candidate receives rejection email

- When an offer is created:
  - Candidate receives offer details email.
  - Candidate can Accept or Reject the offer.

- When offer status changes:
  - Accepted:
    - Candidate receives welcome email
    - Job filled positions are automatically increased

  - Rejected:
    - Candidate receives offer rejection acknowledgement email

- When: Filled Positions == Total Positions
- 
  Job status is automatically updated to: Closed


  ## 🛠️ Salesforce Implementation

### Salesforce Flow
Used for:
- Application date automation
- Record creation automation
- Status updates
- Recruitment process automation

### Apex Development
Implemented using:
- Apex Triggers
- Trigger Handler Framework
- Apex Classes
- SOQL Queries
- Business Logic Classes
- Email Service Classes
- Bulkified Code
  
 <img width="493" height="415" alt="image" src="https://github.com/user-attachments/assets/ea5ea2e7-c6cc-4013-8bd9-7e1c3e6fd035" />

## 📌 Project Overview

This is a Recruitment Management System built on Salesforce.

It allows:
- Candidates to apply for jobs and track progress
- Recruiters to manage hiring process
- Admin to control the entire system

The system includes automation using Apex Triggers and Email Notifications.

## 🏗️ Architecture

The project follows Salesforce best practices:

- Trigger → Handler Pattern
- Separation of concerns using Apex Classes
- Centralized Email Service Class
- LWC for UI components
- Custom Objects for data modeling

Flow:
Trigger → Handler → Service Class → Email 

## 🔔 Automation Features

The system includes multiple automated email notifications:

- Application Shortlisted → Email sent
- Application Rejected → Email sent
- Interview Scheduled → Email sent
- Interview Updated → Email sent
- Interview Passed → Email sent
- Interview Failed → Email sent
- Offer Created → Email sent
- Offer Accepted / Rejected → Email sent

This is implemented using Apex Triggers and a centralized Email Service class.

<img width="1600" height="813" alt="WhatsApp Image 2026-07-29 at 7 31 36 PM" src="https://github.com/user-attachments/assets/570ab4f1-5326-4650-8b49-f4df6de2c636" />

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




### 👤 Candidate Profile Management

This component handles candidate profile creation and display.

- If the candidate profile **does not exist**, a **"Create Profile"** button is shown.
- Once the profile is created, the system displays the **candidate details** such as:
  - Name
  - Email
  - Other personal information

This feature is built using:
- Lightning Web Components (LWC)
- Conditional rendering
- Salesforce data binding

It ensures that each candidate maintains a single profile before applying for jobs.
<img width="1768" height="621" alt="image" src="https://github.com/user-attachments/assets/3c9a3a58-444f-483b-9514-4f163207d11a" />

### 💼 Job Board Access Control

The Job Board component ensures that only logged-in users can view and apply for jobs.

- When the user is **not logged in**, a **Login screen** is displayed.
- After successful login, the system shows a list of **available job openings**.
- Candidates can browse jobs and proceed to apply.

This feature is implemented using:
- Lightning Web Components (LWC)
- Conditional rendering based on authentication
- Secure user access handling

This ensures that only authenticated candidates can interact with job applications.

<img width="1575" height="436" alt="image (1)" src="https://github.com/user-attachments/assets/68973d12-89a0-4beb-861a-e7866dd288dc" />

### 📊 Application & Interview Tracking

This feature allows candidates to track their job applications and interview progress.

- Displays a list of all applications submitted by the candidate
- Shows current **application status** (Applied, Shortlisted, Rejected)
- Displays associated **interview details**, including:
  - Interview Date & Time
  - Interview Result (Pass / Fail)

This is implemented using:
- Lightning Web Components (LWC)
- Apex controllers for data retrieval
- Relationship queries between Application and Interview objects

This provides complete visibility to candidates about their recruitment progress.

<img width="2414" height="413" alt="image (2)" src="https://github.com/user-attachments/assets/5c10fcf0-adf8-4959-ac35-5b7a583bf32b" />

### 🎁 Offer Management

This feature allows candidates to view and manage their job offers.

- Displays a list of received offers in a table format
- On clicking an offer, the user is navigated to the **Offer Details page**
- Shows complete offer information:
  - Role Name
  - Salary
  - Offer Status (Pending / Accepted / Rejected)

- Provides a clear message:
  "Congratulations! You have received a job offer."

This is implemented using:
- Lightning Web Components (LWC)
- Navigation to record detail page
- Salesforce data binding

This ensures candidates can easily review and take action on their job offers.

<img width="968" height="547" alt="Screenshot 2026-07-29 190509" src="https://github.com/user-attachments/assets/e6b2a30c-ecd7-400a-9aff-eb0b4792e065" />



---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


### 🏢 Job Management (Recruiter)

Recruiters can create and manage job postings in the system.

- Create new job openings with role details
- Edit existing job records
- Maintain job availability for candidates

This is implemented using:
- Custom Object (Job__c)
- Standard Salesforce UI / LWC (if used)

This allows recruiters to control available job opportunities in the system.

### 📄 Application Management

Recruiters can manage candidate applications efficiently.

- Create and edit application records
- Update application status:
  - Applied
  - Shortlisted
  - Rejected
  - Selected

- Status updates trigger automated email notifications to candidates

This is implemented using:
- Apex Triggers
- Trigger Handler Pattern
- Email Service Class

This ensures smooth communication and tracking of candidate progress.

<img width="3715" height="520" alt="image (4)" src="https://github.com/user-attachments/assets/afd97467-5b25-4ee6-b286-287a9b00d236" />

### 🎤 Interview Management

Recruiters can schedule and manage interviews for candidates.

- Create interview records with date and time
- Update interview results:
  - Pass
  - Fail

- Automated emails are sent:
  - When interview is scheduled
  - When interview details are updated
  - When result is declared

This is implemented using:
- Custom Object (Interview__c)
- Apex Trigger & Handler
- Email Notification System

This ensures candidates are informed at every stage of the interview process.

<img width="3742" height="468" alt="image (5)" src="https://github.com/user-attachments/assets/4c098c04-d9ab-4825-99f1-d9976ae30c06" />

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


### 🛠️ Admin Control (Full Access)

The system provides an Admin role with complete access to all modules.

Admin capabilities include:
- Manage Jobs, Applications, Interviews, and Offers
- View and update all records across the system
- Monitor candidate and recruiter activities
- Control overall recruitment workflow

This is implemented using:
- Salesforce Profiles & Permissions
- Full CRUD access on all custom objects

This ensures centralized control and smooth system management.

