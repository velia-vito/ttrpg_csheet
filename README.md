# ttrpg_csheet

A TTRPG character sheet application with a gRPC micro-service backend.

| Folder | Description |
|---|---|
| `api/` | Protobuf schema and generated gRPC Dart code shared by server and client |
| `server/` | Dart gRPC server — authentication and service discovery |
| `client/` | Flutter front-end |
| `config/` | Runtime configuration files, created on first server run |

Run `dart doc` in `server/` or `client/` to generate API docs.
