# SIEM

Setup:
- gql_ug - [link](https://github.com/r0zehnal0vak/gql_ug/tree/SIEM)
- gql_forms - [link](https://github.com/r0zehnal0vak/gql_forms/tree/SIEM)

```
# gql_ug
$ docker build . -t hrbolek/gql_ug

# gql_forms
$ docker build . -t hrbolek/gql_forms

# _uois
$ docker compose up
```
Curl the metrics:
```
$ curl 127.0.0.1:8080/metrics
```