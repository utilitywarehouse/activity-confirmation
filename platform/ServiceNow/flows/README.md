Below you'll find the three flows we have that process and handle these requests

## confirm activity watcher - created
This is the main flow, it looks for entries in the table so that it can then contact the affected user or team using the specified contact method in the table entry.
<img width="2431" height="1343" alt="image" src="https://github.com/user-attachments/assets/7d81a1c0-3bc3-4a24-8482-69a515e49c39" />

## confirm activity wather - updated
This is the flow that looks for updates to entries in the table from the user, so that it can then create or update a security incident.
<img width="2428" height="710" alt="image" src="https://github.com/user-attachments/assets/23e33973-86cd-45f4-bdce-7aa1eab03701" />

## confirm activity watcher - monitor expiry
This flow monitors for entries in the table that have gone past their scheduled end date, and marks them as expired.
<img width="2431" height="534" alt="image" src="https://github.com/user-attachments/assets/4365b426-1ccd-457f-80f2-a489ceea069a" />
