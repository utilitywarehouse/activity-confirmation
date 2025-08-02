# **Activity Confirmation Service**

This repository provides documentation and key information about the Activity Confirmation service, an integrated system of IT applications designed to protect employee accounts by having them verify sensitive actions.

## **1\. Overview**

The Activity Confirmation service is designed to empower security and IT teams by providing a mechanism for employees to verify or deny actions on accounts and devices they are responsible for, serving as a first line of triage. This system is valuable for proactively detecting and responding to potential unauthorized access by providing a clear and immediate feedback loop.

## **2\. How It Works: The User Workflow**

The process is designed to be simple and straightforward:

1. **Activity Initiated:** A sensitive action (e.g., a password reset, a permission change, or a login to a sensitive host) is performed on or by an account.  
2. **Notification Sent:** They receive a brief notification via SMS, Slack, or Google Chat which contains a link to a verification page.  
3. **Review & Action:** They click the link to open a dedicated confirmation page. The content of this page depends on the type of activity.  
4. **System Response:** Based on their action (Confirm or Report Suspicious), the system either logs the activity as a confirmed action or immediately raises a security incident and triggers automated responses.

## **3\. Dependencies**

The Activity Confirmation service relies on the following key platforms and integrations:

* **Core Platform:** ServiceNow  
* **SMS Integration:** Twilio (API-agnostic)  
* **Chat Integration:** Slack and Google Chat (using in-house applications)

## **4\. Confirmation Page Types**

The service has two distinct confirmation pages, each tailored to a specific set of activities.

### **a. "Report Suspicious Only" Page**

This page is used for critical activities where the system assumes a request is legitimate unless a user explicitly flags it as suspicious.

* **Triggering Activities:** Password Resets, Multi-Factor Authentication (MFA) Resets.  
* **User Instructions:** The page will display the activity details and a single **Report Suspicious** button.  
  * **If they performed the activity:** No action is needed on their part; they can simply close the page.  
  * **If they did NOT perform the activity:** **They should click the Report Suspicious button immediately.** This creates a security incident and can perform other automated actions such as suspending accounts.
 
    <img width="626" height="680" alt="image" src="https://github.com/user-attachments/assets/87ad3f39-b07c-49a6-96ec-fb9b02520a04" />


### **b. "Confirm or Report Suspicious" Page**

This page is used for other types of activities where the system requires explicit user confirmation.

* **Triggering Activities:** Logins to root AWS accounts, Domain controllers, ESXI hosts.  
* **User Instructions:** The page will display the activity details and two buttons: **Confirm** and **Report Suspicious**.  
  * **If they performed the activity:** They should click the **Confirm** button to authorize the change. No further action is taken.  
  * **If they did NOT perform the activity:** They **should click the Report Suspicious button.** This creates a security incident and performs other changes such as restricting network access to the device.
 
    <img width="667" height="805" alt="image" src="https://github.com/user-attachments/assets/b4924fc8-9b2e-4e26-af53-c10aa6fcead8" />


## **5\. Support**

Whilst we can’t provide this for all tech stacks, we’re happy to accept pull requests if someone wants to share the setup instructions for those additional technologies
