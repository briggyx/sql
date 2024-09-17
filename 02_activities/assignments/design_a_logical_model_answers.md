## Assignment 1: Logical Data Model For A Small Bookstore
#### By: Brigitte Yan 

### Question 1
```
This bookstore data model makes the following simplifications:

- Both online and in-store sales involve only a single product SKU. In other words, customers never purchase multiple different items in one transaction; they only buy varying quantities of the same SKU.
- In-store sales do not record customer addresses or phone numbers, as doing so would create an unusual user experience, especially for a small bookstore that may not have a rewards program.
- Online sales, however, record customer information such as address, phone number, etc.
```
![bookstore data model](images/ERD.jpg)


### Question 2
```
Data Model with added table for employee shifts:
```

![bookstore data model](images/ERD_employeeshifts.jpg)

### Question 3

```
Retaining customer addresses, especially in Type 2, has privacy implications:

- Historical addresses remain in the system even after updates, potentially violating data minimization laws, where customers can request data deletion.
- More stored addresses mean more sensitive data at risk in a breach, which could be exploited for fraud or identity theft.
- Retaining old addresses may require explicit consent, and companies must ensure compliance with privacy laws.

Type 1 (overwrite) reduces exposure by only storing the current address but limits tracking of historical changes.
```
#### Type 1 Architecture 
```
In this customer_address table, the a customer's address is overwritten when it's updated, and the old address is erased from the database. 
```
![bookstore data model](images/customer_address1.png)

#### Type 2 Architecture 
```
In this customer_address table, new addresses are added and old address are not erased. Instead, old addresses will have a 0 under 'active', and a value in 'end_date.' The primary key is also a composite key consisting of the customer_id and start_date.
```
![bookstore data model](images/customer_address2.png)

### Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
Your answer...
```

## Criteria

[Assignment Rubric](./assignment_rubric.md)

# Submission Information

🚨 **Please review our [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md)** 🚨 for detailed instructions on how to format, branch, and submit your work. Following these guidelines is crucial for your submissions to be evaluated correctly.

### Submission Parameters:
* Submission Due Date: `September 28, 2024`
* The branch name for your repo should be: `model-design`
* What to submit for this assignment:
    * This markdown (design_a_logical_model.md) should be populated.
    * Two Entity-Relationship Diagrams (preferably in a pdf, jpeg, png format).
* What the pull request link should look like for this assignment: `https://github.com/<your_github_username>/sql/pull/<pr_id>`
    * Open a private window in your browser. Copy and paste the link to your pull request into the address bar. Make sure you can see your pull request properly. This helps the technical facilitator and learning support staff review your submission easily.

Checklist:
- [ ] Create a branch called `model-design`.
- [ ] Ensure that the repository is public.
- [ ] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [ ] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack at `#cohort-4-help`. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.
