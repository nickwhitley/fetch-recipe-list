# Fetch Take Home Project

### Summary: Include screen shots or a video of your app highlighting its features
<div>
   <img width="33%" src="/Media/HomeScreen.png">
   <img width="33%" src="/Media/MalformedError.png">
   <img width="33%" src="/Media/NoRecipesFound.png">
</div>

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
* The logger should be built using a logger factory to allow different loggers to be interchangable.
* My networking components are more specific then they should be. I would normally implement a more flexible request handling system with optional request bodies and headers.

### Weakest Part of the Project: What do you think is the weakest part of your project?
* Error handling could be more robust. While I handle all required errors intentionally, unexpected errors are not treated differently.
* Unit testing could be expanded to cover more scenarios and edge cases.
* Some UI elements could benefit from smoother animations or animations in general.
  
### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
* You'll see two contributers which are my personal and profession git account, both belong to me.
* I would like to handle some navigation because I have an interesting way to handle navigation that isn't commonly seen but very robust in it's own right.
* I generally don’t use comments in my code unless something isn’t self-explanatory. I strongly believe in writing clean and clear code.
