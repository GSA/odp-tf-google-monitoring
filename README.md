# Terraform  module

## Overview <a name="s1"></a>

The MODULE  module is used to configure X resources.

## Table of Contents <a name="s2"></a>

* [Overview](#s1)
* [Table of Conents](#s2)
* [Module Contents](#s3)
* [Module Variables](#s4)
* [Module Setup](#s5)


## Module Contents <a name="s3"></a>

| Folder / File      |  Description  |
|---          |---    |
| main.tf   |   description |
| variables.tf   |   description |
| output.tf   |   description |

## Module Variables  <a name="s4"></a>


### Inputs

The following variables need to be set either by setting proper environment variables or editing the variables.tf file:

| Variable      |  Type  |  Description  |
|---          |---        |---  | 
| variable  |  string |   description |


### Outputs

The following variables need to be set either by setting proper environment variables or editing the variables.tf file:

| Variable      |  Type  |  Description  |
|---          |---        |---  | 
| variable  |  string |   description |

## Module Setup <a name="s5"></a>


### Authenication and privileges


### Example


```
module "module_name" {
  source = "../modules/module_name" 
  var_1 = "1"
  var_2 = "2"

}

```