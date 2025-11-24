In the confirm_activity table you create, the following fields are used

| Column label | Type | Reference | Max length | Default value | Display | Display name | Mandatory |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| Created by | String | (empty) | 40 | | false | | false |
| Created | Date/Time | (empty) | 40 | | false | | false |
| Sys ID | Sys ID (GUID) | (empty) | 32 | | false | | false |
| Updates | Integer | (empty) | 40 | | false | | false |
| Updated by | String | (empty) | 40 | | false | | false |
| Updated | Date/Time | (empty) | 40 | | false | | false |
| Activity Description | String | (empty) | 5,000 | | false | Activity Description | false |
| Activity name | String | (empty) | 100 | | false | Activity name | true |
| Activity recorded at | Date/Time | (empty) | 40 | | false | Activity recorded at | true |
| Activity Reference | String | (empty) | 100 | | false | Activity Reference | true |
| Activity Source | String | (empty) | 40 | | false | Activity Source | false |
| Actor | String | (empty) | 100 | | false | Actor | false |
| Confirmation expire at | Date/Time | (empty) | 40 | | false | Confirmation expire at | false |
| Confirmation needed | True/False | (empty) | 40 | | false | Confirmation needed | false |
| Impacted Asset | String | (empty) | 100 | | false | Impacted Asset | true |
| Impacted Asset Type | String | (empty) | 50 | | false | Impacted Asset Type | true |
| Incident Reference | String | (empty) | 100 | | false | Incident Reference | false |
| Recipient.contactMethod | String | (empty) | 2,000 | | false | Recipient.contactMethod | true |
| Recipient.displayName | String | (empty) | 100 | | false | Recipient.displayName | true |
| Recipient.email | String | (empty) | 100 | | false | Recipient.email | true |
| Recipient.oktaID | String | (empty) | 100 | | false | Recipient.oktaID | true |
| Response from.email | String | (empty) | 100 | | false | Response from.email | false |
| Response from.ip | String | (empty) | 100 | | false | Response from.ip | false |
| Response from.oktaID | String | (empty) | 100 | | false | Response from.oktaID | false |
| Response outcome | String | (empty) | 40 | | false | Response outcome | false |
| Response ts | Date/Time | (empty) | 40 | | false | Response ts | false |
