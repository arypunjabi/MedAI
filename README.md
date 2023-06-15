## What it does

We built an app that integrates with the GPT 3.5 and DALLE 1 APIs in order for the user to ask for medical advice and we feed their queries to the APIs. We reply back with medical information that GPT 3.5 has been trained on. Additionally, if the user asked for a diagram of what to do, we would call DALLE 1 APIs to feed an AI-generated image to the user.

## How we built it

We created the front-end design in Flutter and used the OpenAI API to link GPT and Dalle to Flutter. We then implemented a text box that moves when you click on it, and a speech icon that integrates a Speech-to-Text algorithm. These are the 2 ways that the user can input, and then we sent their query through the API to either GPT or DALLE. In order to differentiate DALLE requests from GPT requests, we input the prompt into chatgpt followed by a question asking whether the prompt wants a picture. If GPT responds with yes then the prompt is fed into DALLE. If not, then it is given to GPT by itself
