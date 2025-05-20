# 🚀 Getting Started with AI Assistants

Welcome to your first steps with AI assistants! This guide will help you create useful AI workflows even if you're completely new to AI. No coding required! 😊

## 📋 Contents

- [Introduction](#introduction)
- [Before You Begin](#before-you-begin)
- [Use Case 1: Simple Q&A Assistant](#use-case-1-simple-qa-assistant)
- [Use Case 2: Email Summarizer](#use-case-2-email-summarizer)
- [Use Case 3: Document Helper](#use-case-3-document-helper)
- [Use Case 4: Customer Support Assistant](#use-case-4-customer-support-assistant)
- [Next Steps](#next-steps)

## Introduction

AI assistants can help your team work more efficiently by automating repetitive tasks and providing quick access to information. This guide will show you how to create four different AI assistants using the tools in this starter kit.

## Before You Begin

Make sure you have:

- Started all services in the Nova.K starter kit
- Access to the n8n interface at [http://localhost:5678](http://localhost:5678)
- Basic familiarity with using web interfaces (like clicking buttons and filling forms)
- A Google account if you want to try the use cases involving Google Sheets or Google Docs, and basic familiarity with these tools.

## Use Case 1: Simple Q&A Assistant

### 🎯 What You'll Build

A simple assistant that answers questions using AI via a simple form and logs the questions and answers to a Google Sheet. Perfect for team FAQs or general information requests.

### 🛠️ Tools Used

- n8n for the workflow
- Ollama for AI responses
- Google Sheets for logging questions and answers

### 📝 Step-by-Step Guide

#### Step 1: Create a New Workflow

1. Open [n8n](http://localhost:5678) in your browser
2. Click on "Workflows" in the left sidebar (if not already on the workflows page)
3. Click the "+ New workflow" button (or "+ Create Workflow")
4. Name your workflow "Simple Q&A Assistant"

#### Step 2: Add a Way to Ask Questions (Form)

1. Click the "+ Add Trigger" button
2. Search for "Form Trigger" and select it.
3. In the "Elements" section, click "Add Form Element".
   - **Type**: `String`
   - **Name / Field ID**: `question` (this is important for later steps)
   - **Label**: `Ask your question:`
4. You can customize the "Title" and "Subtitle" of the form (e.g., Title: "Simple Q&A Bot").
5. Click "Done". A "Form URL" will be generated and displayed. Keep this URL handy.

#### Step 3: Connect to the AI

1. Click the "+ Add Node" button after the webhook
2. Search for "Ollama" and select it
3. In the settings:
   - Model: Select "llama3" (or another available model)
   - Operation: Select "Chat"
   - System Prompt: Type "You are a helpful assistant that answers questions clearly and simply."
   - Message: Click on "Add Expression" and select the incoming data: `{{$json.question}}`
   - If using the Form Trigger, the expression should be `{{$json.body.question}}` (referencing the 'question' field ID from Step 2.4).
   - Click "Done"

#### Step 4: Format the Answer

1. Add another node by clicking "+ Add Node"
2. Search for "Set" and select it
3. Check "Keep Only Set"
4. Click "Add Value"
5. - Name: `response`
   - Type: `String`
   - Value: Click "Add Expression" and select the AI's response: `{{$node["Ollama"].json.message.content}}`
6. Click "Done"

#### Step 5: Log Question and Answer to Google Sheets

1. Add another node by clicking "+ Add Node".
2. Search for "Google Sheets" and select it.
3. **Authentication:**
   - Click on "Credential for Google Sheets API".
   - Select "Create New" or choose an existing one if you've connected Google Sheets before.
   - Follow the prompts to sign in with your Google account and authorize n8n.
4. **Configuration:**
   - Operation: `Append or Update Row` (or `Append Row`)
   - Spreadsheet ID: Create a new Google Sheet (e.g., named "AI Questions Log"). Open it, and copy the ID from its URL (the long string of characters between `/d/` and `/edit`). Paste this ID here.
   - Sheet Name: Enter the name of the sheet (e.g., "Sheet1" or "Log"). Make sure this sheet has columns like "Timestamp", "Question", "Answer".
   - Columns Mode: `Key/Value Pairs`
   - Data to Append or Update:
     - Click "Add Field".
       - Key: `Timestamp` (this must match a column header in your Google Sheet)
       - Value (Expression): `{{new Date().toISOString()}}`
     - Click "Add Field".
       - Key: `Question` (must match a column header)
       - Value (Expression): `{{$json.body.question}}` (from the Form Trigger)
     - Click "Add Field".
       - Key: `Answer` (must match a column header)
       - Value (Expression): `{{$node["Set"].json.response}}`
5. Click "Done".

#### Step 6: Test Your Assistant

1. Click "Save" in the top right
2. Click "Activate" to turn on your workflow
3. Open the "Form URL" (from the Form Trigger node settings in Step 2) in a new browser tab.
4. Type a question into the form (e.g., "What is artificial intelligence?") and submit it.
5. You should see a response page (n8n shows the output of the last node by default, which would be the Google Sheets node confirmation). The actual AI answer is in the `response` field from the "Set" node.
6. Check your Google Sheet to see the timestamp, question, and answer logged.

### 🌟 Ideas to Improve

- Add company-specific information to the AI's system prompt
- Customize the confirmation message shown after submitting the form (you can do this by adding another "Set" node at the end to define the final output, or configure the Form Trigger's response settings).

## Use Case 2: Email Summarizer

### 🎯 What You'll Build

An assistant that reads emails, creates short summaries, and appends them to a Google Doc, saving you time on reading long messages.

### 🛠️ Tools Used

- n8n for the workflow and email connection
- Ollama for summarization
- Google Docs to store summaries

### 📝 Step-by-Step Guide

#### Step 1: Create a New Workflow

1. Open [n8n](http://localhost:5678) in your browser
2. Create a new workflow named "Email Summarizer"

#### Step 2: Set Up Email Checking

1. Add an "IMAP" trigger (for reading emails)
2. Configure it with:
   - Host: Your email server (e.g., "imap.gmail.com")
   - User: Your email address
   - Password: Your email password or app password
   - **Important**: Ensure your email client/server allows IMAP access and consider using app-specific passwords for security if your provider supports them (like Gmail).
   - Check every: 10 minutes (or your preference)

#### Step 3: Process Each Email

1. Add an "Ollama" node after the IMAP trigger
2. Configure it with:
   - Model: "llama3"
   - Model: "llama3"
   - System Prompt: "You are an assistant that summarizes emails in 3 bullet points, highlighting the most important information."
   - Message: Click "Add Expression" and use: `Subject: {{$json.subject}} Body: {{$json.html || $json.text}}`

#### Step 4: Send the Summary

1. Add a "Send Email" node
2. Add a "Google Docs" node.
3. **Authentication:** Connect your Google account as you did for Google Sheets in Use Case 1.
4. **Configuration:**

   - Operation: `Append Text`
   - Document ID: Create a new Google Doc (e.g., "Email Summaries"). Open it and copy its ID from the URL. Paste the ID here.
   - Text: Click "Add Expression". Combine the subject and summary. Example:

     ```plain
     ## Summary of: {{$json.subject}}
     Date: {{new Date().toLocaleDateString()}}

     {{$node["Ollama"].json.message.content}}

     ---
     ```

     (This adds a heading, date, the summary, and a separator to your Google Doc for each email)

#### Step 5: (Optional) Send Summary via Email

If you also want the summary by email:

1. Add a "Send Email" node after the Google Docs node.
2. Configure it with your email credentials.
   - To: Your email address
   - Subject: `Summary of: {{$json.subject}}`
   - Content: Click "Add Expression" and use: `{{$node["Ollama"].json.message.content}}`

#### Step 6: Activate and Test

1. Save and activate your workflow
2. Send yourself a test email with some lengthy content
3. Wait for the workflow to trigger (based on your IMAP "Check every" interval).
4. Check your Google Doc for the appended summary. If you added the optional email step, check your inbox too.

### 🌟 Ideas to Improve

- Add a filter (using an "IF" node in n8n) to only summarize emails longer than a certain length or from specific senders.
- Add category tags to each summary in the Google Doc.

## Use Case 3: Document Helper

### 🎯 What You'll Build

An assistant that can search through documents and answer questions about their content.

### 🛠️ Tools Used

- n8n for the workflow
- Google Docs for providing the document content
- Ollama for understanding questions and generating answers

### 📝 Step-by-Step Guide

#### Step 1: Prepare Your Document

1. Have your document ready as a Google Doc. This could be a FAQ, a project brief, or any text-based document.
2. Copy its Document ID. You find this in the Google Doc's URL (e.g., if the URL is `https://docs.google.com/document/d/YOUR_DOCUMENT_ID/edit`, then `YOUR_DOCUMENT_ID` is what you need).

#### Step 2: Create the Question-Answering Workflow

1. Create a new workflow named "Document Helper"
2. **Add a "Form Trigger"**.
   - In "Elements", click "Add Form Element".
     - Type: `String`, Name / Field ID: `user_question`, Label: `Your question about the document:`
   - Click "Add Form Element" again.
     - Type: `String`, Name / Field ID: `doc_id`, Label: `Google Doc ID:`
3. **Add a "Google Docs" node.**
   - Authenticate your Google account if you haven't already.
   - Operation: `Get Content`
   - Document ID: Click "Add Expression" and select the `doc_id` from the Form Trigger: `{{$json.body.doc_id}}`
4. **Add an "Ollama" node.**

   - Model: "llama3"
   - System Prompt: "You are a helpful assistant. Answer the question based _only_ on the provided document context. If the answer is not in the context, clearly state that the information is not found in the provided document."
   - Message: Click "Add Expression". You need to combine the user's question and the document content retrieved by the "Google Docs" node.

     ```plain
     Context from document:
     {{$node["Google Docs"].json.text}}

     Based on the context above, please answer the following question:
     Question:
     {{$json.body.user_question}}
     ```

5. **Add a "Set" node** to format the response neatly.
   - Check "Keep Only Set".
   - Click "Add Value".
     - Name: `answer`
     - Type: `String`
     - Value (Expression): `{{$node["Ollama"].json.message.content}}`

#### Step 3: Test Your Document Helper

1. Save and activate your workflow
2. Open the Form URL (from the Form Trigger node settings) in a new browser tab.
3. Enter the Google Doc ID (from Step 1.2) and your question about the document's content.
4. Submit the form. The assistant will provide an answer based _only_ on the content of that specific Google Doc.

### 🌟 Ideas to Improve

- If the Google Doc is very long, the context provided to Ollama might be too large. For very large documents, more advanced techniques (like chunking and embeddings) would be needed, but this approach is great for moderately sized documents.
- Add error handling (e.g., using an "IF" node) for cases where the Google Doc ID is incorrect or the document is not accessible.

## Use Case 4: Customer Support Assistant

### 🎯 What You'll Build

An assistant that helps answer common customer questions using a knowledge base stored in Google Sheets.

### 🛠️ Tools Used

- n8n for the workflow
- Ollama for generating responses
- Google Sheets for storing the knowledge base (common questions and answers)

### 📝 Step-by-Step Guide

#### Step 1: Create the Knowledge Base

1. Create a new Google Sheet (e.g., named "Support KB").
2. In the first sheet (tab), create two columns in the first row:
   - Column A: `Question`
   - Column B: `Answer`
3. Populate this sheet with common customer questions and their corresponding standard answers. Each row represents one Q&A pair.

#### Step 2: Create the Support Assistant Workflow

1. Create a new workflow named "Support Assistant"
2. **Add a "Form Trigger"**.
   - In "Elements", click "Add Form Element".
     - Type: `String`, Name / Field ID: `customer_question`, Label: `What is your support question?`
3. **Add a "Google Sheets" node** to read your knowledge base.
   - Authenticate your Google account.
   - Operation: `Get Many Rows` (or `Read Sheet`)
   - Spreadsheet ID: Enter the ID of your "Support KB" Google Sheet.
   - Sheet Name: Enter the name of the sheet containing your Q&A (e.g., "Sheet1").
   - Options:
     - Key Row: `1` (this tells n8n that your first row contains the headers "Question" and "Answer").
4. **Add an "Ollama" node.**

   - Model: "llama3"
   - System Prompt: "You are a customer support assistant. Use the provided knowledge base entries to help answer the customer's question. If the knowledge base contains relevant information, prioritize using it. If not, try to provide a helpful general answer or suggest how the user can get further help."
   - Message: Click "Add Expression". You'll combine the customer's question with the Q&A data from Google Sheets.

     ```plain
     Here is our knowledge base:
     {{ $node["Google Sheets"].json.map(item => `Q: ${item.Question}\nA: ${item.Answer}`).join('\n\n---\n\n') }}

     Based on the knowledge base above, please answer the following customer question:
     Customer Question:
     {{ $json.body.customer_question }}
     ```

     _Note: This expression assumes your Google Sheets node correctly outputs an array of items, where each item has `Question` and `Answer` properties based on your column headers. Adjust `item.Question` and `item.Answer` if your headers are different._

5. **Add a "Set" node** to format the final response.
   - Check "Keep Only Set".
   - Click "Add Value".
     - Name: `suggested_answer`
     - Type: `String`
     - Value (Expression): `{{$node["Ollama"].json.message.content}}`

#### Step 3: Test Your Support Assistant

1. Save and activate your workflow
2. Open the Form URL (from the Form Trigger node) in a new browser tab.
3. Enter a customer question that is similar to one in your Google Sheets knowledge base.
4. Submit the form and review the suggested answer provided by the AI.
5. Try asking a question that is _not_ in your knowledge base to see how the assistant responds.

### 🌟 Ideas to Improve

- **Smarter KB Search (Advanced):** For a very large knowledge base, sending all Q&A pairs to Ollama can be inefficient. A more advanced setup would involve:
  - Using an "Ollama Embeddings" node to convert the `customer_question` into a vector.
  - Pre-calculating embeddings for all questions in your Google Sheet (could be a separate "indexer" workflow).
  - Using a vector search (e.g., with a "Code" node or a vector database if you decide to scale up) to find the most similar Q&A pairs from your Google Sheet.
  - Passing only these few relevant Q&A pairs to the Ollama node as context.
- Add a step to log the customer question and the provided answer to another Google Sheet for review and improvement of the KB.
- If no good answer is found, the workflow could send an email to a human support agent.

## Next Steps

Congratulations! 🎉 You've created your first AI assistants. Here are some ways to continue learning:

- Explore the [OpenWebUI](http://localhost:3000) interface for direct AI interactions
- Check out more [advanced workflows](advanced-usage.md)
- Learn about [key concepts](concepts.md) behind AI assistants
- Browse the [example agents](../examples/) for more inspiration

Remember, the best way to learn is by experimenting! Try combining different parts of these tutorials to create your own unique assistants. 😊

Need help? Check out the [troubleshooting guide](troubleshooting.md) or ask in our community channels.

Happy building! 🚀
