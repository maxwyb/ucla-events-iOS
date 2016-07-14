## Server & Database design and API: 1st stage product
1. Event storage  
	- Holder/Organization  
	- Date & Place  
	- Event name  
	- Description  
	- Tag  
	- Event Image (one or more)  
	- etc.  
2. Account storage  
	- All user accounts information: participant (& planner) account  
	- Favorite events  
	- Disliked events  
	- Participating events (participants)  
	- *[2nd stage]* uploaded events (planners)  
3. Event-related API  
	- Fetch information of all activities  
	- *[2nd stage]* Add/Edit/Delete an event (planners)  
4. Account-related API (personal preferences)  
	- Login to my account and fetch basic account type information
	- *[2nd stage]* Fetch list of my club's events (planners)  
	- Fetch personal marks (Favorites, Dislikes, Participating...) to each event  
	- Modify (add & delete) personal marks  
5. *[1st stage only]* Super-user for adding & editing & deleting events. Could be done on server side or mobile apps.  

Notes:   
- **Events**-related database would be one large entity (array or others), while **accounts**-related database would be one entity for each user account.  
- Server performance after scaling  
	- Large number of user accounts & events  
	- Large number of simultaneous access  