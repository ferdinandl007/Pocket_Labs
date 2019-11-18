# Pocket_Labs
https://devpost.com/software/pocket-labs
## Inspiration

Malaria kills around 800,000 people a year and is second only to tuberculosis in its impact on world health.  In particular, the WHO African region is badly affected, suffering from over 90+ % of total malaria cases and deaths in 2017. Taking into account of the fact that 85% of malarial deaths are in children under 5 years of age, this is the equivalent of a child dying of malaria in Africa every 30 seconds.

Malaria kills extremely rapidly, as little as 24 hours after the first symptoms appear, and can remain dormant for weeks, allowing the malaria parasite to spread through mosquitos. This makes it all the more important for early and reliable diagnoses of the disease, which can help to nip the problem in the bud.

There are currently 2 huge problems in the treatment of malaria that we aim to solve with our project. 

Firstly, the cost of malarial treatment is high: The current gold standard for malarial tests involves identifying Malaria parasites by examining under the microscope a drop of the patient’s blood, spread out as a “blood smear” on a microscope slide. This is potentially a very expensive diagnostic procedure, requiring the services of a skilled laboratorian and expensive microscopes. 

Secondly, because of the need for specialised medical personnel, rapid and frequent testing of the disease is often not possible, 

## What it does

We have built an end-to-end automatic malaria detection device powered by a small usb microscope and with a companion iPhone app that allows operators to easily keep track of the tests that they have administered. 

All you need to do as a user is to prepare a blood sample using an inexpensive blood lance, place it under our usb microscope and the powerful machine learning models will do the rest!  Trained on azure virtual machines, we managed to achieve an astounding 96.8% accuracy on the test set, demonstrating that our machine learning models has the potential to possibly serve as an automated detection tool.

## How I built it

The end-to-end system consists of 2 main parts. Firstly, we have our end-to-end malarial testing field kit. Consisting of a small USB microscope, some glass slides and a small microprocessor, we are able to use this field kit to perform malarial testing out in the field even without access to internet. We use Azure Functions + Cosmos DB to serve as a resilient data store that we can use to reliably back up our data once internet connection has been established.

We also have a companion iPhone app that helps the user to keep track of the blood tests administered, and the results, as well as serve as a one stop portal for all the issues and problems they might have. 

## Challenges I ran into

Training the model, trying to get the malarial testing done 

## Accomplishments that I'm proud of

Achieving a 96.8 % accuracy on the test set of malaria data
Learning about malarial testing within 24 hours and implementing a passable prototype

## What I learned

Malarial testing, microscopes and all sorts of random information about biochemical tests and reactions

## What's next for Pocket Labs

Trials of alternative forms of cheap malarial tests, use of proper laboratory equipment to replicate our current project and results. 
