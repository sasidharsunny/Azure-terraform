# Define the Resource Group
resource "azurerm_resource_group" "gpt-group" {
  location = "swedencentral"
  name     = "MyOpenAIGPT"
}

# Define the Cognitive Account (with the SKU)
resource "azurerm_cognitive_account" "open_ai" {
  name                = "MyOpenAIAccount"
  resource_group_name = azurerm_resource_group.gpt-group.name
  location            = azurerm_resource_group.gpt-group.location
  kind                = "OpenAI"
  sku_name            = "S0"  # Define SKU here
}

# Define the GPT-4 deployment
resource "azurerm_cognitive_deployment" "open_ai" {
  name                 = "OpenAIDeployment"
  cognitive_account_id = azurerm_cognitive_account.open_ai.id

  model {
    format  = "OpenAI"
    name    = "gpt-4"
    version = "turbo-2024-04-09"
  }

  scale {
    type     = "Manual"  # Set the scaling type (Manual or Automatic)
    capacity = 1         # Number of replicas to run
  }
}

# Define the text-embedding-ada-002 deployment
resource "azurerm_cognitive_deployment" "embedding_ada_deployment" {
  name                 = "OpenAIDeploymentAda"
  cognitive_account_id = azurerm_cognitive_account.open_ai.id

  model {
    format  = "OpenAI"
    name    = "text-embedding-ada-002"
    version = "2"
  }

  scale {
    type     = "Manual"  # Set the scaling type (Manual or Automatic)
    capacity = 1         # Number of replicas to run
  }
}
