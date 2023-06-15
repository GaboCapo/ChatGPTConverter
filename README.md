
⚠️ **Maintenance in Progress** ⚠️

Thank you for visiting our repository. Please note that we are currently undergoing maintenance, and some functionalities may be temporarily unavailable. We apologize for any inconvenience caused and appreciate your patience. Please check back later for updates.




![ChatGPTConverterSocialImage](https://github.com/GaboCapo/ChatGPTConverter/assets/39612138/501f6fb2-7578-453c-8651-f00db84bc58f)

# ChatGPTConverter

This tool enables the conversion of chat data from ChatGPT into Markdown format

## Table of contents

- [Preparation](#preparation)
- [Generate the html file](#generate-the-html-file)
- [Download MD files](#download-md-files)


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


## Generate the html file

We will now create an individual HTML file that is customized to your chat history. This is done with the **helper script** which is based on an [.sh Script](https://en.wikipedia.org/wiki/Shell_script). [²](https://en.wikipedia.org/wiki/Bourne_shell)


From this point you can clone the repository and paste your extracted export files ( `conversations.json` must be included ) into the main project directory.

Run the command, `chmod +x helper.sh` in the project directory to make the file executable.

After that you can execute the script with `./helper.sh`

The script first asks which method of export should be selected.

Option 1 = Without Markdown / Frontmatter Header 
This option creates an export file **without** the frontmatter header.

Option 2 = With Markdown / Frontmatter Header
This option creates an export file **with** the Frontmatter Header which has the following format:
```
---
title: 
create_time: 
update_time: 
plugin_ids: null
id: 
moderation_results: 
---
```

An HTML file will be generated in the same folder.
This can be opened with a browser just like the original `chat.hmtl` file. 


## Download MD Files


![image](https://github.com/GaboCapo/ChatGPTConverter/assets/39612138/ff3aa410-c93c-4287-abbf-2b47d3924c0a)


![image](https://github.com/GaboCapo/ChatGPTConverter/assets/39612138/a8f58f94-1d0c-405f-80d3-3c9769e93c02)

When you have opened the created HTML file with your browser you can click on 'Export all to md Files' to download the MD files as single .md files.

Confirm the message 'Download multiple files' in the browser with 'Allow'.

Now you can save the files individually and also change the name of the file. 

Have fun!
