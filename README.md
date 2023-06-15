## What it does

We built an app that integrates with the GPT 3.5 and DALLE 1 APIs in order for the user to ask for medical advice and we feed their queries to the APIs. We reply back with medical information that GPT 3.5 has been trained on. Additionally, if the user asked for a diagram of what to do, we would call DALLE 1 APIs to feed an AI-generated image to the user.

## How we built it

We created the front-end design in Flutter and used the OpenAI API to link GPT and Dalle to Flutter. We then implemented a text box that moves when you click on it, and a speech icon that integrates a Speech-to-Text algorithm. These are the 2 ways that the user can input, and then we sent their query through the API to either GPT or DALLE. In order to differentiate DALLE requests from GPT requests, we input the prompt into chatgpt followed by a question asking whether the prompt wants a picture. If GPT responds with yes then the prompt is fed into DALLE. If not, then it is given to GPT by itself

## Challenges we ran into

Our original plan was also to have a camera in the app that would allow the user to take a picture of any skin lesions they had. We would then process the image, and resize it to fit our needs before feeding it to an AI algorithm that would classify the skin lesion. It would find the probability for the lesion to be cancerous, acne, chicken pox, or several other skin problems. We ran into a lot of bugs while training the model causing us to lose many hours. We were able to get the algorithm to work, however, we ended up running out of time and could not connect the algorithm to the app.

## Accomplishments that we're proud of

We are really proud of the planning phase of picking what project we were going to do. We came up with 3 really strong ideas and ended up combining 2 of them. Additionally, we are really proud of our UI in the app, and how it seamlessly integrates with the APIs in order to give the user a positive experience.

## What we learned

We learned a lot about how to train AI models, and what can cause a lot of errors. Going into this, none of us had experience working with AI models, so we had to figure out which libraries to use, and how the main function of the libraries- such as Keras and TensorFlow- work.

## What's next for MedAI

Our next goal would be to finish connecting our skin lesion/cancer detection model to the app. After this, we will focus on fine-tuning the biases of the model in order to improve the accuracy of model while increasing its speed. Additionally, we will apply for OpenAIs API beta which allow us to access a much stronger GPT and DALLE while being able to customize the responses to fit our apps needs better.
