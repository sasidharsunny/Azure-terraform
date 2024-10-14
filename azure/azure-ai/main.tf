# Define the Resource Group
resource "azurerm_resource_group" "gpt-group" {
  location = "swedencentral"
  name     = "MyOpenAIGPT"
}

