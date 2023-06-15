![ChatGPTConverterSocialImage](https://github.com/GaboCapo/ChatGPTConverter/assets/39612138/501f6fb2-7578-453c-8651-f00db84bc58f)

<h1 align="center">ChatGPTConverter</h1>

<p align="center"><strong>This tool enables the conversion of chat data from ChatGPT into Markdown format.</strong>


## Preparation

Go to the three dots in your ChatGPT interface and in settings go to the export data item.

![image](https://github.com/GaboCapo/ChatGPTConverter/assets/39612138/841bbaef-615e-434b-a762-6c240eb1c640)

After a few moments or sometimes longer, you will receive an email with a link where you can download this data.

Unzip these files and you will find the following structure of data:

```
.
├── chat.html
├── conversations.json
├── message_feedback.json
├── model_comparisons.json
├── shared_conversations.json
└── user.json
```

The project is actually nothing more than a modified version of the `chat.html` file which gets an additional button as we will see now.

---









