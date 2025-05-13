# Data Analysis AI Agent

This example demonstrates how to build an AI agent that can analyze data from various sources, generate insights, and create reports.

## Features

- Connects to multiple data sources (CSV, databases, APIs)
- Performs data cleaning and preprocessing
- Generates statistical analysis and insights
- Creates visualizations and reports
- Answers questions about the data

## How It Works

1. **Data Collection**: The agent retrieves data from specified sources
2. **Data Processing**: The agent cleans and transforms the data
3. **Analysis**: The agent performs statistical analysis and generates insights
4. **Visualization**: The agent creates charts and graphs to illustrate findings
5. **Reporting**: The agent generates a comprehensive report with findings and recommendations

## Setup Instructions

1. Import the workflow into n8n:
   - Go to Workflows > Import from file
   - Select `data-analysis-agent.json` from this directory

2. Configure data source connections:
   - Set up database credentials in n8n
   - Configure API keys for external data sources
   - Upload sample CSV files to the provided location

3. Activate the workflow:
   - Set the trigger method (webhook, schedule, or manual)
   - Configure any required parameters

## Usage

### Option 1: Webhook Trigger

Send a POST request to the webhook URL with the following JSON structure:

```json
{
  "data_source": {
    "type": "csv",
    "path": "sales_data_2023.csv"
  },
  "analysis_type": "sales_performance",
  "time_period": "last_quarter",
  "output_format": "pdf"
}
```

### Option 2: Scheduled Analysis

Configure the workflow to run on a schedule (e.g., weekly) and automatically:

- Pull the latest data
- Perform analysis
- Send reports to specified recipients

### Option 3: Interactive Analysis

Use the agent to answer specific questions about your data:

```json
{
  "data_source": {
    "type": "database",
    "query": "SELECT * FROM sales WHERE date >= '2023-01-01'"
  },
  "question": "What were our top 3 performing products last quarter and why?"
}
```

## Sample Analyses

The agent can perform various types of analyses, including:

1. **Trend Analysis**: Identify patterns and trends over time
2. **Comparative Analysis**: Compare performance across different categories
3. **Anomaly Detection**: Identify outliers and unusual patterns
4. **Predictive Analysis**: Forecast future trends based on historical data
5. **Correlation Analysis**: Discover relationships between different variables

## Customization

You can customize this agent by:

1. **Adding new data sources**: Integrate with additional databases or APIs
2. **Creating custom analysis templates**: Define specific analyses for your business needs
3. **Enhancing visualizations**: Add more chart types and visualization options
4. **Implementing domain-specific metrics**: Add calculations relevant to your industry

## Integration Ideas

- Connect to your BI tools like Tableau or Power BI
- Integrate with your CRM or ERP system
- Set up automated reporting via email or Slack
- Create interactive dashboards for real-time monitoring
