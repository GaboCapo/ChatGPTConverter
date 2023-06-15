#!/bin/bash

# Check if the conversations.json file exists
if [ ! -f "conversations.json" ]; then
    echo "conversations.json not found. Please add the file to the same directory."
    exit 1
fi

# Version options output and prompt
echo "Which version of Markdown file do you want to create? Enter the number and press Enter"
echo "1 - Without Markdown / Frontmatter Header"
echo "2 - With Markdown / Frontmatter Header"
read -r version

# Assemble the code based on the selected version
code_part_1='
<html>
<head>
    <title>ChatGPT Data Export - with ChatGPTConverter</title>
    <style>
        body {
            margin: 2em;
            background: #202123;
        }
        h4 {
            font-family: sans-serif;
            margin: 0;
        }
        #root {
            display: flex;
            flex-direction: column;
            gap: 2em;
        }
        .conversation {
            border: 0.2em solid #19c37d;
            padding: 2em;
            background-color: #444654;
            border-radius: 1em;
            color: #d1d5db;
        }
        .message {
            white-space: pre-wrap;
            margin: 2em 0;
        }
        .author {
            font-weight: bold;
            margin-bottom: 0.2em;
        }
        .author::first-letter {
            text-transform: uppercase;
        }
        button {
            height: 5em;
            background-color: #fae69e;
            display: inline-block;
            cursor: pointer;
            color: #927707;
            font-family: Arial;
            font-size: 14px;
            font-weight: bold;
            padding: 2em;
            text-decoration: none;
            border: none;
            border-radius: 1em;
        }
    </style>
    <script>
var jsonData = '

code_part_2='

function getConversationMessages(conversation) {
    var messages = [];
    var currentNode = conversation.current_node;
    while (currentNode != null) {
        var node = conversation.mapping[currentNode];
        if (node.message &&
            node.message.content &&
            node.message.content.content_type == "text"
            && node.message.content.parts.length > 0 &&
            node.message.content.parts[0].length > 0 && 
            node.message.author.role != "system") {
            author = node.message.author.role;
            if (author === "assistant") {
                author = "ChatGPT";
            }
            messages.push({ author, text: node.message.content.parts[0] });
        }
        currentNode = node.parent;
    }
    return messages.reverse();
}'

code_part_3_without_header='

// Function to convert a conversation to Markdown format
function convertToMarkdown(conversation) {
    var messages = getConversationMessages(conversation);
    var mdContent = `# ${conversation.title}\n\n`;
    for (var j = 0; j < messages.length; j++) {
        var author = messages[j].author;
        var text = messages[j].text.replace(/\n/g, "\n\n"); // Add an extra newline for line breaks in Markdown
        mdContent += `**${author}**: ${text}\n\n`;
    }
    return mdContent;
}'

code_part_3_with_header='

// Function to convert a conversation to Markdown format with YAML header
function convertToMarkdown(conversation) {
    var messages = getConversationMessages(conversation);
    var mdContent = `---
title: ${conversation.title}
create_time: ${conversation.create_time}
update_time: ${conversation.update_time}
plugin_ids: ${conversation.plugin_ids}
id: ${conversation.id}
moderation_results: ${conversation.moderation_results}
---

`;

    for (var j = 0; j < messages.length; j++) {
        var author = messages[j].author;
        var text = messages[j].text.replace(/\n/g, "\n\n"); // Add an extra newline for line breaks in Markdown
        mdContent += `**${author}**: ${text}\n\n`;
    }
    return mdContent;
}'


# Function to format conversation content
function formatContent() {
    local content="$1"
    formatted_content="${content//</\&lt;}"
    formatted_content="${formatted_content//>/\&gt;}"
    formatted_content="${formatted_content//≤/\&le;}"
    formatted_content="${formatted_content//≥/\&ge;}"
    echo "$formatted_content"
}

code_part_4='

// Function to download a file
function downloadFile(filename, content) {
    var element = document.createElement("a");
    element.setAttribute("href", "data:text/plain;charset=utf-8," + encodeURIComponent(content));
    element.setAttribute("download", filename);
    element.style.display = "none";
    document.body.appendChild(element);
    element.click();
    document.body.removeChild(element);
}

// Export all conversations to separate .md files
function exportToMdFiles() {
    for (var i = 0; i < jsonData.length; i++) {
        setTimeout(function(i) {
            var conversation = jsonData[i];
            var mdContent = convertToMarkdown(conversation);
            var filename = conversation.title + ".md";
            var counter = 1;
            while (filenameExists(filename)) {
                filename = conversation.title + "-" + counter + ".md";
                counter++;
            }
            downloadFile(filename, mdContent);
        }, i * 2000, i); // 2000ms delay between each download
    }
}

// Check if a filename already exists
function filenameExists(filename) {
    var links = document.getElementsByTagName("a");
    for (var i = 0; i < links.length; i++) {
        if (links[i].getAttribute("download") === filename) {
            return true;
        }
    }
    return false;
}

// on load, add messages to the root div 
window.onload = function() {
    var root = document.getElementById("root");
    var exportButton = document.createElement("button");
    exportButton.innerHTML = "Export all to md Files";
    exportButton.onclick = exportToMdFiles;
    root.appendChild(exportButton);

    for (var i = 0; i < jsonData.length; i++) {
        var conversation = jsonData[i];
        var messages = getConversationMessages(conversation);
        var div = document.createElement("div");
        div.className = "conversation";
        div.innerHTML = "<h4>" + conversation.title + "</h4>";
        for (var j = 0; j < messages.length; j++) {
            var message = document.createElement("pre");
            message.className = "message";
            message.innerHTML = `<div class="author">${messages[j].author}</div><div>${messages[j].text}</div>`;
            div.appendChild(message);
        }
        root.appendChild(div);
    }
}
    </script>
</head>
<body>
<div id="root">
</div>
</body>
</html>'

# Creating the HTML filename based on the current timestamp
filename="$(date +'%Y-%m-%d-%H%M%S')-chat.html"

# Assembling the complete code
if [ "$version" = "1" ]; then
    code="$code_part_1$(formatContent "$(cat conversations.json)")$code_part_2$code_part_3_without_header$code_part_4"
elif [ "$version" = "2" ]; then
    code="$code_part_1$(formatContent "$(cat conversations.json)")$code_part_2$code_part_3_with_header$code_part_4"
else
    echo "Invalid version selected. Please choose either 1 or 2."
    exit 1
fi

# Create HTML file
echo "$code" > "$filename"
echo "HTML file created: $filename"
