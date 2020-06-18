
## Criando só a estrutura do indice mapeando os campos:
PUT new_covid
{
    "settings" : {
        "number_of_shards" : 1
    },
    "mappings" : {
        "properties" : {
            "city" : {
          "type" : "text",
          "fields" : {
            "keyword" : {
              "type" : "keyword",
              "ignore_above" : 256
            }
          }
        },
        "city_ibge_code" : {
          "type" : "long"
        },
        "confirmed" : {
          "type" : "long"
        },
        "confirmed_per_100k_inhabitants" : {
          "type" : "float"
        },
        "date" : {
          "type" : "date"
        },
        "death_rate" : {
          "type" : "text",
          "fields" : {
            "keyword" : {
              "type" : "keyword",
              "ignore_above" : 256
            }
          }
        },
        "deaths" : {
          "type" : "long"
        },
        "estimated_population_2019" : {
          "type" : "long"
        },
        "is_last" : {
          "type" : "boolean"
        },
        "latitude" : {
          "type" : "float"
            
        },
        "longitude" : {
          "type" : "float"
          },

        "place_type" : {
          "type" : "text",
          "fields" : {
            "keyword" : {
              "type" : "keyword",
              "ignore_above" : 256
            }
          }
        },
        "state" : {
          "type" : "text",
          "fields" : {
            "keyword" : {
              "type" : "keyword",
              "ignore_above" : 256
            }
          }
        },
        "location": {
          "type" :"geo_point"
        }
    }
}
}

## Criando um novo indice Covid que vai receber a trasformação dos dados:
PUT covid
{
    "settings" : {
        "number_of_shards" : 1
    },
    "mappings" : {
        "properties" : {
            "city" : {
          "type" : "text",
          "fields" : {
            "keyword" : {
              "type" : "keyword",
              "ignore_above" : 256
            }
          }
        },
        "city_ibge_code" : {
          "type" : "long"
        },
        "confirmed" : {
          "type" : "long"
        },
        "confirmed_per_100k_inhabitants" : {
          "type" : "float"
        },
        "date" : {
          "type" : "date"
        },
        "death_rate" : {
          "type" : "text",
          "fields" : {
            "keyword" : {
              "type" : "keyword",
              "ignore_above" : 256
            }
          }
        },
        "deaths" : {
          "type" : "long"
        },
        "estimated_population_2019" : {
          "type" : "long"
        },
        "is_last" : {
          "type" : "boolean"
        },
        "latitude" : {
          "type" : "float"
            
        },
        "longitude" : {
          "type" : "float"
          },

        "place_type" : {
          "type" : "text",
          "fields" : {
            "keyword" : {
              "type" : "keyword",
              "ignore_above" : 256
            }
          }
        },
        "state" : {
          "type" : "text",
          "fields" : {
            "keyword" : {
              "type" : "keyword",
              "ignore_above" : 256
            }
          }
        },
        "location": {
          "type" :"geo_point"
        }
    }
}
}

DELETE covid

DELETE new_covid

GET covid/_search

POST _reindex
{
  "source": {
    "index": "new_covid"
  },
  "dest": {
    "index": "covid",
    "pipeline": "covid"
  }
}

PUT _ingest/pipeline/covid
{
  "processors": [
    {
      "script": {
        "source": """
        
ctx.location = [ Double.parseDouble(ctx.longitude) , Double.parseDouble(ctx.latitude) ]

"""
      }
    },
    {
      "remove" : {
        "field" : [ "latitude" , "longitude"]
      }
    }
  ]
}



GET new_covid/_count

GET covid/_search

GET covid/_search
{
  "query": {
    "match": {
      "city_ibge_code": "3547809"
    }
  }
}