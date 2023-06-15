## Why

In many densly populated cities, 911 emergency calls are often met with waiting times, which on top of the time it would take for an ambulance to arrive at your location might cause help to arrive late. To help with this problem, we developed a way for individuals in an emergency to temporary deal with it while waiting for medical help. When a call is made to 911, an applet is sent by the police to the users phone where the user describes the emergency and AI models are used to develop a response to help the user in the meantime. The entire conversation is sent to the police for them to understand the situation early.

## How it was built

We created the front-end design in Flutter and used the OpenAI API to link GPT and Dalle to Flutter. We then implemented a text box that moves when you click on it, and a speech icon that integrates a Speech-to-Text algorithm. These are the 2 ways that the user can input, and then we sent their query through the API to either GPT or DALLE. In order to differentiate DALLE requests from GPT requests, we input the prompt into GPT 3.5 followed by a question asking whether the prompt wants a picture. If GPT responds with yes, the prompt is fed into DALLE. If not, then it is given to GPT 3.5 by itself.
