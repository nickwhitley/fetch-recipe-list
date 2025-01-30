# Fetch Take Home Project

### Summary: Include screen shots or a video of your app highlighting its features

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I prioritized:
1. Clean and Readable Code:
   Having clean code allows for easy troubleshooting and maintainability. It is something I prioritize with all my applications.

2. Error Handling:
   I want to make sure all errors are logged and handled appropriately.

3. Image Caching:
   I spent more time with a more custom caching approach for more potentialy customization.

4. UI/UX:
   My goal was to have a user-friendly and accessible UI that is nice to look at and operates smoothly.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

Total time spent was around 8 hours:
* UI: 2 hours
* Caching: 1 hour
* Error Handling and Testing: 1 hour
* Backend Services: 2 hours
* Debugging: 1 hour
* Utilities: 1 hour

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
Due to minimal scope of application I decided not to make some things as generic as they should be. For example, the logger should be built by a logger factory to allow for logger changes without affecting services or models using a logger. Also due to minimal scope my networking components are a lot more specified than they should be. I would normally build out more available usages such as full request handling with optional bodies and headers.

### Weakest Part of the Project: What do you think is the weakest part of your project?
There could be more robust error handling, I'm handling all required error with intention but any other unexpected error wouldn't be handled differently. Unit testing could use more work to handle more scenarios and edge cases.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
