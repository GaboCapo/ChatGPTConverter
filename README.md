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

## Generate the html file

We will now create an individual HTML file that is customized to your chat history. This is done with the **helper script** which is based on an [.sh Script](https://en.wikipedia.org/wiki/Shell_script). [²](https://en.wikipedia.org/wiki/Bourne_shell)

From this point you can run this command:

```
mkdir ChatGPTConverter && cd ChatGPTConverter && curl -O https://raw.githubusercontent.com/GaboCapo/ChatGPTConverter/main/helper.sh
```

to create a folder called `ChatGPTConverter` and download the `helper.sh` file to this folder.

Then place the `conversations.json` file from your export files into this folder, so that it is next to the `helper.sh`.

Run the command, 
```
chmod +x helper.sh
```
in the project directory to make the file executable.

After that you can execute the script with 

```
./helper.sh
```

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

## Automatic download

If you want the files to be downloaded automatically without clicking every time you need to disable the option 'Ask for location before downloading files' in the browser settings. 
If this is enabled, the files can be saved one after the other.

Have fun!

## Known Issues

### Code Quality Note ⚠️
As of Jun 2023, **it should be noted that the code does not claim to be complete and should be checked yourself if it is used productively!** This is a hobby project and everyone is invited to extend the project.

### Large Files
For large `conversations.jsons` files ( in my test about 30 MB ) it may take a few minutes depending on your computer. This is due to the processing procedures.

### Chat GPT Plugin Compatibility
Since there are numerous plugins for ChatGPT and they partly have different output forms, it is not possible to consider them directly. If there are special wishes you are welcome to think about an implementation and contribute to the project.

### Consideration of other files like model_comparisons.json
There are other files from the export archive that were also mentioned above, but they are not processed in the script. The code currently uses only the `conversations.json` file from the exported data.
