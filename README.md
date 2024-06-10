# SIEM

Setup:
- gql_ug - [link](https://github.com/r0zehnal0vak/gql_ug/tree/SIEM)
- gql_forms - [link](https://github.com/r0zehnal0vak/gql_forms/tree/SIEM)

```
# build gql_ug image
$ docker build . -t hrbolek/gql_ug

#build gql_forms image
$ docker build . -t hrbolek/gql_forms

# compose _uois
$ docker compose up
```
Curl the metrics inside gql_ug container:
```
$ curl http://gql_ug:8080/metrics | grep apollo_gql_processing_seconds
$ curl http://gql_forms:8080/metrics | grep apollo_gql_processing_seconds
$ curl http://slo_exporter:8080/metrics | grep apollo_gql_processing_seconds
```

In GraphiQL you can run these example queries and then curl the metrics to see the results:
- for gql_ug:
```
query MyQuery2 {
  userPage {
    __typename
    name
    email
    id
    surname
    valid
    fullname
    created
    lastchange
    memberships {
      created
      enddate
      id
      lastchange
      startdate
      valid
      group {
        created
        email
        name
        nameEn
      }
      user {
        name
        id
        fullname
        email
        valid
        surname
      }
    }
    answers {
      aswered
      created
      expired
      lastchange
      value
    }
  }
}
```
- for gql_forms:
```
query MyQuery {
  formPage {
    created
    id
    lastchange
    name
    nameEn
    status
    valid
  }
}
```

Query for both gql_ug and gql_forms:
```
query MyQuery {
  formPage {
    created
    id
    lastchange
    name
    nameEn
    valid
    status
    rbacobject {
      roles {
        group {
          abbreviation
          created
          email
          lastchange
          id
          valid
          nameEn
          name
        }
        created
        enddate
      }
      id
    }
  }
}
```
Result after queries:
- running curl for gql_ug:
 ![gql_ug](pictures/ug.png)

 - running curl for gql_forms:
 ![gql_forms](pictures/forms.png)